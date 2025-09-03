# Unified Codebase Analyzer

---
allowed-tools: Grep, LS, Read, Edit, MultiEdit, Write, WebFetch, TodoWrite, WebSearch, BashOutput, KillBash, ListMcpResourcesTool, ReadMcpResourceTool, mcp__context7__resolve-library-id, mcp__context7__get-library-docs, Bash, Glob
---

## Input Parameters: $ARGUMENTS (Optional)
**Accepts:** Repository URL | Root path | Technology stack | Business domain | Priority areas

**Default Parameters:**
- `repo_url`: Current directory or provided Git URL
- `root_path`: "." (current directory)
- `primary_stack`: Auto-detected from codebase
- `business_domain`: "General business application"
- `priority_areas`: "architecture, security, performance, data model, integrations"
- `time_budget_minutes`: 60
- `diagram_type`: "mermaid" (or "plantuml")
- `analysis_depth`: "comprehensive" (or "standard", "quick")

As a **Senior Software Architect and Reverse Engineering Specialist**, perform comprehensive codebase analysis to understand, document, and evaluate undocumented or complex systems. This unified command ensures systematic discovery with quality assessment and actionable recommendations.

## Core Analysis Principles

*** MANDATORY VALIDATIONS ***
- Clone or access repository before starting analysis
- Detect technology stacks and frameworks automatically
- Validate build systems and dependency managers
- ULTRATHINK the architecture — comprehensively analyze design patterns and decisions
- Use TodoWrite tool for systematic analysis tracking
- Generate comprehensive documentation suitable for all stakeholders
- Include both technical deep-dive and executive summary
- Perform security and performance assessments
- Output findings using `Templates/analyze_code_base.md` template structure to `Context/code-analysis.md`

## Analysis Strategy

Combine internal code analysis with external research to explain undocumented dependencies, frameworks, cloud resources, and integrations. Optimize for accuracy and completeness over speed. Spawn multiple agents and subagents using batch tools for thorough analysis.

## Comprehensive Analysis Methodology

