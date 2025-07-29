# /ace-test-e2e - End-to-End Testing with Playwright MCP

Generate and execute comprehensive E2E tests using Playwright MCP integration for specification-driven testing.

## Command Syntax

```bash
/ace-test-e2e [options]
```

## Core Features

### 1. Specification-Driven Test Generation
Generate E2E tests directly from acceptance criteria:

```bash
# Generate tests for specific user story
/ace-test-e2e --generate --story="US-001"

# Generate tests for specific acceptance criteria  
/ace-test-e2e --generate --criteria="AC-001-01,AC-001-02"

# Generate full test suite
/ace-test-e2e --generate --all
```

### 2. Test Execution
Execute E2E tests with comprehensive reporting:

```bash
# Run all E2E tests
/ace-test-e2e --run

# Run tests for specific feature
/ace-test-e2e --run --feature="authentication"

# Run with specific browser
/ace-test-e2e --run --browser="chromium"

# Run headless mode
/ace-test-e2e --run --headless
```

### 3. Accessibility Testing
Ensure WCAG compliance:

```bash
# Run accessibility tests only
/ace-test-e2e --accessibility

# Include accessibility in regular test run
/ace-test-e2e --run --include-a11y
```

### 4. Real-time Feature Testing
Test AWS Amplify subscriptions and live features:

```bash
# Test real-time subscriptions
/ace-test-e2e --realtime

# Test with multiple browser tabs (concurrent users)
/ace-test-e2e --run --tabs=3
```

## Available Test Types

### Authentication Flow Tests
- User registration with email verification
- Sign-in/sign-out flows
- Password reset functionality
- Social authentication (if configured)

### Data Operations Tests
- CRUD operations with Amplify Gen 2
- Real-time data synchronization
- Offline/online state handling
- File upload/download workflows

### UI/UX Tests
- Responsive design validation
- Form validation and error states
- Navigation and routing
- Component interaction testing

### Integration Tests
- AWS service integration (S3, Cognito, etc.)
- Third-party API integrations
- Payment processing flows
- Email/notification systems

## Command Examples

### Generate Tests from Specifications
```bash
# ACE-Flow Context: Generate E2E tests for a social platform
You are working on a social platform application with the following acceptance criteria:

**User Story US-001**: User Registration
- AC-001-01: User can register with email and password
- AC-001-02: User receives email verification
- AC-001-03: User can complete email verification

**User Story US-012**: Real-time Updates  
- AC-012-01: User sees live post updates
- AC-012-02: User receives instant notifications

Generate comprehensive E2E tests using Playwright MCP for these acceptance criteria. Include:

1. **Authentication Flow Testing**
   - Registration form interaction
   - Email verification simulation
   - AWS Cognito integration validation

2. **Real-time Feature Testing**
   - WebSocket subscription testing
   - Multi-tab concurrent user simulation
   - Live update propagation verification

3. **Accessibility Compliance**
   - WCAG 2.1 AA standard validation
   - Keyboard navigation testing
   - Screen reader compatibility

4. **AWS Amplify Gen 2 Compliance**
   - Verify Gen 2 client usage patterns
   - Check for legacy Gen 1 patterns
   - Validate TypeScript schema integration

Create test files following the ACE-Flow specification-driven approach with full traceability to acceptance criteria.
```

### Execute Tests with Reporting
```bash
# ACE-Flow Context: Execute E2E test suite
Run the complete E2E test suite using Playwright MCP with the following requirements:

1. **Test Execution**
   - Run all generated tests from acceptance criteria
   - Use headless browser mode for CI/CD
   - Capture screenshots on failures
   - Record browser interactions for debugging

2. **Accessibility Validation**
   - Run accessibility snapshots on all pages
   - Validate WCAG 2.1 AA compliance
   - Generate accessibility report

3. **Performance Monitoring**
   - Track page load times
   - Monitor network requests
   - Validate AWS Amplify API calls

4. **Compliance Reporting**
   - Generate specification coverage report
   - Track acceptance criteria validation
   - Export results in JSON and HTML formats

Execute tests and provide comprehensive compliance dashboard showing:
- Overall test pass rate
- Specification coverage percentage
- Accessibility compliance score
- AWS Amplify Gen 2 pattern adherence
```

### Debug Failed Tests
```bash
# ACE-Flow Context: Debug test failures
Analyze failed E2E tests and provide debugging assistance:

1. **Failure Analysis**
   - Review console messages and network requests
   - Analyze screenshot evidence
   - Check element selection issues

2. **Common Issue Resolution**
   - Timing issues with dynamic content
   - Element not found problems
   - AWS Amplify authentication failures

3. **Test Optimization**
   - Improve element selectors
   - Add appropriate wait conditions
   - Enhance error handling

4. **Specification Alignment**
   - Verify tests match acceptance criteria
   - Update test scenarios based on spec changes
   - Maintain traceability links

Provide specific recommendations for test fixes and improvements.
```

