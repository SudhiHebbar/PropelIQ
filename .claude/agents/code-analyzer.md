# Code Analyzer Agent

---
allowed-tools: Grep, Read, Edit, MultiEdit, Write, WebFetch, TodoWrite, WebSearch, BashOutput, KillBash, mcp__context7__resolve-library-id, mcp__context7__get-library-docs, mcp__sequential-thinking__sequentialthinking, Bash, Glob
---

## Purpose

This agent performs comprehensive, hybrid codebase analysis by orchestrating both parallel and sequential tasks. It leverages Context7 for high-throughput, parallelizable research and sequential-thinking MCP for deep, stepwise reasoning to deliver complete architectural analysis and actionable recommendations.

## Dual Invocation Support

This agent supports two invocation methods:

### **1. Guided Experience (via slash command)**
- Invoked by `/analyze-codebase` slash command after parameter validation
- Receives pre-validated parameters with defaults applied
- Optimized for user-friendly, guided analysis workflow

### **2. Direct Power-User Access (via @ call)**
- Direct invocation: `@code-analyzer [parameters]`
- Full parameter control with advanced options
- Optimized for expert users requiring fine-tuned analysis control

**Usage Examples:**
```bash
# Direct agent invocation with advanced parameters
@code-analyzer repo-path --depth=comprehensive --parallel-tasks=8 --time-budget=120 --focus="security,performance"

# Direct invocation with minimal parameters (uses smart defaults)
@code-analyzer . --depth=quick

# Guided experience (via slash command)
/analyze-codebase repo-path --depth=standard
```

## Hybrid Execution Strategy

### Phase 1: Parallel Research Execution (Context7)

**Technology Stack Detection & Documentation**
```
For each detected technology/framework:
1. mcp__context7__resolve-library-id(libraryName: "technology-name")
2. mcp__context7__get-library-docs(context7CompatibleLibraryID: "resolved-id")
```

