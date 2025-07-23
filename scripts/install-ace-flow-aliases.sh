#!/bin/bash

# ACE-Flow Alias Installation Script
# This script creates convenient aliases for ACE-Flow commands in your project

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default options
SHORT_ONLY=false
PRESERVE=false
UPDATE=false
UNINSTALL=false
HELP=false

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --short-only) SHORT_ONLY=true ;;
        --preserve) PRESERVE=true ;;
        --update) UPDATE=true ;;
        --uninstall) UNINSTALL=true ;;
        --help) HELP=true ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

# Show help if requested
if [ "$HELP" = true ]; then
    echo "ACE-Flow Alias Installer"
    echo ""
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --short-only    Only create short aliases (ag, ar, ai, etc.)"
    echo "  --preserve      Preserve existing custom commands in .claude/"
    echo "  --update        Update existing aliases after submodule update"
    echo "  --uninstall     Remove ACE-Flow aliases (preserves custom commands)"
    echo "  --help          Show this help message"
    echo ""
    exit 0
fi

# Detect ACE-Flow location (submodule or current directory)
if [ -d ".ace-flow/.claude" ]; then
    ACE_FLOW_DIR=".ace-flow"
    echo -e "${BLUE}Found ACE-Flow in submodule at ${ACE_FLOW_DIR}${NC}"
elif [ -d ".claude" ] && [ -f ".claude/ace-genesis.md" ]; then
    ACE_FLOW_DIR="."
    echo -e "${BLUE}Found ACE-Flow in current directory${NC}"
else
    echo -e "${RED}Error: Cannot find ACE-Flow commands. Make sure you're in the project root.${NC}"
    exit 1
fi

# Detect operating system
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    OS="windows"
fi

echo -e "${BLUE}Detected OS: ${OS}${NC}"

# Function to create a link or copy based on OS
create_alias() {
    local source=$1
    local target=$2
    
    if [ "$OS" = "windows" ]; then
        # On Windows, create a copy
        cp "$source" "$target"
        echo -e "${GREEN}Created copy: $target${NC}"
    else
        # On Unix/Mac, create a symlink
        ln -sf "$source" "$target"
        echo -e "${GREEN}Created symlink: $target${NC}"
    fi
}

# Function to uninstall ACE-Flow aliases
uninstall_aliases() {
    echo -e "${YELLOW}Uninstalling ACE-Flow aliases...${NC}"
    
    # If we're in the ACE-Flow directory itself, only remove short aliases
    if [ "$ACE_FLOW_DIR" = "." ]; then
        # Only remove short aliases when in ACE-Flow directory
        SHORT_ALIASES=("ag" "ar" "ai" "aa" "as" "ah" "av" "arb" "ac")
        
        for alias in "${SHORT_ALIASES[@]}"; do
            if [ -f ".claude/${alias}.md" ]; then
                rm ".claude/${alias}.md"
                echo -e "${GREEN}Removed: .claude/${alias}.md${NC}"
            fi
        done
    else
        # In a project using ACE-Flow as submodule, remove all aliases
        ACE_COMMANDS=(
            "ace-genesis" "ace-research" "ace-implement" "ace-adopt"
            "ace-status" "ace-help" "ace-validate" "ace-rollback" "ace-cost"
            "ace-flow-install"
            "ag" "ar" "ai" "aa" "as" "ah" "av" "arb" "ac"
        )
        
        for cmd in "${ACE_COMMANDS[@]}"; do
            if [ -f ".claude/${cmd}.md" ]; then
                rm ".claude/${cmd}.md"
                echo -e "${GREEN}Removed: .claude/${cmd}.md${NC}"
            fi
        done
    fi
    
    # Remove manifest
    if [ -f ".claude/.ace-flow-manifest" ]; then
        rm ".claude/.ace-flow-manifest"
    fi
    
    echo -e "${GREEN}ACE-Flow aliases uninstalled successfully!${NC}"
    exit 0
}

# Handle uninstall
if [ "$UNINSTALL" = true ]; then
    uninstall_aliases
fi

# Create .claude directory if it doesn't exist
if [ ! -d ".claude" ]; then
    mkdir -p .claude
    echo -e "${GREEN}Created .claude/ directory${NC}"
fi

# Backup existing .claude directory if preserve is set
if [ "$PRESERVE" = true ] && [ "$UPDATE" = false ]; then
    if [ -d ".claude" ] && [ "$(ls -A .claude)" ]; then
        backup_dir=".claude.backup.$(date +%Y%m%d_%H%M%S)"
        cp -r .claude "$backup_dir"
        echo -e "${YELLOW}Backed up existing .claude/ to $backup_dir${NC}"
    fi
fi

# Define ACE-Flow commands and their short aliases
# Using arrays instead of associative array for compatibility
COMMANDS=(
    "ace-genesis:ag"
    "ace-research:ar"
    "ace-implement:ai"
    "ace-adopt:aa"
    "ace-status:as"
    "ace-help:ah"
    "ace-validate:av"
    "ace-rollback:arb"
    "ace-cost:ac"
    "ace-spec-check:asc"
    "ace-steering:ast"
)

# Create manifest file to track installed commands
echo "# ACE-Flow Alias Manifest" > .claude/.ace-flow-manifest
echo "# Generated on $(date)" >> .claude/.ace-flow-manifest
echo "ACE_FLOW_DIR=$ACE_FLOW_DIR" >> .claude/.ace-flow-manifest

