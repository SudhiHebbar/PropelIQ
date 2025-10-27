# Anti-Patterns for Code quality & Architecture

**Purpose:** Comprehensive guide to avoid common mistakes across code quality, architecture patterns, and technology stacks.

## Universal Anti-Patterns (Any Language/Stack)

### Code Quality & Clean Code Violations

- ❌ **Reinventing the Wheel**: Don't create new patterns when existing ones work.
- ❌ **God Objects/Functions**: Don't create components that do too many things (violates SRP)
- ❌ **Copy-Paste Programming**: Don't duplicate logic - extract to shared utilities (violates DRY)
- ❌ **Magic Numbers/Strings**: Don't hardcode values that should be configurable
- ❌ **Premature Optimization**: Don't optimize before identifying actual bottlenecks
- ❌ **Error Swallowing**: Don't catch exceptions without proper handling or logging
- ❌ **Ignoring Test Failures**: Don't skip/mock tests to make them pass - fix the underlying issue

### Architecture & Design Violations

- ❌ **Circular Dependencies**: Don't create modules that depend on each other
- ❌ **Layer Violations**: Don't skip architectural layers or create shortcuts
- ❌ **Tight Coupling**: Don't make components dependent on implementation details
- ❌ **Interface Pollution**: Don't create fat interfaces with unrelated methods (violates ISP)
- ❌ **Dependency Inversion Violation**: Don't make high-level modules depend on low-level details

### Development Process Anti-Patterns

- ❌ **Big Bang Integration**: Don't integrate everything at once - use incremental integration
- ❌ **No Code Review**: Don't merge code without peer review
- ❌ **Configuration in Code**: Don't hardcode environment-specific values
- ❌ **Security as Afterthought**: Don't add security measures after development
- ❌ **Documentation Drift**: Don't let documentation become outdated
- ❌ **Ignoring API Rate Limits**: Don't ignore rate limits for APIs.

---

## Architecture Pattern Specific Anti-Patterns

### Layered Architecture Violations

```yaml
layer_skipping:
  - problem: "UI directly calling database layer"
  - solution: "Enforce layer boundaries - UI → Business → Data"
  - validation: "Check import statements for layer violations"

business_logic_leakage:
  - problem: "Database procedures containing business rules"
  - solution: "Keep business logic in business layer, not data layer"
  - validation: "Review stored procedures for business logic"

presentation_concerns_in_business:
  - problem: "Business layer handling UI formatting"
  - solution: "Business layer returns raw data, UI handles presentation"
  - validation: "Business layer shouldn't know about UI formats"

data_access_in_ui:
  - problem: "Putting database queries in presentation layer"
  - solution: "Move data access to appropriate data layer"
  - validation: "UI layer should not have database dependencies"
```

### Microservices Anti-Patterns

```yaml
distributed_monolith:
  - problem: "Services too tightly coupled - all must deploy together"
  - solution: "Design for independent deployability"
  - validation: "Can each service be deployed independently?"

shared_database:
  - problem: "Multiple services accessing same database tables"
  - solution: "Each service owns its data, communicate via APIs"
  - validation: "Database access should be service-private"

chatty_interfaces:
  - problem: "Multiple fine-grained calls between services"
  - solution: "Design coarser-grained APIs, batch operations"
  - validation: "Monitor network calls between services"

data_consistency_assumptions:
  - problem: "Expecting immediate consistency across services"
  - solution: "Design for eventual consistency"
  - validation: "Test with network delays and failures"

missing_failure_isolation:
  - problem: "Service failures cascade to other services"
  - solution: "Implement circuit breakers and fallback mechanisms"
  - validation: "Test cascade failure scenarios"
```

### Event-Driven Architecture Anti-Patterns

