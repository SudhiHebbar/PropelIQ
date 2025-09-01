# Automation Testing Gotchas - Playwright Best Practices

## Critical Anti-Patterns to Avoid

### 🚫 Hard-Coded Waits and Timeouts
**DON'T:**
```javascript
await page.waitForTimeout(2000); // Arbitrary delay
await page.click('#submit');
```

**DO:**
```javascript
await page.waitForSelector('#submit', { state: 'visible' });
await page.click('#submit');
// OR use web-first assertions
await expect(page.locator('#submit')).toBeVisible();
await page.click('#submit');
```

**Why:** Hard-coded timeouts make tests slower and unreliable. They don't adapt to varying system performance and can still fail if the element takes longer than expected.

### 🚫 Fragile CSS Selectors
**DON'T:**
```javascript
// Brittle selectors that change frequently
await page.click('.btn-primary.mt-3.px-4');
await page.click('div:nth-child(3) > button');
await page.click('#component-1234-button');
```

**DO:**
```javascript
// Stable, semantic selectors
await page.getByRole('button', { name: 'Submit' }).click();
await page.getByTestId('submit-button').click();
await page.getByLabel('Submit form').click();
```

**Why:** CSS classes and generated IDs change with UI updates. Role-based and test-id selectors are more stable and meaningful.

### 🚫 Test Dependencies and Shared State
**DON'T:**
```javascript
test('login user', async ({ page }) => {
  await loginUser(page);
  // Test leaves user logged in
});

test('view dashboard', async ({ page }) => {
  // Assumes user is already logged in from previous test
  await page.goto('/dashboard');
});
```

**DO:**
```javascript
test('view dashboard', async ({ page }) => {
  await loginUser(page); // Each test handles its own setup
  await page.goto('/dashboard');
  await expect(page.getByRole('heading', { name: 'Dashboard' })).toBeVisible();
});
```

**Why:** Test dependencies cause cascading failures and make tests harder to debug and run independently.

## Selector Strategy Best Practices

### ✅ Selector Priority Hierarchy
1. **Role-based locators** (Preferred)
   ```javascript
   page.getByRole('button', { name: 'Submit' })
   page.getByRole('textbox', { name: 'Email' })
   page.getByRole('link', { name: 'Home' })
   ```

2. **Test ID attributes**
   ```javascript
   page.getByTestId('user-menu')
   page.getByTestId('submit-form-button')
   ```

3. **Semantic locators**
   ```javascript
   page.getByLabel('Email address')
   page.getByPlaceholder('Enter your email')
   page.getByText('Continue')
   ```

4. **ARIA attributes**
   ```javascript
   page.locator('[aria-label="Close dialog"]')
   page.locator('[aria-describedby="help-text"]')
   ```

5. **CSS selectors** (Last resort)
   ```javascript
   page.locator('.stable-class-name') // Only if stable
   ```

### ❌ Selectors to Avoid
- Dynamic IDs: `#user-123456-profile`
- Complex CSS paths: `div > div:nth-child(3) > button`
- Text content that changes: `page.getByText('Updated 2 minutes ago')`
- Styling classes: `.btn-primary.rounded.shadow`

## Wait Strategy Gotchas

### ✅ Proper Wait Conditions
```javascript
// Wait for element state
await page.waitForSelector('#element', { state: 'visible' });
await page.waitForSelector('#element', { state: 'attached' });

// Wait for network requests
await page.waitForResponse(response => response.url().includes('/api/data'));

// Wait for custom conditions
await page.waitForFunction(() => window.myApp.isReady);

// Web-first assertions with automatic waiting
await expect(page.getByText('Success')).toBeVisible({ timeout: 10000 });
```

### ❌ Timing Anti-Patterns
```javascript
// Never use these
await page.waitForTimeout(5000); // Arbitrary wait
await page.click(); await page.waitForTimeout(100); // Racing conditions
```

## Test Organization Gotchas

