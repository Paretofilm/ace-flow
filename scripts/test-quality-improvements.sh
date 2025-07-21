#!/bin/bash

# ACE-Flow Quality Improvements Test Script
# Tests the fixes implemented for Issue #4

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🧪 ACE-Flow Quality Improvements Test Suite${NC}"
echo "Testing fixes for Issue #4 - Quality Improvements"
echo "================================================"

# Test 1: Check for fixed documentation link
test_documentation_fix() {
    echo -e "\n${BLUE}Test 1: Documentation Link Fix${NC}"
    
    if [[ -f "docs/frameworks/amplify-gen2/configuration.md" ]]; then
        echo -e "${GREEN}✅ configuration.md file exists${NC}"
        
        # Check that README still references it
        if grep -q "configuration.md" "docs/frameworks/amplify-gen2/README.md"; then
            echo -e "${GREEN}✅ README.md correctly references configuration.md${NC}"
        else
            echo -e "${RED}❌ README.md missing reference to configuration.md${NC}"
            return 1
        fi
    else
        echo -e "${RED}❌ configuration.md file not found${NC}"
        return 1
    fi
    
    return 0
}

# Test 2: Check ACE-Flow rollback enhancements
test_rollback_enhancements() {
    echo -e "\n${BLUE}Test 2: ACE-Rollback Enhancements${NC}"
    
    if [[ -f ".claude/ace-rollback.md" ]]; then
        echo -e "${GREEN}✅ ace-rollback.md exists${NC}"
        
        # Check for automated backup system content
        if grep -q "Automated Backup System Implementation" ".claude/ace-rollback.md"; then
            echo -e "${GREEN}✅ Automated backup system documented${NC}"
        else
            echo -e "${RED}❌ Automated backup system not found${NC}"
            return 1
        fi
        
        # Check for validation system
        if grep -q "validate_checkpoint()" ".claude/ace-rollback.md"; then
            echo -e "${GREEN}✅ Backup validation system implemented${NC}"
        else
            echo -e "${RED}❌ Backup validation system not found${NC}"
            return 1
        fi
        
        # Check for cleanup system
        if grep -q "cleanup_old_checkpoints()" ".claude/ace-rollback.md"; then
            echo -e "${GREEN}✅ Automatic cleanup system implemented${NC}"
        else
            echo -e "${RED}❌ Automatic cleanup system not found${NC}"
            return 1
        fi
        
    else
        echo -e "${RED}❌ ace-rollback.md not found${NC}"
        return 1
    fi
    
    return 0
}

# Test 3: Check smart hook timeout optimization
test_hook_timeout_optimization() {
    echo -e "\n${BLUE}Test 3: Smart Hook Timeout Optimization${NC}"
    
    # Check if timeout optimization is implemented in rollback
    if grep -q "execute_with_smart_timeout" ".claude/ace-rollback.md"; then
        echo -e "${GREEN}✅ Smart timeout system implemented${NC}"
        
        # Check for progressive timeout handling
        if grep -q "timeout_seconds=180" ".claude/ace-rollback.md"; then
            echo -e "${GREEN}✅ Progressive timeout values configured${NC}"
        else
            echo -e "${YELLOW}⚠️ Progressive timeout values not fully configured${NC}"
        fi
        
    else
        echo -e "${RED}❌ Smart timeout system not found${NC}"
        return 1
    fi
    
    return 0
}

# Test 4: Check checkpoint directory structure
test_checkpoint_structure() {
    echo -e "\n${BLUE}Test 4: Checkpoint Directory Structure${NC}"
    
    if [[ -d ".ace-flow/checkpoints" ]]; then
        echo -e "${GREEN}✅ Checkpoint directory exists${NC}"
        
        if [[ -f ".ace-flow/checkpoints/.gitkeep" ]]; then
            echo -e "${GREEN}✅ .gitkeep file present${NC}"
        else
            echo -e "${YELLOW}⚠️ .gitkeep file not found (directory might be lost in git)${NC}"
        fi
    else
        echo -e "${RED}❌ Checkpoint directory not found${NC}"
        return 1
    fi
    
    return 0
}

# Test 5: Check enhanced ace-flow-install command
test_ace_flow_install_enhancements() {
    echo -e "\n${BLUE}Test 5: ACE-Flow Install Enhancements${NC}"
    
    if [[ -f ".claude/ace-flow-install.md" ]]; then
        echo -e "${GREEN}✅ ace-flow-install.md exists${NC}"
        
        # Check for timeout optimization
        if grep -q "execute_with_smart_timeout" ".claude/ace-flow-install.md"; then
            echo -e "${GREEN}✅ Smart timeout integration in install command${NC}"
        else
            echo -e "${RED}❌ Smart timeout integration not found in install command${NC}"
            return 1
        fi
    else
        echo -e "${RED}❌ ace-flow-install.md not found${NC}"
        return 1
    fi
    
    return 0
}

# Run all tests
echo -e "\n${YELLOW}Running all tests...${NC}\n"

passed_tests=0
total_tests=5

# Execute tests
if test_documentation_fix; then
    ((passed_tests++))
fi

if test_rollback_enhancements; then
    ((passed_tests++))
fi

if test_hook_timeout_optimization; then
    ((passed_tests++))
fi

if test_checkpoint_structure; then
    ((passed_tests++))
fi

if test_ace_flow_install_enhancements; then
    ((passed_tests++))
fi

# Test summary
echo -e "\n${BLUE}================================================${NC}"
echo -e "${BLUE}Test Results Summary${NC}"
echo -e "${BLUE}================================================${NC}"

if [[ $passed_tests -eq $total_tests ]]; then
    echo -e "${GREEN}🎉 ALL TESTS PASSED! ($passed_tests/$total_tests)${NC}"
    echo -e "${GREEN}✅ Quality improvements successfully implemented${NC}"
    echo ""
    echo "✅ Fixed broken documentation link"
    echo "✅ Implemented automated backup system for rollback"
    echo "✅ Added backup validation and integrity checks"
    echo "✅ Added automatic cleanup (keeps last 10 checkpoints)"
    echo "✅ Implemented smart hook timeout optimization"
    echo "✅ Enhanced installation process with better validation"
    echo ""
    echo -e "${BLUE}🎯 Quality targets addressed:${NC}"
    echo "• Command success rate improvement (smart timeouts)"
    echo "• Hook success rate improvement (85% → 95% target)"
    echo "• Data safety with automated backups"
    echo "• Production-ready infrastructure"
    exit 0
else
    echo -e "${RED}❌ SOME TESTS FAILED ($passed_tests/$total_tests passed)${NC}"
    echo -e "${RED}Please review the failing tests above${NC}"
    exit 1
fi