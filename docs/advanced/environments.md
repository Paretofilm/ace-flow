---
layout: docs
title: Multi-environment Setup
---

# Multi-environment Setup

Configure development, staging, and production environments with ACE-Flow for seamless deployment workflows and environment-specific configurations.

## Overview

Multi-environment setup enables:
- Isolated development and testing
- Gradual rollout strategies
- Environment-specific configurations
- Automated CI/CD pipelines
- Risk mitigation through staging

## Environment Architecture

### Standard Environment Topology

```mermaid
graph TD
    A[Local Development] --> B[Development Environment]
    B --> C[Staging Environment]
    C --> D[Production Environment]
    
    E[Feature Branches] --> B
    F[Main Branch] --> C
    G[Release Tags] --> D
```

### Environment Configuration Structure

```bash
.ace-flow/
├── environments/
│   ├── local/
│   │   ├── config.yml
│   │   ├── secrets.yml
│   │   └── overrides/
│   ├── development/
│   │   ├── config.yml
│   │   ├── secrets.yml
│   │   └── overrides/
│   ├── staging/
│   │   ├── config.yml
│   │   ├── secrets.yml
│   │   └── overrides/
│   └── production/
│       ├── config.yml
│       ├── secrets.yml
│       └── overrides/
├── scripts/
│   ├── deploy-dev.sh
│   ├── deploy-staging.sh
│   └── deploy-prod.sh
└── templates/
    ├── environment.template.yml
    └── secrets.template.yml
```

## Environment Configuration

### Base Configuration Template

```yaml
# .ace-flow/templates/environment.template.yml
environment:
  name: ${ENVIRONMENT_NAME}
  region: ${AWS_REGION}
  stage: ${STAGE}

database:
  instance_type: ${DB_INSTANCE_TYPE}
  storage: ${DB_STORAGE_SIZE}
  backup_retention: ${DB_BACKUP_RETENTION}
  multi_az: ${DB_MULTI_AZ}

lambda:
  memory: ${LAMBDA_MEMORY}
  timeout: ${LAMBDA_TIMEOUT}
  runtime: ${LAMBDA_RUNTIME}

storage:
  bucket_name: ${S3_BUCKET_NAME}
  cdn_enabled: ${CDN_ENABLED}
  encryption: ${S3_ENCRYPTION}

monitoring:
  log_level: ${LOG_LEVEL}
  metrics_enabled: ${METRICS_ENABLED}
  alerts_enabled: ${ALERTS_ENABLED}

security:
  mfa_required: ${MFA_REQUIRED}
  session_timeout: ${SESSION_TIMEOUT}
  rate_limiting: ${RATE_LIMITING}
```

### Development Environment

```yaml
# .ace-flow/environments/development/config.yml
environment:
  name: "ace-flow-dev"
  region: "us-east-1"
  stage: "dev"

database:
  instance_type: "t3.micro"
  storage: 20
  backup_retention: 1
  multi_az: false

lambda:
  memory: 256
  timeout: 30
  runtime: "nodejs18.x"

storage:
  bucket_name: "ace-flow-dev-storage"
  cdn_enabled: false
  encryption: "AES256"

monitoring:
  log_level: "DEBUG"
  metrics_enabled: true
  alerts_enabled: false

security:
  mfa_required: false
  session_timeout: 3600
  rate_limiting: 1000

features:
  debug_mode: true
  test_data: true
  mock_external_apis: true
```

### Staging Environment

```yaml
# .ace-flow/environments/staging/config.yml
environment:
  name: "ace-flow-staging"
  region: "us-east-1"
  stage: "staging"

database:
  instance_type: "t3.small"
  storage: 50
  backup_retention: 7
  multi_az: false

lambda:
  memory: 512
  timeout: 60
  runtime: "nodejs18.x"

storage:
  bucket_name: "ace-flow-staging-storage"
  cdn_enabled: true
  encryption: "aws:kms"

monitoring:
  log_level: "INFO"
  metrics_enabled: true
  alerts_enabled: true

security:
  mfa_required: true
  session_timeout: 1800
  rate_limiting: 500

features:
  debug_mode: false
  test_data: false
  mock_external_apis: false
  performance_testing: true
```

