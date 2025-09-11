# Additional Context for Command Development

This file provides specific guidelines for breaking down user stories and creating tasks for command-related development work.

## Controlled Parallelism Guardrail

### Controlled Sub-Agent Instances
- **Cap parallelism**: Run at most 4 subagents in parallel.
- **No recursion**: Do not spawn subagents recursively (max depth 2).
- **Spawn criteria**: Only spawn when tasks are independent and bounded; otherwise run sequentially.
- **Queue overflow**: If 4 are already active, queue additional work.
- **Chunking**: Split work into 25-item chunks and process in waves.
- **Join step**: After each wave, summarize and merge results.
- **Back off**: If time/IO grows, stop spawning and continue sequentially.

## User Story Breakdown Guidelines

### Story Point Estimation
- Each user story should be broken into manageable and independently testable stories
- **Maximum story size**: 5 story points per story
- **Story point calculation**: 1 story point = 6 hours of effort
- Stories should be independent and deliverable as standalone units

### Story Breakdown Criteria
- Stories must be testable independently
- Each story should deliver business value
- Stories should follow INVEST principles (Independent, Negotiable, Valuable, Estimable, Small, Testable)

## Task Creation Guidelines

### Task Effort Estimation
- **Standard task effort**: 4 hours per task
- Tasks must be manageable and meaningful
- Each task should have clear acceptance criteria

### Project Scaffolding (No Existing Codebase)
**When no codebase is available, create language-specific project scaffolding tasks:**
- **Project initialization task**: Setup project structure, build tools, and configuration
- **Development environment task**: Configure development tools, linting, formatting
- **Framework selection task**: Choose and setup appropriate frameworks/libraries
- **Project structure task**: Create folder structure, naming conventions, and organization
- **Build pipeline task**: Setup CI/CD, testing infrastructure, and deployment configuration
- **Documentation foundation task**: Create README, contributing guidelines, and project documentation

### Stream Separation
Create separate tasks for each development stream:
- **Frontend (FE) tasks**: UI/UX implementation, client-side logic
- **Backend (BE) tasks**: Server-side logic, API development
- **Database (DB) tasks**: Schema changes, data migrations, queries
- **Integration tasks**: End-to-end workflow testing, feature integration testing

### Integration Testing
- Create dedicated integration tasks to test complete workflows
- Integration tasks should validate the entire feature implementation
- Include cross-stream dependency validation

## Reference Guidelines

### Existing Task Analysis
**Before creating new tasks:**
1. Review `./Context/Tasks` folder for existing task patterns
2. Understand current task structure and naming conventions
3. Build dependency mapping with existing tasks
4. Identify reusable components or patterns

**For new projects (no existing codebase):**
1. Determine target programming language and technology stack
2. Research language-specific best practices and project templates
3. Consider industry standards for the chosen technology stack
4. Plan scaffolding tasks based on project complexity and requirements

### Test Script Development
**Before creating test scripts:**
1. Review `./Context/Tests` folder for existing test patterns
2. Understand current testing framework and conventions
3. Consider updating existing scripts for new enhancements
4. Follow established test naming and organization patterns

## Task Dependencies

### Dependency Mapping
- Map dependencies between FE, BE, and DB tasks
- Identify blocking dependencies and critical path items
- Document prerequisite tasks and deliverables
- Consider parallel execution opportunities

### Integration Points
- Define clear handoff points between streams
- Specify interface contracts between components
- Plan integration testing at appropriate milestones

## Best Practices

### Task Documentation
- Include clear task descriptions and acceptance criteria
- Document expected inputs and outputs
- Specify testing requirements for each task
- Include relevant context from existing codebase

### Quality Assurance
- Plan testing tasks alongside development tasks
- Include code review tasks where appropriate
- Consider performance and security implications
- Plan documentation updates as separate tasks when needed

## Code Generation Guidelines

### Code Modification Standards
1. **Codebase Analysis**: Always analyze and understand the existing codebase for additional context before generating new code
2. **Boundary Identification**: Always identify the start and end boundaries of existing code before applying modifications
3. **Functionality Preservation**: Ensure code generation does not break existing functionality or introduce regressions
4. **Impact Assessment**: Analyze dependencies and side effects before making changes to existing code

### Template Adherence
- **Template Structure Compliance**: Commands and agents must produce outcomes that follow the referenced template structure available in the Templates folder
- **Template Reading**: Always read the appropriate template from Templates/ directory before generating outputs
- **Structure Validation**: Validate that generated content matches the expected template sections and format
- **Placeholder Replacement**: Ensure all template placeholders are replaced with actual content, not left empty