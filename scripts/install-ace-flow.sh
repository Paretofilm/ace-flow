#!/bin/bash

# ACE-Flow Complete Installation Script
# This script installs ACE-Flow commands, configuration files, and sets up the complete system

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Default options
SHORT_ONLY=false
PRESERVE=false
UPDATE=false
UNINSTALL=false
GITHUB_ACTIONS=false
NO_CLAUDE_MD=false
HELP=false

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --short-only) SHORT_ONLY=true ;;
        --preserve) PRESERVE=true ;;
        --update) UPDATE=true ;;
        --uninstall) UNINSTALL=true ;;
        --github-actions) GITHUB_ACTIONS=true ;;
        --no-claude-md) NO_CLAUDE_MD=true ;;
        --help) HELP=true ;;
        *) echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

# Show help if requested
if [ "$HELP" = true ]; then
    cat << EOF
🚀 ACE-Flow Complete Installation Script

This script installs ACE-Flow commands, configuration files, and sets up 
the complete intelligent automation system for your project.

Usage: $0 [options]

Options:
  --short-only        Only create short aliases (ag, ar, ai, etc.)
  --preserve          Preserve existing custom commands and files
  --github-actions    Install GitHub Actions workflows
  --no-claude-md      Skip CLAUDE.md installation
  --update           Update existing installation after submodule update
  --uninstall        Remove ACE-Flow installation (preserves custom files)
  --help             Show this help message

Examples:
  $0                          # Basic installation
  $0 --preserve               # Install while preserving existing files
  $0 --github-actions         # Include GitHub Actions workflows
  $0 --preserve --github-actions --no-claude-md  # Advanced options

Installation includes:
  ✅ ACE-Flow commands (.claude/ directory)
  ✅ CLAUDE.md project configuration (unless --no-claude-md)
  ✅ GitHub Actions workflows (with --github-actions)
  ✅ Command aliases for easy access

EOF
    exit 0
fi

echo -e "${BLUE}🚀 ACE-Flow Complete Installation${NC}"
echo -e "${BLUE}==================================${NC}"
echo

# Detect ACE-Flow location (submodule or current directory)
if [ -d ".ace-flow/.claude" ]; then
    ACE_FLOW_DIR=".ace-flow"
    echo -e "${GREEN}✅ Found ACE-Flow submodule at ${ACE_FLOW_DIR}${NC}"
elif [ -d ".claude" ] && [ -f ".claude/ace-genesis.md" ]; then
    ACE_FLOW_DIR="."
    echo -e "${GREEN}✅ Found ACE-Flow in current directory${NC}"
else
    echo -e "${RED}❌ Error: Cannot find ACE-Flow. Expected:${NC}"
    echo -e "${RED}   - ACE-Flow submodule at .ace-flow/ (recommended)${NC}"
    echo -e "${RED}   - Or ACE-Flow commands in current .claude/ directory${NC}"
    echo
    echo -e "${YELLOW}💡 To add ACE-Flow as submodule:${NC}"
    echo -e "${YELLOW}   git submodule add https://github.com/Paretofilm/ace-flow.git .ace-flow${NC}"
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

echo -e "${BLUE}🔍 Detected OS: ${OS}${NC}"
echo

# Function to create a link or copy based on OS
create_alias() {
    local source=$1
    local target=$2
    
    if [ "$OS" = "windows" ]; then
        # On Windows, create a copy
        cp "$source" "$target"
        echo -e "${GREEN}  ✅ Created copy: $target${NC}"
    else
        # On Unix/Mac, create a symlink
        ln -sf "$source" "$target" 
        echo -e "${GREEN}  ✅ Created symlink: $target${NC}"
    fi
}