### Production Environment

```yaml
# .ace-flow/environments/production/config.yml
environment:
  name: "ace-flow-prod"
  region: "us-east-1"
  stage: "prod"

database:
  instance_type: "r5.large"
  storage: 100
  backup_retention: 30
  multi_az: true

lambda:
  memory: 1024
  timeout: 60
  runtime: "nodejs18.x"
  provisioned_concurrency: 10

storage:
  bucket_name: "ace-flow-prod-storage"
  cdn_enabled: true
  encryption: "aws:kms"
  backup_enabled: true

monitoring:
  log_level: "WARN"
  metrics_enabled: true
  alerts_enabled: true
  detailed_monitoring: true

security:
  mfa_required: true
  session_timeout: 900
  rate_limiting: 100
  waf_enabled: true

features:
  debug_mode: false
  test_data: false
  mock_external_apis: false
  blue_green_deployment: true
```

## Secret Management

### Environment-specific Secrets

```yaml
# .ace-flow/environments/development/secrets.yml
secrets:
  database:
    password: "dev_db_password"
    connection_string: "postgresql://user:pass@dev-db:5432/aceflow"
  
  external_apis:
    stripe_key: "sk_test_development_key"
    sendgrid_key: "SG.dev_key"
    slack_webhook: "https://hooks.slack.com/dev/webhook"
  
  auth:
    jwt_secret: "dev_jwt_secret_key"
    oauth_client_secret: "dev_oauth_secret"
  
  monitoring:
    sentry_dsn: "https://dev@sentry.io/project"
    datadog_api_key: "dev_datadog_key"
```

### AWS Secrets Manager Integration

```typescript
// utils/environment-secrets.ts
export class EnvironmentSecrets {
  private secretsCache = new Map<string, any>();
  
  async getEnvironmentSecrets(environment: string): Promise<any> {
    const cacheKey = `env_secrets_${environment}`;
    
    if (this.secretsCache.has(cacheKey)) {
      return this.secretsCache.get(cacheKey);
    }
    
    try {
      const secretName = `ace-flow/${environment}/secrets`;
      const secrets = await this.retrieveSecret(secretName);
      
      // Cache for 5 minutes
      this.secretsCache.set(cacheKey, secrets);
      setTimeout(() => {
        this.secretsCache.delete(cacheKey);
      }, 300000);
      
      return secrets;
    } catch (error) {
      console.error(`Failed to retrieve secrets for ${environment}:`, error);
      throw new Error('Environment secrets retrieval failed');
    }
  }
  
  async updateEnvironmentSecrets(environment: string, secrets: any): Promise<void> {
    const secretName = `ace-flow/${environment}/secrets`;
    
    await this.updateSecret(secretName, secrets);
    
    // Invalidate cache
    this.secretsCache.delete(`env_secrets_${environment}`);
  }
  
  private async retrieveSecret(secretName: string): Promise<any> {
    const AWS = require('aws-sdk');
    const secretsManager = new AWS.SecretsManager();
    
    const result = await secretsManager.getSecretValue({
      SecretId: secretName
    }).promise();
    
    return JSON.parse(result.SecretString);
  }
}
```

## CI/CD Pipeline Setup

### GitHub Actions Workflow

```yaml
# .github/workflows/multi-environment.yml
name: Multi-Environment Deployment

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  NODE_VERSION: '18'
  
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Run tests
        run: npm run test
      
      - name: Run linting
        run: npm run lint
      
      - name: Run type checking
        run: npm run type-check

  deploy-dev:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/develop'
    environment: development
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1
      
      - name: Deploy to development
        run: |
          /ace-validate --environment development
          /ace-implement --environment development
        env:
          ACE_ENVIRONMENT: development

  deploy-staging:
    needs: test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    environment: staging
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1
      
      - name: Deploy to staging
        run: |
          /ace-validate --environment staging
          /ace-implement --environment staging
        env:
          ACE_ENVIRONMENT: staging
      
      - name: Run integration tests
        run: npm run test:integration
        env:
          TEST_ENDPOINT: ${{ secrets.STAGING_ENDPOINT }}

  deploy-production:
    needs: deploy-staging
    runs-on: ubuntu-latest
    if: startsWith(github.ref, 'refs/tags/v')
    environment: production
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1
      
      - name: Deploy to production
        run: |
          /ace-validate --environment production --strict
          /ace-implement --environment production --strategy blue-green
        env:
          ACE_ENVIRONMENT: production
      
      - name: Run smoke tests
        run: npm run test:smoke
        env:
          TEST_ENDPOINT: ${{ secrets.PRODUCTION_ENDPOINT }}
      
      - name: Notify deployment
        run: |
          curl -X POST ${{ secrets.SLACK_WEBHOOK }} \
            -H 'Content-type: application/json' \
            --data '{"text":"✅ Production deployment completed: ${{ github.ref }}"}'
```