```yaml
event_coupling:
  - problem: "Events containing implementation details"
  - solution: "Events should be business facts, not technical events"
  - validation: "Events should make sense to business stakeholders"

missing_idempotency:
  - problem: "Processing same event multiple times has different effects"
  - solution: "Design event handlers to be idempotent"
  - validation: "Test processing same event multiple times"

event_ordering_assumptions:
  - problem: "Assuming events arrive in specific order"
  - solution: "Design for out-of-order event processing"
  - validation: "Test with events in different orders"

no_error_handling:
  - problem: "No dead letter queue or error recovery"
  - solution: "Implement dead letter queues and retry mechanisms"
  - validation: "Test what happens when event processing fails"

missing_correlation:
  - problem: "No way to trace related events through the system"
  - solution: "Implement correlation IDs for event tracking"
  - validation: "Can you trace an event flow end-to-end?"

event_immutability_violation:
  - problem: "Modifying events after they're published"
  - solution: "Events are facts - never change them after publishing"
  - validation: "Events should be immutable data structures"
```

### Hexagonal Architecture Anti-Patterns

```yaml
leaky_abstractions:
  - problem: "Core logic depending on adapter implementation details"
  - solution: "Core should only depend on port interfaces"
  - validation: "Can core logic run without any adapters?"

infrastructure_in_core:
  - problem: "Database entities or framework code in business logic"
  - solution: "Use domain models in core, map at adapter boundaries"
  - validation: "Core should have no framework dependencies"

multiple_responsibilities_in_adapter:
  - problem: "Single adapter handling multiple concerns"
  - solution: "One adapter per external concern (database, messaging, etc.)"
  - validation: "Adapters should have single responsibility"

unclear_port_definition:
  - problem: "Ports exposing implementation details or unclear contracts"
  - solution: "Ports define what core needs, not how it's provided"
  - validation: "Are port interfaces clear and stable?"
```

---

## Technology Stack Specific Anti-Patterns

### Frontend Anti-Patterns

```yaml
react_nextjs:
  hydration_mismatch:
    - problem: "Server and client render different content"
    - solution: "Ensure deterministic rendering, use suppressHydrationWarning sparingly"
    - validation: "Check console for hydration warnings"

  unnecessary_use_client:
    - problem: "Using 'use client' when server components would work"
    - solution: "Prefer server components, only use client when needed"
    - validation: "Audit 'use client' usage for necessity"

  prop_drilling:
    - problem: "Passing props through many component levels"
    - solution: "Use React Context, Zustand, Redux, or component composition"
    - validation: "Look for props passed through without use"

  inline_styles:
    - problem: "Styles defined within TypeScript/JavaScript files"
    - solution: "Move all styles to separate files in styles/ folder"
    - validation: "No style objects or CSS-in-JS in component files"

  eager_component_loading:
    - problem: "Loading all components at application start"
    - solution: "Implement route-level and component-level lazy loading"
    - validation: "Bundle analysis should show code splitting"

  browser_api_in_ssr:
    - problem: "Using browser APIs or event handlers in server components"
    - solution: "Use 'use client' directive when browser APIs are needed"
    - validation: "Check for window/document references in server components"

vue_nuxt:
  reactivity_loss:
    - problem: "Destructuring reactive objects loses reactivity"
    - solution: "Use toRefs() when destructuring reactive objects"
    - validation: "Test reactivity after destructuring"

  wrong_ref_usage:
    - problem: "Using ref() for complex objects or reactive() for primitives"
    - solution: "ref() for primitives, reactive() for objects"
    - validation: "Review ref/reactive usage patterns"

  inline_styles:
    - problem: "Styles defined within Vue component script sections"
    - solution: "Use external stylesheet files with src attribute"
    - validation: "No style objects in script setup or methods"

  component_eager_loading:
    - problem: "Importing all components in main bundle"
    - solution: "Use defineAsyncComponent for heavy components"
    - validation: "Bundle analysis shows component-level splitting"

  incorrect_composition_api:
    - problem: "Incorrect use of Composition API patterns"
    - solution: "Follow Vue 3 Composition API best practices"
    - validation: "Review setup() function and composable usage"
```

### Backend Anti-Patterns

