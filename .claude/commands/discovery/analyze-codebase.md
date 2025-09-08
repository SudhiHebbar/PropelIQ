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
- Analyze every folder
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

## Comprehensive Analysis Methodology (Sequential Thinking)

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

# Codebase Analysis Slash Command

---
allowed-tools: Grep, LS, Read, WebSearch, WebFetch, Bash, BashOutput, KillBash, ListMcpResourcesTool, ReadMcpResourceTool
---

## Purpose

This command is the front face for comprehensive codebase analysis. It validates user input, gathers initial context, and delegates all complex, multi-phase, and parallelizable analysis to the `code-analyzer` agent.

- Accepts: repo URL, root path, stack, business domain, priority areas, etc.
- Validates arguments and context.
- Triggers the agent for deep analysis, enabling parallel and sequential execution.
- Returns a summary and a link to the full report.

**How it works:**
- The slash command coordinates the workflow, while the agent executes the analysis plan using both Context7 and sequential-thinking MCP servers.
- Use this command as the entry point for scalable, hybrid codebase analysis.

## Usage

/analyze-codebase [options]

---

*This command is the user-facing entry point. All deep analysis, research, and codebase traversal are handled by the code-analyzer agent for maximum efficiency and scalability.*