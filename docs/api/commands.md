---
layout: docs
title: Command Reference
---

# Command Reference

Complete reference for all ACE-Flow commands and their options.

## Core Commands

### `/ace-genesis` (alias: `/ag`)

Intelligent project creation through conversational interface.

**Usage**:
```bash
/ace-genesis [project-idea]
/ag "e-commerce platform with real-time inventory"
```

**Options**:
- `--pattern <pattern>` - Use specific architecture pattern
- `--quick` - Skip detailed requirements gathering
- `--output <path>` - Specify output directory
- `--dry-run` - Generate specs without creating files

**Examples**:
```bash
# Interactive project creation
/ace-genesis

# Quick start with idea
/ag "social media app for photographers"

# Use specific pattern
/ace-genesis --pattern=e_commerce "marketplace for handmade goods"

# Generate specifications only
/ace-genesis --dry-run "analytics dashboard"
```

### `/ace-research` (alias: `/ar`)

Advanced documentation research system.

**Usage**:
```bash
/ace-research <domain> [search-pattern]
/ar amplify graphql-subscriptions
```

**Options**:
- `--pages <number>` - Pages to research (default: 30)
- `--depth <level>` - Research depth: surface, standard, deep
- `--format <type>` - Output format: markdown, json, yaml
- `--save <path>` - Save research to file

**Examples**:
```bash
# Research AWS Amplify authentication
/ar amplify auth

# Deep research with 100 pages
/ace-research --pages=100 --depth=deep amplify "real-time subscriptions"

# Save research results
/ar --save=research/amplify-auth.md amplify authentication
```

### `/ace-implement` (alias: `/ai`)

Infrastructure-aware implementation with smart timing.

**Usage**:
```bash
/ace-implement [project-name]
/ai my-social-platform
```

**Options**:
- `--skip-research` - Skip documentation research phase
- `--no-deploy` - Generate code without deploying
- `--env <environment>` - Target environment (sandbox, staging, prod)
- `--watch` - Monitor deployment progress

**Examples**:
```bash
# Full implementation with research
/ace-implement

# Quick implementation without research
/ai --skip-research my-dashboard

# Generate code only (no deployment)
/ace-implement --no-deploy analytics-app
```

### `/ace-adopt` (alias: `/aa`)

Safe migration of existing projects to ACE-Flow.

**Usage**:
```bash
/ace-adopt [description]
/aa "React app with Express API and MySQL"
```

**Options**:
- `--strategy <type>` - Migration strategy: gradual, parallel, replacement
- `--analyze <path>` - Analyze specific directory
- `--plan-only` - Generate migration plan without executing
- `--backup` - Create backup before migration

**Examples**:
```bash
# Analyze and migrate current directory
/ace-adopt

# Create migration plan only
/aa --plan-only "Legacy PHP application"

# Gradual migration with backup
/ace-adopt --strategy=gradual --backup "Node.js API"
```

## Status and Monitoring

### `/ace-status` (alias: `/as`)

Real-time progress tracking with visual indicators.

**Usage**:
```bash
/ace-status [options]
/as --specs
```

**Options**:
- `--brief` - Show condensed status
- `--specs` - Display project specifications
- `--hooks` - Show smart hook activity
- `--json` - Output in JSON format
- `--watch` - Continuous monitoring mode

**Examples**:
```bash
# Show current status
/ace-status

# View specifications
/as --specs

# Monitor hook activity
/as --hooks

# Continuous monitoring
/ace-status --watch
```

### `/ace-validate` (alias: `/av`)

Pre-implementation validation and health checks.

**Usage**:
```bash
/ace-validate [component]
/av --all
```

**Options**:
- `--all` - Validate entire project
- `--schema` - Validate GraphQL schema only
- `--auth` - Check authentication configuration
- `--deployment` - Verify deployment readiness
- `--fix` - Auto-fix validation issues

**Examples**:
```bash
# Validate everything
/ace-validate --all

# Check schema only
/av --schema

# Validate and fix issues
/ace-validate --fix
```

## Utility Commands

### `/ace-cost` (alias: `/ac`)

AWS resource cost estimation.

**Usage**:
```bash
/ace-cost [options]
/ac --monthly
```

**Options**:
- `--monthly` - Show monthly estimates
- `--yearly` - Show annual projections
- `--breakdown` - Detailed cost breakdown
- `--region <region>` - Estimate for specific region
- `--scale <factor>` - Scale estimates by usage factor

**Examples**:
```bash
# Basic cost estimate
/ace-cost

# Monthly breakdown
/ac --monthly --breakdown

# Scale for high traffic
/ace-cost --scale=10 --monthly
```

### `/ace-rollback` (alias: `/arb`)

Safe recovery and restore system.

**Usage**:
```bash
/ace-rollback [checkpoint]
/arb --list
```

**Options**:
- `--list` - Show available checkpoints
- `--create` - Create new checkpoint
- `--force` - Force rollback without confirmation
- `--partial <component>` - Rollback specific component

**Examples**:
```bash
# List checkpoints
/ace-rollback --list

# Create checkpoint
/arb --create "before-auth-changes"

# Rollback to specific point
/ace-rollback checkpoint-20240115-143022
```

### `/ace-help` (alias: `/ah`)

