# /ace-rollback - Safe Recovery System

## Overview
The `/ace-rollback` command provides safe recovery options when things go wrong. It can restore previous states, undo deployments, and recover from failed operations while preserving your work.

## Usage
```bash
# Show available restore points
/ace-rollback --list

# Rollback to previous deployment
/ace-rollback

# Rollback to specific point
/ace-rollback --to="2024-01-20T14:30:00"
/ace-rollback --to="before-auth-update"

# Rollback specific components
/ace-rollback --component=backend
/ace-rollback --component=schema
/ace-rollback --component=frontend

# Dry run (preview changes)
/ace-rollback --dry-run

# Enhanced backup and validation commands
/ace-rollback --status          # Check backup status  
/ace-rollback --create          # Create manual checkpoint
/ace-rollback --restore <id>    # Restore from checkpoint
/ace-rollback --cleanup         # Clean old checkpoints
/ace-rollback --validate        # Validate backup integrity
/ace-rollback --export <id>     # Export checkpoint for backup
```

## Restore Points

### Automatic Restore Points
ACE-Flow automatically creates restore points at:
- Before each deployment
- After successful implementations
- Before major schema changes
- Before authentication updates
- After successful validation

### Manual Restore Points
```bash
# Create custom restore point
/ace-checkpoint "before adding payments"
```

## 🛡️ Enhanced Automated Backup System

### Smart Checkpoint Creation

ACE-Flow now includes an enhanced automated backup system that addresses critical data safety concerns:

```bash
# Automatic checkpoint triggers:
- Before /ace-implement operations
- Before /ace-adopt migrations  
- Before destructive schema changes
- Before deployment operations
- Before configuration updates
- Before any destructive operations

# Checkpoint contents include:
- Complete project configuration files
- Schema definitions and data models
- Environment variables and secrets
- Custom code and templates
- ACE-Flow state and metadata
- Git commit hash and branch information
- Backup integrity checksums
```

### Backup Validation System

Every checkpoint includes comprehensive validation:

```bash
# Integrity checks performed:
✅ SHA256 checksums for all files
✅ Archive corruption detection  
✅ Metadata consistency validation
✅ Git state verification
✅ JSON schema validation
✅ Configuration file parsing
✅ Environment variable verification
✅ Dependency consistency checks
```

### Smart Timeout Optimization

The system includes progressive timeout handling to address hook timeout issues:

```bash
# Smart timeout implementation
execute_with_smart_timeout() {
    local operation=$1
    local base_timeout=30
    local max_retries=3
    local retry_count=0
    
    # Calculate complexity-based timeout
    local complexity_score=0
    [ -f "amplify/data/resource.ts" ] && complexity_score=$((complexity_score + 1))
    [ -d "src/components" ] && complexity_score=$((complexity_score + $(find src/components -name "*.tsx" | wc -l)))
    
    # Dynamic timeout: base + (complexity * 2), capped at 180s
    local timeout=$((base_timeout + (complexity_score * 2)))
    [ $timeout -gt 180 ] && timeout=180
    
    echo "🧠 Smart timeout: ${timeout}s (complexity: $complexity_score)"
    
    # Progressive retry with increasing timeouts
    while [ $retry_count -lt $max_retries ]; do
        retry_count=$((retry_count + 1))
        
        if timeout $timeout bash -c "$operation"; then
            return 0  # Success
        fi
        
        # Increase timeout for retries (addresses 15% failure rate)
        timeout=$((timeout + 30))
        [ $retry_count -lt $max_retries ] && sleep $((retry_count * 2))
    done
    
    echo "❌ Operation failed after $max_retries attempts"
    return 1
}
```

This optimization addresses the identified 15% hook timeout failure rate, targeting 95%+ success rate.

## Rollback Scenarios

### 🔴 Deployment Failed
```
❌ Deployment failed: CloudFormation stack update error

🔄 ACE-Rollback Options:
1. Automatic rollback to last stable state
2. Investigate error and retry
3. Manual rollback with modifications

Recommendation: Option 1 (automatic rollback)
Proceed? [Y/n]: Y

🔄 Rolling back...
✅ Backend restored to previous version
✅ Types regenerated
✅ Frontend synced
✅ Rollback complete!

💡 Issue identified: Table already exists
🔧 Suggested fix: Update table name in schema
```

### 🟡 Schema Breaking Change
```
⚠️ Schema change detected that may break existing data

Current schema has 1,234 User records
New schema removes required field 'username'

🔄 ACE-Rollback Safety Check:
□ Create backup of current data
□ Generate migration script
□ Test migration on sample data
□ Apply migration
□ Verify data integrity

Proceed with safe migration? [Y/n]: 
```