# Install ace-flow-install command first (special case)
if [ "$ACE_FLOW_DIR" = "." ]; then
    # If in current directory, just reference it
    echo "ace-flow-install.md already in .claude/" >> .claude/.ace-flow-manifest
else
    # If in submodule, create alias
    create_alias "../$ACE_FLOW_DIR/.claude/ace-flow-install.md" ".claude/ace-flow-install.md"
    echo "ace-flow-install.md" >> .claude/.ace-flow-manifest
fi

# Install full command aliases
if [ "$SHORT_ONLY" = false ]; then
    echo -e "${BLUE}Installing full command aliases...${NC}"
    
    for cmd_pair in "${COMMANDS[@]}"; do
        cmd="${cmd_pair%%:*}"
        source_file="$ACE_FLOW_DIR/.claude/${cmd}.md"
        target_file=".claude/${cmd}.md"
        
        if [ -f "$source_file" ]; then
            if [ "$ACE_FLOW_DIR" = "." ]; then
                # Skip if we're in the same directory
                echo -e "${YELLOW}Skipping ${cmd}.md (already in .claude/)${NC}"
            else
                # Check if file exists and preserve is set
                if [ -f "$target_file" ] && [ "$PRESERVE" = true ] && [ "$UPDATE" = false ]; then
                    echo -e "${YELLOW}Preserving existing: $target_file${NC}"
                else
                    # Create relative path for symlink
                    relative_source="../$source_file"
                    create_alias "$relative_source" "$target_file"
                    echo "${cmd}.md" >> .claude/.ace-flow-manifest
                fi
            fi
        else
            echo -e "${YELLOW}Warning: ${source_file} not found${NC}"
        fi
    done
fi

# Install short aliases
echo -e "${BLUE}Installing short command aliases...${NC}"

for cmd_pair in "${COMMANDS[@]}"; do
    cmd="${cmd_pair%%:*}"
    short_alias="${cmd_pair##*:}"
    target_file=".claude/${short_alias}.md"
    
    # For short aliases, always point to the full command in .claude/
    # This works whether ACE-Flow is in submodule or current directory
    
    cat > "$target_file" << EOF
# Short alias for /${cmd}

This is a short alias for the ACE-Flow command \`/${cmd}\`.

**Usage:** \`/${short_alias} [arguments]\`

**Full command:** \`/${cmd} [arguments]\`

See the full documentation: [${cmd}.md](./${cmd}.md)

---

*This is an automatically generated alias. Run \`/ace-flow-install --update\` to refresh.*
EOF
    
    echo "${short_alias}.md" >> .claude/.ace-flow-manifest
    echo -e "${GREEN}Created short alias: $target_file${NC}"
done

# Update CLAUDE.md with command list (if not uninstalling)
echo -e "${BLUE}Updating CLAUDE.md with command documentation...${NC}"

# Check if we need to add the command section to CLAUDE.md
if [ -f "CLAUDE.md" ]; then
    # Check if ACE-Flow commands section exists
    if ! grep -q "## Available ACE-Flow Commands" CLAUDE.md; then
        # Add the commands section before project-specific configuration
        cat >> CLAUDE.md << 'EOF'

## Available ACE-Flow Commands

### Full Commands (in .claude/)
- `/ace-genesis` - Intelligent project creation through conversation
- `/ace-research` - Advanced documentation research (30-100 pages)
- `/ace-implement` - Infrastructure-aware implementation
- `/ace-adopt` - Safe migration of existing projects
- `/ace-status` - Real-time progress tracking
- `/ace-help` - Comprehensive command documentation
- `/ace-validate` - Pre-implementation validation checks
- `/ace-rollback` - Safe recovery and restore system
- `/ace-cost` - AWS resource cost estimation
- `/ace-flow-install` - Install or update command aliases

### Short Aliases (also in .claude/)
- `/ag` → `/ace-genesis`
- `/ar` → `/ace-research`
- `/ai` → `/ace-implement`
- `/aa` → `/ace-adopt`
- `/as` → `/ace-status`
- `/ah` → `/ace-help`
- `/av` → `/ace-validate`
- `/arb` → `/ace-rollback`
- `/ac` → `/ace-cost`

All commands are linked to the ACE-Flow system. Run `/ace-flow-install --update` after updating the ACE-Flow submodule.

EOF
        echo -e "${GREEN}Added ACE-Flow commands section to CLAUDE.md${NC}"
    else
        echo -e "${YELLOW}ACE-Flow commands section already exists in CLAUDE.md${NC}"
    fi
fi

# Final success message
echo ""
echo -e "${GREEN}✅ ACE-Flow aliases installed successfully!${NC}"
echo ""
echo -e "${BLUE}You can now use short commands like:${NC}"
echo "  /ag \"Your app idea\"     (instead of /ace-genesis)"
echo "  /ar domain pattern      (instead of /ace-research)"
echo "  /ai project-name        (instead of /ace-implement)"
echo ""
echo -e "${BLUE}To update after submodule changes:${NC}"
echo "  /ace-flow-install --update"
echo ""
echo -e "${BLUE}To uninstall ACE-Flow aliases:${NC}"
echo "  /ace-flow-install --uninstall"
echo ""