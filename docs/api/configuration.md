---
layout: docs
title: Configuration
---

# Configuration

Complete guide to configuring ACE-Flow for your development environment and project needs.

## Configuration Hierarchy

ACE-Flow uses a hierarchical configuration system:

1. **Global Configuration** - `~/.ace-flow/config.yml`
2. **Project Configuration** - `.ace-flow/config.yml`
3. **Environment Variables** - `ACE_FLOW_*`
4. **Command Line Arguments** - `--option=value`

Higher priority items override lower priority ones.

## Global Configuration

### Location
```bash
~/.ace-flow/config.yml
```

### Structure
```yaml
# ACE-Flow Global Configuration
version: "1.2.0"
installation_id: "uuid-generated-on-install"
last_updated: "2024-01-15T10:30:00Z"

# Default settings
defaults:
  aws_region: "us-east-1"
  architecture_pattern: "auto-detect"
  research_depth: "standard"
  auto_deploy: true
  telemetry_enabled: true
  
# AWS Configuration
aws:
  default_region: "us-east-1"
  profile: "default"
  credentials_file: "~/.aws/credentials"
  
# Research Settings
research:
  default_pages: 30
  max_pages: 100
  cache_duration: 3600  # seconds
  preferred_sources:
    - "docs.amplify.aws"
    - "aws.amazon.com/documentation"
    - "github.com/aws-amplify"
  
# Implementation Settings
implementation:
  auto_deploy: true
  wait_for_ready: true
  deployment_timeout: 900  # 15 minutes
  parallel_deployments: false
  
# Validation Settings
validation:
  strict_mode: false
  auto_fix: true
  skip_warnings: false
  required_checks:
    - "schema_validation"
    - "auth_configuration"
    - "cost_estimation"
    
# Cost Management
costs:
  currency: "USD"
  alert_threshold: 100.00
  detailed_breakdown: true
  include_free_tier: true
  
# User Interface
ui:
  color_output: true
  progress_indicators: true
  verbose_logging: false
  compact_status: false
  
# Telemetry and Analytics
telemetry:
  enabled: true
  anonymous_usage: true
  error_reporting: true
  performance_metrics: true
```

## Project Configuration

### Location
```bash
.ace-flow/config.yml
```

### Structure
```yaml
# Project-specific ACE-Flow Configuration
project:
  name: "my-awesome-app"
  type: "social_platform"
  created: "2024-01-15T10:30:00Z"
  version: "1.0.0"
  
# Project Settings Override Global
settings:
  aws_region: "us-west-2"  # Override global setting
  auto_deploy: false       # Override for this project
  
# Architecture Pattern Configuration
pattern:
  name: "social_platform"
  customizations:
    enable_real_time: true
    include_media_storage: true
    authentication_provider: "cognito"
    
# Schema Configuration
schema:
  models:
    - name: "User"
      custom_fields:
        - name: "preferences"
          type: "json"
    - name: "Post"
      enable_real_time: true
      
# Feature Flags
features:
  real_time_subscriptions: true
  file_upload: true
  push_notifications: false
  analytics: true
  
# Environment Specific Settings
environments:
  sandbox:
    auto_deploy: true
    cost_alerts: false
    
  staging:
    auto_deploy: false
    require_approval: true
    
  production:
    auto_deploy: false
    require_approval: true
    backup_before_deploy: true
    
# Custom Hooks
hooks:
  pre_generation:
    - "validate_requirements"
    - "check_dependencies"
    
  post_generation:
    - "run_linting"
    - "generate_docs"
    
  pre_deployment:
    - "run_tests"
    - "security_scan"
    - "cost_estimate"
    
  post_deployment:
    - "verify_endpoints"
    - "run_smoke_tests"
    - "update_monitoring"
    
# Dependencies and Integrations
integrations:
  github:
    enabled: true
    auto_commit: false
    branch_protection: true
    
  slack:
    enabled: false
    webhook_url: "${SLACK_WEBHOOK_URL}"
    channels:
      deployments: "#deployments"
      errors: "#alerts"
      
  monitoring:
    cloudwatch: true
    datadog: false
    newrelic: false
```

