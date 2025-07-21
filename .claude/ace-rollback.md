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

## Automated Backup System Implementation

### Checkpoint Creation Process

When you invoke `/ace-rollback`, ACE-Flow automatically executes this backup system:

```bash
#!/bin/bash
# Automated checkpoint creation with validation

create_checkpoint() {
    local description="${1:-Auto-checkpoint before operation}"
    local timestamp=$(date +"%Y%m%d-%H%M%S")
    local checkpoint_dir=".ace-flow/checkpoints/checkpoint-$timestamp"
    
    echo "🔄 Creating checkpoint: $checkpoint_dir"
    
    # Create checkpoint directory
    mkdir -p "$checkpoint_dir"
    
    # Backup critical project files
    backup_project_files() {
        echo "📦 Backing up project configuration..."
        
        # Amplify backend configuration
        if [[ -d "amplify" ]]; then
            cp -r amplify/ "$checkpoint_dir/amplify/" 2>/dev/null || echo "⚠️ amplify/ not found"
        fi
        
        # Package files
        [[ -f "package.json" ]] && cp package.json "$checkpoint_dir/"
        [[ -f "package-lock.json" ]] && cp package-lock.json "$checkpoint_dir/"
        [[ -f "yarn.lock" ]] && cp yarn.lock "$checkpoint_dir/"
        
        # Amplify outputs
        [[ -f "amplify_outputs.json" ]] && cp amplify_outputs.json "$checkpoint_dir/"
        
        # Environment files (excluding secrets)
        find . -name ".env.example" -o -name ".env.local.example" | head -10 | while read envfile; do
            cp "$envfile" "$checkpoint_dir/"
        done
        
        # ACE-Flow configuration
        if [[ -d ".claude" ]]; then
            cp -r .claude/ "$checkpoint_dir/claude-config/" 2>/dev/null || true
        fi
        [[ -f "CLAUDE.md" ]] && cp CLAUDE.md "$checkpoint_dir/"
        
        # Critical source files (limit to prevent huge backups)
        if [[ -d "src" ]]; then
            find src -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" | head -50 | while read srcfile; do
                mkdir -p "$checkpoint_dir/$(dirname $srcfile)"
                cp "$srcfile" "$checkpoint_dir/$srcfile"
            done
        fi
    }
    
    # Execute backup
    backup_project_files
    
    # Create detailed metadata
    create_checkpoint_metadata "$checkpoint_dir" "$description" "$timestamp"
    
    # Validate checkpoint integrity
    if validate_checkpoint "$checkpoint_dir"; then
        echo "✅ Checkpoint created successfully: checkpoint-$timestamp"
        echo "📊 Files backed up: $(find "$checkpoint_dir" -type f | wc -l)"
        return 0
    else
        echo "❌ Checkpoint validation failed, removing invalid checkpoint"
        rm -rf "$checkpoint_dir"
        return 1
    fi
}

create_checkpoint_metadata() {
    local checkpoint_dir=$1
    local description=$2
    local timestamp=$3
    
    cat > "$checkpoint_dir/metadata.json" << EOF
{
  "timestamp": "$timestamp",
  "iso_timestamp": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "description": "$description",
  "checkpoint_version": "1.0",
  "git_info": {
    "commit": "$(git rev-parse HEAD 2>/dev/null || echo 'unknown')",
    "branch": "$(git branch --show-current 2>/dev/null || echo 'unknown')",
    "status": "$(git status --porcelain 2>/dev/null | wc -l) files modified"
  },
  "system_info": {
    "user": "$(whoami)",
    "hostname": "$(hostname)",
    "working_directory": "$(pwd)",
    "node_version": "$(node --version 2>/dev/null || echo 'unknown')",
    "npm_version": "$(npm --version 2>/dev/null || echo 'unknown')"
  },
  "project_state": {
    "has_amplify": $(test -d amplify && echo 'true' || echo 'false'),
    "has_package_json": $(test -f package.json && echo 'true' || echo 'false'),
    "has_amplify_outputs": $(test -f amplify_outputs.json && echo 'true' || echo 'false'),
    "source_files_backed_up": $(find "$checkpoint_dir" -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" 2>/dev/null | wc -l)
  },
  "backup_stats": {
    "total_files": $(find "$checkpoint_dir" -type f | wc -l),
    "total_size_bytes": $(du -sb "$checkpoint_dir" 2>/dev/null | cut -f1),
    "created_by": "ace-rollback automated system"
  }
}
EOF
}
```