```yaml
nodejs_express:
  unhandled_async_errors:
    - problem: "Async errors not caught by express error handlers"
    - solution: "Use async error middleware or express-async-errors"
    - validation: "Test error handling in async routes"

  middleware_order_issues:
    - problem: "Authentication middleware after route handlers"
    - solution: "Register middleware in correct order - auth before routes"
    - validation: "Review middleware registration order"

  unhandled_promise_rejections:
    - problem: "Unhandled promise rejections crash app"
    - solution: "Implement global promise rejection handler"
    - validation: "Test with failing async operations"

python_fastapi:
  sync_async_mixing:
    - problem: "Using sync database calls in async routes"
    - solution: "Use async database drivers consistently"
    - validation: "Audit database calls for sync/async consistency"

  incorrect_dependency_injection:
    - problem: "Not using Depends() for dependency injection"
    - solution: "Use FastAPI's DI system with Depends(), not direct instantiation"
    - validation: "Review parameter injection patterns"

  blocking_io_in_async:
    - problem: "Blocking I/O operations in async routes"
    - solution: "Use async/await consistently throughout async routes"
    - validation: "Check for synchronous file/network operations"

dotnet_aspnet:
  wrong_service_lifetime:
    - problem: "Using Singleton for stateful services or incorrect DI lifetime"
    - solution: "Understand DI lifetimes: Singleton/Scoped/Transient"
    - validation: "Review service registrations for appropriate lifetime"

  configuration_hardcoding:
    - problem: "Hard-coded configuration values"
    - solution: "Use IConfiguration and IOptions pattern"
    - validation: "Search for hard-coded connection strings/URLs"

  synchronous_io:
    - problem: "Using synchronous I/O in async controllers"
    - solution: "Use async/await throughout the call stack"
    - validation: "Check for .Result or .Wait() calls"
```

### Database Anti-Patterns

```yaml
relational_databases:
  n_plus_1_queries:
    - problem: "Separate query for each related entity"
    - solution: "Use eager loading, joins, or projection queries"
    - validation: "Monitor database query patterns"

  over_indexing:
    - problem: "Too many indexes slowing down writes"
    - solution: "Index only frequently queried columns"
    - validation: "Monitor write performance and index usage"

  under_indexing:
    - problem: "Poor query performance due to missing indexes"
    - solution: "Index frequently queried columns and foreign keys"
    - validation: "Analyze query execution plans"

  long_running_transactions:
    - problem: "Transactions held open too long causing deadlocks"
    - solution: "Keep transactions short and focused"
    - validation: "Monitor transaction duration and lock contention"

  missing_foreign_keys:
    - problem: "No referential integrity constraints"
    - solution: "Define foreign key relationships"
    - validation: "Check for orphaned records"

nosql_databases:
  inappropriate_modeling:
    - problem: "Using relational patterns in document databases"
    - solution: "Model for access patterns, denormalize appropriately"
    - validation: "Review query patterns and data model alignment"

  missing_consistency_handling:
    - problem: "Expecting immediate consistency in eventually consistent systems"
    - solution: "Design for eventual consistency, use appropriate consistency levels"
    - validation: "Test with consistency delays"

  unbounded_queries:
    - problem: "Queries without limits returning massive datasets"
    - solution: "Always use pagination or limits"
    - validation: "Check for queries without LIMIT clauses"
```

---

## Best Practices by Category

### Clean Code Practices

```yaml
single_responsibility:
  - ✅ "Each class/function has one reason to change"
  - ✅ "Components have focused, well-defined purposes"
  - validation: "Can you describe function without using 'and'?"

dry_principle:
  - ✅ "Extract common logic into utilities"
  - ✅ "Use constants for repeated values"
  - validation: "Search for duplicated logic patterns"

clear_naming:
  - ✅ "Use intention-revealing names"
  - ✅ "Avoid abbreviations and mental mapping"
  - validation: "Names should be self-explanatory"
```

### Architecture Practices

