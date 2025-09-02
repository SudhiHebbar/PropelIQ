# Comprehensive Pull Request Code Review
---
description: Perform enterprise-grade comprehensive code review for Pull Requests with security, architecture, business logic, and technology-specific analysis.
argument-hint: <pull_request_number_or_url>
---

As a **Senior Software Architect and Security Expert**, perform comprehensive pull request analysis for $ARGUMENTS covering all critical aspects of enterprise software development.

## Core Review Principles

*** MANDATORY VALIDATIONS ***
- Retrieve complete PR context including files, commits, reviews, and metadata
- Apply technology-specific gotchas from `References/Gotchas/` directory
- Perform automated validation using `References/Gotchas/validation_commands.md`
- Assess business logic impact and potential side effects
- Validate architecture compliance with established patterns
- Generate risk-based recommendations with priority levels
- **CRITICAL**: Reference framework standards and anti-patterns throughout review

## Comprehensive Review Framework

### Phase 1: Context Discovery & Risk Assessment

#### PR Metadata Analysis
```bash
# Retrieve comprehensive PR information
gh pr view $ARGUMENTS --json files,commits,reviews,body,title,author,createdAt,mergeable
gh pr diff $ARGUMENTS --name-only
gh pr checks $ARGUMENTS
```

#### Technology Stack Detection
```bash
# Auto-detect technology stack from changed files
rg --files-with-matches "\.(js|jsx|ts|tsx)$" | head -5  # Frontend
rg --files-with-matches "\.(cs|csproj|sln)$" | head -5  # .NET
rg --files-with-matches "\.(py|requirements\.txt)$" | head -5  # Python
rg --files-with-matches "\.(java|gradle|pom\.xml)$" | head -5  # Java
rg --files-with-matches "package\.json|yarn\.lock" | head -5   # Node.js
```

#### Risk Classification
**High Risk Indicators**:
- Database schema changes
- Authentication/authorization modifications
- API contract changes
- Security-related code
- Performance-critical paths
- External integrations

**Medium Risk Indicators**:
- Business logic changes
- New feature implementations
- Configuration updates
- Dependency changes

**Low Risk Indicators**:
- Documentation updates
- Code styling/formatting
- Comment additions
- Test additions

### Phase 2: Security Assessment (OWASP Top 10 Focused)

#### A01: Broken Access Control
```bash
# Check for authorization bypasses
rg "bypass|skip.*auth|admin.*true|role.*=.*admin" --type typescript --type python --type cs
rg "@PreAuthorize|@Authorized|@RequiresRoles" -A 3 -B 3
rg "if.*user.*admin|if.*role.*==" -A 5 -B 2
```

#### A02: Cryptographic Failures
```bash
# Check for weak cryptography
rg "md5|sha1|DES|RC4|ECB" --ignore-case
rg "password.*plain|token.*clear|secret.*unencrypted"
rg "Math\.random|Random\(\)|new Random" # Weak random number generation
```

#### A03: Injection Vulnerabilities
```bash
# SQL Injection patterns
rg "SELECT.*\+|INSERT.*\+|UPDATE.*\+|DELETE.*\+" --type cs --type java
rg "query.*\+|sql.*\+|execute.*\+" -A 3 -B 3
rg "String\.Format.*SELECT|String\.format.*SELECT"

# Command Injection
rg "exec\(|system\(|shell_exec|passthru|eval\(" --type python --type javascript
rg "Runtime\.getRuntime|ProcessBuilder|Process\.start" --type java

# NoSQL Injection
rg "\$where|\$regex|\$ne.*\$|find\(.*\{" --type javascript
```

#### A04: Insecure Design
```bash
# Check for design flaws
rg "TODO.*security|FIXME.*auth|HACK.*permission"
rg "if.*production.*false|if.*debug.*true" # Debug code in production
rg "localhost|127\.0\.0\.1|0\.0\.0\.0" --type config --type yaml --type json
```