## Environment Variables

### ACE-Flow Specific
```bash
# Core Configuration
export ACE_FLOW_CONFIG_DIR="/custom/config/path"
export ACE_FLOW_DEBUG=true
export ACE_FLOW_VERBOSE=false

# AWS Configuration
export ACE_FLOW_AWS_REGION="us-west-2"
export ACE_FLOW_AWS_PROFILE="development"

# Feature Toggles
export ACE_FLOW_TELEMETRY=false
export ACE_FLOW_AUTO_UPDATE=true
export ACE_FLOW_PARALLEL_DEPLOY=false

# Research Configuration
export ACE_FLOW_RESEARCH_PAGES=50
export ACE_FLOW_RESEARCH_CACHE=true

# UI Configuration
export ACE_FLOW_NO_COLOR=false
export ACE_FLOW_COMPACT_OUTPUT=true
```

### AWS Environment Variables
```bash
# AWS Credentials
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_SESSION_TOKEN="your-session-token"
export AWS_DEFAULT_REGION="us-east-1"
export AWS_PROFILE="your-profile"

# AWS SDK Configuration
export AWS_SDK_LOAD_CONFIG=1
export AWS_CONFIG_FILE="~/.aws/config"
export AWS_SHARED_CREDENTIALS_FILE="~/.aws/credentials"
```

## Command Line Configuration

### Global Options
```bash
# Override any configuration setting
/ace-genesis --config.aws_region=us-west-2
/ace-implement --config.auto_deploy=false

# Specify custom config file
/ace-status --config-file=/path/to/custom-config.yml

# Environment-specific overrides
/ace-deploy --env=staging --config.require_approval=false
```

### Configuration Commands
```bash
# View current configuration
/ace-config --show

# Set configuration values
/ace-config --set aws.region=us-west-2
/ace-config --set research.default_pages=50

# Reset to defaults
/ace-config --reset

# Validate configuration
/ace-config --validate
```

## Pattern-Specific Configuration

### Social Platform Pattern
```yaml
pattern:
  name: "social_platform"
  settings:
    max_post_length: 280
    enable_stories: true
    media_formats: ["image", "video", "gif"]
    real_time_features:
      - "likes"
      - "comments"
      - "notifications"
    content_moderation: true
```

### E-commerce Pattern
```yaml
pattern:
  name: "e_commerce"
  settings:
    payment_providers: ["stripe", "paypal"]
    inventory_tracking: true
    multi_vendor: false
    shipping_integration: true
    tax_calculation: true
    currencies: ["USD", "EUR", "GBP"]
```

### Dashboard Analytics Pattern
```yaml
pattern:
  name: "dashboard_analytics"
  settings:
    data_sources: ["api", "database", "files"]
    visualization_types: ["charts", "tables", "maps"]
    real_time_updates: true
    export_formats: ["pdf", "csv", "excel"]
    user_permissions: true
```

## Hook Configuration

### Available Hooks
```yaml
hooks:
  # Generation Phase
  pre_generation: []
  post_generation: []
  
  # Research Phase
  pre_research: []
  post_research: []
  
  # Deployment Phase
  pre_deployment: []
  post_deployment: []
  
  # Validation Phase
  pre_validation: []
  post_validation: []
  
  # Custom Lifecycle Events
  on_error: []
  on_success: []
  on_rollback: []
```

### Custom Hook Scripts
```yaml
hooks:
  pre_deployment:
    - name: "run_tests"
      script: "./scripts/run-tests.sh"
      timeout: 300
      required: true
      
    - name: "security_scan"
      script: "npm run security-check"
      timeout: 120
      required: false
      
  post_deployment:
    - name: "smoke_tests"
      script: "./scripts/smoke-tests.sh"
      timeout: 180
      retry: 3
```

## Integration Configuration

### GitHub Integration
```yaml
integrations:
  github:
    enabled: true
    token: "${GITHUB_TOKEN}"
    owner: "your-username"
    repo: "your-repo"
    settings:
      auto_commit: false
      commit_message_template: "ACE-Flow: {action} - {description}"
      branch_prefix: "ace-flow/"
      create_pr: true
      pr_template: ".github/pull_request_template.md"
```

