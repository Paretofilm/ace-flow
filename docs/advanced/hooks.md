---
layout: docs
title: Hooks and Extensions
---

# Hooks and Extensions

Customize ACE-Flow behavior with hooks and extensions to integrate with your existing workflows and add custom functionality.

## Overview

ACE-Flow provides a comprehensive hook system that allows you to:
- Execute custom code at key lifecycle points
- Integrate with third-party services and tools
- Validate and transform data during operations
- Automate repetitive tasks and workflows

## Pre/Post Deployment Hooks

### Pre-deployment Hooks

Execute validation and preparation tasks before deployment:

```bash
# .ace-flow/hooks/pre-deploy.sh
#!/bin/bash
echo "Running pre-deployment checks..."

# Run tests
npm run test

# Validate configuration
/ace-validate --strict

# Check AWS resources
aws sts get-caller-identity

echo "Pre-deployment checks completed successfully"
```

### Post-deployment Hooks

Perform cleanup and notification tasks after deployment:

```bash
# .ace-flow/hooks/post-deploy.sh
#!/bin/bash
echo "Running post-deployment tasks..."

# Send deployment notification
curl -X POST "$SLACK_WEBHOOK_URL" \
  -H 'Content-type: application/json' \
  --data '{"text":"ACE-Flow deployment completed successfully"}'

# Update monitoring dashboards
npm run update-dashboards

echo "Post-deployment tasks completed"
```

## Custom Validation Rules

### Schema Validation Extensions

Add custom validation logic to your data models:

```typescript
// .ace-flow/validators/user-validator.ts
export const validateUser = (user: any) => {
  const errors: string[] = [];
  
  // Custom email domain validation
  if (!user.email.endsWith('@company.com')) {
    errors.push('User email must be from company domain');
  }
  
  // Complex password requirements
  if (!isStrongPassword(user.password)) {
    errors.push('Password must meet security requirements');
  }
  
  return {
    isValid: errors.length === 0,
    errors
  };
};
```

### Business Rule Enforcement

Implement custom business logic validation:

```typescript
// .ace-flow/validators/business-rules.ts
export const validateOrder = (order: any) => {
  // Check inventory availability
  if (!checkInventory(order.items)) {
    throw new Error('Insufficient inventory for order');
  }
  
  // Validate pricing
  if (!validatePricing(order)) {
    throw new Error('Order pricing validation failed');
  }
  
  return true;
};
```

## Third-party Integrations

### Webhook Configuration

Configure webhooks for external service integration:

```yaml
# .ace-flow/config/webhooks.yml
webhooks:
  deployment:
    url: "https://api.github.com/repos/owner/repo/dispatches"
    headers:
      Authorization: "token $GITHUB_TOKEN"
      Accept: "application/vnd.github.v3+json"
    payload:
      event_type: "ace-flow-deployment"
      client_payload:
        environment: "$ACE_ENVIRONMENT"
        timestamp: "$DEPLOYMENT_TIME"
  
  errors:
    url: "https://hooks.slack.com/services/YOUR/SLACK/WEBHOOK"
    headers:
      Content-Type: "application/json"
    payload:
      text: "ACE-Flow error: $ERROR_MESSAGE"
```

### API Integration Patterns

Integrate with external APIs during the ACE-Flow lifecycle:

```typescript
// .ace-flow/integrations/external-api.ts
import { APIClient } from './api-client';

export class ExternalIntegration {
  private client: APIClient;
  
  constructor() {
    this.client = new APIClient(process.env.EXTERNAL_API_URL);
  }
  
  async onUserCreated(user: any) {
    // Sync user to external CRM
    await this.client.post('/users', {
      id: user.id,
      email: user.email,
      name: user.name
    });
  }
  
  async onOrderCompleted(order: any) {
    // Send to fulfillment system
    await this.client.post('/orders', {
      orderId: order.id,
      items: order.items,
      shippingAddress: order.shippingAddress
    });
  }
}
```

## Event Processing

### Lifecycle Events

Hook into ACE-Flow lifecycle events:

```typescript
// .ace-flow/hooks/lifecycle.ts
export const hooks = {
  beforeGenesis: async (config: any) => {
    console.log('Starting project genesis...');
    // Custom initialization logic
  },
  
  afterImplementation: async (project: any) => {
    console.log('Implementation completed');
    // Send notifications, update tracking systems
  },
  
  onError: async (error: Error, context: any) => {
    console.error('ACE-Flow error:', error);
    // Send to error tracking service
    await sendToErrorTracker(error, context);
  }
};
```

### Custom Event Handlers

Create custom event handlers for specific scenarios:

