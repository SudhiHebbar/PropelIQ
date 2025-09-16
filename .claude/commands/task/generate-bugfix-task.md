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

#### 2. Root Cause Analysis (Sequential Thinking)
- Use `mcp__sequential-thinking__sequentialthinking` to trace error through codebase
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

#### 5. Solution Validation
- Research similar fixes in git history using Bash
- Use `mcp__context7__resolve-library-id` and `mcp__context7__get-library-docs` for framework-specific solutions
- Evaluate multiple solution approaches
- Estimate complexity and regression risk
- Define rollback procedures
- Specify validation criteria for successful fix

### Phase 2: Fix Task Generation

#### Task Structure Requirements
- Base task structure on `References/Templates/triage_base.md`
- Include complete triage summary in task description
- Define clear, sequential fix implementation steps
- Specify regression test requirements
- Include rollback procedures and validation checkpoints

#### Output Specifications
**File Naming Convention**: `Context/Tasks/task_<seqnum>_fix_<descriptive_name>.md`

**Sequence Number Logic**:
- Auto-increment based on existing task files in directory
- Use zero-padded 3-digit format (001, 002, 003...)
- Descriptive name should reflect the bug being fixed

**Compatibility**: Generated tasks must be executable via `/execute-task` command

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

1. **Start with Triage**: Never skip the triage phase - it's mandatory for quality outcomes
2. **Use Sequential Thinking**: For complex bugs, break down analysis into logical steps
3. **Leverage Research Tools**: Use Context7 for framework-specific guidance
4. **Document Everything**: Comprehensive documentation enables successful implementation
5. **Validate Executability**: Ensure the generated task can be run via execute-task command

## Expected Output

The command generates a structured bug fix task file in `Context/Tasks/` that includes:

- **Comprehensive triage summary** with reproduction steps and root cause
- **Clear implementation plan** with sequential steps and code references
- **Testing and validation requirements** including regression prevention
- **Framework-specific guidance** from research using Context7
- **Quality gates and rollback procedures** for safe implementation

*This specialized command ensures systematic bug resolution with high success rates while maintaining compatibility with the existing task execution framework.*