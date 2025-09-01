# Unified Requirements Generator (PRD)

## Project Scope File: $ARGUMENTS (Mandatory)
**Accepts:** Feature specifications | Business requirements | Project scope documents | User needs text

As an expert Business Analyst and Product Manager with deep technical understanding, generate comprehensive Product Requirements Documents (PRDs) that bridge business needs with technical implementation. This unified command ensures thorough requirements analysis with stakeholder alignment and technical feasibility validation.

## Core Requirements Principles

*** MANDATORY VALIDATIONS ***
- Analyze project scope and business context before requirements generation
- Review existing codebase (if available) to understand current state and constraints
- Validate technical feasibility with architecture and technology stack considerations
- ULTRATHINK the requirements — comprehensively analyze business and technical implications
- Request explicit user confirmation (YES/NO) before writing/updating PRD files
- Update existing PRD sections incrementally when file exists; avoid complete overwrites
- Split complex requirements by functional areas and technology stacks when applicable
- Ensure requirements are testable, measurable, and aligned with business objectives
- Include both functional and non-functional requirements comprehensively

## Business Analysis Strategy

The AI agent receives your research findings and domain knowledge. Since agents have codebase access and equivalent knowledge cutoff, embed comprehensive business context and technical constraints in the PRD. Agents have web search capabilities — provide specific documentation URLs, industry standards, and best practice references.

## Deep Requirements Analysis Methodology

Optimize for requirements completeness and implementation success over speed. Spawn multiple agents and subagents using batch tools for comprehensive analysis.

### 1. Business Context Analysis
- **Stakeholder Identification**: Map all stakeholders and their requirements priorities
- **Business Objectives**: Align features with strategic business goals and KPIs
- **User Journey Mapping**: Document end-to-end user flows and interaction points
- **Success Metrics**: Define measurable success criteria and acceptance standards
- **Risk Assessment**: Identify business risks and mitigation strategies

### 2. Technical Feasibility Assessment
- **Architecture Alignment**: Verify compatibility with existing system architecture
- **Technology Stack Analysis**: Assess requirements against technology capabilities
- **Integration Requirements**: Identify system dependencies and integration points
- **Performance Implications**: Analyze scalability and performance requirements
- **Security Considerations**: Document security requirements and compliance needs

### 3. Existing System Analysis (If Applicable)
- **Current State Documentation**: Map existing features and functionality
- **Gap Analysis**: Identify differences between current and desired states
- **Impact Assessment**: Analyze effects on existing features and workflows
- **Migration Requirements**: Document data migration and transition needs
- **Backward Compatibility**: Ensure existing functionality preservation

### 4. External Research and Standards
- **Industry Best Practices**: Research similar implementations and patterns
- **Regulatory Compliance**: Identify applicable regulations and standards
- **Competitive Analysis**: Study competitor features and market standards
- **Technology Documentation**: Gather framework and library documentation
- **User Research**: Incorporate user feedback and usability studies

## Essential Project Intelligence

### Reference Materials Integration
- **Gotchas Repository**: Examine `References\Gotchas` for technology-specific constraints and guidelines
- **Architecture Patterns**: Review `References\Gotchas\architecture_patterns.md` for system design considerations
- **Anti-Patterns**: Check `References\Gotchas\anti_patterns.md` to avoid common pitfalls
- **Existing Codebase**: Analyze `app`, `backend`, `server` folders for current implementation patterns
- **Documentation Standards**: Follow existing documentation patterns and conventions

*** Comprehensive understanding of business context and technical constraints is non-negotiable ***

## PRD Generation Framework

### Template Foundation
Base all PRDs on `Templates/requirement_base.md` for consistency and completeness.

### Critical Context Integration

**📊 Business Context**
- Stakeholder requirements and priorities
- Business objectives and success metrics
- User personas and journey maps
- Market analysis and competitive positioning

**🏗️ Technical Context**
- System architecture and design patterns
- Technology stack capabilities and limitations
- Integration points and API requirements
- Performance and scalability considerations

**📋 Requirements Specification**
- Detailed functional requirements with acceptance criteria
- Non-functional requirements (performance, security, usability)
- Data requirements and information architecture
- User interface and experience requirements

**⚠️ Constraints and Dependencies**
- Technical limitations and workarounds
- External system dependencies
- Regulatory and compliance requirements
- Timeline and resource constraints

**🔄 Implementation Considerations**
- Development approach and methodology
- Testing strategy and validation criteria
- Deployment and rollout planning
- Maintenance and support requirements

### Requirements Structure Architecture

**Functional Requirements**
- User stories with clear acceptance criteria
- Feature specifications with detailed behaviors
- Business rules and logic documentation
- Data flow and process diagrams

**Non-Functional Requirements**
- Performance benchmarks and SLAs
- Security requirements and threat models
- Usability and accessibility standards
- Scalability and reliability targets

**Technical Requirements**
- API specifications and contracts
- Database schema and data models
- Integration requirements and protocols
- Infrastructure and deployment needs

## Stakeholder Analysis Framework

### Stakeholder Mapping
- **Primary Stakeholders**: Direct users and beneficiaries
- **Secondary Stakeholders**: Indirect users and support teams
- **Technical Stakeholders**: Development and operations teams
- **Business Stakeholders**: Management and decision makers

