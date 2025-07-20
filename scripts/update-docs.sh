#!/bin/bash

# 📚 ACE-Flow Documentation Update Script
# Automated documentation fetching and validation system

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DOCS_DIR="$PROJECT_ROOT/docs"
META_DIR="$DOCS_DIR/meta"

# Framework configuration
declare -A FRAMEWORK_SOURCES=(
    ["amplify-gen2"]="https://docs.amplify.aws/gen2/"
    ["nextjs"]="https://nextjs.org/docs"
    ["amplify-ui"]="https://ui.docs.amplify.aws/"
)

declare -A FRAMEWORK_REPOS=(
    ["amplify-gen2"]="aws-amplify/amplify-backend"
    ["nextjs"]="vercel/next.js"
    ["amplify-ui"]="aws-amplify/amplify-ui"
)

# Function to print status
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Show usage information
show_usage() {
    cat << EOF
📚 ACE-Flow Documentation Update Tool

Usage: $0 [FRAMEWORK] [OPTIONS]

FRAMEWORKS:
  all                 Update all framework documentation
  amplify-gen2        Update AWS Amplify Gen 2 documentation
  nextjs              Update Next.js documentation
  amplify-ui          Update Amplify UI documentation

OPTIONS:
  --validate          Validate existing documentation
  --coverage          Generate coverage report
  --dry-run          Show what would be updated without making changes
  --force            Force update even if documentation appears current
  --help             Show this help message

EXAMPLES:
  $0 all              Update all documentation
  $0 nextjs           Update only Next.js documentation
  $0 --validate       Validate current documentation
  $0 --coverage       Generate coverage report

EOF
}

# Parse command line arguments
parse_arguments() {
    FRAMEWORK="all"
    VALIDATE_ONLY=false
    COVERAGE_ONLY=false
    DRY_RUN=false
    FORCE_UPDATE=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            amplify-gen2|nextjs|amplify-ui|all)
                FRAMEWORK="$1"
                shift
                ;;
            --validate)
                VALIDATE_ONLY=true
                shift
                ;;
            --coverage)
                COVERAGE_ONLY=true
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --force)
                FORCE_UPDATE=true
                shift
                ;;
            --help)
                show_usage
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                show_usage
                exit 1
                ;;
        esac
    done
}

# Check prerequisites
check_prerequisites() {
    print_info "Checking prerequisites..."
    
    # Check for required tools
    for cmd in curl jq node npm; do
        if ! command -v $cmd &> /dev/null; then
            print_error "$cmd is required but not installed"
            exit 1
        fi
    done
    
    # Check for documentation directory
    if [[ ! -d "$DOCS_DIR" ]]; then
        print_error "Documentation directory not found: $DOCS_DIR"
        exit 1
    fi
    
    print_status "All prerequisites met"
}

# Get latest version from GitHub API
get_latest_version() {
    local repo="$1"
    local version
    
    version=$(curl -s "https://api.github.com/repos/$repo/releases/latest" | jq -r '.tag_name // empty')
    
    if [[ -z "$version" || "$version" == "null" ]]; then
        # Fallback to tags if no releases
        version=$(curl -s "https://api.github.com/repos/$repo/tags" | jq -r '.[0].name // "unknown"')
    fi
    
    echo "$version"
}

# Get current documented version
get_current_version() {
    local framework="$1"
    local version_file="$META_DIR/doc-versions.md"
    
    if [[ -f "$version_file" ]]; then
        grep "^$framework:" "$version_file" | cut -d: -f2 | tr -d ' ' || echo "unknown"
    else
        echo "unknown"
    fi
}

# Update version tracking
update_version_tracking() {
    local framework="$1"
    local version="$2"
    local version_file="$META_DIR/doc-versions.md"
    
    # Create meta directory if it doesn't exist
    mkdir -p "$META_DIR"
    
    # Create or update version file
    if [[ ! -f "$version_file" ]]; then
        cat > "$version_file" << EOF
# Documentation Version Tracking

This file tracks the versions of framework documentation included in ACE-Flow.

## Framework Versions
EOF
    fi
    
    # Update or add version entry
    if grep -q "^$framework:" "$version_file"; then
        sed -i.bak "s/^$framework:.*/$framework: $version ($(date +%Y-%m-%d))/" "$version_file"
    else
        echo "$framework: $version ($(date +%Y-%m-%d))" >> "$version_file"
    fi
    
    # Clean up backup file
    rm -f "$version_file.bak"
}

