#!/bin/bash

# 🔍 ACE-Flow Quality Review Script
# Automated quality assurance and validation system

set -e  # Exit on any error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DOCS_DIR="$PROJECT_ROOT/docs"
CLAUDE_DIR="$PROJECT_ROOT/.claude"
REVIEW_OUTPUT_DIR="$PROJECT_ROOT/quality-reports"

# Create output directory
mkdir -p "$REVIEW_OUTPUT_DIR"

# Global counters
CRITICAL_ISSUES=0
HIGH_ISSUES=0
MEDIUM_ISSUES=0
LOW_ISSUES=0
TOTAL_FILES_CHECKED=0

# Function to print status
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
    ((MEDIUM_ISSUES++))
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
    ((CRITICAL_ISSUES++))
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_high() {
    echo -e "${PURPLE}🔥 $1${NC}"
    ((HIGH_ISSUES++))
}

# Show usage information
show_usage() {
    cat << EOF
🔍 ACE-Flow Quality Review Tool

Usage: $0 [OPTIONS]

OPTIONS:
  --area=AREA           Review specific area (docs|commands|patterns|integrations|all)
  --format=FORMAT       Output format (detailed|summary|checklist)
  --severity=LEVEL      Filter by severity (critical|high|medium|low)
  --generate-prompt     Generate Claude Opus review prompt
  --quick              Quick validation checks only
  --syntax-only        Check syntax and patterns only
  --help               Show this help message

EXAMPLES:
  $0                   Full system review
  $0 --area=docs       Review documentation only
  $0 --generate-prompt Generate AI review prompt
  $0 --quick           Quick validation

EOF
}

# Parse command line arguments
parse_arguments() {
    AREA="all"
    FORMAT="detailed"
    SEVERITY="all"
    GENERATE_PROMPT=false
    QUICK_MODE=false
    SYNTAX_ONLY=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --area=*)
                AREA="${1#*=}"
                shift
                ;;
            --format=*)
                FORMAT="${1#*=}"
                shift
                ;;
            --severity=*)
                SEVERITY="${1#*=}"
                shift
                ;;
            --generate-prompt)
                GENERATE_PROMPT=true
                shift
                ;;
            --quick)
                QUICK_MODE=true
                shift
                ;;
            --syntax-only)
                SYNTAX_ONLY=true
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