### ✅ Proper Test Structure
```javascript
test.describe('User Authentication', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/login');
  });

  test('should login with valid credentials', async ({ page }) => {
    await page.getByLabel('Email').fill('user@example.com');
    await page.getByLabel('Password').fill('password');
    await page.getByRole('button', { name: 'Login' }).click();
    
    await expect(page.getByText('Welcome')).toBeVisible();
  });

  test.afterEach(async ({ page }) => {
    // Cleanup if needed
    await page.evaluate(() => localStorage.clear());
  });
});
```

### ❌ Poor Test Organization
```javascript
// DON'T: Vague test names
test('test1', async ({ page }) => { /* ... */ });
test('check stuff', async ({ page }) => { /* ... */ });

// DON'T: Tests that do too much
test('complete user workflow', async ({ page }) => {
  // 50+ lines testing login, navigation, form submission, etc.
});
```

## Assertion Gotchas

### ✅ Comprehensive Assertions
```javascript
// Assert on user-visible behavior
await expect(page.getByRole('alert')).toHaveText('Form submitted successfully');
await expect(page.locator('.user-profile')).toContainText('John Doe');
await expect(page).toHaveURL(/\/dashboard/);

// Visual assertions
await expect(page.getByRole('button', { name: 'Submit' })).toBeEnabled();
await expect(page.getByText('Loading...')).not.toBeVisible();
```

### ❌ Weak Assertions
```javascript
// DON'T: Just check element exists
const element = await page.$('#success');
expect(element).toBeTruthy(); // Too vague

// DON'T: Test implementation details
expect(await page.evaluate(() => myApp.internal.state)).toBe('loaded');
```

## Network and API Gotchas

### ✅ Proper API Mocking
```javascript
test('should handle API errors gracefully', async ({ page }) => {
  await page.route('/api/users', route => {
    route.fulfill({
      status: 500,
      contentType: 'application/json',
      body: JSON.stringify({ error: 'Internal server error' })
    });
  });

  await page.goto('/users');
  await expect(page.getByText('Unable to load users')).toBeVisible();
});
```

### ❌ Relying on External Services
```javascript
// DON'T: Test against live APIs
test('should fetch user data', async ({ page }) => {
  await page.goto('/users');
  // Relies on external API being available and returning specific data
  await expect(page.getByText('John Doe')).toBeVisible();
});
```

## Page Object Model Gotchas

### ✅ Clean Page Objects
```javascript
export class LoginPage {
  constructor(page) {
    this.page = page;
  }

  get emailInput() {
    return this.page.getByLabel('Email');
  }

  get passwordInput() {
    return this.page.getByLabel('Password');
  }

  get loginButton() {
    return this.page.getByRole('button', { name: 'Login' });
  }

  async login(email, password) {
    await this.emailInput.fill(email);
    await this.passwordInput.fill(password);
    await this.loginButton.click();
  }

  async verifyLoginSuccess() {
    await expect(this.page.getByText('Welcome')).toBeVisible();
  }
}
```

### ❌ Page Object Anti-Patterns
```javascript
// DON'T: Include test logic in page objects
export class LoginPage {
  async testValidLogin() { // Page objects shouldn't contain test logic
    expect(await this.isLoggedIn()).toBe(true);
  }

  async clickSubmitAndWait() { // Avoid arbitrary waits
    await this.loginButton.click();
    await this.page.waitForTimeout(2000);
  }
}
```

## Data Management Gotchas

### ✅ Test Data Best Practices
```javascript
// Use fixtures for consistent test data
const testData = {
  validUser: {
    email: 'test@example.com',
    password: 'SecurePass123!'
  },
  invalidUser: {
    email: 'invalid@example.com',
    password: 'wrong'
  }
};

test('login with valid credentials', async ({ page }) => {
  await loginPage.login(testData.validUser.email, testData.validUser.password);
});
```

### ❌ Hard-Coded Test Data
```javascript
// DON'T: Hard-code data in tests
test('login test', async ({ page }) => {
  await page.fill('#email', 'user123@test.com'); // Hard-coded
  await page.fill('#password', 'pass123'); // Hard-coded
});
```

## Browser Configuration Gotchas

