# ACE-Flow Review Prompts

**Comprehensive quality assurance prompts and tools for validating ACE-Flow system integrity.**

## 📋 **Available Review Resources**

### **Claude Opus Review Prompt**
**File**: `claude-opus-quality-review.md`  
**Purpose**: Detailed prompt for AI-powered comprehensive system review

**Usage**:
```bash
# Generate the prompt for Claude Opus
/ace-review --generate-prompt

# Copy the generated prompt to Claude Opus for analysis
```

**What it covers**:
- Complete Amplify Gen 2 compliance validation
- Documentation accuracy and completeness
- Architecture pattern quality assessment
- Integration guide verification
- User experience flow validation

### **Human Review Checklist**
**File**: `review-checklist.md`  
**Purpose**: Step-by-step manual review process for human validators

**Usage**:
```bash
# Use as a manual checklist for comprehensive review
# Check off items as you validate each component
```

**Covers**:
- Pre-review setup and preparation
- Critical review areas with specific checks
- Quality metrics validation
- User experience testing
- Production readiness assessment

### **Test Scenarios**
**File**: `test-scenarios.md`  
**Purpose**: Specific test cases and validation scenarios

**Usage**:
```bash
# Reference for creating automated tests
# Use for manual testing procedures
# Validate specific functionality
```

**Includes**:
- Amplify Gen 2 compliance tests
- Documentation accuracy tests
- Architecture pattern validation
- Integration guide testing
- Command system validation
- User experience testing

## 🤖 **AI Review Integration**

### **Using with Claude Opus**
```bash
# 1. Generate the review prompt
/ace-review --generate-prompt > claude-review.md

# 2. Copy the content to Claude Opus
# 3. Provide access to the ACE-Flow repository
# 4. Request comprehensive review based on the prompt
```

### **Expected AI Output**
- Executive summary with quality score
- Detailed findings by category
- Specific issues with file locations
- Recommended fixes with examples
- Action plan with priorities

### **Using with Other AI Models**
The prompts can be adapted for:
- **GPT-4**: Comprehensive code and documentation review
- **Internal Review Systems**: Automated quality gates
- **Custom AI Tools**: Specialized validation systems

## 🔧 **Automation Integration**

### **Automated Review Script**
**File**: `../ace-review.sh`  
**Purpose**: Automated quality validation

**Usage**:
```bash
# Full system review
./scripts/ace-review.sh

# Specific area review
./scripts/ace-review.sh --area=docs
./scripts/ace-review.sh --area=patterns

# Generate AI prompt
./scripts/ace-review.sh --generate-prompt

# Quick validation
./scripts/ace-review.sh --quick
```

### **CI/CD Integration**
```yaml
# GitHub Actions workflow
name: ACE-Flow Quality Review
on: [push, pull_request]

jobs:
  quality-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run Quality Review
        run: ./scripts/ace-review.sh --area=all
      - name: Upload Report
        uses: actions/upload-artifact@v3
        with:
          name: quality-report
          path: quality-reports/
```

## 📊 **Review Process Workflow**

### **1. Preparation Phase**
- [ ] Ensure latest ACE-Flow version
- [ ] Review previous quality reports
- [ ] Set review scope and criteria
- [ ] Prepare validation environment

### **2. Automated Validation**
```bash
# Run automated checks
./scripts/ace-review.sh --area=all --format=detailed

# Generate AI review prompt
./scripts/ace-review.sh --generate-prompt
```

### **3. AI-Powered Review**
- [ ] Use generated prompt with Claude Opus
- [ ] Analyze detailed findings
- [ ] Cross-reference with automated results
- [ ] Document specific issues found

### **4. Manual Validation**
- [ ] Use review checklist for manual validation
- [ ] Test specific scenarios from test scenarios
- [ ] Validate user experience flows
- [ ] Check production readiness

### **5. Report Generation**
- [ ] Compile comprehensive quality report
- [ ] Prioritize issues by severity
- [ ] Create action plan
- [ ] Set improvement timeline

## 🎯 **Quality Standards**

### **Review Success Criteria**
- ✅ Zero Amplify Gen 1 patterns
- ✅ All code examples work correctly
- ✅ Complete architecture patterns
- ✅ Current integration guides
- ✅ Consistent command documentation
- ✅ Clear user experience flows

### **Quality Gates**
```yaml
Quality_Thresholds:
  critical_issues: 0
  high_priority_issues: "< 3"
  overall_quality_score: "> 90"
  documentation_accuracy: "> 95%"
  code_example_validity: "100%"
  link_validation: "100%"
```

### **Review Frequency**
- **Pre-Release**: Complete comprehensive review
- **Weekly**: Automated validation
- **Monthly**: AI-powered analysis
- **Quarterly**: Full manual review

## 📈 **Continuous Improvement**

### **Review History Tracking**
- Maintain review reports in `quality-reports/`
- Track improvement over time
- Identify recurring issues
- Monitor quality trends

### **Process Enhancement**
- Update review prompts based on findings
- Enhance automated validation scripts
- Improve test scenarios coverage
- Refine quality standards

### **Knowledge Sharing**
- Document lessons learned
- Share best practices
- Update review procedures
- Train team members

## 🚀 **Getting Started**

### **Quick Review**
```bash
# 1. Run automated validation
./scripts/ace-review.sh --quick

# 2. Check critical issues
./scripts/ace-review.sh --severity=critical

# 3. Generate AI prompt if issues found
./scripts/ace-review.sh --generate-prompt
```

### **Comprehensive Review**
```bash
# 1. Full automated review
./scripts/ace-review.sh --area=all --format=detailed

# 2. Generate AI review prompt
./scripts/ace-review.sh --generate-prompt

# 3. Manual validation using checklist
# Follow review-checklist.md

# 4. Test specific scenarios
# Use test-scenarios.md
```

### **Review Report Analysis**
```bash
# Generated reports location
ls quality-reports/

# Latest report
cat quality-reports/quality-report-$(date +%Y%m%d)*.md
```

---

**Review System Version**: 1.0  
**Automation**: Comprehensive automated and AI-powered validation  
**Coverage**: Complete ACE-Flow system quality assurance