# Function to backup file if it exists
backup_if_exists() {
    local file=$1
    if [ -f "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d_%H%M%S)"
        cp "$file" "$backup"
        echo -e "${YELLOW}  📋 Backed up existing $file to $backup${NC}"
        return 0
    fi
    return 1
}

# Function to uninstall ACE-Flow
uninstall_ace_flow() {
    echo -e "${YELLOW}🗑️  Uninstalling ACE-Flow...${NC}"
    echo
    
    # Remove commands but preserve custom ones
    if [ "$ACE_FLOW_DIR" = "." ]; then
        # Only remove short aliases when in ACE-Flow directory
        SHORT_ALIASES=("ag" "ar" "ai" "aa" "as" "ah" "av" "arb" "ac")
        
        for alias in "${SHORT_ALIASES[@]}"; do
            if [ -f ".claude/${alias}.md" ]; then
                rm ".claude/${alias}.md"
                echo -e "${GREEN}  ✅ Removed: .claude/${alias}.md${NC}"
            fi
        done
    else
        # In a project using ACE-Flow as submodule, remove ACE-Flow commands
        ACE_COMMANDS=(
            "ace-genesis" "ace-research" "ace-implement" "ace-adopt"
            "ace-status" "ace-help" "ace-validate" "ace-rollback" "ace-cost"
            "ace-flow-install"
            "ag" "ar" "ai" "aa" "as" "ah" "av" "arb" "ac"
        )
        
        for cmd in "${ACE_COMMANDS[@]}"; do
            if [ -f ".claude/${cmd}.md" ] && [ -L ".claude/${cmd}.md" ]; then
                rm ".claude/${cmd}.md"
                echo -e "${GREEN}  ✅ Removed ACE-Flow command: .claude/${cmd}.md${NC}"
            elif [ -f ".claude/${cmd}.md" ]; then
                echo -e "${YELLOW}  📋 Preserved custom command: .claude/${cmd}.md${NC}"
            fi
        done
    fi
    
    # Remove manifest
    if [ -f ".claude/.ace-flow-manifest" ]; then
        rm ".claude/.ace-flow-manifest"
        echo -e "${GREEN}  ✅ Removed installation manifest${NC}"
    fi
    
    echo
    echo -e "${GREEN}✅ ACE-Flow uninstalled successfully!${NC}"
    echo -e "${BLUE}💡 Custom commands and CLAUDE.md were preserved${NC}"
    exit 0
}

# Handle uninstall
if [ "$UNINSTALL" = true ]; then
    uninstall_ace_flow
fi

# Create .claude directory if it doesn't exist
if [ ! -d ".claude" ]; then
    mkdir -p .claude
    echo -e "${GREEN}📁 Created .claude/ directory${NC}"
fi

# Create .ace-flow/steering directory structure if it doesn't exist
if [ ! -d ".ace-flow/steering" ]; then
    mkdir -p .ace-flow/steering
    echo -e "${GREEN}📁 Created .ace-flow/steering/ directory${NC}"
    
    # Copy steering templates if they exist in the source
    if [ -d "$ACE_FLOW_DIR/.ace-flow/steering" ] && [ "$ACE_FLOW_DIR" != "." ]; then
        echo -e "${BLUE}📋 Installing steering context templates${NC}"
        cp -r "$ACE_FLOW_DIR/.ace-flow/steering/"* ".ace-flow/steering/" 2>/dev/null || true
        echo -e "${GREEN}  ✅ Steering templates installed${NC}"
    fi
fi

# 1. INSTALL ACE-FLOW COMMANDS
echo -e "${PURPLE}📦 Installing ACE-Flow Commands${NC}"

# Define ACE-Flow commands and their short aliases
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
    "update-docs:ud"
)

# Create manifest file to track installed commands
echo "# ACE-Flow Installation Manifest" > .claude/.ace-flow-manifest
echo "# Generated on $(date)" >> .claude/.ace-flow-manifest
echo "ACE_FLOW_DIR=$ACE_FLOW_DIR" >> .claude/.ace-flow-manifest
echo "INSTALLED_BY=install-ace-flow.sh" >> .claude/.ace-flow-manifest

# Install ace-flow-install command first (special case)  
if [ "$ACE_FLOW_DIR" = "." ]; then
    echo -e "${YELLOW}  📋 ace-flow-install.md already in .claude/${NC}"
else
    if [ -f "$ACE_FLOW_DIR/.claude/ace-flow-install.md" ]; then
        create_alias "../$ACE_FLOW_DIR/.claude/ace-flow-install.md" ".claude/ace-flow-install.md"
        echo "ace-flow-install.md" >> .claude/.ace-flow-manifest
    fi
fi

# Install full command aliases
if [ "$SHORT_ONLY" = false ]; then
    for cmd_pair in "${COMMANDS[@]}"; do
        cmd="${cmd_pair%%:*}"
        source_file="$ACE_FLOW_DIR/.claude/${cmd}.md"
        target_file=".claude/${cmd}.md"
        
        if [ -f "$source_file" ]; then
            if [ "$ACE_FLOW_DIR" = "." ]; then
                echo -e "${YELLOW}  📋 ${cmd}.md already in .claude/${NC}"
            else
                # Check if file exists and preserve is set
                if [ -f "$target_file" ] && [ "$PRESERVE" = true ] && [ "$UPDATE" = false ]; then
                    echo -e "${YELLOW}  📋 Preserving existing: $target_file${NC}"
                else
                    # Create relative path for symlink
                    relative_source="../$ACE_FLOW_DIR/.claude/${cmd}.md"
                    create_alias "$relative_source" "$target_file"
                    echo "$cmd.md" >> .claude/.ace-flow-manifest
                fi
            fi
        fi
    done
fi

# Install short aliases
echo
echo -e "${PURPLE}🔗 Installing Short Command Aliases${NC}"

for cmd_pair in "${COMMANDS[@]}"; do
    cmd="${cmd_pair%%:*}"
    alias="${cmd_pair##*:}"
    source_file="$ACE_FLOW_DIR/.claude/${cmd}.md"
    target_file=".claude/${alias}.md"
    
    if [ -f "$source_file" ]; then
        if [ "$ACE_FLOW_DIR" = "." ]; then
            if [ ! -f "$target_file" ]; then
                create_alias "${cmd}.md" "$target_file"
                echo "$alias.md" >> .claude/.ace-flow-manifest
            else
                echo -e "${YELLOW}  📋 ${alias}.md already exists${NC}"
            fi
        else
            # Check if file exists and preserve is set
            if [ -f "$target_file" ] && [ "$PRESERVE" = true ] && [ "$UPDATE" = false ]; then
                echo -e "${YELLOW}  📋 Preserving existing: $target_file${NC}"
            else
                relative_source="../$ACE_FLOW_DIR/.claude/${cmd}.md"
                create_alias "$relative_source" "$target_file" 
                echo "$alias.md" >> .claude/.ace-flow-manifest
            fi
        fi
    fi
