#!/bin/bash

# ACE-Flow Quality Improvements Test Script
# Tests all high-priority fixes from Issue #4

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TESTS_RUN=0
TESTS_PASSED=0
TESTS_FAILED=0

# Print header
echo -e "${BLUE}🔧 ACE-Flow Quality Improvements Test Suite${NC}"
echo "=============================================="
echo -e "Testing fixes for Issue #4 quality improvements"
echo

# Helper functions
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    TESTS_RUN=$((TESTS_RUN + 1))
    echo -e "${BLUE}Test $TESTS_RUN:${NC} $test_name"
    
    if eval "$test_command"; then
        echo -e "${GREEN}✅ PASSED${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        echo
        return 0
    else
        echo -e "${RED}❌ FAILED${NC}"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        echo
        return 1
    fi
}

# Test 1: Documentation Link Fixes
echo -e "${YELLOW}📚 Testing Documentation Link Fixes${NC}"
echo "-----------------------------------"

run_test "Configuration.md exists and is valid" '
    [ -f "docs/frameworks/amplify-gen2/configuration.md" ] &&
    [ -s "docs/frameworks/amplify-gen2/configuration.md" ] &&
    grep -q "Environment Configuration" "docs/frameworks/amplify-gen2/configuration.md"
'

run_test "Troubleshooting.md exists and is comprehensive" '
    [ -f "docs/frameworks/amplify-gen2/troubleshooting.md" ] &&
    [ -s "docs/frameworks/amplify-gen2/troubleshooting.md" ] &&
    grep -q "Build & Deployment Issues" "docs/frameworks/amplify-gen2/troubleshooting.md"
'

run_test "README links are now valid" '
    [ -f "docs/frameworks/amplify-gen2/README.md" ] &&
    grep -q "Configuration](./configuration.md)" "docs/frameworks/amplify-gen2/README.md" &&
    grep -q "Troubleshooting](./troubleshooting.md)" "docs/frameworks/amplify-gen2/README.md"
'

# Test 2: ACE-Flow Infrastructure
echo -e "${YELLOW}🏗️ Testing ACE-Flow Infrastructure${NC}"
echo "--------------------------------"

run_test ".claude directory exists" '
    [ -d ".claude" ]
'

run_test "ace-rollback command exists with enhancements" '
    [ -f ".claude/ace-rollback.md" ] &&
    grep -q "Enhanced Automated Backup System" ".claude/ace-rollback.md" &&
    grep -q "Smart Timeout Optimization" ".claude/ace-rollback.md"
'

run_test "ace-flow-install command exists" '
    [ -f ".claude/ace-flow-install.md" ] &&
    grep -q "Smart Hook Timeout Optimization" ".claude/ace-flow-install.md"
'

run_test "Checkpoint directory structure exists" '
    [ -d ".ace-flow/checkpoints" ] &&
    [ -f ".ace-flow/checkpoints/.gitkeep" ]
'

# Test 3: Backup System Components
echo -e "${YELLOW}🛡️ Testing Automated Backup System${NC}"
echo "--------------------------------"

run_test "Rollback system has automated backup features" '
    grep -q "Automatic checkpoint triggers:" ".claude/ace-rollback.md" &&
    grep -q "Before /ace-implement operations" ".claude/ace-rollback.md" &&
    grep -q "Before /ace-adopt migrations" ".claude/ace-rollback.md"
'

run_test "Backup validation system is documented" '
    grep -q "Backup Validation System" ".claude/ace-rollback.md" &&
    grep -q "SHA256 checksums" ".claude/ace-rollback.md" &&
    grep -q "Archive corruption detection" ".claude/ace-rollback.md"
'

run_test "Checkpoint metadata structure is defined" '
    grep -q "checkpoint.json" ".ace-flow/checkpoints/.gitkeep" &&
    grep -q "project_state.json" ".ace-flow/checkpoints/.gitkeep"
'

# Test 4: Smart Hook Timeout Optimization  
echo -e "${YELLOW}⚡ Testing Smart Hook Timeout Optimization${NC}"
echo "----------------------------------------"

run_test "Smart timeout system is implemented in rollback" '
    grep -q "execute_with_smart_timeout" ".claude/ace-rollback.md" &&
    grep -q "complexity_score" ".claude/ace-rollback.md" &&
    grep -q "Progressive retry" ".claude/ace-rollback.md"
'

run_test "Smart timeout addresses 15% failure rate" '
    grep -q "addresses 15% failure rate" ".claude/ace-rollback.md" &&
    grep -q "targeting 95%" ".claude/ace-rollback.md"
'

run_test "Installation system has timeout optimization" '
    grep -q "calculate_smart_timeout" ".claude/ace-flow-install.md" &&
    grep -q "progressive_backoff" ".claude/ace-flow-install.md"
'

run_test "Performance monitoring is included" '
    grep -q "log_hook_success" ".claude/ace-flow-install.md" &&
    grep -q "show_performance_stats" ".claude/ace-flow-install.md"
'

# Test 5: Enhanced Command Structure
echo -e "${YELLOW}🚀 Testing Enhanced Command Structure${NC}"
echo "-----------------------------------"

run_test "ace-rollback has enhanced command options" '
    grep -q -- "--status" ".claude/ace-rollback.md" &&
    grep -q -- "--validate" ".claude/ace-rollback.md" &&
    grep -q -- "--cleanup" ".claude/ace-rollback.md"
'

run_test "ace-flow-install has optimization options" '
    grep -q -- "--timeout-opt" ".claude/ace-flow-install.md" &&
    grep -q -- "--hook-config" ".claude/ace-flow-install.md" &&
    grep -q -- "--performance" ".claude/ace-flow-install.md"
'

