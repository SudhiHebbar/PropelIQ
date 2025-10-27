# Architecture Patterns Reference Guide

> **Purpose:** Reference guide for architecture patterns, implementation gotchas, and validation checklists to ensure proper system design and avoid common architectural pitfalls across different technology stacks and business requirements.

## Architecture Patterns Quick Reference

| **Pattern**                  | **Best For**                                | **Key Gotchas**                                                    |
| ---------------------------- | ------------------------------------------- | ------------------------------------------------------------------ |
| Layered (N-Tier)             | Well-understood domains, clear separation   | Don't skip layers; avoid data access in presentation layer         |
| Modular Monolith             | Single team, simpler ops than microservices | Enforce module boundaries strictly; prevent circular dependencies  |
| Microservices                | Multiple teams, independent scaling         | Avoid distributed monolith; handle network failures gracefully     |
| Event-Driven                 | Real-time flows, decoupled components       | Handle event ordering and duplicates; embrace eventual consistency |
| Hexagonal (Ports & Adapters) | Highly testable, framework-independent      | Don't create leaky abstractions; keep core logic pure              |
| CQRS & Event Sourcing        | Audit requirements, temporal queries        | Separate read/write models completely; version events carefully    |
| Serverless / FaaS            | Variable load, minimal ops overhead         | Watch for cold starts; design for statelessness                    |

## Implementation Best Practices by Pattern

### Layered Architecture

```yaml
critical_rules:
  - layer_communication: "Only communicate with adjacent layers"
  - separation_of_concerns: "Each layer has distinct responsibility"
  - dependency_direction: "Dependencies flow in one direction (usually downward)"

best_practices:
  - clear_interfaces: "Define clear contracts between layers"
  - dependency_injection: "Use DI to manage dependencies between layers"
  - dto_patterns: "Use DTOs for data transfer between layers"

validation_points:
  - check_dependencies: "Verify layer dependencies don't violate architecture"
  - test_isolation: "Can you test business logic without database?"
  - layer_cohesion: "Is functionality properly grouped in layers?"
```

### Microservices Architecture

```yaml
critical_rules:
  - service_autonomy: "Each service owns its data and decisions"
  - failure_isolation: "Service failures don't cascade"
  - communication_patterns: "Async messaging preferred over sync calls"

best_practices:
  - api_versioning: "Version APIs for backward compatibility"
  - service_discovery: "Use service registry for dynamic discovery"
  - circuit_breakers: "Implement circuit breakers for resilience"
  - distributed_tracing: "Use correlation IDs for request tracking"

validation_points:
  - service_boundaries: "Can service be developed/deployed independently?"
  - data_ownership: "Does service own all data it needs?"
  - failure_handling: "What happens when dependencies fail?"
```

### Event-Driven Architecture

```yaml
critical_rules:
  - event_immutability: "Events are facts - never change them"
  - idempotency: "Processing same event multiple times has same effect"
  - eventual_consistency: "Accept that data won't be immediately consistent"

best_practices:
  - event_versioning: "Version events for backward compatibility"
  - event_sourcing: "Store events as source of truth when appropriate"
  - saga_patterns: "Use sagas for distributed transactions"
  - correlation_tracking: "Implement correlation IDs for event flows"

validation_points:
  - event_schema: "Are events versioned and backward compatible?"
  - duplicate_handling: "What happens if event is processed twice?"
  - dead_letter_queue: "How are failed events handled?"
```

### Hexagonal (Ports & Adapters)

```yaml
critical_rules:
  - core_isolation: "Business logic has no external dependencies"
  - port_definition: "Ports define what core needs, not how it's provided"
  - adapter_responsibility: "Adapters translate between core and external world"

best_practices:
  - domain_modeling: "Use rich domain models in core"
  - test_doubles: "Use test doubles for adapters in testing"
  - mapper_pattern: "Use mappers to convert between domain and infrastructure models"
  - repository_pattern: "Abstract data access through repository interfaces"

validation_points:
  - core_purity: "Can core logic run without any adapters?"
  - port_clarity: "Are port interfaces clear and stable?"
  - adapter_swapping: "Can adapters be replaced without changing core?"
```

## Clean Code Architecture Principles

### SOLID Principles Application

```yaml
single_responsibility:
  architecture_level: "Each service/module has one reason to change"
  component_level: "Each class/function does one thing well"
  implementation: "Split large components into focused, cohesive units"

open_closed:
  architecture_level: "Add features through new modules, not modifications"
  component_level: "Extend behavior through interfaces and composition"
  implementation: "Use strategy pattern, plugins, or extension points"

liskov_substitution:
  architecture_level: "Services can be swapped if they implement same contract"
  component_level: "Subtypes must be substitutable for base types"
  implementation: "Ensure derived classes honor base class contracts"

interface_segregation:
  architecture_level: "Services don't depend on capabilities they don't use"
  component_level: "Create focused, role-based interfaces"
  implementation: "Split fat interfaces into smaller, cohesive ones"

dependency_inversion:
  architecture_level: "High-level policies don't depend on low-level details"
  component_level: "Depend on abstractions, not concretions"
  implementation: "Use dependency injection and interface-based design"
```

### DRY (Don't Repeat Yourself) & Other Principles