### AWS CodePipeline Alternative

```typescript
// infrastructure/pipeline.ts
import * as codepipeline from 'aws-cdk-lib/aws-codepipeline';
import * as codepipeline_actions from 'aws-cdk-lib/aws-codepipeline-actions';

export class MultiEnvironmentPipeline extends Stack {
  constructor(scope: Construct, id: string, props?: StackProps) {
    super(scope, id, props);
    
    const pipeline = new codepipeline.Pipeline(this, 'ACEFlowPipeline', {
      pipelineName: 'ace-flow-multi-env',
      crossAccountKeys: false
    });
    
    // Source stage
    const sourceOutput = new codepipeline.Artifact();
    pipeline.addStage({
      stageName: 'Source',
      actions: [
        new codepipeline_actions.GitHubSourceAction({
          actionName: 'GitHub_Source',
          owner: 'paretofilm',
          repo: 'ace-flow',
          branch: 'main',
          oauthToken: SecretValue.secretsManager('github-token'),
          output: sourceOutput
        })
      ]
    });
    
    // Build stage
    const buildOutput = new codepipeline.Artifact();
    pipeline.addStage({
      stageName: 'Build',
      actions: [
        new codepipeline_actions.CodeBuildAction({
          actionName: 'Build',
          project: this.createBuildProject(),
          input: sourceOutput,
          outputs: [buildOutput]
        })
      ]
    });
    
    // Development deployment
    pipeline.addStage({
      stageName: 'Deploy-Dev',
      actions: [
        new codepipeline_actions.CloudFormationCreateUpdateStackAction({
          actionName: 'Deploy-Development',
          templatePath: buildOutput.atPath('dev-template.yml'),
          stackName: 'ace-flow-dev',
          adminPermissions: true,
          parameterOverrides: {
            Environment: 'development'
          }
        })
      ]
    });
    
    // Staging deployment with approval
    pipeline.addStage({
      stageName: 'Deploy-Staging',
      actions: [
        new codepipeline_actions.ManualApprovalAction({
          actionName: 'Approve-Staging',
          notificationTopic: this.createNotificationTopic()
        }),
        new codepipeline_actions.CloudFormationCreateUpdateStackAction({
          actionName: 'Deploy-Staging',
          templatePath: buildOutput.atPath('staging-template.yml'),
          stackName: 'ace-flow-staging',
          adminPermissions: true,
          parameterOverrides: {
            Environment: 'staging'
          }
        })
      ]
    });
    
    // Production deployment with approval
    pipeline.addStage({
      stageName: 'Deploy-Production',
      actions: [
        new codepipeline_actions.ManualApprovalAction({
          actionName: 'Approve-Production',
          notificationTopic: this.createNotificationTopic()
        }),
        new codepipeline_actions.CloudFormationCreateUpdateStackAction({
          actionName: 'Deploy-Production',
          templatePath: buildOutput.atPath('prod-template.yml'),
          stackName: 'ace-flow-prod',
          adminPermissions: true,
          parameterOverrides: {
            Environment: 'production'
          }
        })
      ]
    });
  }
}
```

## Deployment Strategies

### Blue-Green Deployment