### 🟠 Authentication Misconfiguration
```
❌ Auth update failed: Users cannot log in

🔄 Quick Rollback Available:
- Restore point: "pre-auth-update" (15 minutes ago)
- Affected users: 0 (caught before impact)
- Downtime: ~2 minutes

Execute rollback? [Y/n]: Y

🔄 Rolling back auth configuration...
✅ Cognito settings restored
✅ Frontend auth updated
✅ Session handling reverted
✅ Users can log in again
```

## Rollback Process

### 1. Analysis Phase
```
🔍 Analyzing rollback request...
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Current State:      v2.3.0 (unstable)
Target State:       v2.2.0 (stable)
Changes to revert:  47 files, 1,234 lines
Data impact:        None
Downtime estimate:  3-5 minutes
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 2. Backup Phase
```
💾 Creating safety backup...
✅ Database snapshot created
✅ S3 bucket versioning enabled
✅ Configuration backed up
✅ Code state preserved
```

### 3. Rollback Phase
```
🔄 Executing rollback...
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ ☁️  Backend      ████████░░ 80%   ┃
┃ 📊 Database     ██████████ 100%  ┃
┃ 🔐 Auth         ██████████ 100%  ┃
┃ 💻 Frontend     ████░░░░░░ 40%   ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```

### 4. Verification Phase
```
✅ Verifying rollback...
- API endpoints: Responding ✅
- Authentication: Working ✅
- Database queries: Normal ✅
- Frontend build: Success ✅

🎉 Rollback completed successfully!
```

## Intelligent Recovery

### Auto-Detection
ACE-Flow detects issues and suggests rollbacks:
```
🚨 Anomaly detected!
- API error rate: 45% (threshold: 5%)
- Last deployment: 12 minutes ago
- Probable cause: Schema mismatch

Recommended action: Rollback deployment
Auto-rollback in 30 seconds... [Cancel]
```

### Partial Rollbacks
```
🔄 Selective Rollback Options:
┌─────────────────────────────────┐
│ Component      Status   Rollback │
├─────────────────────────────────┤
│ ✅ Backend     Stable   No      │
│ ❌ Schema      Error    Yes     │
│ ✅ Auth        Stable   No      │
│ ⚠️  Frontend    Warning  Optional│
└─────────────────────────────────┘

Select components to rollback: [2,4]
```

## Rollback History

### View History
```bash
/ace-rollback --history

📜 Rollback History
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Date         From    To      Reason           Result
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
2024-01-20   v2.3.0  v2.2.0  Deploy failed    ✅ Success
2024-01-18   v2.1.0  v2.0.0  Schema error     ✅ Success
2024-01-15   v1.9.0  v1.8.5  User request     ✅ Success
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## State Management

### Checkpoint System
```
.ace-flow/
└── checkpoints/
    ├── auto-2024-01-20-143000/
    │   ├── amplify-backup/
    │   ├── src-backup/
    │   └── metadata.json
    ├── manual-before-payments/
    └── stable-v2.2.0/
```

### Metadata Tracking
```json
{
  "timestamp": "2024-01-20T14:30:00Z",
  "version": "2.3.0",
  "trigger": "auto-pre-deployment",
  "components": {
    "backend": "stable",
    "frontend": "stable",
    "schema": "modified",
    "auth": "stable"
  },
  "git_commit": "a1b2c3d4",
  "deployment_id": "amp-deploy-123"
}
```

## Recovery Strategies

### Strategy 1: Fast Rollback
- Immediate reversion
- Minimal downtime
- No data migration
- Best for recent changes

### Strategy 2: Safe Migration
- Data backup first
- Migration scripts
- Gradual rollback
- Best for data changes

### Strategy 3: Blue-Green Switch
- Parallel environments
- Instant switching
- Zero downtime
- Best for production

## Best Practices

### 1. Regular Checkpoints
```bash
# Before major changes
/ace-checkpoint "pre-payment-integration"

# After successful features
/ace-checkpoint "stable-with-chat"
```

### 2. Test Rollbacks
```bash
# Practice in sandbox
/ace-rollback --dry-run --env=sandbox
```

### 3. Document Issues
```bash
# Add notes to rollback
/ace-rollback --reason="API rate limit issues"
```

### 4. Monitor After Rollback
```bash
# Watch for issues
/ace-status --monitor
```

## Limitations

### Cannot Rollback:
- Deleted user data
- External API changes
- Third-party service updates
- Certain IAM permission changes

### Rollback Window:
- Checkpoints kept for 30 days
- Automatic cleanup of old states
- Manual checkpoints preserved longer

## Emergency Procedures

### Critical Failure
```bash
# Emergency rollback (skips confirmations)
/ace-rollback --emergency --force

# Contact points displayed
🚨 Emergency Support:
- AWS Support: [Case ID generated]
- Amplify Team: [Slack channel]
- ACE-Flow Issues: [GitHub link]
```

---

*ACE-Rollback: Your safety net for confident development! 🛟*