#### A05: Security Misconfiguration
```bash
# Configuration security issues
rg "AllowAnyOrigin|allowCredentials.*true|cors.*\*"
rg "debug.*=.*true|development.*=.*true" --type config
rg "password.*=|secret.*=|key.*=" --type config --type env
```

#### A06: Vulnerable and Outdated Components
```bash
# Check for known vulnerable dependencies
rg "jquery.*[12]\.|lodash.*[1-3]\.|bootstrap.*[1-3]\." --type json
rg "<PackageReference.*Version.*[\"'][01]\." --type xml # .NET old packages
rg "python.*[12]\.|django.*[12]\.|flask.*[01]\." --type txt
```

#### A07: Authentication Failures
```bash
# Weak authentication patterns
rg "password.*length.*[1-7]|password.*min.*[1-7]"
rg "session.*timeout.*[0-9]{4,}|expires.*365" # Long sessions
rg "remember.*true|persistent.*true" -A 3 -B 3 # Persistent logins
```

#### A08: Software and Data Integrity Failures
```bash
# Check for integrity issues
rg "deserialize|pickle\.load|yaml\.load" --type python
rg "JSON\.parse.*user|eval\(.*user" --type javascript
rg "XmlSerializer|BinaryFormatter" --type cs # Unsafe .NET serialization
```

#### A09: Logging and Monitoring Failures
```bash
# Check for sensitive data in logs
rg "log.*password|logger.*token|console.*secret"
rg "System\.out\.print.*password|Console\.WriteLine.*token"
rg "print\(.*password|logging.*secret" --type python
```

#### A10: Server-Side Request Forgery (SSRF)
```bash
# SSRF vulnerability patterns
rg "http.*\+.*user|url.*\+.*request|fetch\(.*user"
rg "HttpClient.*user|WebRequest.*input|curl.*\$" 
```

#### Additional Security Checks
```bash
# Hardcoded secrets scanning
rg "(?i)(password|passwd|pwd|secret|key|token|api[_-]?key)\s*[:=]\s*['\"][^'\"\s]{8,}" --type typescript --type python --type cs
rg "-----BEGIN.*PRIVATE.*KEY-----" # Private keys in code

# Insecure HTTP usage
rg "http://(?!localhost|127\.0\.0\.1)" --type config --type yaml
rg "ssl.*false|tls.*false|verify.*false" --type config
```

### Phase 3: Architecture & Design Review

#### SOLID Principles Validation
```bash
# Single Responsibility Principle violations
rg "class.*Manager|class.*Helper|class.*Utility" # Generic class names
find . -name "*.ts" -o -name "*.cs" -o -name "*.py" | xargs wc -l | awk '$1 > 200 {print "SRP VIOLATION - Large class: " $2}'

# Open/Closed Principle - Check for proper abstractions
rg "interface.*I[A-Z]|abstract.*class|protocol.*class" --type typescript --type cs --type python

# Dependency Inversion - Check for tight coupling
rg "new [A-Z][a-zA-Z]*\(|new [A-Z][a-zA-Z]*Service\(" --type typescript --type cs
rg "import.*\.\.\/\.\.\/\.\." # Deep import chains indicating tight coupling
```

#### Design Pattern Analysis
```bash
# God Object detection
rg "class.*\{" -A 300 . | rg -c "public.*method|def |function " | awk '$1 > 20 {print "GOD OBJECT: Too many methods in " FILENAME}'

# Singleton misuse
rg "static.*instance|getInstance\(\)|singleton" -A 5 -B 5

# Factory pattern validation
rg "create[A-Z]|make[A-Z]|build[A-Z]" -A 3 -B 3

# Observer pattern implementation
rg "addEventListener|subscribe|notify|emit" -A 3 -B 3
```

#### Anti-Pattern Detection
```bash
# Deep nesting (Pyramid of Doom)
rg "if.*\{[\s]*if.*\{[\s]*if.*\{" --multiline

# Long parameter lists
rg "function.*\([^)]{100,}\)|def.*\([^)]{100,}\)|public.*\([^)]{100,}\)"

# Magic numbers and strings
rg "\b[0-9]{2,}\b(?![\.0-9])" --type typescript --type python | grep -v test | head -10
rg "\"[A-Z_]{10,}\"" | grep -v test | head -10

# Circular dependencies
rg "import.*from.*\.\./.*\.\." --type typescript
rg "using.*Project.*\..*Project\." --type cs
```