# Generate Claude Opus review prompt
generate_review_prompt() {
    local prompt_file="$REVIEW_OUTPUT_DIR/claude-opus-review-$(date +%Y%m%d-%H%M%S).md"
    
    print_info "Generating Claude Opus review prompt..."
    
    cp "$SCRIPT_DIR/review-prompts/claude-opus-quality-review.md" "$prompt_file"
    
    # Add current system state
    cat >> "$prompt_file" << EOF

## 📊 Current System State ($(date))

### Repository Structure
\`\`\`
$(find "$PROJECT_ROOT" -type f -name "*.md" | head -20 | sed "s|$PROJECT_ROOT/||")
...
\`\`\`

### Documentation Files Count
- Framework docs: $(find "$DOCS_DIR/frameworks" -name "*.md" 2>/dev/null | wc -l)
- Pattern docs: $(find "$DOCS_DIR/patterns" -name "*.md" 2>/dev/null | wc -l)
- Integration docs: $(find "$DOCS_DIR/integrations" -name "*.md" 2>/dev/null | wc -l)
- Command docs: $(find "$CLAUDE_DIR" -name "*.md" 2>/dev/null | wc -l)

### Recent Changes
$(git log --oneline -5 2>/dev/null || echo "Git history not available")

---
**Review Prompt Generated**: $(date)
**System Version**: $(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
EOF

    print_status "Claude Opus review prompt generated: $prompt_file"
}

# Check for Amplify Gen 1 patterns (CRITICAL)
check_amplify_gen2_compliance() {
    print_info "🔍 Checking Amplify Gen 2 compliance..."
    
    local gen1_patterns=(
        "import.*{.*API.*}.*from.*['\"]aws-amplify['\"]"
        "import.*{.*graphqlOperation.*}.*from.*['\"]aws-amplify['\"]"
        "API\.graphql.*graphqlOperation"
        "import.*{.*Auth.*}.*from.*['\"]aws-amplify['\"]"
        "Auth\.signIn"
        "Auth\.signOut"
        "Auth\.signUp"
        "import.*{.*Storage.*}.*from.*['\"]aws-amplify['\"]"
        "Storage\.put"
        "Storage\.get"
        "from.*['\"]@aws-amplify/api['\"]"
        "from.*['\"]@aws-amplify/auth['\"]"
        "from.*['\"]@aws-amplify/storage['\"]"
        "\.create.*{.*input:"
    )
    
    local files_with_issues=()
    
    for pattern in "${gen1_patterns[@]}"; do
        while IFS= read -r -d '' file; do
            ((TOTAL_FILES_CHECKED++))
            # Skip files that are documenting anti-patterns
            if [[ "$file" =~ "ace-review.md" ]] || [[ "$file" =~ "review-checklist.md" ]]; then
                continue
            fi
            if grep -q "$pattern" "$file"; then
                # Check if this is in a code block showing what NOT to do
                if grep -B2 -A2 "$pattern" "$file" | grep -q "FAIL\|Gen 1\|Anti-Pattern\|❌\|avoid\|don't"; then
                    continue
                fi
                files_with_issues+=("$file")
                print_error "Gen 1 pattern found in $file: $pattern"
            fi
        done < <(find "$DOCS_DIR" "$CLAUDE_DIR" -name "*.md" -print0 2>/dev/null)
    done
    
    if [[ ${#files_with_issues[@]} -eq 0 ]]; then
        print_status "Amplify Gen 2 compliance: PASSED"
    else
        print_error "Amplify Gen 2 compliance: FAILED (${#files_with_issues[@]} files with Gen 1 patterns)"
    fi
}

# Check for proper Gen 2 patterns
check_gen2_patterns() {
    print_info "✅ Verifying Amplify Gen 2 patterns..."
    
    local gen2_patterns=(
        "generateClient.*from.*aws-amplify/data"
        "signIn.*from.*aws-amplify/auth"
        "uploadData.*from.*aws-amplify/storage"
        "client\.models\."
        "observeQuery"
    )
    
    local pattern_count=0
    
    for pattern in "${gen2_patterns[@]}"; do
        local count=$(find "$DOCS_DIR" "$CLAUDE_DIR" -name "*.md" -exec grep -l "$pattern" {} \; 2>/dev/null | wc -l)
        if [[ $count -gt 0 ]]; then
            print_status "Found $count files using pattern: $pattern"
            ((pattern_count++))
        fi
    done
    
    if [[ $pattern_count -ge 3 ]]; then
        print_status "Gen 2 pattern usage: GOOD"
    else
        print_warning "Gen 2 pattern usage: LIMITED (only $pattern_count patterns found)"
    fi
}

# Validate documentation links
check_links() {
    print_info "🔗 Checking documentation links..."
    
    local broken_links=0
    
    # Check internal links
    while IFS= read -r -d '' file; do
        while IFS= read -r link; do
            if [[ "$link" =~ ^\./|^\.\./ ]]; then
                local target_file="$(dirname "$file")/$link"
                if [[ ! -f "$target_file" ]]; then
                    print_warning "Broken internal link in $file: $link"
                    ((broken_links++))
                fi
            fi
        done < <(grep -o '\[.*\](\..*\.md)' "$file" 2>/dev/null | sed 's/.*](\(.*\))/\1/' || true)
    done < <(find "$DOCS_DIR" "$CLAUDE_DIR" -name "*.md" -print0 2>/dev/null)
    
    if [[ $broken_links -eq 0 ]]; then
        print_status "Link validation: PASSED"
    else
        print_warning "Link validation: $broken_links broken links found"
    fi
}

# Check code example syntax
check_code_examples() {
    print_info "💻 Checking code example syntax..."
    
    local syntax_errors=0
    
    # Extract and validate TypeScript code blocks
    while IFS= read -r -d '' file; do
        local line_num=1
        local in_ts_block=false
        
        while IFS= read -r line; do
            if [[ "$line" =~ ^\`\`\`typescript|^\`\`\`ts ]]; then
                in_ts_block=true
            elif [[ "$line" =~ ^\`\`\`$ ]] && [[ "$in_ts_block" == true ]]; then
                in_ts_block=false
            elif [[ "$in_ts_block" == true ]]; then
                # Basic syntax checks
                if [[ "$line" =~ ^import.*from.*[\'\"]\;$ ]]; then
                    print_warning "Missing semicolon in $file:$line_num"
                    ((syntax_errors++))
                fi
                
                # Check for common mistakes
                if [[ "$line" =~ await.*client\.models\..*create.*input: ]]; then
                    print_error "Gen 1 style create() with input in $file:$line_num"
                    ((syntax_errors++))
                fi
            fi
            ((line_num++))
        done < "$file"
    done < <(find "$DOCS_DIR" "$CLAUDE_DIR" -name "*.md" -print0 2>/dev/null)
    
    if [[ $syntax_errors -eq 0 ]]; then
        print_status "Code example syntax: PASSED"
    else
        print_warning "Code example syntax: $syntax_errors issues found"
    fi
}

# Check architecture pattern completeness
check_architecture_patterns() {
    print_info "🏗️ Checking architecture pattern completeness..."
    
    local patterns_dir="$DOCS_DIR/patterns"
    local required_patterns=("social-platform.md" "simple-crud.md" "e-commerce.md" "content-management.md" "dashboard-analytics.md")
    local missing_patterns=()
    
    for pattern in "${required_patterns[@]}"; do
        if [[ ! -f "$patterns_dir/$pattern" ]]; then
            missing_patterns+=("$pattern")
        else
            # Check pattern completeness
            local content=$(cat "$patterns_dir/$pattern")
            if [[ ! "$content" =~ "Data Models" ]]; then
                print_warning "$pattern missing Data Models section"
            fi
            if [[ ! "$content" =~ "UI Components" ]] && [[ ! "$content" =~ "User Interface" ]]; then
                print_warning "$pattern missing UI Components section"
            fi
            if [[ ! "$content" =~ "Security" ]]; then
                print_warning "$pattern missing Security section"
            fi
        fi
    done
    
    if [[ ${#missing_patterns[@]} -eq 0 ]]; then
        print_status "Architecture patterns: COMPLETE"
    else
        print_high "Architecture patterns: INCOMPLETE (missing: ${missing_patterns[*]})"
    fi
}

# Check integration guide accuracy
check_integration_guides() {
    print_info "🔌 Checking integration guide accuracy..."
    
    local integrations_dir="$DOCS_DIR/integrations"
    local integration_files=()
    
    if [[ -d "$integrations_dir" ]]; then
        while IFS= read -r -d '' file; do
            integration_files+=("$file")
            
            # Check for current API versions
            local basename=$(basename "$file" .md)
            case "$basename" in
                "stripe")
                    if ! grep -q "2023-10-16" "$file"; then
                        print_warning "$file may not use current Stripe API version"
                    fi
                    ;;
                "sendgrid")
                    if ! grep -q "@sendgrid/mail" "$file"; then
                        print_warning "$file may not use current SendGrid SDK"
                    fi
                    ;;
            esac
            
            # Check for security considerations
            if ! grep -qi "security\|secret\|api.*key" "$file"; then
                print_warning "$file missing security considerations"
            fi
            
        done < <(find "$integrations_dir" -name "*.md" -print0 2>/dev/null)
    fi
    
    if [[ ${#integration_files[@]} -gt 0 ]]; then
        print_status "Integration guides: ${#integration_files[@]} guides found"
    else
        print_high "Integration guides: NONE FOUND"
    fi
}

# Check command documentation
check_command_documentation() {
    print_info "📋 Checking command documentation..."
    
    local required_commands=("ace-genesis.md" "ace-research.md" "ace-implement.md" "ace-adopt.md" "ace-learn.md")
    local missing_commands=()
    
    for command in "${required_commands[@]}"; do
        local command_file="$CLAUDE_DIR/$command"
        if [[ ! -f "$command_file" ]]; then
            missing_commands+=("$command")
        else
            # Check command completeness
            local content=$(cat "$command_file")
            if [[ ! "$content" =~ "Usage" ]]; then
                print_warning "$command missing Usage section"
            fi
            if [[ ! "$content" =~ "Example" ]]; then
                print_warning "$command missing Examples section"
            fi
        fi
    done
    
    if [[ ${#missing_commands[@]} -eq 0 ]]; then
        print_status "Command documentation: COMPLETE"
    else
        print_high "Command documentation: INCOMPLETE (missing: ${missing_commands[*]})"
    fi
}

# Generate quality report
generate_report() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    local report_file="$REVIEW_OUTPUT_DIR/quality-report-$(date +%Y%m%d-%H%M%S).md"
    
    print_info "📊 Generating quality report..."
    
    cat > "$report_file" << EOF
# ACE-Flow Quality Assessment Report
Generated: $timestamp

## Executive Summary
- **Overall Status**: $(if [[ $CRITICAL_ISSUES -eq 0 ]]; then echo "PASSED"; else echo "FAILED"; fi)
- **Critical Issues**: $CRITICAL_ISSUES
- **High Priority Issues**: $HIGH_ISSUES  
- **Medium Priority Issues**: $MEDIUM_ISSUES
- **Files Checked**: $TOTAL_FILES_CHECKED

## Quality Score
EOF

    # Calculate quality score
    local total_issues=$((CRITICAL_ISSUES + HIGH_ISSUES + MEDIUM_ISSUES))
    local quality_score=100
    
    if [[ $total_issues -gt 0 ]]; then
        quality_score=$((100 - (CRITICAL_ISSUES * 20) - (HIGH_ISSUES * 10) - (MEDIUM_ISSUES * 5)))
        if [[ $quality_score -lt 0 ]]; then
            quality_score=0
        fi
    fi
    
    cat >> "$report_file" << EOF
**Quality Score**: $quality_score/100

$(if [[ $quality_score -ge 95 ]]; then
    echo "🟢 **EXCELLENT** - Production ready"
elif [[ $quality_score -ge 85 ]]; then
    echo "🟡 **GOOD** - Minor improvements needed"
elif [[ $quality_score -ge 70 ]]; then
    echo "🟠 **FAIR** - Significant improvements needed"
else
    echo "🔴 **POOR** - Major revision required"
fi)

## Issue Summary
- Critical issues require immediate attention
- High priority issues should be fixed before release
- Medium priority issues are improvement opportunities

## Recommendations
EOF

    if [[ $CRITICAL_ISSUES -gt 0 ]]; then
        cat >> "$report_file" << EOF
### 🚨 Critical Actions Required
1. Fix all Amplify Gen 1 patterns
2. Resolve broken links and code examples
3. Complete missing architecture patterns

EOF
    fi
    
    if [[ $HIGH_ISSUES -gt 0 ]]; then
        cat >> "$report_file" << EOF
### 🔥 High Priority Improvements
1. Complete missing command documentation
2. Add security considerations to integration guides
3. Enhance pattern completeness

EOF
    fi
    
    cat >> "$report_file" << EOF
### 📈 Next Steps
1. Address critical issues immediately
2. Plan high priority improvements
3. Schedule regular quality reviews
4. Maintain documentation freshness

---
**Report Generated By**: ACE-Flow Quality Review Tool
**Review Date**: $timestamp
**Review Scope**: $AREA
EOF

    print_status "Quality report generated: $report_file"
    
    # Display summary
    echo
    print_info "=== QUALITY REVIEW SUMMARY ==="
    echo -e "Quality Score: ${BLUE}$quality_score/100${NC}"
    echo -e "Critical Issues: ${RED}$CRITICAL_ISSUES${NC}"
    echo -e "High Priority: ${PURPLE}$HIGH_ISSUES${NC}"
    echo -e "Medium Priority: ${YELLOW}$MEDIUM_ISSUES${NC}"
    echo -e "Files Checked: ${BLUE}$TOTAL_FILES_CHECKED${NC}"
    
    if [[ $CRITICAL_ISSUES -eq 0 && $HIGH_ISSUES -eq 0 ]]; then
        print_status "🎉 ACE-Flow quality review PASSED!"
    elif [[ $CRITICAL_ISSUES -eq 0 ]]; then
        print_warning "⚠️ ACE-Flow quality review passed with minor issues"
    else
        print_error "❌ ACE-Flow quality review FAILED - critical issues found"
    fi
}

# Main execution flow
main() {
    echo -e "${BLUE}🔍 ACE-Flow Quality Review Tool${NC}"
    echo -e "${BLUE}================================${NC}"
    echo
    
    parse_arguments "$@"
    
    if [[ "$GENERATE_PROMPT" == "true" ]]; then
        generate_review_prompt
        exit 0
    fi
    
    print_info "Starting quality review (area: $AREA, format: $FORMAT)"
    echo
    
    # Run checks based on area
    case "$AREA" in
        "docs"|"all")
            check_amplify_gen2_compliance
            check_gen2_patterns
            check_links
            check_code_examples
            ;;
    esac
    
    case "$AREA" in
        "patterns"|"all")
            check_architecture_patterns
            ;;
    esac
    
    case "$AREA" in
        "integrations"|"all")
            check_integration_guides
            ;;
    esac
    
    case "$AREA" in
        "commands"|"all")
            check_command_documentation
            ;;
    esac
    
    # Generate report unless it's a quick check
    if [[ "$QUICK_MODE" != "true" && "$SYNTAX_ONLY" != "true" ]]; then
        echo
        generate_report
    fi
    
    # Exit with appropriate code
    if [[ $CRITICAL_ISSUES -gt 0 ]]; then
        exit 1
    else
        exit 0
    fi
}

# Run main function with all arguments
main "$@"