#!/usr/bin/env python3
"""
Claude Code File Access Validator Hook

This script validates file access requests from Claude Code to prevent
access to sensitive files and directories based on configured patterns.
"""

import sys
import json
import re
import os
from pathlib import Path
from datetime import datetime

def load_restricted_patterns():
    """Load restricted patterns from configuration file"""
    patterns_file = Path(__file__).parent / "restricted-patterns.json"

    if not patterns_file.exists():
        # Default patterns if config file doesn't exist
        return {
            "blocked_patterns": [
                r".*\.env\.production.*",
                r".*\.pem$",
                r".*\.key$",
                r".*\.cert$",
                r".*production\.config.*",
                r".*/\.ssh/.*",
                r".*/\.aws/.*",
                r".*/\.azure/.*",
                r".*/\.git/config$",
                r".*secret.*",
                r".*password.*",
                r".*credential.*"
            ],
            "blocked_directories": [
                "/etc",
                "/root",
                "C:\\Windows\\System32",
                "/var/log"
            ],
            "allowed_directories": [
                "./Context",
                "./References",
                "./Templates",
                "./.claude"
            ]
        }

    try:
        with open(patterns_file, 'r') as f:
            return json.load(f)
    except Exception as e:
        log_access("ERROR", f"Failed to load patterns: {e}")
        return {"blocked_patterns": [], "blocked_directories": [], "allowed_directories": []}

def log_access(decision, file_path, reason=""):
    """Log access attempts for audit purposes"""
    log_file = Path(__file__).parent / "access.log"
    timestamp = datetime.now().isoformat()
    log_entry = f"{timestamp} | {decision} | {file_path} | {reason}\n"

    try:
        with open(log_file, 'a') as f:
            f.write(log_entry)
    except Exception:
        pass  # Fail silently if logging fails

def validate_file_access(file_path):
    """Validate if file access should be allowed"""
    patterns = load_restricted_patterns()

    # Normalize path for consistent checking
    normalized_path = os.path.normpath(file_path).replace("\\", "/")

    # Check if path is in allowed directories (whitelist approach)
    for allowed_dir in patterns.get("allowed_directories", []):
        if normalized_path.startswith(allowed_dir.replace("\\", "/")):
            log_access("ALLOW", file_path, f"In allowed directory: {allowed_dir}")
            return True, f"Access allowed - in permitted directory: {allowed_dir}"

    # Check blocked directories
    for blocked_dir in patterns.get("blocked_directories", []):
        if normalized_path.startswith(blocked_dir.replace("\\", "/")):
            log_access("DENY", file_path, f"In blocked directory: {blocked_dir}")
            return False, f"Access denied - sensitive directory: {blocked_dir}"

    # Check blocked patterns
    for pattern in patterns.get("blocked_patterns", []):
        if re.search(pattern, normalized_path, re.IGNORECASE):
            log_access("DENY", file_path, f"Matches pattern: {pattern}")
            return False, f"Access denied - matches restricted pattern: {pattern}"

    # Default allow for other files
    log_access("ALLOW", file_path, "No restrictions matched")
    return True, "Access allowed - no restrictions matched"

def main():
    """Main entry point for the hook"""
    try:
        # Read input from Claude Code
        input_data = sys.stdin.read()

        if not input_data.strip():
            print(json.dumps({
                "decision": "deny",
                "reason": "No input data received"
            }))
            return

        # Parse the input JSON
        try:
            hook_input = json.loads(input_data)
        except json.JSONDecodeError:
            print(json.dumps({
                "decision": "deny",
                "reason": "Invalid JSON input"
            }))
            return

        # Extract file path from the tool arguments
        tool_name = hook_input.get("toolName", "")
        tool_args = hook_input.get("arguments", {})

        # Get file path based on tool type
        file_path = None
        if tool_name in ["Read", "Write", "Edit", "MultiEdit"]:
            file_path = tool_args.get("file_path") or tool_args.get("filePath")

        if not file_path:
            # If no file path found, allow the operation
            print(json.dumps({
                "decision": "approve",
                "reason": "No file path to validate"
            }))
            return

        # Validate the file access
        allowed, reason = validate_file_access(file_path)

        decision = "approve" if allowed else "deny"
        print(json.dumps({
            "decision": decision,
            "reason": reason
        }))

    except Exception as e:
        # In case of any error, deny access for security
        log_access("ERROR", "unknown", str(e))
        print(json.dumps({
            "decision": "deny",
            "reason": f"Validation error: {str(e)}"
        }))

if __name__ == "__main__":
    main()