### Phase 4: Business Logic & Context Analysis

#### Business Logic Impact Assessment
```bash
# Critical business logic changes
rg "calculate.*price|compute.*total|process.*payment|validate.*transaction"
rg "discount|refund|billing|invoice|subscription|order"
rg "user.*role|permission|access.*control|authorization"

# Data validation logic
rg "validate|sanitize|filter|transform" -A 5 -B 2
rg "min.*length|max.*length|pattern|regex" -A 3 -B 3

# State management changes
rg "setState|state.*=|dispatch|reducer|action" --type typescript --type javascript
rg "transaction|commit|rollback|savepoint" --type cs --type java --type python
```

#### Potential Business Logic Vulnerabilities
```bash
# Race conditions in business logic
rg "async.*async|await.*await|Promise.*Promise" --type typescript
rg "Thread|Task\.Run|Parallel\." --type cs
rg "threading|asyncio|concurrent" --type python

# Integer overflow/underflow risks
rg "int.*\+.*int|long.*\*.*long|\+\+.*\+\+|--.*--"
rg "Math\.max|Math\.min|Integer\.MAX|Long\.MAX" -A 3 -B 3

# Business rule bypasses
rg "bypass|skip.*validation|force.*true|override.*check"
rg "if.*debug|if.*test|if.*development" # Environment-specific bypasses
```

#### Financial Logic Specific Checks
```bash
# Currency and precision handling
rg "float.*money|double.*price|decimal(?!.*money|.*price)" --type cs --type java
rg "parseFloat.*price|parseInt.*amount|Number\(.*money" --type typescript --type javascript

# Rounding and calculation errors
rg "Math\.round|Math\.floor|Math\.ceil" -A 3 -B 3
rg "toFixed|toPrecision|parseFloat" -A 2 -B 2
```

### Phase 5: Technology-Specific Gotchas Application

#### Auto-Apply Technology-Specific Standards
Based on detected technology stack, apply relevant gotchas:

**React/Frontend (`References/Gotchas/react_gotchas.md` + `frontend_best_practices.md`)**:
```bash
# React-specific anti-patterns
rg "useEffect\(\[\]\)" # Missing dependencies
rg "useState.*object|useState.*array" # Complex state objects
rg "key=\{.*index\}" # Using array index as key
rg "dangerouslySetInnerHTML" # XSS risks
rg "document\.getElementById|document\.querySelector" # Direct DOM manipulation

# Performance issues
rg "\.map\(.*\.map\(.*\.map\(" # Nested maps
rg "useEffect.*\[\].*useEffect.*\[\]" # Multiple effects without dependencies
rg "React\.Component.*render.*\{" -A 50 | rg "new.*Date|Math\.random" # Side effects in render
```

**.NET Specific (`References/Gotchas/dotnet_gotchas.md` + `backend_best_practices.md`)**:
```bash
# .NET anti-patterns
rg "catch.*Exception.*\{.*\}" # Catching all exceptions
rg "async.*void|Task\.Result|\.GetAwaiter\.GetResult" # Async anti-patterns
rg "string.*\+.*string.*\+" # String concatenation performance
rg "new.*Dictionary.*foreach|new.*List.*foreach" # Collection performance

# Entity Framework issues
rg "\.ToList\(\)\.Where\(|\.ToList\(\)\.First\(" # N+1 queries
rg "context\.[A-Z].*\.Where\(.*\=\=.*\$\{" # SQL injection via EF
rg "Include\(.*Include\(.*Include\(" # Over-eager loading
```

