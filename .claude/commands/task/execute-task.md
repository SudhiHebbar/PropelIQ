# Unified Task Executor

---
allowed-tools: Grep, LS, Read, Edit, MultiEdit, Write, WebFetch, TodoWrite, WebSearch, BashOutput, KillBash, ListMcpResourcesTool, ReadMcpResourceTool, mcp__context7__resolve-library-id, mcp__context7__get-library-docs, Bash, Glob
# Note: Context7 MCP with fallback to WebSearch for framework research when MCP unavailable
---

## Task File: $ARGUMENTS (Mandatory)

Implement features, fix bugs, or complete development tasks using comprehensive task files. This command ensures systematic, high-quality implementation with thorough validation and quality control.

## Core Execution Principles

*** MANDATORY VALIDATIONS ***
- Load and comprehend the complete task file before starting implementation
- Understand all context by reviewing Docs/Spec.md, Docs/Design.md, and existing codebase
- Verify task completion status - terminate if already completed with "All tasks were implemented"
- Follow all task instructions and extend research when additional context is needed
- Update task file sections based on current codebase state and implementation progress
- Split complex implementations by technology stack (frontend, backend, database) when applicable
- Use TodoWrite tool for systematic progress tracking throughout implementation
- Request explicit confirmation for destructive changes that affect multiple files
- Validate each step before proceeding to maintain code quality and functionality

## AI Agent Implementation Strategy

Leverage comprehensive research and context from task files. Access to codebase and web search capabilities enables thorough implementation with proper validation at each stage.

## Deep Implementation Methodology

Optimize for implementation success and code quality over execution speed. Use systematic approach with comprehensive validation.

### 1. Task Comprehension and Planning
- **Task Analysis**: Parse complete task file including context, requirements, and validation criteria
- **Codebase Assessment**: Review existing code patterns, conventions, and integration points
- **Impact Analysis**: Identify existing features that may be affected by the implementation
- **Pattern Recognition**: Identify existing implementation patterns to follow for consistency
- **Dependency Mapping**: Understand task dependencies and execution order requirements

### 2. Implementation Planning
- **ULTRATHINK Phase**: Create comprehensive implementation plan addressing all requirements
- **Task Breakdown**: Use TodoWrite to create detailed, trackable implementation steps
- **Technology Separation**: Plan frontend, backend, and database components independently when applicable
- **Restoration Points**: Plan strategic code backup points for easy rollback if needed
- **Validation Strategy**: Define testing and validation approach for each implementation step

### 3. Quality Assurance Integration
- **Gotchas Review**: Check `References\Gotchas` for technology-specific warnings and best practices
- **Code Standards**: Ensure adherence to existing coding standards and project conventions
- **Test Strategy**: Plan unit test creation/updates as mandatory part of implementation
- **Error Handling**: Implement comprehensive error handling following project patterns

## Essential Project Intelligence Integration

### Reference Materials Analysis
- **Gotchas Repository**: Examine `References\Gotchas` for technology-specific implementation guidance
- **Codebase Patterns**: Follow existing code organization, naming conventions, and architectural decisions
- **Documentation Standards**: Maintain consistency with existing documentation and inline comments
- **Testing Patterns**: Follow established testing strategies and validation approaches

*** Existing codebase pattern compliance is mandatory for quality implementation ***

## Systematic Implementation Framework

### Phase 1: Task Loading and Preparation
**Task File Analysis**
- Load and parse complete task file structure
- Extract all requirements, context, and validation criteria
- Identify completion status of existing todo items
- Update task understanding based on current codebase state

**Context Gathering**
- Review Docs/Spec.md, Docs/CodeAnalysis.md and Docs/Design.md for comprehensive understanding
- Analyze existing codebase for patterns and integration points
- Use `mcp__context7__resolve-library-id` to lock framework/library versions present in the task and codebase before fetching guidance
- Use `mcp__context7__get-library-docs` for technology-specific, version-specific documentation, code examples, design principles and coding standards
- Perform additional web research if task context requires updates
- Document any gaps or additional research findings

### Phase 2: Implementation Planning
**Strategic Planning**
- Create comprehensive TodoWrite plan with all implementation steps
- Break down complex tasks into manageable, testable units
- Plan technology stack separation (frontend/backend/database) when needed
- Identify precise code modification targets using line numbers, function names, variables

**Quality Planning**
- Define validation commands and success criteria for each step
- Plan unit test creation/updates for all new functionality
- Establish restoration points for complex code changes
- Define completion criteria and validation gates

### Phase 3: Systematic Implementation
**Code Implementation**
- Use Playwright MCP to implement the pixel perfect user interface
- Execute implementation following TodoWrite plan systematically
- Implement all required code following existing project patterns
- Mark each completed todo task as [X] in the task file progressively
- Maintain precise targeting using line numbers and function references
- Preserve existing functionality while adding new features

**MCP Validation Loop (pre-commit)**
- **Plan**: Run `mcp__sequential_thinking__plan` to materialize a verification checklist from the task’s acceptance criteria and NFRs.
- **Critique**: Run `mcp__sequential_thinking__critique` mapping real repo evidence (files/endpoints/tests) to each checklist item; capture Pass/Gap/Fail with pointers.
- **Reflect**: Run `mcp__sequential_thinking__reflect` to summarize risks and generate the minimal fix list and missing tests to address before proceeding.