```typescript
// utils/blue-green-deployment.ts
export class BlueGreenDeployment {
  async deploy(environment: string, version: string) {
    const currentColor = await this.getCurrentColor(environment);
    const newColor = currentColor === 'blue' ? 'green' : 'blue';
    
    console.log(`Deploying ${version} to ${newColor} environment`);
    
    try {
      // Deploy to inactive environment
      await this.deployToColor(environment, newColor, version);
      
      // Run health checks
      await this.runHealthChecks(environment, newColor);
      
      // Run smoke tests
      await this.runSmokeTests(environment, newColor);
      
      // Switch traffic
      await this.switchTraffic(environment, newColor);
      
      // Monitor for issues
      await this.monitorDeployment(environment, newColor);
      
      // Mark old environment for cleanup
      await this.scheduleCleanup(environment, currentColor);
      
      console.log(`Successfully deployed ${version} to ${environment}`);
      
    } catch (error) {
      console.error(`Deployment failed:`, error);
      
      // Rollback if needed
      await this.rollback(environment, currentColor);
      
      throw error;
    }
  }
  
  private async runHealthChecks(environment: string, color: string): Promise<void> {
    const endpoint = await this.getEnvironmentEndpoint(environment, color);
    const healthUrl = `${endpoint}/health`;
    
    let attempts = 0;
    const maxAttempts = 30;
    
    while (attempts < maxAttempts) {
      try {
        const response = await fetch(healthUrl);
        
        if (response.ok) {
          const health = await response.json();
          
          if (health.status === 'healthy') {
            console.log(`Health check passed for ${color} environment`);
            return;
          }
        }
        
        attempts++;
        await this.sleep(10000); // Wait 10 seconds
        
      } catch (error) {
        attempts++;
        await this.sleep(10000);
      }
    }
    
    throw new Error(`Health checks failed for ${color} environment`);
  }
}
```

### Canary Deployment

```typescript
// utils/canary-deployment.ts
export class CanaryDeployment {
  async deploy(environment: string, version: string, canaryPercent = 10) {
    console.log(`Starting canary deployment: ${canaryPercent}% traffic to ${version}`);
    
    try {
      // Deploy canary version
      await this.deployCanary(environment, version);
      
      // Route small percentage of traffic
      await this.routeTraffic(environment, version, canaryPercent);
      
      // Monitor metrics
      const metrics = await this.monitorCanary(environment, version, 300000); // 5 minutes
      
      if (this.isCanaryHealthy(metrics)) {
        // Gradually increase traffic
        await this.promoteCanary(environment, version);
      } else {
        // Rollback canary
        await this.rollbackCanary(environment, version);
        throw new Error('Canary deployment failed health checks');
      }
      
    } catch (error) {
      console.error('Canary deployment failed:', error);
      await this.rollbackCanary(environment, version);
      throw error;
    }
  }
  
  private async promoteCanary(environment: string, version: string) {
    const trafficSteps = [25, 50, 75, 100];
    
    for (const percent of trafficSteps) {
      await this.routeTraffic(environment, version, percent);
      
      console.log(`Routing ${percent}% traffic to canary`);
      
      // Monitor for 2 minutes at each step
      const metrics = await this.monitorCanary(environment, version, 120000);
      
      if (!this.isCanaryHealthy(metrics)) {
        throw new Error(`Canary promotion failed at ${percent}% traffic`);
      }
    }
    
    console.log('Canary deployment successfully promoted to 100%');
  }
}
```

## Environment Monitoring

### Multi-Environment Dashboard

```typescript
// utils/environment-monitor.ts
export class EnvironmentMonitor {
  async getEnvironmentStatus() {
    const environments = ['development', 'staging', 'production'];
    
    const statuses = await Promise.all(
      environments.map(async (env) => {
        const health = await this.checkEnvironmentHealth(env);
        const metrics = await this.getEnvironmentMetrics(env);
        const deployments = await this.getRecentDeployments(env);
        
        return {
          environment: env,
          health,
          metrics,
          deployments,
          lastUpdated: new Date()
        };
      })
    );
    
    return {
      environments: statuses,
      summary: this.generateSummary(statuses)
    };
  }
  
  private async checkEnvironmentHealth(environment: string) {
    try {
      const config = await this.getEnvironmentConfig(environment);
      const endpoint = config.api_endpoint;
      
      const response = await fetch(`${endpoint}/health`, {
        timeout: 5000
      });
      
      if (!response.ok) {
        return { status: 'unhealthy', reason: `HTTP ${response.status}` };
      }
      
      const health = await response.json();
      return health;
      
    } catch (error) {
      return { 
        status: 'unhealthy', 
        reason: error.message 
      };
    }
  }
  
  private generateSummary(statuses: any[]) {
    const healthy = statuses.filter(s => s.health.status === 'healthy').length;
    const total = statuses.length;
    
    return {
      healthyEnvironments: healthy,
      totalEnvironments: total,
      overallStatus: healthy === total ? 'healthy' : 'degraded',
      criticalIssues: statuses.filter(s => s.health.status === 'critical').length
    };
  }
}
```