### ✅ Proper Browser Setup
```javascript
// playwright.config.js
export default defineConfig({
  testDir: './tests',
  timeout: 30000,
  expect: {
    timeout: 5000
  },
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure'
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] }
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] }
    }
  ]
});
```

### ❌ Configuration Mistakes
```javascript
// DON'T: Overly long timeouts
timeout: 120000, // 2 minutes is usually too long

// DON'T: No retry strategy
retries: 0, // In CI, retries can help with flaky infrastructure

// DON'T: Single browser testing only
projects: [{ name: 'chromium' }] // Test multiple browsers
```

## Debugging Gotchas

### ✅ Effective Debugging Techniques
```javascript
// Use Playwright's debugging tools
test('debug failing test', async ({ page }) => {
  await page.pause(); // Pauses execution for manual inspection
  
  // Take screenshots for visual debugging
  await page.screenshot({ path: 'debug-screenshot.png' });
  
  // Console logging for state inspection
  console.log('Current URL:', page.url());
  console.log('Page title:', await page.title());
});
```

### ❌ Poor Debugging Practices
```javascript
// DON'T: Leave debug code in production tests
test('my test', async ({ page }) => {
  console.log('Debug: starting test'); // Remove debug logs
  await page.pause(); // Remove pause statements
  await page.waitForTimeout(10000); // Don't add long waits for debugging
});
```

## Performance Gotchas

### ✅ Efficient Test Execution
```javascript
// Parallel test execution
test.describe.configure({ mode: 'parallel' });

// Efficient page object reuse
test.beforeEach(async ({ page }) => {
  await page.goto('/app');
  // Reuse authentication state
  await page.context().addCookies([authCookie]);
});
```

### ❌ Performance Anti-Patterns
```javascript
// DON'T: Recreate expensive setup in each test
test('test 1', async ({ page }) => {
  await performExpensiveSetup(); // Repeated in every test
});

// DON'T: Sequential test execution when parallel is possible
test.describe.configure({ mode: 'serial' }); // Usually unnecessary
```

## Security and Credentials Gotchas

### ✅ Secure Credential Management
```javascript
// Use environment variables
const credentials = {
  email: process.env.TEST_EMAIL,
  password: process.env.TEST_PASSWORD
};

// Use Playwright's auth storage
await page.context().storageState({ path: 'auth.json' });
```

### ❌ Security Anti-Patterns
```javascript
// DON'T: Hard-code credentials
await page.fill('#password', 'my-secret-password'); // Exposed in code

// DON'T: Use production credentials in tests
const prodUser = 'admin@company.com'; // Never use real credentials
```

## References and Further Reading

### Official Documentation
- [Playwright Best Practices](https://playwright.dev/docs/best-practices) - Official Playwright guidelines
- [Playwright Locators](https://playwright.dev/docs/locators) - Comprehensive locator strategies
- [Playwright Assertions](https://playwright.dev/docs/test-assertions) - Web-first assertion patterns

### Community Resources
- [Better Stack - Playwright Best Practices](https://betterstack.com/community/guides/testing/playwright-best-practices/) - Community-driven best practices
- [Medium - Flaky Test Prevention](https://medium.com/@samuel.sperling/say-goodbye-to-flaky-tests-playwright-best-practices-every-test-automation-engineer-must-know-9dfeb9bb5017) - Flaky test prevention strategies
- [TestGrid - Playwright Testing Guide](https://testgrid.io/blog/playwright-testing/) - Comprehensive automation testing guide

### Tool Integration
- [Playwright Inspector](https://playwright.dev/docs/debug#playwright-inspector) - Built-in debugging tool
- [Trace Viewer](https://playwright.dev/docs/trace-viewer) - Post-mortem debugging
- [VS Code Extension](https://playwright.dev/docs/getting-started-vscode) - IDE integration

---

**Remember:** The goal of automation testing is to build confidence in your application's behavior. Focus on user-centric testing, maintain stable and readable tests, and leverage Playwright's powerful built-in capabilities rather than fighting against the framework.