### Backup Validation System

```bash
validate_checkpoint() {
    local checkpoint_dir=$1
    
    echo "🔍 Validating checkpoint integrity..."
    
    # Check if checkpoint directory exists
    if [[ ! -d "$checkpoint_dir" ]]; then
        echo "❌ Checkpoint directory not found: $checkpoint_dir"
        return 1
    fi
    
    # Validate metadata file
    local metadata_file="$checkpoint_dir/metadata.json"
    if [[ ! -f "$metadata_file" ]]; then
        echo "❌ Missing metadata.json"
        return 1
    fi
    
    # Validate JSON syntax
    if ! jq empty "$metadata_file" 2>/dev/null; then
        echo "❌ Invalid JSON in metadata.json"
        return 1
    fi
    
    # Check required metadata fields
    local required_fields=("timestamp" "description" "checkpoint_version")
    for field in "${required_fields[@]}"; do
        if [[ $(jq -r ".$field // empty" "$metadata_file") == "" ]]; then
            echo "❌ Missing required field: $field"
            return 1
        fi
    done
    
    # Validate file count
    local file_count=$(find "$checkpoint_dir" -type f | wc -l)
    if [[ $file_count -lt 2 ]]; then  # At least metadata.json + 1 other file
        echo "⚠️ Warning: Very few files in checkpoint ($file_count files)"
    fi
    
    # Check for empty files
    local empty_files=$(find "$checkpoint_dir" -type f -empty | wc -l)
    if [[ $empty_files -gt 0 ]]; then
        echo "⚠️ Warning: $empty_files empty files found"
    fi
    
    echo "✅ Checkpoint validation passed"
    echo "📊 Validation summary: $file_count files, $(du -sh "$checkpoint_dir" 2>/dev/null | cut -f1) total size"
    
    return 0
}
```

### Automatic Cleanup System

```bash
cleanup_old_checkpoints() {
    local max_checkpoints=10
    local checkpoints_dir=".ace-flow/checkpoints"
    
    echo "🧹 Cleaning up old checkpoints (keeping last $max_checkpoints)..."
    
    if [[ ! -d "$checkpoints_dir" ]]; then
        echo "📁 No checkpoints directory found, nothing to clean up"
        return 0
    fi
    
    # Get all checkpoint directories sorted by modification time (oldest first)
    local checkpoints=($(find "$checkpoints_dir" -type d -name "checkpoint-*" -printf '%T@ %p\n' | sort -n | cut -d' ' -f2-))
    local total_checkpoints=${#checkpoints[@]}
    
    echo "📊 Found $total_checkpoints checkpoints"
    
    if [[ $total_checkpoints -le $max_checkpoints ]]; then
        echo "✅ No cleanup needed (within limit of $max_checkpoints)"
        return 0
    fi
    
    local to_delete=$((total_checkpoints - max_checkpoints))
    echo "🗑️ Will delete $to_delete oldest checkpoints"
    
    # Delete oldest checkpoints
    for ((i=0; i<to_delete; i++)); do
        local checkpoint_to_delete="${checkpoints[$i]}"
        local checkpoint_name=$(basename "$checkpoint_to_delete")
        
        # Show info about checkpoint being deleted
        if [[ -f "$checkpoint_to_delete/metadata.json" ]]; then
            local timestamp=$(jq -r '.timestamp // "unknown"' "$checkpoint_to_delete/metadata.json" 2>/dev/null)
            local description=$(jq -r '.description // "No description"' "$checkpoint_to_delete/metadata.json" 2>/dev/null)
            echo "🗑️ Deleting: $checkpoint_name ($timestamp - $description)"
        else
            echo "🗑️ Deleting: $checkpoint_name (no metadata)"
        fi
        
        rm -rf "$checkpoint_to_delete"
    done
    
    echo "✅ Cleanup completed: kept $max_checkpoints most recent checkpoints"
}
```