**Python Specific (`References/Gotchas/` - if exists)**:
```bash
# Python anti-patterns
rg "except:|except Exception:" # Broad exception catching
rg "global |globals\(\)" # Global variable usage
rg "eval\(|exec\(" # Code injection risks
rg "import \*" # Namespace pollution

# Performance issues
rg "list\(.*for.*in.*for.*in" # Nested list comprehensions
rg "\+.*string.*\+" # String concatenation performance in loops
```

**Database/SQL Patterns (`References/Gotchas/database_best_practices.md`)**:
```bash
# Database anti-patterns
rg "SELECT \*|select \*" --type sql
rg "WHERE.*LIKE.*%.*%" --type sql # Leading wildcard searches
rg "OR.*OR.*OR" --type sql # Complex OR conditions
rg "CURSOR|cursor" --type sql # Cursor usage

# Migration risks
rg "DROP.*TABLE|ALTER.*TABLE.*DROP|DELETE.*FROM" --type sql
rg "ADD.*COLUMN.*NOT.*NULL" --type sql # Non-nullable columns without defaults
```

### Phase 6: Code Quality & Standards Validation

#### Universal Quality Checks (`References/Gotchas/validation_commands.md`)
```bash
# File size validation
find . -name "*.js" -o -name "*.ts" -o -name "*.py" -o -name "*.cs" | xargs wc -l | awk '$1 > 500 {print "VIOLATION: Large file - " $2 " (" $1 " lines)"}'

# Function size validation
rg "function.*\{[\s\S]{3000,}|def .*:[\s\S]{2500,}|public.*\{[\s\S]{3000,}" --multiline
rg "^\s*(function|def|public|private).*\{.*\n.*\{" -A 100 | wc -l # Nested functions

# Code complexity indicators
rg "if.*\{.*if.*\{.*if.*\{" # Deep nesting
rg "case.*case.*case.*case.*case" # Large switch statements
rg "else.*if.*else.*if.*else.*if" # Long if-else chains
```

#### Documentation Standards
```bash
# Missing documentation for public APIs
rg "export.*function|export.*class|public.*class|public.*method" --type typescript --type cs | rg -v "/\*\*|///"
rg "def [^_].*:" --type python | rg -v '"""'
rg "public.*\{" --type cs | rg -v "///"

# TODO/FIXME/HACK markers
rg "TODO|FIXME|HACK|XXX|BUG" --type-not=markdown --type-not=txt
rg "console\.log|print\(|System\.out\.print|Console\.WriteLine" # Debug statements
```

#### Naming Convention Validation
```bash
# Poor naming patterns
rg "\b(usr|cfg|ctx|ptr|str|num|arr|obj|doc|win|btn|txt|mgr|hlpr)\b" --type typescript --type cs --type python
rg "function [a-z]+[0-9]|class [a-z]+[0-9]|var [a-z]+[0-9]" # Numbers in names
rg "data|info|item|thing|stuff|obj" # Generic names

# Boolean naming issues
rg "boolean [a-zA-Z]+(?!is|has|can|should|will)" --type typescript --type cs
rg "flag[A-Z]|Flag[A-Z]" # Generic flag names
```

### Phase 7: Performance Analysis

#### Database Performance
```bash
# N+1 Query patterns
rg "foreach.*\{.*context\.|for.*in.*session\.|\.map.*\{.*query" 
rg "\.Where\(.*\)\.ToList\(\)\.Where\(|\.filter\(.*\)\.map\(.*\)\.filter\("

# Inefficient queries
rg "SELECT.*COUNT\(\*\).*FROM.*WHERE|SELECT.*\*.*ORDER.*BY" --type sql
rg "JOIN.*JOIN.*JOIN.*JOIN" --type sql # Too many joins
rg "\.Include\(.*\)\.Include\(.*\)\.Include\(" # EF over-eager loading
```

#### Frontend Performance
```bash
# Inefficient React patterns
rg "useEffect\(\(\)" # Effects without dependencies that run every render
rg "\.map\(.*return.*<" -A 10 | rg "onClick=\{.*\}" # Inline handlers in lists
rg "new Date\(\)|Math\.random\(\)" # Side effects in render
rg "props\..*\..*\." # Deep prop drilling

# Bundle size issues
rg "import.*from.*'[^']*'" --type typescript | wc -l # Import count
rg "import.*\*.*from" --type typescript # Barrel imports
rg "require\(.*\)" --type javascript # Synchronous requires
```