### Cross-Environment Alerting

```typescript
// utils/cross-environment-alerts.ts
export class CrossEnvironmentAlerts {
  async setupAlerts() {
    const alerts = [
      {
        name: 'Production Down',
        condition: 'environment:production AND status:unhealthy',
        severity: 'critical',
        channels: ['pagerduty', 'slack-critical']
      },
      {
        name: 'Staging Deployment Failed',
        condition: 'environment:staging AND deployment:failed',
        severity: 'high',
        channels: ['slack-dev', 'email-dev-team']
      },
      {
        name: 'Development Environment Issues',
        condition: 'environment:development AND status:unhealthy',
        severity: 'low',
        channels: ['slack-dev']
      },
      {
        name: 'Cross-Environment Performance Degradation',
        condition: 'response_time > 2s AND affected_environments >= 2',
        severity: 'high',
        channels: ['slack-critical', 'email-sre']
      }
    ];
    
    for (const alert of alerts) {
      await this.createAlert(alert);
    }
  }
  
  private async createAlert(alert: any) {
    // Create CloudWatch alarm or integrate with monitoring service
    console.log(`Creating alert: ${alert.name}`);
    
    // Example with CloudWatch
    const cloudwatch = new AWS.CloudWatch();
    
    await cloudwatch.putMetricAlarm({
      AlarmName: alert.name,
      ComparisonOperator: 'GreaterThanThreshold',
      EvaluationPeriods: 2,
      MetricName: 'EnvironmentHealth',
      Namespace: 'ACE-Flow/Environments',
      Period: 300,
      Statistic: 'Average',
      Threshold: 0.8,
      ActionsEnabled: true,
      AlarmActions: [
        `arn:aws:sns:us-east-1:123456789012:${alert.name.replace(/\s+/g, '-')}`
      ],
      AlarmDescription: `Alert for ${alert.name}`,
      Dimensions: [
        {
          Name: 'Environment',
          Value: 'all'
        }
      ]
    }).promise();
  }
}
```

## Best Practices

### Environment Hygiene

1. **Consistent Configuration**: Use templates for environment consistency
2. **Secret Rotation**: Regularly rotate secrets across all environments
3. **Access Control**: Implement environment-specific access controls
4. **Data Isolation**: Ensure complete data separation between environments
5. **Resource Tagging**: Tag all resources with environment information

### Deployment Best Practices

1. **Always deploy to lower environments first**
2. **Run comprehensive tests in staging**
3. **Use feature flags for gradual rollouts**
4. **Implement automated rollback mechanisms**
5. **Monitor deployments closely**
6. **Document environment-specific procedures**

### Cost Management

```typescript
// utils/environment-cost-optimizer.ts
export class EnvironmentCostOptimizer {
  async optimizeEnvironmentCosts() {
    const environments = await this.getEnvironments();
    
    for (const env of environments) {
      if (env.name !== 'production') {
        await this.scheduleResourceShutdown(env, {
          schedule: '0 18 * * 1-5', // Shutdown at 6 PM weekdays
          resources: ['ec2', 'rds', 'elasticache']
        });
        
        await this.scheduleResourceStartup(env, {
          schedule: '0 8 * * 1-5', // Startup at 8 AM weekdays
          resources: ['ec2', 'rds', 'elasticache']
        });
      }
    }
  }
}
```

---

[← Back to Security Best Practices](security.md) | [Monitoring and Analytics →](monitoring.md)