```yaml
dry_principle:
  architecture_level:
    - shared_libraries: "Common utilities in shared packages"
    - configuration: "Centralized configuration management"
    - patterns: "Consistent patterns across services/modules"
  component_level:
    - utility_functions: "Extract common operations"
    - constants: "Centralize magic numbers and strings"
    - validation_logic: "Reusable validation functions"

kiss_principle:
  guideline: "Keep It Simple, Stupid - prefer simple solutions"
  implementation: "Start simple, add complexity only when needed"
  validation: "Can a simpler solution achieve the same goal?"

yagni_principle:
  guideline: "You Aren't Gonna Need It - don't add functionality until needed"
  implementation: "Build what's required now, not what might be needed"
  validation: "Is this feature actually required or speculative?"
```

## Technology Stack Best Practices

### Frontend Architecture

```yaml
react_nextjs:
  server_components:
    best_practice: "Prefer server components for better performance"
    guideline: "Use 'use client' only when browser APIs are needed"

  state_management:
    best_practice: "Choose appropriate state management solution"
    options: "React Context for simple state, Zustand/Redux for complex state"

  performance:
    best_practice: "Implement code splitting and lazy loading"
    guideline: "Use dynamic imports for route-level splitting"

vue_nuxt:
  composition_api:
    best_practice: "Use Composition API for better TypeScript support"
    guideline: "ref() for primitives, reactive() for objects"

  reactivity:
    best_practice: "Maintain reactivity when destructuring"
    guideline: "Use toRefs() to preserve reactivity"
```

### Backend Architecture

```yaml
nodejs_express:
  error_handling:
    best_practice: "Implement centralized error handling"
    guideline: "Use error middleware for consistent error responses"

  middleware:
    best_practice: "Order middleware correctly"
    guideline: "Authentication → Authorization → Business Logic"

python_fastapi:
  dependency_injection:
    best_practice: "Use FastAPI's DI system"
    guideline: "Leverage Depends() for reusable components"

  async_patterns:
    best_practice: "Use async/await consistently"
    guideline: "Async all the way down the call stack"

dotnet_aspnet:
  dependency_injection:
    best_practice: "Choose appropriate service lifetimes"
    guideline: "Singleton for stateless, Scoped for request, Transient for lightweight"

  configuration:
    best_practice: "Externalize configuration"
    guideline: "Use IConfiguration with appsettings.json"
```

### Database Architecture

```yaml
relational_databases:
  query_optimization:
    best_practice: "Optimize queries based on execution plans"
    guideline: "Use appropriate indexes and avoid N+1 queries"

  transaction_management:
    best_practice: "Keep transactions short and focused"
    guideline: "Use appropriate isolation levels"

nosql_databases:
  data_modeling:
    best_practice: "Model for access patterns"
    guideline: "Denormalize data appropriately for read performance"

  consistency:
    best_practice: "Design for eventual consistency"
    guideline: "Use appropriate consistency levels for operations"
```

## Architecture Validation Checklists

### Universal Architecture Best Practices

- [ ] **Single Responsibility:** Each component has one clear purpose
- [ ] **Loose Coupling:** Components can be changed independently
- [ ] **High Cohesion:** Related functionalities are grouped together
- [ ] **Clear Interfaces:** Well-defined contracts between components
- [ ] **Dependency Management:** Dependencies flow toward stable abstractions
- [ ] **Failure Resilience:** Graceful degradation and recovery mechanisms
- [ ] **Testability:** Components can be tested in isolation
- [ ] **Performance:** Architecture meets performance requirements
- [ ] **Scalability:** System can handle expected growth
- [ ] **Security:** Security implemented at appropriate layers
- [ ] **Maintainability:** Easy to understand, modify, and extend
- [ ] **Documentation:** Architecture decisions are well-documented

### Pattern-Specific Best Practices

```yaml
layered:
  - [ ] "Clear layer boundaries with defined interfaces"
  - [ ] "Consistent data flow direction"
  - [ ] "Each layer independently testable"
  - [ ] "Proper separation of concerns"

microservices:
  - [ ] "Services aligned with business capabilities"
  - [ ] "Independent deployment capability"
  - [ ] "Service discovery and registry implemented"
  - [ ] "Circuit breakers and retry logic in place"
  - [ ] "Distributed tracing for debugging"

event_driven:
  - [ ] "Events are immutable and versioned"
  - [ ] "Idempotent event processing implemented"
  - [ ] "Event store for audit trail"
  - [ ] "Dead letter queue for failed events"
  - [ ] "Event schema registry maintained"

hexagonal:
  - [ ] "Core domain logic is framework-free"
  - [ ] "Clear port interfaces defined"
  - [ ] "Adapters handle all external concerns"
  - [ ] "Domain models separate from persistence models"
  - [ ] "Easy to add new adapters"
```

---

## Quick Decision Matrix

**Use this to quickly identify the right pattern for your feature:**

| **Requirement**               | **Recommended Pattern**      | **Alternative**         |
| ----------------------------- | ---------------------------- | ----------------------- |
| Simple CRUD with clear layers | Layered Architecture         | Hexagonal               |
| High testability required     | Hexagonal (Ports & Adapters) | Layered with DI         |
| Independent team deployments  | Microservices                | Modular Monolith        |
| Real-time event processing    | Event-Driven                 | Reactive/Streaming      |
| Audit trail requirements      | Event Sourcing + CQRS        | Event-Driven            |
| Variable/unpredictable load   | Serverless/FaaS              | Auto-scaling Containers |
| Legacy system integration     | Service-Oriented (SOA)       | Event-Driven            |
| Extreme performance needs     | Space-Based (Grid)           | Reactive                |

---

_This guide should be referenced to ensure architecture decisions align with established patterns and avoid common pitfalls._