### Phase 1: Repository Intelligence Gathering
**Technology Stack Detection**
- **Package Managers**: package.json, pom.xml, build.gradle, go.mod, requirements.txt, Gemfile, *.csproj
- **Frameworks**: React, Angular, Vue, .NET, Spring, Django, Rails, Express
- **Build Tools**: Webpack, Vite, Maven, Gradle, MSBuild, Make
- **Container/Orchestration**: Dockerfile, docker-compose.yml, k8s/*, helm/*
- **IaC**: terraform/*, bicep/*, arm/*, cloudformation/*
- **CI/CD**: .github/workflows, azure-pipelines.yml, .gitlab-ci.yml, Jenkinsfile

**Monorepo Detection**
- **Tools**: nx.json, lerna.json, rush.json, turbo.json, pnpm-workspace.yaml
- **Structure**: packages/*, apps/*, libs/*, services/*
- **Build Strategy**: Affected builds, dependency graphs, shared configurations

### Phase 2: Architecture Discovery
**Design Pattern Recognition**
- **Architectural Patterns**: Layered, Microservices, Event-Driven, Hexagonal, CQRS, MVC, MVP, MVVM
- **Design Patterns**: Singleton, Factory, Observer, Strategy, Repository, Unit of Work
- **Anti-Patterns Detection**: God objects, circular dependencies, tight coupling
- **References Check**: Review `References/Gotchas/architecture_patterns.md` and `anti_patterns.md`
- **External Reference**: Use `mcp__context7__get-library-docs` for technology-specific, version-specific documentation, code examples, design principles and coding standards

**System Topology Mapping**
- **Entry Points**: Web apps, APIs, CLI tools, functions, workers, scheduled jobs
- **Communication**: REST, GraphQL, gRPC, WebSocket, SignalR, Message queues
- **Data Flow**: Request flow, event flow, data pipelines, ETL processes
- **External Integrations**: Third-party APIs, cloud services, SaaS platforms

### Phase 3: Code Quality Assessment
**Metrics Collection**
```bash
# Cyclomatic complexity (if available)
npx complexity-report --format json || true
dotnet tool run codecracker || true

# Code duplication
npx jscpd . --min-tokens 50 --reporters "json,console" || true

# Technical debt (SonarQube if available)
sonar-scanner || true

# Dead code detection
npx unimported || true
dotnet tool run dead-code-analyzer || true
```

**Quality Indicators**
- Code duplication percentage
- Cyclomatic complexity hotspots
- Test coverage metrics
- Documentation coverage
- SOLID principles compliance
- Code smell detection

### Phase 4: Security Analysis
**Vulnerability Scanning**
```bash
# Dependency vulnerabilities
npm audit --audit-level=moderate || true
dotnet list package --vulnerable --include-transitive || true
pip-audit || safety check || true

# Secret scanning
trufflehog filesystem . --json || true
gitleaks detect --source . || true
rg -n "(?i)(api[_-]?key|secret|password|token|private[_-]?key)" --glob "!*.lock" || true

# SAST scanning (if available)
semgrep --config=auto || true
```

**Security Assessment Areas**
- **OWASP Top 10 Detailed Compliance**:
  - A01:2021 - Broken Access Control
  - A02:2021 - Cryptographic Failures
  - A03:2021 - Injection
  - A04:2021 - Insecure Design
  - A05:2021 - Security Misconfiguration
  - A06:2021 - Vulnerable and Outdated Components
  - A07:2021 - Identification and Authentication Failures
  - A08:2021 - Software and Data Integrity Failures
  - A09:2021 - Security Logging and Monitoring Failures
  - A10:2021 - Server-Side Request Forgery (SSRF)
- Authentication/Authorization implementation review
- Input validation patterns and sanitization
- Encryption usage (at rest and in transit)
- CORS/CSP/Security headers configuration
- SQL injection and NoSQL injection risks
- XSS/CSRF/SSRF protections
- Secrets management and key rotation
- API security and rate limiting

### Phase 5: Performance Profiling
**Database Analysis**
- N+1 query detection
- Missing indexes identification
- Query optimization opportunities
- Connection pool configuration
- Caching strategy evaluation

**API Performance**
- Response time analysis
- Payload size optimization
- Rate limiting implementation
- Pagination patterns
- Batch operation support

**Frontend Performance**
```bash
# Bundle analysis
npm run build -- --stats || webpack-bundle-analyzer || true
npx vite-bundle-visualizer || true

# Lighthouse CI (if available)
lhci autorun || true
```

### Phase 6: Documentation & Testing Coverage
**Documentation Analysis**
- README completeness
- API documentation (OpenAPI/Swagger)
- Code comment density
- Architecture Decision Records (ADRs)
- Inline documentation quality

**Test Coverage Deep Dive**
```bash
# .NET
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover /p:CoverletOutput=./coverage/ || true

# JavaScript/TypeScript
npm test -- --coverage --coverageReporters=json-summary text lcov || true
npx vitest --coverage || true

# Python
pytest --cov=. --cov-report=json --cov-report=term || true
```

### Phase 7: Critical Business Logic Documentation
**Core Business Logic Discovery**
- **Business Logic Classes**: Identify core classes/modules solving business problems
- **Method Analysis**: Document key methods and their business purpose
- **Business Rules**: Extract and document enforced business rules
- **Dependencies Mapping**: Track critical dependencies for business logic
- **Plain English Documentation**: Translate technical implementation to business language

**Business Process Flow Mapping**
- **Entry Points**: Identify where business processes start
- **Flow Documentation**: Step-by-step business flow in plain English
- **Decision Points**: Document critical business logic branches
- **Error Handling**: How business failures are handled
- **Transaction Boundaries**: Identify transactional scopes

**Business Rule Validation Analysis**
- **Rule Categories**: Pricing, Compliance, Authorization, Validation
- **Implementation Locations**: Map rules to code locations
- **Validation Logic**: Document how rules are checked
- **Failure Impact**: What happens when rules are violated
- **Business Constraints**: Document enforced business constraints

### Phase 8: User Journey & Use Case Analysis
**Actor Discovery from Code**
- **Authentication Analysis**: Extract user roles from auth middleware
- **Route Analysis**: Map routes to user types
- **Permission Mapping**: Document access levels from code
- **API Consumer Identification**: Find external system integrations
- **Background Job Analysis**: Identify system actors

**Use Case Reverse Engineering**
```bash
# Extract routes and endpoints
grep -r "@route\|@app.route\|router." --include="*.py" --include="*.js" --include="*.ts"
grep -r "\[Route\|\[HttpGet\|\[HttpPost" --include="*.cs"

# Find authentication decorators/attributes
grep -r "@auth\|@requires\|\[Authorize" --include="*.py" --include="*.cs" --include="*.ts"

# Identify API consumers
grep -r "api_key\|client_id\|webhook" --include="*.json" --include="*.yml"
```

**Critical User Flow Tracing**
- **Entry Point Mapping**: UI routes to backend endpoints
- **Code Path Analysis**: Controller → Service → Repository flow
- **Database Operations**: Track CRUD operations
- **External Calls**: API integrations and webhooks
- **Response Handling**: Success and error scenarios

**Sequence Diagram Generation**
- **Authentication Flows**: Login, logout, token refresh
- **Transaction Flows**: Payment, order, booking processes
- **Data Processing**: ETL, batch processing, reports
- **Integration Flows**: Third-party API interactions
- **Event-Driven Flows**: Message queue, event handlers

**Actor-Feature Interaction Analysis**
- **Visual Mapping**: Create interaction matrix between actors and features
- **Access Patterns**: Document how different actors use system features
- **Permission Boundaries**: Map actor permissions to feature access
- **Usage Frequency**: Identify high-traffic actor-feature combinations
- **Dependency Analysis**: Track feature dependencies per actor type

### Phase 9: Risk Register & Impact Analysis
**Risk Identification**
- **Security Risks**: Vulnerabilities, authentication weaknesses, data exposure
- **Performance Risks**: Scalability issues, bottlenecks, resource constraints
- **Technical Debt Risks**: Code quality, outdated dependencies, maintenance burden
- **Operational Risks**: Deployment complexity, monitoring gaps, recovery procedures
- **Compliance Risks**: Regulatory requirements, data privacy, audit trails

**Risk Assessment Matrix**
- **Severity Levels**: Critical, High, Medium, Low
- **Likelihood Assessment**: High, Medium, Low probability
- **Impact Analysis**: Business impact, user impact, technical impact
- **Risk Score Calculation**: Severity × Likelihood
- **Mitigation Strategies**: Preventive and corrective actions

### Phase 10: Modernization Roadmap Development
**Quick Wins Analysis (< 2 weeks)**
- Dependency updates and security patches
- Performance optimizations
- Code quality improvements
- Documentation updates
- Configuration fixes

**Medium-Term Improvements (2-8 weeks)**
- Architecture refactoring
- Test coverage expansion
- API modernization
- Database optimizations
- Monitoring implementation

**Strategic Initiatives (> 8 weeks)**
- Platform migrations
- Microservices transformation
- Cloud-native adoption
- Complete rewrites
- Major integrations

### Phase 11: Comprehensive Dependency Analysis
**Dependency Health Assessment**
```bash
# Check for outdated dependencies
npm outdated --json || true
dotnet list package --outdated --include-transitive || true
pip list --outdated || true

# Analyze dependency tree
npm ls --depth=3 --json || true
dotnet list package --include-transitive || true
pipdeptree --json || true

# License compliance check
license-checker --json || true
dotnet-project-licenses || true
```

**Dependency Risk Matrix**
- **Version Status**: Latest, Outdated, Deprecated, EOL
- **Security Status**: Vulnerable, Patched, Secure
- **Maintenance Status**: Active, Inactive, Abandoned
- **License Compatibility**: Permissive, Copyleft, Proprietary
- **Alternative Options**: Drop-in replacements available

## Essential Project Intelligence Integration

### Reference Materials Analysis
- **Gotchas Repository**: Examine `References/Gotchas` for technology-specific guidelines
- **Architecture Patterns**: Review `References/Gotchas/architecture_patterns.md`
- **Anti-Patterns**: Check `References/Gotchas/anti_patterns.md`
- **Tech Stack Guidelines**: Consult stack-specific documentation in References
- **Security Standards**: Review security best practices and compliance requirements

*** Comprehensive pattern recognition and anti-pattern detection is mandatory ***

### C4 Architecture Diagram Requirements
**Context Diagram (Level 1)**
- System boundaries and scope
- External actors (users, systems)
- High-level interactions
- Key data flows

**Container Diagram (Level 2)**
- Major application components
- Databases and data stores
- Message queues and caches
- Technology choices per container

**Component Diagram (Level 3)**
- Internal structure of containers
- Key components and their responsibilities
- Component interactions
- Important interfaces

**Deployment Diagram**
- Infrastructure topology
- Deployment environments
- Network boundaries
- Scaling strategy

## Analysis Output Framework

### Source Code Organization
**Folder Structure Analysis**
```bash
# Generate comprehensive tree (with intelligent filtering)
tree -L 3 -I "node_modules|.git|bin|obj|dist|coverage|.next|out|build|*.lock" > structure.txt

# Alternative for large codebases
find . -type d -name "node_modules" -prune -o -type d -name ".git" -prune -o -type d -print | head -100
```

**Grouping Categories**
- Frontend Applications
- Backend Services/APIs
- Shared Libraries/Packages
- Infrastructure as Code
- Database/Migrations
- Testing Suites
- Documentation
- DevOps/CI/CD

### Application Inventory
**Per Application/Service Documentation**
- Entry points and bootstrap process
- Build commands and dependencies
- Environment variables and configuration
- Default ports and endpoints
- Deployment requirements
- Health check endpoints
- Monitoring integration

### Comprehensive Feature Mapping
**Routes & Endpoints Inventory**
- UI routes and navigation structure
- REST API endpoints with methods
- GraphQL schema and resolvers
- WebSocket events and channels
- Message queue topics and subscriptions
- Scheduled jobs and triggers
- Webhook receivers

### Technology Stack Data Collection
*Data gathered here will populate the Technology Stack Inventory section in the template*

## Quality Assurance Framework

### Pre-Delivery Checklist
- [ ] **Repository Access**: Successfully cloned/accessed all code
- [ ] **Stack Detection**: All technologies identified and documented
- [ ] **Architecture Mapping**: Design patterns and anti-patterns identified
- [ ] **Security Assessment**: Vulnerabilities scanned and documented
- [ ] **Performance Analysis**: Bottlenecks and optimizations identified
- [ ] **Test Coverage**: Current coverage measured and gaps identified
- [ ] **Documentation Review**: Existing docs evaluated for completeness
- [ ] **Dependency Analysis**: All dependencies catalogued with versions
- [ ] **Build Verification**: Build processes tested and documented
- [ ] **Deployment Understanding**: Deployment pipeline comprehended

## Comprehensive Evaluation Protocol

### Analysis Quality Assessment (1-100% scale)

| **Evaluation Dimension** | **Assessment Criteria** |
|---------------------------|-------------------------|
| **Completeness** | All codebase aspects analyzed and documented |
| **Technical Accuracy** | Correct identification of patterns and technologies |
| **Security Diligence** | Comprehensive vulnerability and risk assessment |
| **Performance Insights** | Actionable performance findings and recommendations |
| **Architecture Clarity** | Clear understanding of system design and patterns |
| **Documentation Quality** | Professional, clear, stakeholder-appropriate output |
| **Risk Identification** | Critical issues properly identified and prioritized |
| **Actionability** | Practical, implementable recommendations provided |

### Evaluation Output Template
```markdown
## Codebase Analysis Quality Assessment

| Metric | Score | Notes |
|--------|-------|-------|
| Completeness (%) | [Score]% | [Coverage assessment] |
| Technical Accuracy (%) | [Score]% | [Accuracy validation] |
| Security Diligence (%) | [Score]% | [Security findings] |
| Performance Insights (%) | [Score]% | [Performance analysis] |
| Architecture Clarity (%) | [Score]% | [Design understanding] |
| Documentation Quality (%) | [Score]% | [Output quality] |
| Risk Identification (%) | [Score]% | [Risk discovery] |
| Actionability (%) | [Score]% | [Recommendation value] |

### Analysis Summary
**Confidence Level**: [High/Medium/Low]
**Key Findings**: [Top 5 critical discoveries]
**Immediate Actions**: [Top 3 urgent recommendations]
**Strategic Recommendations**: [Long-term improvements]
```

## Analysis Report Generation

### Output Requirements
**Base all analysis reports on `Templates/analyze_code_base.md` template for consistency and completeness.**

The template defines the comprehensive structure and content requirements. This command focuses on the **methodology** for gathering the data needed to populate all template sections effectively.

### Analysis Execution Guidelines
- Adapt analysis depth based on discovered technology stack
- Include framework-specific methodology (React, .NET, Python, etc.)
- Generate architecture diagrams using specified `diagram_type`
- Focus data gathering on `priority_areas` when specified
- Scale analysis effort based on `analysis_depth` parameter
- Reference `References/Gotchas` for technology-specific guidance
- Document all assumptions and unresolved questions during analysis

## Analysis Completion Criteria

- [ ] All 11 analysis phases completed systematically
- [ ] All data collected to populate template sections
- [ ] Output formatted using `Templates/analyze_code_base.md` structure
- [ ] Results saved to `Context/code-analysis.md`
- [ ] Quality assessment scoring completed
- [ ] All assumptions and limitations documented

## Usage Examples

**Basic Analysis (current directory)**
```bash
/analyze-codebase
```

**Repository Analysis**
```bash
/analyze-codebase repo_url="https://github.com/org/project.git"
```

**Focused Analysis**
```bash
/analyze-codebase priority_areas="security, performance" analysis_depth="comprehensive"
```

**Quick Assessment**
```bash
/analyze-codebase analysis_depth="quick" time_budget_minutes=30
```

---

*This unified codebase analyzer ensures comprehensive system understanding through systematic analysis, quality assessment, and actionable recommendations for all stakeholders.*