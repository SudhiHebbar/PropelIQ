name: "Automation Test Template - Process Workflow for Playwright"
description: |

## Purpose
Template optimized for AI agents to create automation test workflows based on use case analysis from requirements. This template generates process workflows that will be consumed by automation script generators for Playwright execution.

## Core Principles
1. **Process-Driven**: Focus on user workflow and business process automation
2. **Test-Ready**: Generate actionable test steps that map directly to Playwright scripts
3. **Context-Rich**: Include all necessary selectors, data, and validation points
4. **Scenario-Based**: Cover happy path, edge cases, and error scenarios
5. **Executable**: Every step should be automatable through Playwright/MCP tools
6. **Best Practice Compliance**: Follow automation testing gotchas and anti-patterns guidelines

## Critical Testing Guidelines
**⚠️ MANDATORY**: Review `.propel/gotchas/automation_testing_gotchas.md` before creating workflows
- **Avoid Hard-Coded Waits**: Use proper wait conditions instead of arbitrary timeouts
- **Use Stable Selectors**: Prefer data-testid, role-based, and semantic locators
- **Ensure Test Isolation**: Each test should be completely independent
- **Focus on User Behavior**: Test what users see and do, not implementation details

---

## Test Overview
**Test Suite Name**: [Name of the test suite based on feature/use case]
**Feature Under Test**: [Primary feature being tested]
**User Persona**: [Type of user performing the workflow]
**Business Process**: [High-level business process being automated]

## Use Case Analysis Source
**Requirements File**: [Path to source Spec.md]
**Use Case ID**: [Reference to specific use case from requirements]
**User Story ID**: [Reference to user story being tested]

## Test Environment Configuration
### Application Under Test
- **Base URL**: [Application base URL]
- **Environment**: [dev/staging/prod]
- **Browser Requirements**: [Chrome/Firefox/Safari/Edge requirements]
- **Resolution**: [Viewport size requirements]
- **Authentication**: [Login/auth requirements]

### Test Data Requirements
- **User Accounts**: [Required test user accounts and roles]
- **Test Data Sets**: [Required data for test execution]
- **Database State**: [Required database setup/teardown]
- **External Dependencies**: [APIs, services, integrations needed]

## Process Workflow Specification

### Primary Workflow: [Workflow Name]
**Objective**: [What the workflow achieves]
**Entry Point**: [Starting page/state]
**Exit Criteria**: [End state/success condition]

#### Step-by-Step Process Flow
```yaml
workflow_steps:
  - step_id: "001"
    action: "navigate"
    description: "[Human-readable description]"
    details:
      url: "[Target URL or route]"
      wait_condition: "[Element or state to wait for]"
    validation:
      - check: "[What to verify]"
        expected: "[Expected result]"
    selectors:
      - element: "[CSS selector or data-testid]"
        purpose: "[Why this element is important]"

  - step_id: "002"
    action: "input"
    description: "[Human-readable description]"
    details:
      target: "[Input field selector]"
      value: "[Test data or variable reference]"
      input_type: "[text/email/password/number]"
    validation:
      - check: "[Input validation]"
        expected: "[Expected behavior]"
    error_scenarios:
      - condition: "[Error condition]"
        expected_result: "[Expected error handling]"

  - step_id: "003"
    action: "click"
    description: "[Human-readable description]"
    details:
      target: "[Button/link selector]"
      wait_after: "[What to wait for after click]"
    validation:
      - check: "[Post-action validation]"
        expected: "[Expected result]"

  - step_id: "004"
    action: "verify"
    description: "[Human-readable description]"
    details:
      check_type: "[text/element/url/status]"
      target: "[What to check]"
      expected_value: "[Expected value]"
    assertions:
      - type: "[assertion type: visible/contains/equals/count]"
        value: "[expected value]"
```

### Alternative Workflows
#### Error Scenario 1: [Error Name]
**Trigger**: [What causes this error scenario]
**Expected Behavior**: [How system should handle error]

```yaml
error_workflow_steps:
  - step_id: "E001"
    action: "[action type]"
    description: "[Error step description]"
    validation:
      - check: "[Error validation]"
        expected: "[Expected error state]"
```

#### Edge Case 1: [Edge Case Name]
**Scenario**: [Description of edge case]
**Expected Behavior**: [Expected system behavior]

```yaml
edge_case_steps:
  - step_id: "EC001"
    action: "[action type]"
    description: "[Edge case step description]"
    validation:
      - check: "[Edge case validation]"
        expected: "[Expected result]"
```

## Playwright Integration Specifications

### Page Object Model Structure
```yaml
page_objects:
  - page_name: "[PageName]"
    file_path: "pages/[page-name].page.js"
    elements:
      - name: "[elementName]"
        selector: "[CSS selector]"
        type: "[button/input/text/dropdown]"
    methods:
      - name: "[methodName]"
        purpose: "[What the method does]"
        parameters: "[Required parameters]"
```