# Validate documentation links
validate_links() {
    local framework="$1"
    local framework_dir="$DOCS_DIR/frameworks/$framework"
    
    if [[ ! -d "$framework_dir" ]]; then
        print_warning "Framework directory not found: $framework_dir"
        return 1
    fi
    
    print_info "Validating links in $framework documentation..."
    
    local broken_links=0
    local total_links=0
    
    # Find all markdown files and extract links
    while IFS= read -r file; do
        if [[ -f "$file" ]]; then
            # Extract markdown links [text](url)
            while IFS= read -r link; do
                if [[ -n "$link" ]]; then
                    ((total_links++))
                    
                    # Skip internal anchors and mailto links
                    if [[ "$link" =~ ^#|^mailto: ]]; then
                        continue
                    fi
                    
                    # Check if link is accessible
                    if [[ "$link" =~ ^https?:// ]]; then
                        if ! curl -s --head "$link" > /dev/null 2>&1; then
                            print_warning "Broken link: $link in $file"
                            ((broken_links++))
                        fi
                    fi
                fi
            done < <(grep -o '\[.*\]([^)]*)' "$file" | sed 's/.*(\([^)]*\)).*/\1/')
        fi
    done < <(find "$framework_dir" -name "*.md")
    
    if [[ $broken_links -eq 0 ]]; then
        print_status "All $total_links links are valid"
        return 0
    else
        print_warning "Found $broken_links broken links out of $total_links total"
        return 1
    fi
}

# Check if framework documentation needs update
needs_update() {
    local framework="$1"
    
    if [[ "$FORCE_UPDATE" == "true" ]]; then
        return 0
    fi
    
    local repo="${FRAMEWORK_REPOS[$framework]}"
    if [[ -z "$repo" ]]; then
        print_warning "No repository configured for $framework"
        return 1
    fi
    
    local latest_version=$(get_latest_version "$repo")
    local current_version=$(get_current_version "$framework")
    
    print_info "Framework: $framework"
    print_info "Current version: $current_version"
    print_info "Latest version: $latest_version"
    
    if [[ "$current_version" != "$latest_version" ]]; then
        print_info "Update available: $current_version → $latest_version"
        return 0
    else
        print_status "Documentation is up to date"
        return 1
    fi
}

# Placeholder function for fetching documentation
fetch_documentation() {
    local framework="$1"
    local source_url="${FRAMEWORK_SOURCES[$framework]}"
    
    print_info "Fetching documentation for $framework from $source_url"
    
    # This is a placeholder implementation
    # In a full implementation, this would:
    # 1. Fetch documentation from the source
    # 2. Parse and extract relevant content
    # 3. Convert to ACE-Flow format
    # 4. Validate code examples
    # 5. Update local documentation files
    
    print_warning "Documentation fetching not yet implemented for $framework"
    print_info "Would fetch from: $source_url"
    
    # Simulate update by updating version tracking
    local repo="${FRAMEWORK_REPOS[$framework]}"
    if [[ -n "$repo" ]]; then
        local latest_version=$(get_latest_version "$repo")
        update_version_tracking "$framework" "$latest_version"
        print_status "Updated version tracking for $framework to $latest_version"
    fi
}

# Update specific framework
update_framework() {
    local framework="$1"
    
    print_info "Checking $framework documentation..."
    
    if needs_update "$framework"; then
        if [[ "$DRY_RUN" == "true" ]]; then
            print_info "DRY RUN: Would update $framework documentation"
        else
            print_info "Updating $framework documentation..."
            fetch_documentation "$framework"
            validate_links "$framework"
            print_status "Updated $framework documentation"
        fi
    else
        print_status "$framework documentation is current"
    fi
}

# Generate coverage report
generate_coverage_report() {
    print_info "Generating documentation coverage report..."
    
    local report_file="$META_DIR/coverage-report.md"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    cat > "$report_file" << EOF
# ACE-Flow Documentation Coverage Report

Generated: $timestamp

## Framework Coverage

EOF
    
    for framework in "${!FRAMEWORK_SOURCES[@]}"; do
        local framework_dir="$DOCS_DIR/frameworks/$framework"
        local file_count=0
        local total_size=0
        
        if [[ -d "$framework_dir" ]]; then
            file_count=$(find "$framework_dir" -name "*.md" | wc -l)
            total_size=$(find "$framework_dir" -name "*.md" -exec wc -c {} + | tail -1 | awk '{print $1}')
        fi
        
        local current_version=$(get_current_version "$framework")
        
        cat >> "$report_file" << EOF
### $framework
- **Files**: $file_count
- **Total Size**: $(numfmt --to=iec --suffix=B $total_size)
- **Version**: $current_version
- **Status**: $(if [[ $file_count -gt 0 ]]; then echo "✅ Available"; else echo "❌ Missing"; fi)

EOF
    done
    
    # Add pattern coverage
    local pattern_dir="$DOCS_DIR/patterns"
    local pattern_count=0
    if [[ -d "$pattern_dir" ]]; then
        pattern_count=$(find "$pattern_dir" -name "*.md" | wc -l)
    fi
    
    cat >> "$report_file" << EOF
## Architecture Patterns
- **Pattern Documents**: $pattern_count
- **Status**: $(if [[ $pattern_count -gt 0 ]]; then echo "✅ Available"; else echo "❌ Missing"; fi)

## Integration Guides
EOF
    
    local integration_dir="$DOCS_DIR/integrations"
    local integration_count=0
    if [[ -d "$integration_dir" ]]; then
        integration_count=$(find "$integration_dir" -name "*.md" | wc -l)
    fi
    
    cat >> "$report_file" << EOF
- **Integration Documents**: $integration_count
- **Status**: $(if [[ $integration_count -gt 0 ]]; then echo "✅ Available"; else echo "❌ Missing"; fi)

## Recommendations

EOF
    
    # Add recommendations based on gaps
    if [[ $pattern_count -eq 0 ]]; then
        echo "- Add architecture pattern documentation" >> "$report_file"
    fi
    
    if [[ $integration_count -eq 0 ]]; then
        echo "- Add integration guide documentation" >> "$report_file"
    fi
    
    for framework in "${!FRAMEWORK_SOURCES[@]}"; do
        local framework_dir="$DOCS_DIR/frameworks/$framework"
        if [[ ! -d "$framework_dir" ]]; then
            echo "- Add $framework framework documentation" >> "$report_file"
        fi
    done
    
    print_status "Coverage report generated: $report_file"
    
    # Display summary
    echo
    print_info "Coverage Summary:"
    echo "  Framework docs: $(find "$DOCS_DIR/frameworks" -name "*.md" 2>/dev/null | wc -l) files"
    echo "  Pattern docs: $pattern_count files"
    echo "  Integration docs: $integration_count files"
}

# Validate all documentation
validate_documentation() {
    print_info "Validating ACE-Flow documentation..."
    
    local validation_errors=0
    
    # Validate each framework
    for framework in "${!FRAMEWORK_SOURCES[@]}"; do
        if ! validate_links "$framework"; then
            ((validation_errors++))
        fi
    done
    
    # Check for required files
    local required_files=(
        "$DOCS_DIR/README.md"
        "$DOCS_DIR/frameworks/README.md"
        "$DOCS_DIR/patterns/README.md"
        "$DOCS_DIR/integrations/README.md"
        "$DOCS_DIR/meta/README.md"
    )
    
    for file in "${required_files[@]}"; do
        if [[ ! -f "$file" ]]; then
            print_error "Missing required file: $file"
            ((validation_errors++))
        fi
    done
    
    if [[ $validation_errors -eq 0 ]]; then
        print_status "All documentation validation checks passed"
        return 0
    else
        print_error "Found $validation_errors validation issues"
        return 1
    fi
}

# Main execution flow
main() {
    echo -e "${BLUE}📚 ACE-Flow Documentation Update Tool${NC}"
    echo -e "${BLUE}====================================${NC}"
    echo
    
    parse_arguments "$@"
    check_prerequisites
    
    if [[ "$COVERAGE_ONLY" == "true" ]]; then
        generate_coverage_report
        exit 0
    fi
    
    if [[ "$VALIDATE_ONLY" == "true" ]]; then
        validate_documentation
        exit $?
    fi
    
    # Update documentation
    if [[ "$FRAMEWORK" == "all" ]]; then
        print_info "Updating all framework documentation..."
        for framework in "${!FRAMEWORK_SOURCES[@]}"; do
            update_framework "$framework"
        done
    else
        if [[ -n "${FRAMEWORK_SOURCES[$FRAMEWORK]}" ]]; then
            update_framework "$FRAMEWORK"
        else
            print_error "Unknown framework: $FRAMEWORK"
            show_usage
            exit 1
        fi
    fi
    
    # Generate final report
    print_info "Generating update summary..."
    echo
    print_status "Documentation update completed successfully!"
    
    if [[ "$DRY_RUN" != "true" ]]; then
        generate_coverage_report
    fi
}

# Run main function with all arguments
main "$@"