### Requirements Prioritization
- **MoSCoW Method**: Must have, Should have, Could have, Won't have
- **Value vs Effort Matrix**: High value/low effort items prioritized
- **Risk Assessment**: Critical path and high-risk items identified
- **Dependencies Mapping**: Sequential requirements ordering

## Technology Stack Considerations

### Multi-Tier Requirements
- **Frontend Requirements**: UI/UX, client-side functionality, responsive design
- **Backend Requirements**: Business logic, API design, data processing
- **Database Requirements**: Data models, queries, performance optimization
- **Infrastructure Requirements**: Deployment, monitoring, scaling strategies

### Cross-Cutting Concerns
- **Security Requirements**: Authentication, authorization, data protection
- **Performance Requirements**: Response times, throughput, resource usage
- **Monitoring Requirements**: Logging, metrics, alerting, observability
- **Compliance Requirements**: Regulatory standards, audit trails, data governance

## Output Specifications

**File Path**: `Context/requirements.md`

**Document Structure**:
- Executive summary with business context
- Comprehensive stakeholder analysis
- Detailed functional requirements
- Non-functional requirements specification
- Technical architecture considerations
- Implementation roadmap and priorities
- Success metrics and validation criteria

## Quality Assurance Framework

### Pre-Delivery Checklist
- [ ] **Business Alignment**: Requirements align with business objectives and KPIs
- [ ] **Stakeholder Coverage**: All stakeholder needs identified and addressed
- [ ] **Technical Feasibility**: Requirements validated against technical constraints
- [ ] **Story Sizing**: User stories exceeding 20 hours decomposed into smaller, manageable units
- [ ] **Testability**: All requirements have clear acceptance criteria
- [ ] **Completeness**: Functional and non-functional requirements comprehensive
- [ ] **Clarity**: Requirements are unambiguous and well-documented
- [ ] **Traceability**: Requirements linked to business objectives and user needs
- [ ] **Prioritization**: Clear priority and dependency mapping provided
- [ ] **Risk Assessment**: Potential risks identified with mitigation strategies

## Comprehensive Evaluation Protocol

Score generated PRDs using detailed metrics (1-100% scale):

### Requirements Quality Assessment

| **Evaluation Dimension** | **Assessment Criteria** |
|---------------------------|-------------------------|
| **Business Alignment** | Alignment with strategic objectives and stakeholder needs |
| **Requirements Completeness** | Comprehensive coverage of functional and non-functional aspects |
| **Technical Accuracy** | Feasibility validation and architecture compatibility |
| **Clarity and Precision** | Unambiguous, well-structured documentation |
| **Testability** | Clear acceptance criteria and validation methods |
| **Stakeholder Coverage** | All stakeholder perspectives addressed appropriately |
| **Risk Management** | Comprehensive risk identification and mitigation |
| **Implementation Readiness** | Clear path from requirements to development |

### Evaluation Output Template

```markdown
## PRD Quality Assessment

| Metric | Score | Notes |
|--------|-------|-------|
| Business Alignment (%) | [Score]% | [Strategic alignment assessment] |
| Requirements Completeness (%) | [Score]% | [Coverage evaluation] |
| Technical Accuracy (%) | [Score]% | [Feasibility validation notes] |
| Clarity and Precision (%) | [Score]% | [Documentation quality assessment] |
| Testability (%) | [Score]% | [Acceptance criteria evaluation] |
| Stakeholder Coverage (%) | [Score]% | [Stakeholder needs assessment] |
| Risk Management (%) | [Score]% | [Risk mitigation evaluation] |
| Implementation Readiness (%) | [Score]% | [Development readiness assessment] |

### Requirements Summary
**Business Value**: [Key business benefits and outcomes]
**Technical Approach**: [High-level implementation strategy]
**Priority Features**: [Must-have functionality for MVP]
**Risk Factors**: [Critical risks and mitigation strategies]
**Success Metrics**: [Measurable success criteria and KPIs]
```

## Context Documentation Requirements

### Essential References Package
```yaml
# MUST READ - Critical context for requirements generation
- url: [Industry standards documentation]
  why: [Compliance requirements and best practices]
  
- file: [existing/feature/path]
  why: [Current implementation to maintain compatibility]
  
- doc: [Framework/library documentation URL]
  section: [Architecture constraints and capabilities]
  critical: [Key limitations affecting requirements]

- reference: [References/Gotchas/specific_file.md]
  why: [Technology-specific constraints and guidelines]

- stakeholder: [Stakeholder interview notes/feedback]
  priority: [Critical requirements from key stakeholders]
```

## Input Type Handling

This unified command automatically processes various requirement sources:

### 📋 Feature Specifications
- **Source**: Feature request documents or descriptions
- **Focus**: New capability addition with business justification
- **Output**: Comprehensive PRD with implementation roadmap

### 🎯 Business Requirements
- **Source**: Business case documents or strategic initiatives
- **Focus**: Business-driven functionality with ROI analysis
- **Output**: Business-aligned PRD with success metrics

### 📊 Project Scope
- **Source**: Project charter or scope documents
- **Focus**: Complete project requirements with phases
- **Output**: Phased PRD with milestone definitions

### 👥 User Needs Analysis
- **Source**: User research, feedback, or journey maps
- **Focus**: User-centric requirements with experience priorities
- **Output**: User-focused PRD with usability criteria

---

*This unified requirements generator ensures comprehensive, business-aligned PRDs with technical feasibility validation and stakeholder alignment for successful implementation.*