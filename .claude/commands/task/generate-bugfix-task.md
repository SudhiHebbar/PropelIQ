---
name: Bug Fix Task Generator with Triage
description: Performs comprehensive bug triage, root cause analysis, and generates fix implementation tasks with validation criteria
model: inherit
allowed-tools: Bash, Grep, Glob, Read, Edit, MultiEdit, Write, WebFetch, WebSearch, TodoWrite, Task, mcp__sequential-thinking__sequentialthinking, BashOutput, KillShell, mcp__context7__resolve-library-id, mcp__context7__get-library-docs
---

# Bug Fix Task Generator with Triage

## Input: $ARGUMENTS (Mandatory)
**Accepts:** Bug report file | Bug URL | Issue description | Error log

As a Senior Software Engineer specializing in debugging and system reliability, perform comprehensive bug triage and generate actionable fix tasks based on the provided bug report.

## Core Analysis Principle
**CRITICAL**: Think longer and deeper about bugs. Keep thinking to ensure:
- Complete understanding of the root cause
- All edge cases are considered
- Solution addresses the actual problem, not just symptoms
- No regression risks are overlooked

### Bug ID Extraction Algorithm
**File Input**: Extract bug ID from file path or content
- Patterns: `BUG[_-]?(\d{3,4})`, `ISSUE[_-]?(\d{3,4})`, `#(\d{3,5})`
- Example: `Context/Tasks/BUG_042/bug_report.md` → Extract `BUG_042`

**URL Input**:
- GitHub Issues: `github.com/.*/issues/(\d+)` → `ISSUE_XXX`
- JIRA: `jira.*/browse/([A-Z]+-\d+)` → Use ticket ID
- Azure DevOps: `dev.azure.com/.*/workitems/(\d+)` → `BUG_XXX`
- Generic: Parse URL and content for bug ID patterns

**Text Input**:
- Search for bug ID patterns in text
- Common formats: "BUG-123", "Issue #456", "Bug 789"

**Fallback Behavior**:
- If no bug ID found → Create tasks in `/Context/Tasks/`
- Use standard naming: `task_XXX_fix_<descriptive_name>.md`
- Log decision clearly for transparency

## Core Execution Workflow

### Phase 1: Bug Triage Protocol (MANDATORY)

Execute comprehensive triage before creating any bug fixing tasks:

#### 1. Issue Reproduction & Verification
- Parse bug report for reproduction steps and environment details
- Search codebase for error messages using Grep tool
- Examine relevant files with Read tool
- Execute reproduction steps with Bash tool (if runnable commands provided)
- Capture stack traces and error logs
- Verify issue exists in latest codebase version

#### 2. Root Cause Analysis (Sequential Thinking - Think Longer)
- Use `mcp__sequential-thinking__sequentialthinking` to trace error through codebase
- **IMPORTANT**: Think deeply about the bug - keep thinking longer to uncover hidden causes
- Continue thinking about edge cases and related issues that might share the root cause
- Think more about system interactions that could contribute to this bug
- Analyze git history for recent breaking changes using Bash
- Review component dependencies and interactions
- Identify regression source if applicable
- Document root cause with specific file:line references

#### 3. Impact Assessment
- Determine affected features and user workflows
- Evaluate data integrity implications
- Assess security and performance impacts
- Calculate affected user percentage
- Check for similar issues in related components

#### 4. Priority Categorization
- **Critical**: System down, data loss, security breach (< 4 hours)
- **High**: Core feature broken, major UX degradation (< 1 day)
- **Medium**: Minor features affected, workarounds exist (< 3 days)
- **Low**: Cosmetic issues, rare edge cases (< 1 week)

#### 5. Solution Validation (Think Deeply)
- Research similar fixes in git history using Bash
- **Think longer**: Consider multiple solution approaches before settling on one
- Keep thinking about potential side effects and regression risks
- Think more about edge cases that the fix must handle
- Use `mcp__context7__resolve-library-id` and `mcp__context7__get-library-docs` for framework-specific solutions
- Evaluate multiple solution approaches with deep consideration
- Think deeply about rollback procedures and failure scenarios
- Estimate complexity and regression risk
- Define rollback procedures
- Specify validation criteria for successful fix

### Phase 2: Fix Task Generation

#### Task Structure Requirements
- Base task structure on `.propel/templates/triage_base.md`
- Include complete triage summary in task description
- Define clear, sequential fix implementation steps
- Specify regression test requirements
- Include rollback procedures and validation checkpoints

#### Output Specifications

**Directory Organization**:

**Bug with ID Found**:
- **Directory**: `/Context/Tasks/BUG_<ID>/` or `/Context/Tasks/ISSUE_<ID>/`
- **File Pattern**: `task_<seqnum>_fix_<descriptive_name>.md`
- **Example**: `/Context/Tasks/BUG_042/task_001_fix_login_error.md`

**No Bug ID (Fallback)**:
- **Directory**: `/Context/Tasks/`
- **File Pattern**: `task_<seqnum>_fix_<descriptive_name>.md`
- **Example**: `/Context/Tasks/task_001_fix_validation_error.md`

**Sequence Number Logic**:
- Auto-increment within target directory (bug folder or root)
- Use zero-padded 3-digit format (001, 002, 003...)
- Continue from highest existing number in directory
- Descriptive name should reflect the bug being fixed

**Compatibility**: Generated tasks must be executable via `/execute-task` command

### Directory Management

**Bug ID Extraction Priority**:
1. **Parse Input**: Extract bug ID using patterns above
2. **Validate Format**: Ensure valid bug ID format
3. **Create Directory**: `/Context/Tasks/BUG_<ID>/` if ID found
4. **Fallback**: Use `/Context/Tasks/` if no ID extracted