#### Memory Management
```bash
# Memory leaks patterns
rg "setInterval|setTimeout" -A 3 -B 3 | rg -v "clear"
rg "addEventListener" -A 3 -B 3 | rg -v "removeEventListener"
rg "new.*Array\([0-9]{4,}\)|new.*Buffer\([0-9]{4,}\)" # Large allocations

# Resource disposal
rg "using.*\{|IDisposable" --type cs | rg -v "Dispose"
rg "try.*finally|with.*as" --type python | rg -v "close"
```

### Phase 8: Testing & Quality Assurance

#### Test Coverage Analysis
```bash
# Missing tests for new functionality
rg "export.*function|export.*class|public.*class" --files-with-matches | while read file; do
  testfile=$(echo $file | sed 's/src/test/' | sed 's/\.\([jt]s\|py\|cs\)$/.test.\1/')
  [ ! -f "$testfile" ] && echo "MISSING TEST: $testfile for $file"
done

# Test quality issues
rg "it\('.*'\)|test\('.*'\)|Test.*\(\)" -A 10 | rg "expect\(.*true\)|assert.*True" # Weak assertions
rg "\.only\(|\.skip\(|@Ignore" # Skipped or focused tests
rg "setTimeout.*done\(\)|sleep\(|Thread\.Sleep" # Timing-dependent tests
```

#### Integration Points Validation
```bash
# API contract changes
rg "@RequestMapping|@GetMapping|@PostMapping|app\.get|app\.post" -A 3 -B 3
rg "ApiController|Controller.*public" -A 5 --type cs
rg "router\.|Route\.|endpoint\(" -A 3 --type typescript --type python

# Database schema impacts
rg "Migration|migration|ALTER.*TABLE|CREATE.*TABLE" --type cs --type python --type sql
rg "Column\(|ForeignKey\(|Index\(" -A 2 --type cs --type python
```

### Phase 9: Styling & Code Standards

#### Technology-Specific Style Issues
```bash
# JavaScript/TypeScript style issues
rg "var |==|\!\=|console\.log" --type typescript --type javascript
rg "function\(" --type typescript # Should use arrow functions in modern code
rg "\.innerHTML.*\+|\.innerHTML.*\$\{" # XSS risks

# Python style issues (PEP 8)
rg "import.*,.*,.*," --type python # Multiple imports per line
rg "^[a-z].*=[a-z].*=" --type python | rg -v "__" # Multiple assignments
rg "except.*:" --type python | rg -v "Exception" # Bare except clauses

# .NET style issues
rg "public.*[a-z]|private.*[a-z]" --type cs # Naming conventions
rg "catch.*\{.*\}" --type cs # Empty catch blocks
rg "string.*\+.*string.*\+" --type cs # String concatenation
```

#### Formatting and Structure
```bash
# Line length violations
rg ".{120,}" --type typescript --type cs --type python | head -20

# Inconsistent indentation
rg "^\t.*    |^    .*\t" --type typescript --type python --type cs

# Missing or excessive whitespace
rg "\{[A-Za-z]|[A-Za-z]\}|\)[A-Za-z]|[A-Za-z]\(" --type typescript --type cs
```

### Phase 10: Integration & Dependencies

#### Dependency Analysis
```bash
# Potentially problematic dependencies
rg "lodash|moment\.js|jquery" --type json # Heavy or deprecated libraries
rg "version.*[\"\'][01]\.|version.*[\"\'].*beta|version.*[\"\'].*alpha" --type json # Old or unstable versions

# Circular dependencies
rg "import.*\.\..*import" --type typescript
rg "using.*Project.*using.*Project" --type cs

# Missing error handling for external calls
rg "fetch\(|axios\.|http\.|HttpClient\." -A 5 | rg -v "catch\(|\.catch|try.*{" | head -10
```

