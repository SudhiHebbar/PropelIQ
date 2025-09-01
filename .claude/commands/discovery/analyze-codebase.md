# Unified Codebase Analyzer & Reverse Engineering

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
- Output findings to `Context/existingrequirements.md` for future reference

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
- OWASP Top 10 compliance
- Authentication/Authorization implementation
- Input validation patterns
- Encryption usage
- CORS/CSP configuration
- SQL injection risks
- XSS/CSRF protections

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

## Essential Project Intelligence Integration

### Reference Materials Analysis
- **Gotchas Repository**: Examine `References/Gotchas` for technology-specific guidelines
- **Architecture Patterns**: Review `References/Gotchas/architecture_patterns.md`
- **Anti-Patterns**: Check `References/Gotchas/anti_patterns.md`
- **Tech Stack Guidelines**: Consult stack-specific documentation in References
- **Security Standards**: Review security best practices and compliance requirements

*** Comprehensive pattern recognition and anti-pattern detection is mandatory ***

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

### Technology Stack Matrix
| Category | Technology | Version | Usage | Health Status |
|----------|------------|---------|-------|---------------|
| Language | TypeScript | 5.x | Frontend/Backend | Active |
| Framework | React | 18.x | UI Components | Active |
| Database | PostgreSQL | 14.x | Primary Store | Active |
| Cache | Redis | 7.x | Session/Cache | Active |
| Queue | RabbitMQ | 3.x | Async Processing | Active |

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

### Template Foundation
Base all codebase analysis reports on `Templates/analyze_code_base.md` for consistency and completeness.

### Critical Deliverables to Include
Using the template structure, ensure comprehensive coverage of:
- **Executive Summary**: Business context, risks, and strategic recommendations
- **Technical Architecture**: C4 diagrams, patterns, and system topology
- **Technology Stack**: Complete inventory with version and health status
- **Code Quality**: Metrics, technical debt, and improvement priorities
- **Security Assessment**: Vulnerabilities, OWASP compliance, and remediation
- **Performance Analysis**: Bottlenecks, optimizations, and metrics
- **Development Guide**: Setup, build, deployment, and operations
- **Risk Register**: Categorized risks with mitigation strategies
- **Modernization Roadmap**: Prioritized initiatives with effort estimates

### Customization Guidelines
- Adapt template sections based on discovered technology stack
- Include framework-specific analysis (React, .NET, Python, etc.)
- Generate architecture diagrams using specified `diagram_type`
- Focus analysis on `priority_areas` when specified
- Scale documentation detail based on `analysis_depth` parameter
- Reference `References/Gotchas` for technology-specific guidance

## Completion Criteria

- [ ] All analysis phases completed systematically
- [ ] Output saved to `Context/code-analysis.md`
- [ ] Executive summary under 200 words
- [ ] At least 3 architecture diagrams generated
- [ ] Security vulnerabilities mapped to CVE/CWE
- [ ] Performance bottlenecks identified with metrics
- [ ] 10+ actionable recommendations provided
- [ ] Quality assessment scoring completed
- [ ] Documentation suitable for all stakeholders

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