```typescript
// .ace-flow/handlers/custom-events.ts
export class CustomEventHandler {
  async handleSchemaChange(event: SchemaChangeEvent) {
    // Regenerate API documentation
    await this.generateApiDocs(event.schema);
    
    // Update test fixtures
    await this.updateTestFixtures(event.changes);
    
    // Notify development team
    await this.notifyTeam(`Schema updated: ${event.summary}`);
  }
  
  async handleDeploymentFailure(event: DeploymentFailureEvent) {
    // Automatic rollback
    await this.executeRollback(event.deploymentId);
    
    // Create incident ticket
    await this.createIncident(event);
    
    // Alert on-call engineer
    await this.alertOnCall(event);
  }
}
```

## Automation Workflows

### CI/CD Integration

Integrate ACE-Flow with your CI/CD pipeline:

```yaml
# .github/workflows/ace-flow.yml
name: ACE-Flow Deployment
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm install
      
      - name: Run ACE-Flow validation
        run: /ace-validate --ci
      
      - name: Deploy with ACE-Flow
        run: /ace-implement ${{ github.repository }}
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```

### Scheduled Tasks

Automate recurring tasks with scheduled hooks:

```bash
# .ace-flow/hooks/scheduled/daily-maintenance.sh
#!/bin/bash
# Run via cron: 0 2 * * * /path/to/daily-maintenance.sh

echo "Running daily maintenance tasks..."

# Clean up old logs
find /var/log/ace-flow -name "*.log" -mtime +7 -delete

# Optimize database
/ace-status --optimize-db

# Generate usage reports
/ace-cost --report --email admin@company.com

echo "Daily maintenance completed"
```

## Configuration

### Hook Configuration

Configure hook behavior in your project:

```yaml
# .ace-flow/config/hooks.yml
hooks:
  enabled: true
  timeout: 300  # seconds
  retries: 3
  
  pre_deploy:
    - script: "hooks/pre-deploy.sh"
      timeout: 600
    - command: "npm run test"
      required: true
  
  post_deploy:
    - script: "hooks/post-deploy.sh"
    - webhook: "webhooks.deployment"
  
  validation:
    - validator: "validators/user-validator"
    - validator: "validators/business-rules"
      models: ["Order", "Product"]
```

### Environment Variables

Configure hooks with environment variables:

```bash
# .env.hooks
HOOK_TIMEOUT=300
SLACK_WEBHOOK_URL=https://hooks.slack.com/your/webhook
GITHUB_TOKEN=your_github_token
EXTERNAL_API_URL=https://api.external-service.com
ERROR_TRACKER_URL=https://sentry.io/api/projects/your-project
```

## Best Practices

### Error Handling

Implement robust error handling in your hooks:

```typescript
// .ace-flow/hooks/error-handling.ts
export const safeHook = (hookFunction: Function) => {
  return async (...args: any[]) => {
    try {
      return await hookFunction(...args);
    } catch (error) {
      console.error('Hook execution failed:', error);
      
      // Don't fail the entire deployment for non-critical hooks
      if (!hookFunction.critical) {
        return { success: false, error: error.message };
      }
      
      throw error;
    }
  };
};
```

### Testing Hooks

Test your hooks thoroughly:

```typescript
// .ace-flow/tests/hooks.test.ts
import { validateUser } from '../validators/user-validator';

describe('User Validator Hook', () => {
  it('should validate company email domain', () => {
    const user = {
      email: 'user@company.com',
      password: 'StrongP@ssw0rd123'
    };
    
    const result = validateUser(user);
    expect(result.isValid).toBe(true);
  });
  
  it('should reject external email domains', () => {
    const user = {
      email: 'user@gmail.com',
      password: 'StrongP@ssw0rd123'
    };
    
    const result = validateUser(user);
    expect(result.isValid).toBe(false);
    expect(result.errors).toContain('User email must be from company domain');
  });
});
```

### Performance Considerations

Optimize hook performance:

- Keep hooks lightweight and fast
- Use async/await for I/O operations
- Implement caching where appropriate
- Set reasonable timeouts
- Use parallel execution for independent operations

## Troubleshooting

### Common Issues

**Hook timeouts:**
- Increase timeout values in configuration
- Optimize hook performance
- Split long-running tasks into smaller chunks

**Permission errors:**
- Ensure hook scripts have execute permissions
- Verify AWS credentials and permissions
- Check file system permissions

**Integration failures:**
- Validate webhook URLs and authentication
- Test API endpoints separately
- Check network connectivity and firewall rules

---

[← Back to Advanced Topics](index.md) | [Performance Optimization →](performance.md)