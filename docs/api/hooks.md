---
layout: docs
title: Hooks System
---

# Hooks System

Advanced automation through smart hooks that respond to ACE-Flow lifecycle events.

## Overview

ACE-Flow's hooks system provides powerful automation capabilities by allowing you to execute custom scripts at specific points in the development lifecycle. Hooks enable continuous integration, automated testing, monitoring, and custom workflows.

## Hook Types

### Generation Hooks

Execute during project generation phase:

```yaml
# .ace-flow/hooks.yml
generation:
  pre_generation:
    - name: "validate_requirements"
      script: "./scripts/validate-reqs.sh"
      required: true
      
  post_generation:
    - name: "setup_git"
      script: "git init && git add ."
      required: false
      
    - name: "install_dependencies"
      script: "npm install"
      timeout: 300
```

### Research Hooks

Execute during documentation research:

```yaml
research:
  pre_research:
    - name: "check_cache"
      script: "./scripts/check-research-cache.sh"
      
  post_research:
    - name: "update_knowledge_base"
      script: "./scripts/update-kb.py"
      async: true
```

### Deployment Hooks

Execute during AWS deployment:

```yaml
deployment:
  pre_deployment:
    - name: "run_tests"
      script: "npm test"
      required: true
      timeout: 600
      
    - name: "security_scan"
      script: "./scripts/security-check.sh"
      required: true
      
    - name: "cost_check"
      script: "./scripts/estimate-costs.sh"
      max_cost: 100.00
      
  post_deployment:
    - name: "smoke_tests"
      script: "./scripts/smoke-tests.sh"
      retry_count: 3
      
    - name: "update_docs"
      script: "./scripts/generate-api-docs.sh"
      async: true
      
    - name: "notify_team"
      script: "./scripts/slack-notify.sh"
      env:
        SLACK_CHANNEL: "#deployments"
```

### Validation Hooks

Execute during validation checks:

```yaml
validation:
  pre_validation:
    - name: "lint_code"
      script: "npm run lint"
      
  post_validation:
    - name: "generate_report"
      script: "./scripts/validation-report.sh"
      output_file: "validation-report.json"
```

## Hook Configuration

### Basic Hook Structure

```yaml
hooks:
  [phase]:
    [event]:
      - name: "hook_name"
        script: "command or script path"
        required: true|false
        timeout: 300  # seconds
        retry_count: 3
        async: false
        env:
          KEY: "value"
        conditions:
          - "condition_expression"
```

### Hook Properties

| Property | Type | Description | Default |
|----------|------|-------------|---------|
| `name` | string | Unique hook identifier | required |
| `script` | string | Command or script to execute | required |
| `required` | boolean | Fail workflow if hook fails | `false` |
| `timeout` | integer | Maximum execution time (seconds) | `300` |
| `retry_count` | integer | Number of retries on failure | `0` |
| `async` | boolean | Run hook in background | `false` |
| `env` | object | Environment variables | `{}` |
| `conditions` | array | Conditions for hook execution | `[]` |
| `working_dir` | string | Working directory for execution | project root |
| `shell` | string | Shell to use for execution | `/bin/bash` |

### Environment Variables in Hooks

Hooks have access to ACE-Flow context variables:

```bash
# Available in all hooks
$ACE_FLOW_PROJECT_NAME
$ACE_FLOW_PROJECT_TYPE
$ACE_FLOW_PATTERN
$ACE_FLOW_VERSION
$ACE_FLOW_PHASE      # current phase: generation, research, deployment, validation
$ACE_FLOW_EVENT      # current event: pre_deployment, post_deployment, etc.

# AWS Context
$AWS_REGION
$AWS_ACCOUNT_ID
$AMPLIFY_APP_ID
$AMPLIFY_BRANCH

# Project Context
$PROJECT_ROOT
$CONFIG_FILE
$AMPLIFY_OUTPUTS_FILE
```

## Built-in Hooks

### AWS Amplify Integration

```yaml
# Automatically triggered by AWS Amplify events
amplify:
  schema_update:
    - name: "regenerate_types"
      script: "npx amplify generate graphql-client-code"
      auto_trigger: true
      
  sandbox_ready:
    - name: "run_integration_tests"
      script: "./scripts/integration-tests.sh"
      
  deployment_complete:
    - name: "verify_endpoints"
      script: "./scripts/verify-deployment.sh"
```

### Testing Hooks

```yaml
testing:
  pre_test:
    - name: "setup_test_data"
      script: "./scripts/seed-test-data.sh"
      
  post_test:
    - name: "cleanup_test_data"
      script: "./scripts/cleanup-test-data.sh"
      always_run: true  # Run even if tests fail
```

### Security Hooks