### Slack Integration
```yaml
integrations:
  slack:
    enabled: true
    webhook_url: "${SLACK_WEBHOOK_URL}"
    channels:
      deployments: "#deployments"
      errors: "#alerts"
      general: "#ace-flow"
    message_templates:
      deployment_start: "🚀 Deploying {project} to {environment}"
      deployment_success: "✅ {project} deployed successfully"
      deployment_failure: "❌ {project} deployment failed"
```

### Monitoring Integration
```yaml
integrations:
  monitoring:
    cloudwatch:
      enabled: true
      custom_metrics: true
      log_groups: true
      
    datadog:
      enabled: false
      api_key: "${DATADOG_API_KEY}"
      tags:
        - "project:{project_name}"
        - "environment:{environment}"
```

## Security Configuration

### Secrets Management
```yaml
security:
  secrets_manager: "aws"  # aws, vault, env
  encryption_key: "${ACE_FLOW_ENCRYPTION_KEY}"
  
  # Allowed secrets patterns
  allowed_secrets:
    - "DATABASE_URL"
    - "API_KEY_*"
    - "*_SECRET"
    
  # Blocked patterns
  blocked_secrets:
    - "password"
    - "key"
    - "secret"
```

### Access Control
```yaml
security:
  access_control:
    require_mfa: false
    allowed_ips: []
    allowed_users: []
    admin_users: []
    
  audit:
    enabled: true
    log_commands: true
    log_file: "~/.ace-flow/audit.log"
```

## Performance Configuration

### Caching
```yaml
performance:
  caching:
    enabled: true
    ttl: 3600  # seconds
    max_size: "100MB"
    location: "~/.ace-flow/cache"
    
  research_cache:
    enabled: true
    ttl: 86400  # 24 hours
    max_entries: 1000
```

### Concurrency
```yaml
performance:
  concurrency:
    max_parallel_operations: 5
    research_workers: 3
    deployment_timeout: 900
    
  optimization:
    lazy_loading: true
    compress_outputs: true
    minimal_logging: false
```

## Validation Configuration

### Schema Validation
```yaml
validation:
  schema:
    strict_mode: false
    allow_custom_fields: true
    require_descriptions: false
    max_model_count: 50
    max_field_count: 100
    
  naming_conventions:
    model_names: "PascalCase"
    field_names: "camelCase"
    enum_values: "UPPER_CASE"
```

### Deployment Validation
```yaml
validation:
  deployment:
    check_costs: true
    cost_threshold: 100.00
    check_quotas: true
    verify_permissions: true
    
  pre_checks:
    - "aws_credentials"
    - "service_quotas"
    - "network_connectivity"
    - "disk_space"
```

## Configuration Templates

### Development Environment
```yaml
# .ace-flow/config.development.yml
environments:
  development:
    aws_region: "us-east-1"
    auto_deploy: true
    cost_alerts: false
    validation:
      strict_mode: false
    features:
      debug_mode: true
      verbose_logging: true
```

### Production Environment
```yaml
# .ace-flow/config.production.yml
environments:
  production:
    aws_region: "us-west-2"
    auto_deploy: false
    require_approval: true
    backup_before_deploy: true
    validation:
      strict_mode: true
    monitoring:
      enabled: true
      alert_threshold: 50.00
```

## Configuration Management

### Version Control
```bash
# Add configuration to git
git add .ace-flow/config.yml

# Use different configs per environment
cp .ace-flow/config.production.yml .ace-flow/config.yml
```

### Configuration Validation
```bash
# Validate current configuration
/ace-config --validate

# Check for configuration conflicts
/ace-config --check-conflicts

# Show effective configuration
/ace-config --show-effective
```

### Migration and Updates
```bash
# Migrate old configuration format
/ace-config --migrate

# Update to latest schema
/ace-config --update-schema

# Backup current configuration
/ace-config --backup
```

---

*For more advanced configuration scenarios, see our [Advanced Configuration Guide](../advanced/configuration) or join our [Discord community](https://discord.gg/ace-flow) for help.*