## Review Execution Strategy

### 1. Automated Analysis Phase
```bash
# Execute all automated checks
npm run lint 2>&1 || echo "LINTING ISSUES FOUND"
npm test -- --coverage 2>&1 || echo "TEST FAILURES OR LOW COVERAGE"
npm run build 2>&1 || echo "BUILD FAILURES"

# Security scanning
npm audit --audit-level=moderate 2>&1 || echo "SECURITY VULNERABILITIES"
```

### 2. Risk-Based Review Depth

**High Risk Changes** (Apply all phases):
- Complete security assessment
- Full architecture review
- Business logic deep-dive
- Performance impact analysis
- Integration testing requirements

**Medium Risk Changes** (Focus on Phases 1-6):
- Security spot checks
- Architecture pattern compliance
- Code quality validation
- Technology-specific gotchas

**Low Risk Changes** (Phases 1, 6, 9):
- Basic security scan
- Style and formatting
- Documentation updates

### 3. Comprehensive Output Structure

## PR Review Report: [PR Title]

### 📋 Executive Summary
- **Risk Level**: [High/Medium/Low]
- **Recommendation**: [Approve/Request Changes/Needs Discussion]
- **Key Findings**: [Top 3-5 critical issues]
- **Estimated Review Effort**: [Hours/Days if significant changes needed]

### 🔒 Security Assessment
**OWASP Top 10 Analysis**:
- [Detailed findings for each applicable category]

**Critical Security Issues**:
- [List with severity and remediation steps]

### 🏗 Architecture & Design Review
**SOLID Principles Compliance**: [✅/⚠️/❌]
**Design Pattern Usage**: [Analysis of patterns used/misused]
**Anti-Patterns Detected**: [List with locations and fixes]

### 💼 Business Logic Analysis
**Impact Assessment**: [How changes affect business operations]
**Logic Vulnerabilities**: [Potential business rule bypasses or edge cases]
**Data Integrity Concerns**: [Data validation and consistency issues]

### ⚙️ Technology-Specific Issues
**[Technology] Gotchas Applied**: [Specific issues found using framework gotchas]
**Performance Implications**: [Technology-specific performance concerns]
**Best Practice Violations**: [Deviations from established patterns]

### 📚 Documentation & Quality
**Missing Documentation**: [What needs documentation]
**Code Quality Score**: [Based on automated analysis]
**Technical Debt Impact**: [How changes affect maintainability]

### 🎨 Style & Standards
**Formatting Issues**: [Automated style violations]
**Naming Convention Problems**: [Poor naming patterns found]
**Code Organization**: [Structural improvements needed]

### ⚡ Performance Analysis
**Performance Risks**: [Potential bottlenecks or inefficiencies]
**Database Impact**: [Query performance and N+1 issues]
**Resource Usage**: [Memory/CPU implications]

### ✅ Recommendations
**Must Fix (Blocking)**:
1. [Critical security issues]
2. [Business logic vulnerabilities]
3. [Architecture violations]

**Should Fix (Important)**:
1. [Performance concerns]
2. [Documentation gaps]
3. [Code quality issues]

**Could Fix (Nice to Have)**:
1. [Style improvements]
2. [Minor optimizations]
3. [Additional testing]

### 🔧 Action Items
- [ ] [Specific actionable items with owners]
- [ ] [Required testing or validation]
- [ ] [Documentation updates needed]

## Integration with Framework Standards

This comprehensive review process leverages:
- `References/Gotchas/validation_commands.md` for automated quality checks
- `References/Gotchas/automation_testing_gotchas.md` for testing standards
- `References/Gotchas/[technology]_gotchas.md` for technology-specific validations
- `References/Gotchas/architecture_patterns.md` for design compliance
- `References/Gotchas/general_coding_standards.md` for universal quality gates

The review adapts its depth and focus based on the detected risk level and technology stack, ensuring comprehensive coverage while maintaining efficiency for different types of changes.