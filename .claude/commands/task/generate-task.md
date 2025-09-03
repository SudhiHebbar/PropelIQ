# Unified Task Generator

---
allowed-tools: Grep, LS, Read, Edit, MultiEdit, Write, WebFetch, TodoWrite, WebSearch, BashOutput, KillBash, ListMcpResourcesTool, ReadMcpResourceTool, mcp__context7__resolve-library-id, mcp__context7__get-library-docs, Bash, Glob
---

## Input: $ARGUMENTS (Mandatory)
**Accepts:** Feature requirements | User story file | Bug report | URL | Functional specification

As a Senior Software Engineer expert in Full Stack development, generate comprehensive implementation tasks based on the provided input. This unified command handles all task generation scenarios with consistent quality and thorough research approach.

## Core Execution Principles

*** MANDATORY VALIDATIONS ***
- Understanding the input, design documents, and existing codebase is required before task creation
- If source code is missing, prioritize project creation tasks first
- Continue execution if design.md is unavailable (optional for user stories and bug reports)
- ULTRATHINK the implementation — analyze approach comprehensively before proceeding
- Request explicit user confirmation (YES/NO) before writing/updating task files
- Update existing files incrementally; avoid unnecessary complete overwrites
- Split tasks exceeding 6 hours into smaller, independently testable units
- Split tasks by technology stack when applicable (separate tasks for frontend, backend, database, etc.)
- Map one task to one requirement/story/bug only — NO cross-referencing multiple items
- Single requirements can spawn multiple task files when complexity demands it

## AI Agent Context Strategy

The AI agent receives only your research findings and training data. Since agents have codebase access and equivalent knowledge cutoff, embed comprehensive research findings in the framework. Agents have web search capabilities — provide specific documentation URLs and implementation examples.

## Deep Research Methodology

Optimize for success probability over execution speed. Spawn multiple agents and subagents using batch tools for comprehensive analysis.

### 1. Codebase Intelligence Gathering
- **Pattern Discovery**: Search for similar features/implementations in existing codebase
- **Impact Analysis**: Identify existing features requiring modification to maintain functionality  
- **Reference Mapping**: Document files and patterns to reference in task design
- **Convention Documentation**: Catalog existing code styles, naming patterns, and architectural approaches
- **Test Pattern Analysis**: Review testing strategies and validation approaches used in the project

### 2. External Knowledge Acquisition
- **Implementation Research**: Search for similar features/patterns in open-source projects
- **Sample Code**: Use `mcp__context7__get-library-docs` for technology-specific, version-specific documentation, code examples, design principles and coding standards
- **Style Guidelines**: Research project-specific or framework coding standards
- **Documentation Deep-Dive**: Library documentation with specific section URLs
- **Example Collection**: GitHub repositories, StackOverflow solutions, technical blog implementations
- **Best Practice Synthesis**: Industry patterns, performance considerations, and common pitfalls

### 3. Contextual Clarification (When Needed)
- **Pattern Alignment**: Which existing implementations should be mirrored and their locations?
- **Integration Requirements**: How should new features integrate with existing systems?
- **Quality Standards**: What testing, documentation, and validation standards apply?

## Essential Project Intelligence

### Reference Materials Analysis
- **Gotchas Repository**: Examine `\References\Gotchas` for technology-specific guidelines, anti-patterns, and implementation warnings
- **Codebase Structure**: Explore `app`, `backend`, `server` folders for existing code patterns and architectural decisions
- **Documentation Review**: Study existing README files, API documentation, and inline code comments

*** Codebase comprehension is non-negotiable for quality task generation ***

## Task Design Framework

### Template Foundation
Base all tasks on `Templates/base_task.md` structure for consistency.

### Critical Context Integration
Package comprehensive context for AI agent success:

**📚 Documentation Context**
- Specific URLs with relevant sections highlighted
- API documentation with version-specific considerations
- Framework guides with implementation examples

**🏗️ Architecture Context**
- System design patterns and their rationale
- Integration points and data flow diagrams  
- Performance and scalability considerations

**💻 Implementation Context**
- Real code snippets from existing codebase
- Configuration examples and environment setup
- Error handling patterns used in the project

**⚠️ Critical Knowledge**
- Library-specific quirks and version compatibility issues
- Known limitations and workaround strategies
- Security considerations and compliance requirements

**🔄 Pattern Consistency**
- Existing approaches for similar functionality
- Naming conventions and code organization patterns
- Testing and validation strategies already established