```yaml
security:
  pre_deployment:
    - name: "vulnerability_scan"
      script: "npm audit --audit-level=high"
      required: true
      
    - name: "secrets_scan"
      script: "./scripts/check-secrets.sh"
      required: true
      
  post_deployment:
    - name: "penetration_test"
      script: "./scripts/pen-test.sh"
      async: true
```

## Conditional Hooks

Execute hooks based on conditions:

```yaml
hooks:
  deployment:
    pre_deployment:
      - name: "production_checks"
        script: "./scripts/prod-checks.sh"
        conditions:
          - "$AMPLIFY_BRANCH == 'main'"
          - "$ACE_FLOW_PATTERN == 'e_commerce'"
          
      - name: "staging_setup"
        script: "./scripts/staging-setup.sh"
        conditions:
          - "$AMPLIFY_BRANCH == 'staging'"
```

### Condition Syntax

```yaml
conditions:
  # Environment variables
  - "$NODE_ENV == 'production'"
  - "$AWS_REGION != 'us-east-1'"
  
  # File existence
  - "file_exists('package.json')"
  - "file_exists('.env.production')"
  
  # Project properties
  - "$ACE_FLOW_PATTERN in ['e_commerce', 'social_platform']"
  - "$ACE_FLOW_PROJECT_TYPE == 'new'"
  
  # Time-based
  - "time_between('09:00', '17:00')"
  - "day_of_week() in ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']"
  
  # Git context
  - "git_branch() == 'main'"
  - "git_has_changes() == false"
  
  # Custom functions
  - "custom_condition('param1', 'param2')"
```

## Hook Scripts

### Shell Scripts

```bash
#!/bin/bash
# scripts/pre-deployment-checks.sh

set -e  # Exit on any error

echo "Running pre-deployment checks..."

# Check AWS credentials
if ! aws sts get-caller-identity > /dev/null 2>&1; then
    echo "Error: AWS credentials not configured"
    exit 1
fi

# Check required environment variables
required_vars=("DATABASE_URL" "API_KEY")
for var in "${required_vars[@]}"; do
    if [[ -z "${!var}" ]]; then
        echo "Error: Required environment variable $var is not set"
        exit 1
    fi
done

# Run tests
echo "Running tests..."
npm test

# Check code quality
echo "Running linting..."
npm run lint

echo "Pre-deployment checks completed successfully"
```

### Python Scripts

```python
#!/usr/bin/env python3
# scripts/cost-analysis.py

import json
import os
import sys
import boto3

def estimate_costs():
    """Estimate deployment costs"""
    
    # Load Amplify outputs
    with open('amplify_outputs.json') as f:
        config = json.load(f)
    
    # Calculate estimated costs
    dynamodb_cost = estimate_dynamodb_cost()
    lambda_cost = estimate_lambda_cost()
    s3_cost = estimate_s3_cost()
    
    total_cost = dynamodb_cost + lambda_cost + s3_cost
    
    # Check against threshold
    threshold = float(os.getenv('MAX_MONTHLY_COST', '100'))
    
    if total_cost > threshold:
        print(f"Error: Estimated cost ${total_cost:.2f} exceeds threshold ${threshold:.2f}")
        sys.exit(1)
    
    print(f"Estimated monthly cost: ${total_cost:.2f}")
    return total_cost

def estimate_dynamodb_cost():
    # Implement DynamoDB cost estimation
    return 10.50

def estimate_lambda_cost():
    # Implement Lambda cost estimation
    return 5.25

def estimate_s3_cost():
    # Implement S3 cost estimation
    return 2.75

if __name__ == "__main__":
    estimate_costs()
```

### Node.js Scripts

```javascript
#!/usr/bin/env node
// scripts/verify-deployment.js

const https = require('https');
const fs = require('fs');

async function verifyDeployment() {
    console.log('Verifying deployment...');
    
    // Load Amplify configuration
    const config = JSON.parse(fs.readFileSync('amplify_outputs.json', 'utf8'));
    const apiEndpoint = config.API.GraphQL.endpoint;
    
    // Test GraphQL endpoint
    const testQuery = {
        query: `
            query TestQuery {
                __schema {
                    types {
                        name
                    }
                }
            }
        `
    };
    
    try {
        const response = await makeGraphQLRequest(apiEndpoint, testQuery);
        
        if (response.data) {
            console.log('✅ GraphQL API is responding');
        } else {
            throw new Error('GraphQL API returned no data');
        }
        
        // Test authentication endpoints
        await testAuthEndpoints(config);
        
        // Test file storage
        await testStorageEndpoints(config);
        
        console.log('✅ Deployment verification completed successfully');
        
    } catch (error) {
        console.error('❌ Deployment verification failed:', error.message);
        process.exit(1);
    }
}

async function makeGraphQLRequest(endpoint, query) {
    // Implement GraphQL request logic
    return { data: { __schema: { types: [] } } };
}

async function testAuthEndpoints(config) {
    console.log('Testing authentication endpoints...');
    // Implement auth testing
}

async function testStorageEndpoints(config) {
    console.log('Testing storage endpoints...');
    // Implement storage testing
}

verifyDeployment();
```