done

# 2. INSTALL CLAUDE.MD CONFIGURATION
if [ "$NO_CLAUDE_MD" = false ]; then
    echo
    echo -e "${PURPLE}📄 Installing CLAUDE.md Configuration${NC}"
    
    if [ -f "CLAUDE.md" ]; then
        if [ "$PRESERVE" = true ]; then
            backup_if_exists "CLAUDE.md"
            echo -e "${YELLOW}  📋 CLAUDE.md already exists, creating backup${NC}"
        else
            echo -e "${YELLOW}  📋 CLAUDE.md already exists${NC}"
        fi
    fi
    
    if [ -f "$ACE_FLOW_DIR/CLAUDE.md" ]; then
        if [ ! -f "CLAUDE.md" ] || [ "$UPDATE" = true ]; then
            cp "$ACE_FLOW_DIR/CLAUDE.md" "CLAUDE.md"
            echo -e "${GREEN}  ✅ Installed CLAUDE.md configuration${NC}"
            echo "CLAUDE.md" >> .claude/.ace-flow-manifest
        fi
    fi
fi

# 3. INSTALL GITHUB ACTIONS (OPTIONAL)
if [ "$GITHUB_ACTIONS" = true ]; then
    echo
    echo -e "${PURPLE}⚡ Installing GitHub Actions Workflows${NC}"
    
    if [ ! -d ".github" ]; then
        mkdir -p .github/workflows
        echo -e "${GREEN}  📁 Created .github/workflows/ directory${NC}"
    elif [ ! -d ".github/workflows" ]; then
        mkdir -p .github/workflows
        echo -e "${GREEN}  📁 Created .github/workflows/ directory${NC}"
    fi
    
    # Copy workflow files
    if [ -d "$ACE_FLOW_DIR/.github/workflows" ]; then
        for workflow in "$ACE_FLOW_DIR/.github/workflows"/*.yml; do
            if [ -f "$workflow" ]; then
                workflow_name=$(basename "$workflow")
                target_workflow=".github/workflows/$workflow_name"
                
                if [ -f "$target_workflow" ] && [ "$PRESERVE" = true ]; then
                    backup_if_exists "$target_workflow"
                fi
                
                cp "$workflow" "$target_workflow"
                echo -e "${GREEN}  ✅ Installed workflow: $workflow_name${NC}"
                echo ".github/workflows/$workflow_name" >> .claude/.ace-flow-manifest
            fi
        done
    else
        echo -e "${YELLOW}  ⚠️  No GitHub workflows found in $ACE_FLOW_DIR/.github/workflows${NC}"
    fi
fi

# 4. INSTALLATION SUMMARY
echo
echo -e "${BLUE}🎉 ACE-Flow Installation Complete!${NC}"
echo -e "${BLUE}====================================${NC}"
echo

echo -e "${GREEN}✅ Installed Components:${NC}"
echo -e "${GREEN}   • ACE-Flow commands in .claude/ directory${NC}"
if [ "$NO_CLAUDE_MD" = false ]; then
    echo -e "${GREEN}   • CLAUDE.md project configuration${NC}"
fi
if [ "$GITHUB_ACTIONS" = true ]; then
    echo -e "${GREEN}   • GitHub Actions workflows${NC}"
fi

echo
echo -e "${BLUE}🚀 Quick Start Commands:${NC}"
echo -e "${BLUE}   /ag \"your app idea\"          ${NC}# Create new project"
echo -e "${BLUE}   /aa \"existing project desc\"  ${NC}# Adopt existing project"
echo -e "${BLUE}   /as                          ${NC}# Check project status"
echo -e "${BLUE}   /ah                          ${NC}# Show all available commands"

echo
echo -e "${BLUE}📋 Next Steps:${NC}"
echo -e "${BLUE}   1. Commit the changes: git add . && git commit -m \"feat: Add ACE-Flow intelligent automation\"${NC}"
echo -e "${BLUE}   2. Set up AWS pipeline: ./.ace-flow/scripts/setup-aws-pipeline.sh${NC}"
echo -e "${BLUE}   3. Create GitHub issue: @claude /ag \"your amazing idea\"${NC}"

echo
echo -e "${PURPLE}🔧 Management Commands:${NC}"
echo -e "${PURPLE}   $0 --update            ${NC}# Update installation"
echo -e "${PURPLE}   $0 --uninstall         ${NC}# Remove ACE-Flow (keeps custom files)"
echo -e "${PURPLE}   $0 --help              ${NC}# Show all options"

echo
echo -e "${GREEN}🎯 ACE-Flow is ready! Start building with intelligent automation.${NC}"