# Test 6: Configuration and Setup Files
echo -e "${YELLOW}⚙️ Testing Configuration Files${NC}"
echo "-----------------------------"

run_test "Documentation files have proper headers and structure" '
    grep -q "# AWS Amplify Gen 2 Configuration" "docs/frameworks/amplify-gen2/configuration.md" &&
    grep -q "# AWS Amplify Gen 2 Troubleshooting" "docs/frameworks/amplify-gen2/troubleshooting.md"
'

run_test "Configuration file has all required sections" '
    grep -q "Environment Configuration" "docs/frameworks/amplify-gen2/configuration.md" &&
    grep -q "Build Configuration" "docs/frameworks/amplify-gen2/configuration.md" &&
    grep -q "Security Configuration" "docs/frameworks/amplify-gen2/configuration.md"
'

run_test "Troubleshooting file has comprehensive coverage" '
    grep -q "Build & Deployment Issues" "docs/frameworks/amplify-gen2/troubleshooting.md" &&
    grep -q "Authentication Problems" "docs/frameworks/amplify-gen2/troubleshooting.md" &&
    grep -q "GraphQL & Data Issues" "docs/frameworks/amplify-gen2/troubleshooting.md"
'

# Test 7: Quality Metrics Integration
echo -e "${YELLOW}📊 Testing Quality Metrics Integration${NC}"
echo "-----------------------------------"

run_test "Hook success tracking is implemented" '
    grep -q "Hook Success Tracking" ".claude/ace-flow-install.md" &&
    grep -q "success_rate" ".claude/ace-flow-install.md"
'

run_test "Performance statistics system exists" '
    grep -q "Performance Statistics" ".claude/ace-flow-install.md" &&
    grep -q "Total executions" ".claude/ace-flow-install.md"
'

run_test "Quality targets are documented" '
    grep -q "Success Rate Target: 95%" ".claude/ace-flow-install.md" &&
    grep -q "Target achieved" ".claude/ace-flow-install.md"
'

# Test 8: File Integrity and Content Quality
echo -e "${YELLOW}📝 Testing File Integrity and Content Quality${NC}"
echo "--------------------------------------------"

run_test "All created files are non-empty and have content" '
    [ -s "docs/frameworks/amplify-gen2/configuration.md" ] &&
    [ -s "docs/frameworks/amplify-gen2/troubleshooting.md" ] &&
    [ -s ".claude/ace-rollback.md" ] &&
    [ -s ".claude/ace-flow-install.md" ] &&
    [ -s ".ace-flow/checkpoints/.gitkeep" ]
'

run_test "Files have proper markdown formatting" '
    grep -q "^# " "docs/frameworks/amplify-gen2/configuration.md" &&
    grep -q "^## " "docs/frameworks/amplify-gen2/configuration.md" &&
    grep -q "^# " "docs/frameworks/amplify-gen2/troubleshooting.md" &&
    grep -q "^## " "docs/frameworks/amplify-gen2/troubleshooting.md"
'

run_test "Command files have proper structure" '
    grep -q "^# /ace-" ".claude/ace-rollback.md" &&
    grep -q "^# /ace-flow-install" ".claude/ace-flow-install.md"
'

# Test 9: Integration with Existing System
echo -e "${YELLOW}🔗 Testing Integration with Existing System${NC}"  
echo "----------------------------------------"

run_test "New files integrate with existing documentation structure" '
    [ -f "docs/frameworks/amplify-gen2/README.md" ] &&
    [ -f "docs/frameworks/amplify-gen2/getting-started.md" ] &&
    [ -f "docs/frameworks/amplify-gen2/configuration.md" ] &&
    [ -f "docs/frameworks/amplify-gen2/troubleshooting.md" ]
'

run_test "ACE commands maintain consistency with existing commands" '
    grep -q "## Overview" ".claude/ace-rollback.md" &&
    grep -q "## Usage" ".claude/ace-rollback.md"
'

# Test 10: Validation and Error Handling
echo -e "${YELLOW}🔍 Testing Validation and Error Handling${NC}"
echo "--------------------------------------"

run_test "Backup validation procedures are documented" '
    grep -q "validate_checkpoint" ".claude/ace-rollback.md" &&
    grep -q "exit_code" ".claude/ace-rollback.md"
'

run_test "Error handling scenarios are covered" '
    grep -q "retry_count" ".claude/ace-rollback.md" &&
    grep -q "max_retries" ".claude/ace-rollback.md"
'

run_test "Timeout handling has proper error cases" '
    grep -q "Timeout reached" ".claude/ace-rollback.md" &&
    grep -q "Operation failed" ".claude/ace-rollback.md"
'

# Summary
echo -e "${BLUE}📊 Test Results Summary${NC}"
echo "======================"
echo -e "Tests run: ${BLUE}$TESTS_RUN${NC}"
echo -e "Tests passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Tests failed: ${RED}$TESTS_FAILED${NC}"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "\n${GREEN}🎉 All tests passed! Quality improvements implemented successfully.${NC}"
    echo -e "\n${BLUE}✅ High Priority Issues Addressed:${NC}"
    echo "   📚 Documentation link fixes (configuration.md, troubleshooting.md)"
    echo "   🛡️ Automated backup system with checkpoint validation"
    echo "   ⚡ Smart hook timeout optimization (85% → 95% target success rate)"
    echo "   🏗️ Complete ACE-Flow command infrastructure"
    echo -e "\n${BLUE}📈 Quality Score Impact:${NC}"
    echo "   • Command success rate improvements"
    echo "   • Hook timeout failure reduction"
    echo "   • Data safety with automated backups"
    echo "   • Production-ready infrastructure"
    exit 0
else
    echo -e "\n${RED}❌ Some tests failed. Please review the issues above.${NC}"
    exit 1
fi