Comprehensive command documentation.

**Usage**:
```bash
/ace-help [command]
/ah ace-genesis
```

**Options**:
- `--examples` - Show usage examples
- `--verbose` - Detailed documentation
- `--search <term>` - Search help content

**Examples**:
```bash
# General help
/ace-help

# Help for specific command
/ah ace-implement --examples

# Search help content
/ace-help --search="authentication"
```

## Specialized Commands

### `/ace-spec-check` (alias: `/asc`)

Specification compliance monitoring.

**Usage**:
```bash
/ace-spec-check [component]
/asc --report
```

**Options**:
- `--report` - Generate compliance report
- `--fix` - Auto-fix spec violations
- `--strict` - Enable strict compliance mode
- `--baseline` - Set current state as baseline

**Examples**:
```bash
# Check all specifications
/ace-spec-check

# Generate detailed report
/asc --report --strict

# Fix compliance issues
/ace-spec-check --fix
```

### `/ace-steering` (alias: `/ast`)

Kiro-style steering context management.

**Usage**:
```bash
/ace-steering [action]
/ast --analytics
```

**Options**:
- `--analytics` - Show steering analytics
- `--export` - Export steering data
- `--reset` - Reset steering context
- `--import <file>` - Import steering configuration

**Examples**:
```bash
# View steering status
/ace-steering

# Show analytics
/ast --analytics

# Export steering data
/ace-steering --export=steering-backup.json
```

### `/ace-flow-install`

Install or update command aliases.

**Usage**:
```bash
/ace-flow-install [options]
```

**Options**:
- `--update` - Update existing installation
- `--force` - Force reinstallation
- `--uninstall` - Remove ACE-Flow aliases
- `--check` - Verify installation

**Examples**:
```bash
# Initial installation
/ace-flow-install

# Update existing installation
/ace-flow-install --update

# Verify installation
/ace-flow-install --check
```

## Command Chaining

Combine commands for powerful workflows:

```bash
# Research → Validate → Implement
/ar amplify auth && /av --auth && /ai auth-service

# Create → Check → Deploy
/ag "cms platform" && /asc && /ai --env=staging

# Backup → Implement → Validate
/arb --create "pre-migration" && /aa && /av --all
```

## Global Options

Available for all commands:

- `--verbose` - Enable verbose output
- `--quiet` - Suppress non-essential output
- `--no-color` - Disable colored output
- `--config <file>` - Use custom configuration
- `--log-level <level>` - Set logging level (error, warn, info, debug)

## Environment Variables

Control ACE-Flow behavior:

```bash
# Enable debug mode
export ACE_FLOW_DEBUG=true

# Set default AWS region
export ACE_FLOW_AWS_REGION=us-west-2

# Custom configuration directory
export ACE_FLOW_CONFIG_DIR=/path/to/config

# Disable telemetry
export ACE_FLOW_TELEMETRY=false
```

## Exit Codes

Standard exit codes returned by commands:

- `0` - Success
- `1` - General error
- `2` - Invalid arguments
- `3` - Configuration error
- `4` - Network/AWS error
- `5` - Validation failure
- `6` - Resource not found
- `7` - Permission denied

## Configuration Files

ACE-Flow uses several configuration files:

### `.ace-flow/config.yml`
```yaml
# Global ACE-Flow configuration
version: "1.2.0"
default_region: "us-east-1"
telemetry_enabled: true
auto_update: false

research:
  default_pages: 30
  default_depth: "standard"
  
implementation:
  auto_deploy: true
  wait_for_ready: true
  
validation:
  strict_mode: false
  auto_fix: true
```

### `.ace-flow/hooks.yml`
```yaml
# Smart hook configuration
hooks:
  pre_deploy:
    - validate_schema
    - check_costs
    - run_tests
    
  post_deploy:
    - verify_endpoints
    - run_integration_tests
    - update_documentation
```

## Advanced Usage

### Custom Patterns

Register custom architecture patterns:

```bash
# Register new pattern
/ace-register-pattern custom-analytics.yml

# List available patterns
/ace-list-patterns

# Use custom pattern
/ag --pattern=custom_analytics "data platform"
```

### Hook System

Configure smart hooks for automation:

```bash
# Setup pre-deployment hooks
/ace-setup-hooks --pre-deploy="validate,test,estimate-cost"

# View hook activity
/as --hooks

# Disable specific hooks
/ace-disable-hook cost-estimation
```

### Multi-Environment Support

Manage multiple environments:

```bash
# Deploy to staging
/ai --env=staging

# Promote staging to production
/ace-promote staging production

# Environment-specific validation
/av --env=production
```

## Troubleshooting Commands

Quick diagnostic help:

```bash
# System diagnostics
/ace-doctor

# Check permissions
/ace-check-permissions

# Verify AWS credentials
/ace-verify-aws

# Reset configuration
/ace-reset --config-only
```

## Integration with CI/CD

Use ACE-Flow in automated pipelines:

```bash
# CI-friendly mode (non-interactive)
/ace-validate --ci --fail-fast

# Generate deployment artifacts
/ace-build --output=artifacts/

# Deploy with verification
/ace-deploy --wait --verify
```

---

*For detailed examples and tutorials, see our [Examples](../examples) section.*