## Hook Management

### Enable/Disable Hooks

```bash
# Disable specific hook
/ace-disable-hook cost-estimation

# Enable hook
/ace-enable-hook cost-estimation

# List hook status
/ace-list-hooks --status

# Run hooks manually
/ace-run-hook pre-deployment cost-estimation
```

### Hook Debugging

```bash
# Enable hook debugging
export ACE_FLOW_DEBUG_HOOKS=true

# View hook execution logs
/ace-logs --hooks --follow

# Test hook configuration
/ace-test-hooks --dry-run
```

### Hook Templates

Generate hook templates:

```bash
# Generate basic hook
/ace-generate-hook --name=my-hook --type=pre-deployment

# Generate from template
/ace-generate-hook --template=security-scan

# List available templates
/ace-list-hook-templates
```

## Integration Examples

### CI/CD Integration

```yaml
# GitHub Actions integration
github_actions:
  on_push:
    - name: "trigger_ace_flow"
      script: "/ace-implement --ci-mode"
      env:
        GITHUB_TOKEN: "${{ secrets.GITHUB_TOKEN }}"
        
  on_pull_request:
    - name: "validate_changes"
      script: "/ace-validate --pr-mode"
```

### Slack Notifications

```bash
#!/bin/bash
# scripts/slack-notify.sh

WEBHOOK_URL="${SLACK_WEBHOOK_URL}"
CHANNEL="${SLACK_CHANNEL:-#deployments}"

curl -X POST -H 'Content-type: application/json' \
    --data "{
        \"channel\": \"$CHANNEL\",
        \"text\": \"🚀 ACE-Flow deployment completed for $ACE_FLOW_PROJECT_NAME\",
        \"username\": \"ACE-Flow Bot\"
    }" \
    "$WEBHOOK_URL"
```

### Monitoring Integration

```javascript
// scripts/setup-monitoring.js
const AWS = require('aws-sdk');
const cloudwatch = new AWS.CloudWatch();

async function setupAlarms() {
    // Create CloudWatch alarms for key metrics
    await cloudwatch.putMetricAlarm({
        AlarmName: `${process.env.ACE_FLOW_PROJECT_NAME}-high-error-rate`,
        MetricName: 'ErrorRate',
        Namespace: 'AWS/Lambda',
        Statistic: 'Average',
        Period: 300,
        EvaluationPeriods: 2,
        Threshold: 5.0,
        ComparisonOperator: 'GreaterThanThreshold',
        AlarmActions: [process.env.SNS_ALARM_TOPIC]
    }).promise();
    
    console.log('Monitoring alarms configured');
}

setupAlarms();
```

## Best Practices

### Hook Development

1. **Keep hooks focused** - Each hook should have a single responsibility
2. **Make hooks idempotent** - Safe to run multiple times
3. **Handle errors gracefully** - Provide meaningful error messages
4. **Use proper exit codes** - 0 for success, non-zero for failure
5. **Log appropriately** - Include relevant context in logs

### Performance Optimization

1. **Use async hooks** for non-blocking operations
2. **Set appropriate timeouts** to prevent hanging
3. **Implement retries** for transient failures
4. **Cache results** when possible
5. **Parallelize** independent operations

### Security Considerations

1. **Validate inputs** from environment variables
2. **Use secure credential storage** (AWS Secrets Manager, etc.)
3. **Limit hook permissions** to minimum required
4. **Audit hook execution** for compliance
5. **Encrypt sensitive data** in hook outputs

## Troubleshooting Hooks

### Common Issues

1. **Hook timeout** - Increase timeout or optimize script
2. **Permission denied** - Check file permissions and execution rights
3. **Environment variables** - Verify all required variables are set
4. **Path issues** - Use absolute paths or ensure PATH is correct

### Debug Commands

```bash
# View hook execution history
/ace-hook-history --last=10

# Test hook in isolation
/ace-test-hook pre-deployment security-scan --verbose

# Validate hook configuration
/ace-validate-hooks --config=.ace-flow/hooks.yml
```

---

*For more advanced hook scenarios and custom integrations, see our [Advanced Hooks Guide](../advanced/hooks) or join our [Discord community](https://discord.gg/ace-flow) for support.*