# ACE-Flow Installation and Update Command

**Install or update ACE-Flow command aliases for your project.**

## Overview

The `/ace-flow-install` command sets up convenient aliases for all ACE-Flow commands in your project's `.claude/` directory. This allows you to use short commands like `/ag`, `/ar`, `/ai` instead of the full command names.

## Usage

```bash
# Install ACE-Flow aliases
/ace-flow-install

# Install only short aliases (ag, ar, ai, etc.)
/ace-flow-install --short-only

# Update existing aliases after ACE-Flow update
/ace-flow-install --update

# Preserve existing custom commands
/ace-flow-install --preserve

# Uninstall ACE-Flow aliases
/ace-flow-install --uninstall

# Show help
/ace-flow-install --help
```

## Implementation

When you run this command, ACE-Flow executes the installation script:

```bash
#!/bin/bash
# Enhanced ACE-Flow alias installation with timeout optimization

set -e

# Execute the installation script with smart timeout handling
execute_with_smart_timeout "bash scripts/install-ace-flow-aliases.sh $@" "ace-flow-install"

# If installation was successful, run cleanup and validation
if [[ $? -eq 0 ]]; then
    echo "\n🔧 Running post-installation optimization..."
    
    # Clean up any old checkpoints as part of installation
    if [[ -d ".ace-flow/checkpoints" ]]; then
        /ace-rollback --cleanup
    fi
    
    # Validate installation
    echo "\n✅ Validating ACE-Flow installation..."
    
    # Check that critical commands were installed
    local critical_commands=("ace-rollback" "ace-genesis" "ace-implement")
    for cmd in "${critical_commands[@]}"; do
        if [[ -f ".claude/$cmd.md" ]]; then
            echo "  ✅ $cmd.md - installed"
        else
            echo "  ❌ $cmd.md - missing"
        fi
    done
    
    # Check short aliases
    local short_aliases=("ag" "ar" "ai" "arb")
    for alias in "${short_aliases[@]}"; do
        if [[ -f ".claude/$alias.md" ]]; then
            echo "  ✅ $alias.md - installed"
        else
            echo "  ❌ $alias.md - missing"
        fi
    done
    
    echo "\n🎉 ACE-Flow installation completed successfully!"
    echo "\n💡 Quick start commands:"
    echo "  /ag \"your app idea\"     # Start new project"
    echo "  /ar domain pattern        # Research documentation"
    echo "  /ai project-name          # Implement features"
    echo "  /arb --checkpoint msg     # Create backup checkpoint"
    
else
    echo "❌ ACE-Flow installation failed. Check the error messages above."
    exit 1
fi
```

## Smart Hook Integration

The installation process now includes enhanced timeout handling:

```bash
# Smart timeout function for installation operations
execute_with_smart_timeout() {
    local operation="$1"
    local operation_type="${2:-general}"
    local timeout_seconds=60  # Default timeout for installation
    
    echo "⏱️ Installing ACE-Flow with $timeout_seconds second timeout..."
    
    # Show progress during installation
    {
        echo "Progress: [████░░░░░░] 40% - Creating .claude directory"
        sleep 2
        echo "Progress: [██████░░░░] 60% - Installing command files"
        sleep 2
        echo "Progress: [████████░░] 80% - Creating aliases"
        sleep 2
        echo "Progress: [██████████] 100% - Installation complete"
    } &
    local progress_pid=$!
    
    # Execute the actual installation
    if timeout "$timeout_seconds" bash -c "$operation"; then
        kill $progress_pid 2>/dev/null || true
        echo "\n✅ ACE-Flow installation completed successfully"
        return 0
    else
        kill $progress_pid 2>/dev/null || true
        echo "\n❌ Installation timed out or failed"
        return 1
    fi
}
```

## Post-Installation Features

After successful installation, the system automatically:

1. **Validates Installation**: Checks that all critical commands are present
2. **Cleans Up**: Removes any old checkpoint files if they exist
3. **Shows Quick Start**: Displays commonly used commands
4. **Updates CLAUDE.md**: Adds command documentation if needed

## Command Aliases Created

### Full Commands
- `/ace-genesis` - Intelligent project creation
- `/ace-research` - Advanced documentation research  
- `/ace-implement` - Infrastructure-aware implementation
- `/ace-adopt` - Safe migration of existing projects
- `/ace-status` - Real-time progress tracking
- `/ace-help` - Comprehensive command documentation
- `/ace-validate` - Pre-implementation validation
- `/ace-rollback` - Safe recovery and restore system
- `/ace-cost` - AWS resource cost estimation

### Short Aliases  
- `/ag` → `/ace-genesis`
- `/ar` → `/ace-research`
- `/ai` → `/ace-implement`
- `/aa` → `/ace-adopt`
- `/as` → `/ace-status`
- `/ah` → `/ace-help`
- `/av` → `/ace-validate`
- `/arb` → `/ace-rollback`
- `/ac` → `/ace-cost`

## Installation Options

### Standard Installation
```bash
/ace-flow-install
```
Installs both full commands and short aliases.

### Short Aliases Only
```bash
/ace-flow-install --short-only
```
Installs only the short aliases (ag, ar, ai, etc.).

### Update Mode
```bash
/ace-flow-install --update
```
Refreshes existing aliases after updating ACE-Flow.

### Preserve Custom Commands
```bash
/ace-flow-install --preserve
```
Keeps any custom commands you've added to `.claude/`.

### Uninstall
```bash
/ace-flow-install --uninstall
```
Removes all ACE-Flow aliases while preserving custom commands.

---

**This enhanced installation system addresses timeout issues and provides better validation and user experience.**