```yaml
loose_coupling:
  - ✅ "Components depend on abstractions, not concretions"
  - ✅ "Changes in one component don't require changes in others"
  - validation: "Can components be tested in isolation?"

high_cohesion:
  - ✅ "Related functionality grouped together"
  - ✅ "Components have clear, focused responsibilities"
  - validation: "Does component functionality belong together?"

dependency_direction:
  - ✅ "Dependencies flow toward stable abstractions"
  - ✅ "High-level policies don't depend on low-level details"
  - validation: "Check dependency graphs for violations"
```

### Security Practices

```yaml
input_validation:
  - ✅ "Validate all inputs at system boundaries"
  - ✅ "Use parameterized queries to prevent injection"
  - validation: "Test with malicious inputs"

least_privilege:
  - ✅ "Grant minimum necessary permissions"
  - ✅ "Use role-based access control"
  - validation: "Review permission grants regularly"

defense_in_depth:
  - ✅ "Multiple layers of security controls"
  - ✅ "Don't rely on single security mechanism"
  - validation: "Test security with multiple attack vectors"
```

---

## Validation Checklist by Pattern Type

### Code Quality Validation

- [ ] **Single Responsibility**: Does each component have one clear purpose?
- [ ] **DRY Compliance**: Is logic duplicated anywhere?
- [ ] **Clear Naming**: Are names self-explanatory?
- [ ] **Error Handling**: Are errors handled appropriately?
- [ ] **Test Coverage**: Are critical paths tested?

### Architecture Pattern Validation

- [ ] **Pattern Compliance**: Does implementation follow chosen pattern?
- [ ] **Boundary Enforcement**: Are architectural boundaries respected?
- [ ] **Dependency Direction**: Do dependencies flow correctly?
- [ ] **Coupling**: Are components loosely coupled?
- [ ] **Cohesion**: Is related functionality grouped together?

### Technology Stack Validation

- [ ] **Framework Patterns**: Are framework-specific patterns followed?
- [ ] **Performance**: Are there obvious performance issues?
- [ ] **Security**: Are security best practices followed?
- [ ] **Configuration**: Is configuration properly externalized?
- [ ] **Error Handling**: Are stack-specific error patterns used?

### SOLID Principles Violations

```yaml
single_responsibility_violation:
  - problem: "Classes/modules with multiple reasons to change"
  - solution: "Split into focused components with single responsibility"
  - validation: "Can you describe the component without using 'and'?"

open_closed_violation:
  - problem: "Modifying existing code to add features"
  - solution: "Extend behavior through interfaces and composition"
  - validation: "Can features be added without modifying existing code?"

liskov_substitution_violation:
  - problem: "Subtypes not substitutable for base types"
  - solution: "Ensure derived classes don't violate base class contracts"
  - validation: "Does substitution break expected behavior?"

interface_segregation_violation:
  - problem: "Fat interfaces with many unrelated methods"
  - solution: "Split interfaces based on client needs"
  - validation: "Do clients depend on methods they don't use?"

dependency_inversion_violation:
  - problem: "High-level modules depending on low-level details"
  - solution: "Depend on abstractions, not concretions"
  - validation: "Are dependencies pointing toward stable abstractions?"
```

---

_This comprehensive anti-patterns reference should be consulted during implementation to avoid common pitfalls and ensure high-quality, maintainable code that follows established patterns and principles._

### Performance Practices

```yaml
optimization_approach:
  - ✅ "Profile before optimizing - identify actual bottlenecks"
  - ✅ "Cache appropriately - but invalidate correctly"
  - ✅ "Use efficient algorithms and data structures"
  - ✅ "Optimize database queries based on execution plans"
  - ✅ "Consider memory usage patterns and garbage collection"
  - validation: "Use profiling tools to measure improvements"

caching_strategy:
  - ✅ "Cache expensive computations and external API calls"
  - ✅ "Implement cache invalidation strategies"
  - ✅ "Use appropriate cache levels (browser, CDN, application, database)"
  - validation: "Monitor cache hit rates and staleness"
```
