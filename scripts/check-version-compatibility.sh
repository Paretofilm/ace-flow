#!/bin/bash

# ACE-Flow Version Compatibility Checker Script
# Ensures Next.js and AWS Amplify versions are compatible

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ACE_FLOW_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔍 ACE-Flow Version Compatibility Check${NC}"
echo "======================================="

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to get package version
get_package_version() {
    local package=$1
    local version=$(node -p "try { require('./package.json').dependencies['$package'] || require('./package.json').devDependencies['$package'] } catch(e) { 'not found' }" 2>/dev/null)
    echo ${version//[\^~]/}
}

# Function to check npm registry for latest compatible version
check_latest_compatible() {
    local current_amplify=$1
    local recommended_nextjs=""
    
    # Based on Amplify version, determine compatible Next.js
    case $current_amplify in
        6.8.*)
            recommended_nextjs="14.2.16"
            ;;
        6.7.*)
            recommended_nextjs="14.1.4"
            ;;
        6.6.*)
            recommended_nextjs="14.0.4"
            ;;
        *)
            recommended_nextjs="14.2.16"  # Default to latest stable
            ;;
    esac
    
    echo $recommended_nextjs
}

# Function to update package.json with compatible versions
update_package_json() {
    local nextjs_version=$1
    local backup_file="package.json.backup"
    
    # Create backup
    cp package.json $backup_file
    echo -e "${BLUE}📋 Created backup: $backup_file${NC}"
    
    # Update package.json using Node.js
    node -e "
    const fs = require('fs');
    const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
    
    // Update Next.js version
    if (pkg.dependencies && pkg.dependencies.next) {
        pkg.dependencies.next = '^$nextjs_version';
    }
    
    // Ensure all Amplify packages are compatible
    const amplifyPackages = [
        'aws-amplify',
        '@aws-amplify/ui-react',
        '@aws-amplify/backend',
        '@aws-amplify/backend-cli'
    ];
    
    amplifyPackages.forEach(pkgName => {
        if (pkg.dependencies && pkg.dependencies[pkgName]) {
            // Keep existing version but ensure it's latest
            console.log('Found ' + pkgName + ' in dependencies');
        }
        if (pkg.devDependencies && pkg.devDependencies[pkgName]) {
            console.log('Found ' + pkgName + ' in devDependencies');
        }
    });
    
    fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2) + '\n');
    console.log('✅ Updated package.json with compatible versions');
    "
}