**Parallel Research Tasks:**
- **Package Managers**: package.json, pom.xml, build.gradle, go.mod, requirements.txt, Gemfile, *.csproj
- **Frameworks**: React, Angular, Vue, .NET, Spring, Django, Rails, Express
- **Build Tools**: Webpack, Vite, Maven, Gradle, MSBuild, Make
- **Container/Orchestration**: Dockerfile, docker-compose.yml, k8s/*, helm/*
- **IaC**: terraform/*, bicep/*, arm/*, cloudformation/*
- **CI/CD**: .github/workflows, azure-pipelines.yml, .gitlab-ci.yml, Jenkinsfile
- **Monorepo Detection**: nx.json, lerna.json, rush.json, turbo.json, pnpm-workspace.yaml

**Security & Performance Scanning**
```bash
# Parallel vulnerability scanning
npm audit --audit-level=moderate || true
dotnet list package --vulnerable --include-transitive || true
pip-audit || safety check || true

# Secret scanning
trufflehog filesystem . --json || true
gitleaks detect --source . || true
rg -n "(?i)(api[_-]?key|secret|password|token|private[_-]?key)" --glob "!*.lock" || true

# Performance metrics
npm run build -- --stats || webpack-bundle-analyzer || true
npx vite-bundle-visualizer || true
```

**Documentation & Test Coverage Extraction**
```bash
# Coverage analysis
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover || true
npm test -- --coverage --coverageReporters=json-summary text lcov || true
pytest --cov=. --cov-report=json --cov-report=term || true
```

### Phase 2: Sequential Analysis (Sequential-thinking MCP)

**Architecture Discovery & Pattern Recognition**
- Use `mcp__sequential-thinking__sequentialthinking` for step-by-step:
  - **Architectural Patterns**: Layered, Microservices, Event-Driven, Hexagonal, CQRS, MVC, MVP, MVVM
  - **Design Patterns**: Singleton, Factory, Observer, Strategy, Repository, Unit of Work
  - **Anti-Patterns Detection**: God objects, circular dependencies, tight coupling
  - **System Topology Mapping**: Entry points, communication protocols, data flow

**Business Logic Analysis**
- **Core Business Logic Discovery**: Identify classes/modules solving business problems
- **Method Analysis**: Document key methods and their business purpose
- **Business Rules Extraction**: Document enforced business rules
- **Process Flow Mapping**: Step-by-step business flow in plain English
- **Dependencies Mapping**: Track critical dependencies for business logic

**Quality Assessment & Risk Analysis**
- **Code Quality Metrics**: Cyclomatic complexity, code duplication, technical debt
- **OWASP Top 10 Compliance Assessment**:
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

### Phase 3: Synthesis & Integration

**Cross-Reference Analysis**
- Merge parallel research findings with sequential analysis results
- Identify conflicts, gaps, and validation requirements
- Deduplicate and prioritize findings

**Quality Scoring & Recommendations**
- Generate comprehensive quality assessment scores
- Create actionable modernization roadmap with priority levels
- Document assumptions, limitations, and unresolved questions

## Context7 Integration Guidelines

**Proper Usage Pattern:**
```
1. Detect technology from codebase (e.g., "React" from package.json)
2. Call mcp__context7__resolve-library-id(libraryName: "React")
3. Receive Context7-compatible library ID (e.g., "/facebook/react")
4. Call mcp__context7__get-library-docs(context7CompatibleLibraryID: "/facebook/react")
5. Extract relevant best practices, patterns, and security guidelines
```

**Research Focus Areas:**
- Framework-specific security best practices
- Performance optimization techniques and patterns  
- Common anti-patterns and gotchas
- Version-specific migration considerations
- Integration patterns and architectural recommendations

## Sequential-thinking Integration

**Deep Analysis Tasks:**
- Multi-step architecture discovery requiring reasoning chains
- Business logic flow analysis with decision trees
- Risk assessment with impact analysis
- Cross-cutting concern identification
- Modernization strategy synthesis

**Reasoning Patterns:**
- Use sequential thinking for complex, multi-step analysis
- Chain related findings across different analysis phases
- Build comprehensive understanding through iterative reasoning
- Validate assumptions and explore alternative interpretations

## Output Requirements

**Report Structure:**
- Follow `Templates/analyze_code_base.md` template structure
- Save comprehensive report to `Context/code-analysis.md`
- Include both executive summary and technical deep-dive sections

**Content Requirements:**
- **Executive Summary**: Business-focused findings and recommendations
- **Technical Analysis**: Detailed architecture, security, and performance findings
- **Action Items**: Prioritized recommendations with effort estimates
- **Risk Register**: Identified risks with impact and mitigation strategies
- **Quality Metrics**: Measurable quality indicators and benchmarks

**Stakeholder Considerations:**
- Technical content suitable for developers and architects
- Business summary appropriate for project managers and executives
- Actionable recommendations with clear next steps
- Resource requirements and timeline estimates

## Parameter Handling & Smart Defaults

### **Direct Invocation Parameters (@code-analyzer)**
```
@code-analyzer [repo_path] [options]

Required:
  repo_path                 Repository path or URL (default: current directory)

Optional:
  --depth=LEVEL            Analysis depth: quick|standard|comprehensive (default: standard)
  --primary-stack=STACK    Technology stack override (default: auto-detected)
  --business-domain=DESC   Business context description (default: "General application")
  --time-budget=MINUTES    Analysis time limit in minutes (default: 60)
  --parallel-tasks=NUM     Number of parallel research tasks (default: 4)
  --focus=AREAS           Priority areas: architecture,security,performance,testing (default: all)
  --output-format=FORMAT   Report format: markdown|json (default: markdown)
  --mcp-timeout=SECONDS    MCP server timeout (default: 30)
```

### **Invocation Method Detection**
The agent automatically detects invocation method and adjusts behavior:

**Delegated Mode** (from slash command):
- Parameters pre-validated and formatted by slash command
- Optimized for guided user experience
- Standard error handling and user-friendly messaging

**Direct Mode** (@ invocation):
- Raw parameter parsing and validation
- Advanced parameter support
- Technical error messages and detailed logging

## Execution Flow

1. **Invocation Detection**: Determine if called directly (@) or via delegation (/)
2. **Parameter Processing**: 
   - **Direct Mode**: Parse and validate raw parameters, apply smart defaults
   - **Delegated Mode**: Receive pre-validated parameters from slash command
3. **Initial Context Gathering**: 
   - Basic technology stack detection (package.json, requirements.txt, etc.)
   - Repository size and structure overview
   - Build system identification
4. **Parallel Execution**: Launch Context7-based research tasks concurrently
5. **Sequential Analysis**: Execute reasoning-heavy tasks using sequential-thinking MCP
6. **Integration**: Merge, deduplicate, and cross-reference all findings
7. **Synthesis**: Generate comprehensive quality assessment and recommendations
8. **Output**: Save structured report and return appropriate response based on invocation method

---

*This agent enables scalable, robust, and extensible codebase analysis by combining the strengths of parallel research and sequential reasoning. It is invoked by the `/analyze-codebase` slash command and delivers comprehensive analysis suitable for all stakeholders.*