## Integration with ACE-Flow Commands

### Pre-Implementation Testing
```bash
# Generate tests before implementation
/ace-genesis social_platform
/ace-test-e2e --generate --from-specs
```

### Post-Implementation Validation
```bash
# Validate implementation against specs
/ace-implement --feature="messaging"
/ace-test-e2e --run --validate-specs
```

### Continuous Testing
```bash
# Hook for automatic test execution
{
  "PostImplement": [
    {
      "type": "command", 
      "command": "ace-test-e2e",
      "args": ["--run", "--fail-fast"]
    }
  ]
}
```

## Advanced Features

### Visual Regression Testing
```bash
# Compare screenshots across test runs
/ace-test-e2e --visual-regression

# Update baseline screenshots
/ace-test-e2e --update-baselines
```

### Cross-browser Testing
```bash
# Test across multiple browsers
/ace-test-e2e --run --browsers="chromium,firefox,webkit"

# Mobile device testing
/ace-test-e2e --run --device="iPhone 13,Pixel 5"
```

### Load Testing Integration
```bash
# Combine E2E with performance testing
/ace-test-e2e --performance --concurrent-users=10
```

## Reporting and Analytics

### Test Results Dashboard
- Real-time test execution status
- Specification coverage metrics
- Accessibility compliance trends
- Performance benchmarks

### Integration Reports
- GitHub PR comments with test results
- Slack notifications for failures
- Email summaries for stakeholders

### Compliance Tracking
- AWS Amplify Gen 2 pattern usage
- Security best practice adherence
- Code quality metrics

## Best Practices

### 1. Specification Traceability
Always link tests to acceptance criteria:
```typescript
/**
 * @user-story US-001
 * @acceptance-criteria AC-001-01
 * @specification-version 1.2.0
 */
```

### 2. Maintainable Selectors
Use data attributes for stable selectors:
```typescript
// Good
await click({ element: "Submit button", ref: "[data-testid='submit-btn']" });

// Avoid
await click({ element: "Submit button", ref: ".btn-primary.submit" });
```

### 3. Error Handling
Include comprehensive error scenarios:
```typescript
// Test both success and failure paths
await testSuccessfulLogin();
await testFailedLogin();
await testNetworkErrorHandling();
```

### 4. Accessibility First
Include accessibility in every test:
```typescript
// Always capture accessibility snapshot
const snapshot = await browser_snapshot();
// Validate WCAG compliance
```

## Troubleshooting

### Common Issues

1. **Browser Installation**
   ```bash
   # Install browser if needed
   /ace-test-e2e --install-browsers
   ```

2. **Timing Issues**
   ```bash
   # Add debug mode for timing analysis
   /ace-test-e2e --run --debug --slow-mo=1000
   ```

3. **Element Selection**
   ```bash
   # Use interactive mode to find selectors
   /ace-test-e2e --interactive --page="/dashboard"
   ```

## Output Examples

### Success Report
```
🎭 ACE-Flow E2E Test Results
============================

✅ Overall Status: PASSED (38/40 tests)
📊 Specification Coverage: 95% (38/40 acceptance criteria)
♿ Accessibility Compliance: 92% WCAG 2.1 AA
🚀 AWS Amplify Gen 2 Compliance: 100%

Test Results by Priority:
├── Critical: 20/20 ✅ (100%)
├── High: 15/15 ✅ (100%) 
├── Medium: 3/5 ⚠️ (60%)
└── Low: 0/0 - (N/A)

Performance Metrics:
├── Average Page Load: 1.2s
├── API Response Time: 145ms
└── Test Suite Duration: 4m 32s

Next Steps:
1. Fix 2 medium priority test failures
2. Improve accessibility score to >95%
3. Schedule weekly regression testing
```

### Failure Report
```
❌ ACE-Flow E2E Test Failures
============================

Failed Tests (2/40):
├── AC-012-01: Real-time updates (Timeout waiting for WebSocket)
└── AC-015-02: File upload (S3 permission denied)

Debugging Information:
├── Screenshots: Available in /test-results/screenshots/
├── Console Logs: Captured for failed tests
└── Network Requests: Full HAR files generated

Recommendations:
1. Check WebSocket configuration in amplify/backend
2. Verify S3 bucket permissions for file uploads
3. Update test timeouts for real-time features
```

This command enables comprehensive E2E testing that ensures ACE-Flow applications meet all specifications while maintaining AWS Amplify Gen 2 compliance and accessibility standards.