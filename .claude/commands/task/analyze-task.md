---
name: Task Analysis Command
description: Entry point for post-implementation task analysis. Reviews completed code changes against task requirements to verify scope alignment, identify gaps, and provide quality assessment with actionable recommendations through specialized task-analyzer agent delegation
model: inherit
allowed-tools: Bash, Read, Glob, Task
---

# Task Analysis Command

## Purpose
Entry point for post-implementation task analysis. Reviews completed code changes against task requirements to verify scope alignment, identify gaps, and provide quality assessment with actionable recommendations.

## Input Parameters: $ARGUMENTS (Required)
**Accepts:** Task file path

**Required Parameters:**
- `task_file_path`: Path to the task file that defines requirements, acceptance criteria, and validation gates (e.g., `Context/Tasks/task_001_signin.md`)

**Optional Parameters:**
- `analysis_depth`: "quick" | "standard" | "comprehensive" (default: "standard")
- `focus_areas`: Specific areas to emphasize (e.g., "security,testing,performance")

## Execution Flow

### 1. Parameter Validation
- Validate task file path and accessibility
- Parse basic task file structure to ensure it's processable
- Verify repository context and related code accessibility

### 2. Agent Delegation
- Invoke **task-analyzer** agent with validated parameters
- Pass structured context including:
  - Task file path and parsed metadata
  - Analysis depth and focus area preferences
  - Repository context and permissions

### 3. Summary Presentation
- Present executive summary of analysis findings
- Highlight critical gaps, risks, and recommendations
- Provide pass/fail verdict with prioritized action items
- Link to detailed analysis report in `Context/Analysis/<task_file_name>.md`

## Usage Examples

```bash
# Analyze completed task implementation
/analyze-task Context/Tasks/task_001_signin.md

# Quick analysis with security focus
/analyze-task Context/Tasks/task_002_api.md --depth=quick --focus="security,testing"

# Comprehensive analysis of complex feature
/analyze-task Context/Tasks/task_003_payment.md --depth=comprehensive
```

## Integration Notes

- Designed to work with `/generate` and `/execute` workflow as QA gate
- Non-destructive: reads repository without making changes
- Complements task generator and executor for complete development lifecycle
- All complex analysis, MCP integration, and report generation handled by **task-analyzer** agent
- Results follow `References/Templates/analyze_task_base.md` structure for consistency

## Alternative: Direct Agent Access

**For power users:** You can also invoke the task analysis agent directly for advanced control:

```bash
# Direct agent invocation with comprehensive analysis
@task-analyzer Context/Tasks/task_001_signin.md --depth=comprehensive --focus="security,testing" --parallel-research=6

# Direct invocation with custom validation mode
@task-analyzer Context/Tasks/task_002_api.md --validation-mode=strict --evidence-level=exhaustive

# Quick direct analysis with smart defaults
@task-analyzer Context/Tasks/task_003_feature.md --depth=quick
```

**Choose your approach:**
- **`/analyze-task`** - Guided experience with validation and user-friendly workflow
- **`@task-analyzer`** - Direct access with full parameter control for detailed analysis

## Output Specifications

**File Naming Convention**: `Context/Analysis/<task_file_name>_analysis.md`
**Content**: Executive summary, detailed findings, scoring rubric, actionable recommendations

---

*Optimized for efficient task validation and quality assurance through agent delegation.*