**Continuous Validation**
- Run validation commands after each significant implementation step
- Fix any failures immediately before proceeding
- Re-run validations until all pass successfully
- Use Playwright MCP to review the implemented user interface
- Use Context7 MCP for the review of implemented code against the design principles and coding guidelines
- Update todo progress in real-time

### Phase 4: Comprehensive Validation
**Quality Validation**
- Execute complete validation suite as defined in task file
- Verify all checklist items are completed successfully
- Ensure unit tests are created/updated and passing
- Validate logical correctness against requirements

**Integration Testing**
- Test integration with existing functionality to prevent regressions
- Validate error handling and edge case scenarios
- Confirm adherence to coding standards and project conventions
- Verify proper documentation and code comments

## Implementation Quality Standards

### Technology Stack Considerations
- **Frontend Tasks**: Handle UI/UX, client-side logic, and user interactions independently
- **Backend Tasks**: Manage server-side logic, APIs, and business rules separately
- **Database Tasks**: Handle data modeling, migrations, and queries in focused tasks
- **Infrastructure Tasks**: Manage deployment, configuration, and system setup independently

### Code Quality Requirements
- **Pattern Consistency**: Follow existing codebase patterns and architectural decisions
- **Error Handling**: Implement comprehensive error handling following project standards
- **Testing Coverage**: Ensure unit tests cover all new functionality and edge cases
- **Documentation**: Maintain clear code comments and update relevant documentation
- **Performance**: Consider performance implications and follow project optimization patterns

## Completion and Validation Framework

### Completion Criteria
- [ ] **MCP Critique Resolved**: All critical Gaps from `mcp__sequential_thinking__critique`/`reflect` are fixed or explicitly waived with rationale
- [ ] **Context7 Alignment**: At least one validation pass confirms implemented patterns align with versioned guidance fetched via Context7
- [ ] **Task Implementation**: All todo items in task file marked as completed [X]
- [ ] **Code Quality**: Implementation follows existing project patterns and standards
- [ ] **Testing**: Unit tests created/updated and all tests passing
- [ ] **Validation**: All validation commands execute successfully
- [ ] **Integration**: No regressions in existing functionality
- [ ] **Documentation**: Code properly documented and comments updated
- [ ] **Error Handling**: Comprehensive error scenarios handled appropriately
- [ ] **Requirements Compliance**: All original requirements fully implemented

### Final Deliverables
**Implementation Report**
- Complete list of updated/created files with descriptions
- Summary of changes made relative to project structure
- Validation results and test coverage confirmation
- Any logical errors identified and resolved

**Future Considerations**
- Suggested refactoring opportunities based on implementation
- Potential improvements for future iterations
- Integration points for related features
- Performance optimization opportunities

## Comprehensive Evaluation Protocol

Evaluate completed implementation using detailed metrics (1-100% scale):

### Implementation Quality Assessment

| **Evaluation Dimension** | **Assessment Criteria** |
|---------------------------|-------------------------|
| **Requirements Fulfillment** | Complete adherence to task specifications and acceptance criteria |
| **Code Quality** | Clean, maintainable code following project patterns and standards |
| **Testing Coverage** | Comprehensive unit tests with appropriate edge case coverage |
| **Integration Success** | Seamless integration without breaking existing functionality |
| **Error Handling** | Robust error scenarios coverage with appropriate responses |
| **Performance Impact** | Optimal performance with consideration for system resources |
| **Documentation Quality** | Clear, comprehensive documentation and code comments |
| **Pattern Consistency** | Adherence to existing architectural and coding patterns |

### Evaluation Output Template

```markdown
## Implementation Quality Assessment

| Metric | Score | Notes |
|--------|-------|-------|
| Requirements Fulfillment (%) | [Score]% | [Completeness assessment] |
| Code Quality (%) | [Score]% | [Standards adherence notes] |
| Testing Coverage (%) | [Score]% | [Test comprehensiveness evaluation] |
| Integration Success (%) | [Score]% | [System integration assessment] |
| Error Handling (%) | [Score]% | [Error scenario coverage] |
| Performance Impact (%) | [Score]% | [Performance considerations] |
| Documentation Quality (%) | [Score]% | [Documentation assessment] |
| Pattern Consistency (%) | [Score]% | [Architectural alignment] |

### Implementation Summary
**Successfully Implemented**: [Key features and functionality delivered]
**Quality Highlights**: [Code quality achievements and best practices followed]
**Test Coverage**: [Testing strategy and validation results]
**Integration Impact**: [Effects on existing system and functionality]
**Future Recommendations**: [Suggestions for continued development]
```

## Error Recovery and Rollback Procedures

### Error Handling Strategy
- **Immediate Validation**: Validate after each significant code change
- **Rollback Planning**: Use established restoration points for quick recovery
- **Pattern-Based Fixes**: Apply error patterns from task file for systematic resolution
- **Iterative Resolution**: Fix-validate-retest cycle until all validations pass

### Quality Assurance Gates
- **Code Review**: Self-review against project standards before completion
- **Test Validation**: All tests must pass before marking task complete
- **Integration Check**: Verify no regressions in existing functionality
- **Documentation Review**: Ensure all changes are properly documented

---

*This unified task executor ensures systematic, high-quality implementation with comprehensive validation and adherence to project standards and patterns.*