#!/bin/bash

# 🧹 ACE-Flow Temporary File Cleanup Hook
# Automatically removes temporary files that shouldn't be committed

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Files/patterns to automatically clean up
cleanup_temp_files() {
    local files_removed=0
    
    print_info "🧹 Running ACE-Flow temporary file cleanup..."
    
    cd "$PROJECT_ROOT"
    
    # 1. Test files with specific patterns
    local test_patterns=(
        "test-*.md"
        "*-test-*.md"
        "quality-reports/test-*.md"
        "quality-reports/*-test-*.md"
    )
    
    for pattern in "${test_patterns[@]}"; do
        for file in $pattern; do
            if [[ -f "$file" ]]; then
                print_warning "Removing test file: $file"
                rm "$file"
                ((files_removed++))
            fi
        done
    done
    
    # 2. Temporary GitHub issue files (created for single use)
    for file in github-issue-*.md; do
        if [[ -f "$file" ]]; then
            print_warning "Removing temporary GitHub issue file: $file"
            rm "$file"
            ((files_removed++))
        fi
    done
    
    # 3. Old quality reports (keep only latest 5)
    if [[ -d "quality-reports" ]]; then
        local report_count=$(find quality-reports -name "ace-flow-quality-report-*.md" | wc -l)
        if [[ $report_count -gt 5 ]]; then
            print_info "Keeping only latest 5 quality reports..."
            find quality-reports -name "ace-flow-quality-report-*.md" -type f | sort | head -n -5 | while read -r file; do
                print_warning "Removing old quality report: $file"
                rm "$file"
                ((files_removed++))
            done
        fi
    fi
    
    # 4. Temporary script files
    for file in temp-*.sh tmp-*.sh *-temp.sh; do
        if [[ -f "$file" ]]; then
            print_warning "Removing temporary script: $file"
            rm "$file"
            ((files_removed++))
        fi
    done
    
    # 5. Backup files from editors
    for file in *~ *.bak *.orig; do
        if [[ -f "$file" ]]; then
            print_warning "Removing backup file: $file"
            rm "$file"
            ((files_removed++))
        fi
    done
    
    # Summary
    if [[ $files_removed -eq 0 ]]; then
        print_success "No temporary files found to clean up"
    else
        print_success "Cleaned up $files_removed temporary files"
    fi
}

# Git hook integration
setup_git_hooks() {
    print_info "🪝 Setting up Git hooks for automatic cleanup..."
    
    local git_hooks_dir="$PROJECT_ROOT/.git/hooks"
    
    # Pre-commit hook to clean temp files
    cat > "$git_hooks_dir/pre-commit" << 'EOF'
#!/bin/bash
# ACE-Flow automatic temp file cleanup

# Run cleanup script
if [[ -f "scripts/cleanup-temp-files.sh" ]]; then
    bash scripts/cleanup-temp-files.sh
    
    # Re-stage any files that might have been cleaned up
    git add -A
fi
EOF
    
    chmod +x "$git_hooks_dir/pre-commit"
    print_success "Pre-commit hook installed"
    
    # Pre-push hook for additional safety
    cat > "$git_hooks_dir/pre-push" << 'EOF'
#!/bin/bash
# ACE-Flow pre-push cleanup check

echo "🔍 Checking for temporary files before push..."

# Check for common temp file patterns
temp_files_found=false

if ls test-*.md *-test-*.md 2>/dev/null | grep -q .; then
    echo "⚠️  Warning: Test files detected"
    temp_files_found=true
fi

if ls github-issue-*.md 2>/dev/null | grep -q .; then
    echo "⚠️  Warning: Temporary GitHub issue files detected"
    temp_files_found=true
fi

if [[ "$temp_files_found" == "true" ]]; then
    echo ""
    echo "🧹 Run 'bash scripts/cleanup-temp-files.sh' to clean up"
    echo "   Or commit with --no-verify to skip this check"
    exit 1
fi

echo "✅ No temporary files detected"
EOF
    
    chmod +x "$git_hooks_dir/pre-push"
    print_success "Pre-push hook installed"
}

# Show usage information
show_usage() {
    cat << EOF
🧹 ACE-Flow Temporary File Cleanup

Usage: $0 [OPTIONS]

OPTIONS:
  --setup-hooks     Install Git hooks for automatic cleanup
  --dry-run        Show what would be cleaned up without removing files
  --help           Show this help message

EXAMPLES:
  $0                Clean up temporary files now
  $0 --setup-hooks  Install Git hooks for automatic cleanup
  $0 --dry-run      Preview cleanup without removing files

EOF
}

# Parse command line arguments
SETUP_HOOKS=false
DRY_RUN=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --setup-hooks)
            SETUP_HOOKS=true
            shift
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --help)
            show_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Main execution
main() {
    echo -e "${BLUE}🧹 ACE-Flow Temporary File Cleanup${NC}"
    echo -e "${BLUE}===================================${NC}"
    echo
    
    if [[ "$DRY_RUN" == "true" ]]; then
        print_info "DRY RUN MODE - No files will be removed"
        echo
    fi
    
    if [[ "$SETUP_HOOKS" == "true" ]]; then
        setup_git_hooks
        echo
    fi
    
    if [[ "$DRY_RUN" == "true" ]]; then
        print_info "Would clean up temporary files (use without --dry-run to execute)"
    else
        cleanup_temp_files
    fi
    
    echo
    print_success "ACE-Flow cleanup complete!"
}

# Run main function
main "$@"