### Implementation Blueprint Architecture

**Pseudocode Foundation**
- Start with high-level algorithmic approach
- Break down complex operations into manageable steps
- Reference real files demonstrating similar patterns

**Error Resilience Strategy**  
- Identify potential failure points and mitigation approaches
- Document rollback procedures for destructive operations
- Plan validation checkpoints throughout implementation

**Sequential Task Breakdown**
- List implementation tasks in logical dependency order
- Include mandatory unit test creation/updates for each component
- Define clear completion criteria and validation gates

## Context Documentation Requirements

### Essential References Package
- **Technical Documentation**: All URLs, guides, and examples needed for implementation
- **Implementation Examples**: Complex code snippets with explanations and context
- **Integration Points**: How the feature connects with existing systems
- **Quality Gates**: Testing requirements, performance benchmarks, security validations

## Output Specifications

**File Naming Convention**: `Context/Tasks/task_<seqnum>_<descriptive_name>.md`

**Sequence Number Logic**:
- Auto-increment based on existing task files in directory
- Use zero-padded 3-digit format (001, 002, 003...)
- Descriptive name should reflect primary functionality being implemented

## Quality Assurance Framework

### Pre-Delivery Checklist
- [ ] **Context Completeness**: All necessary implementation context included and accessible
- [ ] **Task Scope Validation**: Tasks are under 6 hours and properly split by technology stack when applicable
- [ ] **Technology Stack Separation**: Frontend, backend, database, and infrastructure tasks are independently manageable
- [ ] **Validation Executability**: All quality gates can be executed by AI without human intervention
- [ ] **Pattern Consistency**: References and follows established project patterns
- [ ] **Implementation Clarity**: Clear, unambiguous path from start to completion
- [ ] **Error Handling**: Comprehensive error scenarios documented with responses
- [ ] **Test Strategy**: Testing approach defined with specific validation criteria

## Comprehensive Evaluation Protocol

Score generated tasks using the following metrics (1-100% scale):

### Quality Metrics Assessment

| **Evaluation Dimension** | **Assessment Criteria** |
|---------------------------|-------------------------|
| **Relevance** | Alignment with provided requirements and project context |
| **Correctness** | Technical accuracy and absence of implementation errors |
| **Coherence** | Logical structure, clear progression, and readability |
| **Conciseness** | Optimal information density without unnecessary verbosity |
| **Completeness** | Comprehensive coverage of all implementation aspects |
| **Factual Accuracy** | Verifiable statements and reliable technical information |
| **Implementation Confidence** | Overall assessment of successful execution probability |
| **Risk Assessment** | Identification of harmful or inappropriate content |

### Evaluation Output Template

```markdown
## Task Quality Assessment

| Metric | Score | Notes |
|--------|-------|-------|
| Relevance (%) | [Score]% | [Specific observations] |
| Correctness (%) | [Score]% | [Technical accuracy notes] |
| Coherence (%) | [Score]% | [Structure and flow assessment] |
| Conciseness (%) | [Score]% | [Information density evaluation] |
| Completeness (%) | [Score]% | [Coverage gap analysis] |
| Factual Accuracy (%) | [Score]% | [Verification notes] |
| Implementation Confidence (%) | [Score]% | [Success probability assessment] |
| Risk Assessment | [Pass/Fail] | [Safety and appropriateness check] |

### Quality Summary
**Strengths**: [Key advantages and well-executed aspects]
**Improvement Areas**: [Specific recommendations for enhancement]
**Implementation Readiness**: [Overall assessment of task readiness for execution]
```

## Input Type Handling

This unified command automatically detects and processes:

### 🎯 Feature Requirements
- **Source**: `Context/requirements.md` (mandatory)
- **Design**: `Context/design.md` (mandatory)
- **Focus**: New feature implementation with comprehensive planning

### 📖 User Stories  
- **Source**: User story file path provided in $ARGUMENTS
- **Design**: `Context/design.md` (optional)
- **Focus**: Story-driven development with acceptance criteria

### 🐛 Bug Reports
- **Source**: Bug report file or URL provided in $ARGUMENTS  
- **Design**: `Context/design.md` (optional)
- **Focus**: Problem resolution with root cause analysis

### 📋 Functional Specifications
- **Source**: Any text-based functional description
- **Design**: Available project documentation
- **Focus**: Specification-driven implementation with detailed requirements analysis

---

*This unified task generator ensures consistent, high-quality task creation across all development scenarios while optimizing for prompt caching and maintainability.*