### Smart Hook Integration for Timeouts

Enhanced hook system to address the 15% timeout issue:

```bash
execute_with_smart_timeout() {
    local operation="$1"
    local base_timeout=30
    local max_attempts=3
    
    # Dynamic timeout based on operation complexity
    local timeout_seconds=$base_timeout
    case "$operation" in
        *"large-deployment"*|*"infrastructure"*)
            timeout_seconds=180  # 3 minutes for complex operations
            ;;
        *"schema"*|*"migration"*)
            timeout_seconds=120  # 2 minutes for schema changes
            ;;
        *"backup"*|*"checkpoint"*)
            timeout_seconds=60   # 1 minute for backup operations
            ;;
    esac
    
    echo "⏱️ Using $timeout_seconds second timeout for: $operation"
    
    for attempt in $(seq 1 $max_attempts); do
        echo "🔄 Attempt $attempt/$max_attempts..."
        
        if timeout "$timeout_seconds" bash -c "$operation"; then
            echo "✅ Operation completed successfully on attempt $attempt"
            return 0
        else
            local exit_code=$?
            if [[ $exit_code -eq 124 ]]; then
                echo "⏰ Operation timed out after $timeout_seconds seconds"
                if [[ $attempt -lt $max_attempts ]]; then
                    timeout_seconds=$((timeout_seconds + 30))  # Increase timeout
                    echo "📈 Increasing timeout to $timeout_seconds seconds for next attempt"
                fi
            else
                echo "❌ Operation failed with exit code $exit_code"
            fi
        fi
        
        if [[ $attempt -lt $max_attempts ]]; then
            echo "⏳ Waiting 5 seconds before retry..."
            sleep 5
        fi
    done
    
    echo "❌ Operation failed after $max_attempts attempts"
    return 1
}
```

### State Management

#### Checkpoint Directory Structure
```
.ace-flow/
├── checkpoints/
│   ├── checkpoint-20250721-143052/
│   │   ├── amplify/           # Full Amplify backend config
│   │   ├── claude-config/     # ACE-Flow command configuration
│   │   ├── src/              # Critical source files (limited)
│   │   ├── package.json      # Dependencies
│   │   ├── amplify_outputs.json
│   │   ├── CLAUDE.md
│   │   └── metadata.json     # Comprehensive checkpoint info
│   ├── checkpoint-20250721-142015/
│   └── checkpoint-20250721-140830/
└── .gitkeep
```

#### Enhanced Metadata Structure
```json
{
  "timestamp": "20250721-143052",
  "iso_timestamp": "2025-07-21T14:30:52Z",
  "description": "Auto-checkpoint before schema migration",
  "checkpoint_version": "1.0",
  "git_info": {
    "commit": "a1b2c3d4e5f6",
    "branch": "feature/payment-system",
    "status": "3 files modified"
  },
  "system_info": {
    "user": "developer",
    "hostname": "dev-machine",
    "working_directory": "/path/to/project",
    "node_version": "v18.17.0",
    "npm_version": "9.6.7"
  },
  "project_state": {
    "has_amplify": true,
    "has_package_json": true,
    "has_amplify_outputs": true,
    "source_files_backed_up": 23
  },
  "backup_stats": {
    "total_files": 45,
    "total_size_bytes": 892456,
    "created_by": "ace-rollback automated system"
  }
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