**Supported Bug ID Formats**:
- `BUG_XXX` or `BUG-XXX` (3-4 digits)
- `ISSUE_XXX` or `ISSUE-XXX` (3-5 digits)
- `#XXX` (GitHub/GitLab style)
- JIRA format: `PROJECT-XXX`
- Custom patterns from bug tracking systems

**Directory Examples**:
```
Context/Tasks/
├── BUG_042/ (bug ID extracted)
│   ├── bug_report.md
│   ├── task_001_fix_login_error.md
│   └── task_002_add_regression_tests.md
├── ISSUE_123/ (GitHub issue)
│   └── task_001_fix_validation.md
└── task_001_fix_general_error.md (no ID - fallback)
```

## Context Documentation Requirements

### Essential Bug Context Package
- **Triage Results**: Complete reproduction steps and root cause analysis
- **Technical Investigation**: Error traces, affected components, dependency analysis
- **Fix Strategy**: Solution approach with implementation examples from research
- **Validation Plan**: Testing requirements, regression prevention measures

### Framework Research Integration
- **Version Pinning**: Use `mcp__context7__resolve-library-id` to identify exact library versions
- **Implementation Patterns**: Use `mcp__context7__get-library-docs` for bug fix patterns and best practices
- **Error Handling**: Include framework-specific error handling approaches
- **Testing Strategies**: Framework-appropriate testing and validation methods

## Quality Assurance Framework

### Pre-Delivery Checklist
- [ ] **Bug ID Extraction**: Attempted to extract bug ID from input
- [ ] **Folder Structure**: Created appropriate BUG_XXX folder or used fallback to /Context/Tasks/
- [ ] **Deep Thinking Applied**: Spent adequate time thinking through all aspects of the bug
- [ ] **Extended Analysis**: Kept thinking about edge cases and related issues
- [ ] **Issue Reproduction**: Bug successfully reproduced and documented
- [ ] **Root Cause Verified**: Technical cause identified with code references
- [ ] **Impact Assessment**: Complete evaluation of affected systems
- [ ] **Priority Assignment**: Correct categorization based on business impact
- [ ] **Solution Validation**: Approach verified through research and analysis
- [ ] **Regression Tests**: Testing strategy defined for preventing recurrence
- [ ] **Task Executability**: Generated task is compatible with execute-task command
- [ ] **Context Completeness**: All necessary implementation context included
- [ ] **Framework Research**: Version-specific documentation and patterns included
- [ ] **Rollback Plan**: Clear reversion procedure documented

## Execution Instructions

1. **Start with Bug ID Extraction**: Identify bug ID from input to determine folder structure
2. **Think Longer During Triage**: Keep thinking deeply - never rush the analysis phase
3. **Use Sequential Thinking**: For complex bugs, think more and break down analysis into logical steps
4. **Continue Thinking**: Even when you find a cause, keep thinking about related issues
5. **Leverage Research Tools**: Use Context7 for framework-specific guidance
6. **Document Everything**: Comprehensive documentation enables successful implementation
7. **Think About Edge Cases**: Keep thinking about scenarios that might not be obvious
8. **Validate Executability**: Ensure the generated task can be run via execute-task command

## Example Usage

### Bug Reports with ID
```bash
# GitHub Issue URL
/generate-bugfix-task https://github.com/org/repo/issues/123
# → Creates: /Context/Tasks/ISSUE_123/task_001_fix_*.md

# JIRA Bug URL
/generate-bugfix-task https://jira.company.com/browse/PROJ-456
# → Creates: /Context/Tasks/PROJ_456/task_001_fix_*.md

# Bug report file with ID
/generate-bugfix-task Context/Tasks/BUG_042/bug_report.md
# → Creates: /Context/Tasks/BUG_042/task_001_fix_*.md

# Text with bug ID
/generate-bugfix-task "Bug #789: Login fails with special characters"
# → Creates: /Context/Tasks/ISSUE_789/task_001_fix_*.md
```

### Bug Reports without ID (Fallback)
```bash
# Error description only
/generate-bugfix-task "Users cannot reset password"
# → Creates: /Context/Tasks/task_001_fix_password_reset.md

# Generic error log
/generate-bugfix-task error.log
# → Creates: /Context/Tasks/task_001_fix_error.md

# URL without bug ID
/generate-bugfix-task https://support.company.com/ticket/12345
# → Fetches content, no standard bug ID found
# → Creates: /Context/Tasks/task_001_fix_support_issue.md
```

**Task Output Decision Matrix:**
| Input Type | Bug ID Found | Output Location | Example |
|------------|-------------|-----------------|---------|
| File path | Yes | `/Context/Tasks/BUG_XXX/` | `BUG_042/task_001_*.md` |
| File path | No | `/Context/Tasks/` | `task_001_*.md` |
| URL | Yes | `/Context/Tasks/ISSUE_XXX/` | `ISSUE_123/task_001_*.md` |
| URL | No | `/Context/Tasks/` | `task_001_*.md` |
| Text | Yes | `/Context/Tasks/BUG_XXX/` | `BUG_789/task_001_*.md` |
| Text | No | `/Context/Tasks/` | `task_001_*.md` |

## Expected Output

The command generates a structured bug fix task file in `Context/Tasks/` that includes:

- **Comprehensive triage summary** with reproduction steps and root cause
- **Clear implementation plan** with sequential steps and code references
- **Testing and validation requirements** including regression prevention
- **Framework-specific guidance** from research using Context7
- **Quality gates and rollback procedures** for safe implementation

*This specialized command ensures systematic bug resolution with high success rates while maintaining compatibility with the existing task execution framework.*