### Test Data Management
```yaml
test_data:
  - data_set: "[DataSetName]"
    file_path: "data/[dataset-name].json"
    structure:
      - field: "[field_name]"
        type: "[data type]"
        purpose: "[usage purpose]"
```

### Assertion Strategy
```yaml
assertions:
  - type: "visual"
    description: "[Visual validation description]"
    screenshot_comparison: "[baseline image reference]"
  
  - type: "functional"
    description: "[Functional validation description]"
    validation_points:
      - element: "[selector]"
        check: "[what to verify]"
  
  - type: "performance"
    description: "[Performance validation description]"
    metrics:
      - metric: "[load_time/response_time]"
        threshold: "[acceptable limit]"
```

## Test Execution Configuration

### Browser Configuration
```yaml
browser_config:
  - browser: "chromium"
    viewport: { width: 1920, height: 1080 }
    device_scale_factor: 1
    headless: false
  - browser: "firefox"
    viewport: { width: 1920, height: 1080 }
    headless: false
  - browser: "webkit"
    viewport: { width: 1920, height: 1080 }
    headless: false
```

### Parallel Execution Strategy
```yaml
execution:
  parallel: true
  workers: 4
  retries: 2
  timeout: 30000
  test_isolation: true
```

## Success Criteria & Validation Points

### Primary Success Criteria
- [ ] [Specific measurable outcome 1]
- [ ] [Specific measurable outcome 2]
- [ ] [Specific measurable outcome 3]

### Quality Gates
- [ ] All steps execute without errors
- [ ] All assertions pass consistently
- [ ] Performance thresholds are met
- [ ] Error scenarios are handled correctly
- [ ] Cross-browser compatibility verified

## Maintenance & Sustainability

### Selector Strategy
**⚠️ CRITICAL**: Follow selector hierarchy from `.propel/gotchas/automation_testing_gotchas.md`

**Preferred Selectors** (in order of preference):
1. **Role-based locators** (BEST): `page.getByRole('button', { name: 'Submit' })`
2. **Test ID attributes**: `page.getByTestId('submit-button')`
3. **Semantic locators**: `page.getByLabel('Email')`, `page.getByPlaceholder('Enter email')`
4. **ARIA attributes**: `[aria-label="Close dialog"]`
5. **Stable CSS classes**: `.permanent-class-name` (only if guaranteed stable)

**❌ AVOID THESE SELECTORS:**
- Dynamic IDs: `#user-123456-profile`
- Complex CSS paths: `div > div:nth-child(3) > button`
- Styling classes: `.btn-primary.rounded.shadow`
- Text content that changes: `'Updated 2 minutes ago'`

**✅ SELECTOR EXAMPLES:**
```yaml
# Good selector examples for workflow steps
selectors:
  login_button: "page.getByRole('button', { name: 'Login' })"
  email_input: "page.getByLabel('Email address')"
  error_message: "page.getByRole('alert')"
  navigation_menu: "page.getByTestId('main-nav')"
```

### Wait Strategy Guidelines
**⚠️ CRITICAL**: Never use hard-coded waits - see automation_testing_gotchas.md

**✅ PROPER WAIT CONDITIONS:**
```yaml
wait_strategies:
  element_visibility: "await page.waitForSelector('#element', { state: 'visible' })"
  network_response: "await page.waitForResponse(response => response.url().includes('/api/data'))"
  custom_condition: "await page.waitForFunction(() => window.myApp.isReady)"
  web_first_assertion: "await expect(page.getByText('Success')).toBeVisible({ timeout: 10000 })"
```

**❌ FORBIDDEN PRACTICES:**
- `await page.waitForTimeout(5000)` - Never use arbitrary timeouts
- Racing conditions with immediate actions after clicks
- Assuming elements are immediately available

### Test Data Management Strategy
**Approach**: [static/dynamic/api-generated]
**Cleanup Strategy**: [How to clean up test data]
**Isolation Strategy**: [How to ensure test isolation]

### Reporting Requirements
```yaml
reporting:
  - type: "html"
    include_screenshots: true
    include_video: true
  - type: "junit"
    for_ci_integration: true
  - type: "allure"
    detailed_reporting: true
```

## Generated Script Expectations
This workflow specification should generate:

1. **Main Test File**: `test-automation/tests/[feature-name].spec.js`
2. **Page Objects**: `test-automation/pages/[page-name].page.js`
3. **Test Data**: `test-automation/data/[test-data].json`
4. **Configuration**: `test-automation/playwright.config.js` updates
5. **Utilities**: `test-automation/utils/[helper-functions].js`

## Integration Points
**Previous Command**: This file is generated by automation test creation slash command
**Next Command**: `generate` command will consume this workflow to create Playwright scripts
**Output Location**: `Context/Test/[test-workflow-name].md`
**Script Output Location**: `test-automation/` directory structure

---

*This template ensures comprehensive test workflow documentation that directly translates to executable Playwright automation scripts.*