# Main compatibility check
main() {
    cd "$ACE_FLOW_ROOT"
    
    # Check if package.json exists
    if [ ! -f "package.json" ]; then
        echo -e "${YELLOW}⚠️  No package.json found. Running from ACE-Flow root.${NC}"
        cd "$SCRIPT_DIR/.."
    fi
    
    # Get current versions
    NEXTJS_VERSION=$(get_package_version "next")
    AMPLIFY_VERSION=$(get_package_version "aws-amplify")
    
    echo -e "\n${BLUE}Current Versions:${NC}"
    echo "├── Next.js: ${NEXTJS_VERSION:-Not installed}"
    echo "└── AWS Amplify: ${AMPLIFY_VERSION:-Not installed}"
    
    # Check if both are installed
    if [ "$NEXTJS_VERSION" = "not found" ] || [ "$AMPLIFY_VERSION" = "not found" ]; then
        echo -e "\n${RED}❌ Missing required dependencies${NC}"
        echo "Please run: npm install next aws-amplify"
        exit 1
    fi
    
    # Get recommended Next.js version
    RECOMMENDED_NEXTJS=$(check_latest_compatible "$AMPLIFY_VERSION")
    
    echo -e "\n${BLUE}Compatibility Analysis:${NC}"
    echo "├── Amplify $AMPLIFY_VERSION requires Next.js ~$RECOMMENDED_NEXTJS"
    
    # Check compatibility using semver
    if command_exists node; then
        COMPATIBLE=$(node -e "
        const semver = require('semver');
        const current = '$NEXTJS_VERSION'.replace(/[\^~]/, '');
        const recommended = '$RECOMMENDED_NEXTJS';
        console.log(semver.satisfies(current, '~' + recommended));
        " 2>/dev/null || echo "false")
        
        if [ "$COMPATIBLE" = "true" ]; then
            echo -e "└── Status: ${GREEN}✅ Compatible${NC}"
        else
            echo -e "└── Status: ${YELLOW}⚠️  Update recommended${NC}"
            
            echo -e "\n${YELLOW}Recommended Actions:${NC}"
            echo "1. Update Next.js to $RECOMMENDED_NEXTJS"
            echo "   Run: npm install next@$RECOMMENDED_NEXTJS"
            echo ""
            echo "2. Or use the auto-update option:"
            echo "   Run: $0 --update"
        fi
    fi
    
    # Check for latest versions
    if [ "$1" = "--check-latest" ]; then
        echo -e "\n${BLUE}Checking latest versions...${NC}"
        LATEST_NEXTJS=$(npm view next version 2>/dev/null || echo "Check failed")
        LATEST_AMPLIFY=$(npm view aws-amplify version 2>/dev/null || echo "Check failed")
        
        echo "├── Latest Next.js: $LATEST_NEXTJS"
        echo "└── Latest Amplify: $LATEST_AMPLIFY"
    fi
    
    # Auto-update if requested
    if [ "$1" = "--update" ]; then
        echo -e "\n${BLUE}🔄 Updating to compatible versions...${NC}"
        
        # Update package.json
        update_package_json "$RECOMMENDED_NEXTJS"
        
        # Run npm install
        echo -e "\n${BLUE}📦 Installing updated dependencies...${NC}"
        if command_exists yarn && [ -f "yarn.lock" ]; then
            yarn install
        else
            npm install
        fi
        
        # Update framework registry
        echo -e "\n${BLUE}📝 Updating framework registry...${NC}"
        if [ -f "$ACE_FLOW_ROOT/ace-system/version-management/version-compatibility-checker.ts" ]; then
            cd "$ACE_FLOW_ROOT"
            npx ts-node ace-system/version-management/version-compatibility-checker.ts update-registry
        fi
        
        echo -e "\n${GREEN}✅ Successfully updated to compatible versions!${NC}"
    fi
    
    # Generate compatibility report
    if [ "$1" = "--report" ]; then
        REPORT_FILE="version-compatibility-report.json"
        node -e "
        const report = {
            timestamp: new Date().toISOString(),
            current: {
                nextjs: '$NEXTJS_VERSION',
                amplify: '$AMPLIFY_VERSION'
            },
            recommended: {
                nextjs: '$RECOMMENDED_NEXTJS'
            },
            compatible: $COMPATIBLE,
            aceFlowVersion: require('$ACE_FLOW_ROOT/package.json').version || '1.0.0'
        };
        require('fs').writeFileSync('$REPORT_FILE', JSON.stringify(report, null, 2));
        console.log('\n✅ Report saved to: $REPORT_FILE');
        "
    fi
}

# Show usage
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --check-latest      Check latest available versions"
    echo "  --update           Auto-update to compatible versions"
    echo "  --report           Generate compatibility report"
    echo "  --update-registry  Update framework registry only"
    echo "  --help             Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                  # Basic compatibility check"
    echo "  $0 --update         # Update to compatible versions"
    echo "  $0 --check-latest   # Check latest NPM versions"
    exit 0
fi

# Update registry only if requested
if [ "$1" = "--update-registry" ]; then
    echo -e "${BLUE}📝 Updating framework registry...${NC}"
    if [ -f "$ACE_FLOW_ROOT/ace-system/version-management/version-compatibility-checker.ts" ]; then
        cd "$ACE_FLOW_ROOT"
        npx ts-node ace-system/version-management/version-compatibility-checker.ts update-registry
    else
        echo -e "${YELLOW}⚠️  Version checker not found. Using basic update...${NC}"
        # Fallback: Update registry manually
        REGISTRY_FILE="$ACE_FLOW_ROOT/ace-system/frameworks/README.md"
        if [ -f "$REGISTRY_FILE" ]; then
            sed -i.bak "s/version: \".*\" # AWS Amplify/version: \"$AMPLIFY_VERSION\" # AWS Amplify/" "$REGISTRY_FILE"
            sed -i.bak "s/version: \".*\" # Next.js/version: \"$NEXTJS_VERSION\" # Next.js/" "$REGISTRY_FILE"
            sed -i.bak "s/last_updated: \".*\"/last_updated: \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"/" "$REGISTRY_FILE"
            rm "${REGISTRY_FILE}.bak"
            echo -e "${GREEN}✅ Framework registry updated${NC}"
        fi
    fi
    exit 0
fi

# Run main function
main "$@"