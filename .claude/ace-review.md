# ACE-Review: Comprehensive Quality Assurance Command

**Systematic quality review and validation system for ACE-Flow to ensure all components work as expected and documentation aligns with current best practices.**

## 🎯 **Command Overview**

The `/ace-review` command provides comprehensive quality assurance for the ACE-Flow system, validating documentation accuracy, command consistency, and user experience flows. It generates detailed reports and AI-ready prompts for thorough system validation.

## 📋 **Usage**

### **Basic Commands**
```bash
# Complete system review
/ace-review

# Review specific areas
/ace-review --area=docs
/ace-review --area=commands  
/ace-review --area=patterns
/ace-review --area=integrations

# Generate AI review prompts
/ace-review --generate-prompt
/ace-review --generate-prompt --area=docs

# Quick validation checks
/ace-review --quick
/ace-review --syntax-only
```

### **Advanced Options**
```bash
# Review with specific focus
/ace-review --focus="amplify-gen2-alignment"
/ace-review --focus="command-consistency"
/ace-review --focus="user-experience"

# Output formats
/ace-review --format=detailed
/ace-review --format=summary
/ace-review --format=checklist

# Severity filtering
/ace-review --severity=critical
/ace-review --severity=high
/ace-review --include-suggestions
```

## 🔍 **Review Areas**

### **1. Documentation Consistency (`--area=docs`)**
**Purpose**: Ensure all documentation uses current patterns and accurate information

#### **Validation Checks**
- ✅ **Amplify Gen 2 Compliance**: All code examples use `generateClient<Schema>()` not `API.graphql()`
- ✅ **Framework Versions**: Documentation matches latest stable releases
- ✅ **Import Statements**: Correct `aws-amplify/data`, `aws-amplify/auth` imports
- ✅ **TypeScript Accuracy**: Proper type definitions and interfaces
- ✅ **Link Validation**: All internal and external links functional
- ✅ **Code Example Testing**: All code samples syntactically correct

#### **Critical Issues Detected**
```yaml
Critical_Patterns:
  gen1_detection:
    - "API.graphql(graphqlOperation"
    - "import { API } from 'aws-amplify'"
    - "@aws-amplify/api"
    
  outdated_imports:
    - "aws-amplify" (should be specific imports)
    - "aws-amplify/core" (deprecated patterns)
    
  incorrect_syntax:
    - ".create({ input: data })" (Gen 1 style)
    - "Auth.signIn()" (should be "signIn()")
```

### **2. Command System Validation (`--area=commands`)**
**Purpose**: Verify all ACE-Flow commands are properly documented and consistent

#### **Command Checks**
- ✅ **Complete Documentation**: All commands have full `.claude/*.md` files
- ✅ **Syntax Consistency**: Uniform command patterns across all docs
- ✅ **Keyword Validation**: All architecture patterns and features defined
- ✅ **Example Accuracy**: All usage examples work as documented
- ✅ **Help System**: Proper error messages and help text

#### **Command Validation Matrix**
```yaml
Commands_Validated:
  ace-genesis:
    documentation: ".claude/ace-genesis.md"
    syntax_examples: 15
    keyword_usage: ["social_platform", "e_commerce", etc.]
    
  ace-research:
    documentation: ".claude/ace-research.md"
    local_docs_integration: true
    pattern_detection: validated
    
  ace-implement:
    documentation: ".claude/ace-implement.md"
    context_awareness: true
    feature_extension: validated
```

### **3. Architecture Pattern Quality (`--area=patterns`)**
**Purpose**: Ensure architecture patterns are complete and production-ready

#### **Pattern Validation**
- ✅ **Implementation Completeness**: Full data models, UI components, API functions
- ✅ **Security Best Practices**: Proper authorization rules and data protection
- ✅ **Performance Optimization**: Efficient queries and caching strategies
- ✅ **Integration Points**: Correct third-party service configurations
- ✅ **Real-world Validation**: Patterns work in actual development scenarios

#### **Quality Metrics per Pattern**
```typescript
interface PatternQuality {
  social_platform: {
    dataModels: "100% complete";
    uiComponents: "100% complete";
    realTimeFeatures: "100% complete";
    securityImplementation: "100% complete";
    integrationExamples: "95% complete";
  };
  
  e_commerce: {
    paymentIntegration: "100% complete";
    inventoryManagement: "100% complete";
    orderProcessing: "100% complete";
    multiVendorSupport: "95% complete";
  };
}
```

### **4. Integration Guide Accuracy (`--area=integrations`)**
**Purpose**: Validate third-party service integrations work with current APIs

#### **Integration Validation**
- ✅ **API Compatibility**: All service APIs use current versions
- ✅ **Setup Completeness**: Environment variables, configuration steps complete
- ✅ **Error Handling**: Proper error management and fallback strategies
- ✅ **Security Implementation**: API keys, webhooks, data protection
- ✅ **Testing Procedures**: Validation methods for each integration

#### **Service-Specific Checks**
```yaml
Integration_Validation:
  stripe:
    api_version: "2023-10-16"
    webhook_security: "signature validation implemented"
    error_handling: "comprehensive coverage"
    testing_guide: "complete"
    
  sendgrid:
    api_version: "current"
    template_management: "complete"
    delivery_tracking: "webhook integration"
    spam_compliance: "best practices documented"
```

## 🤖 **AI Review Prompt Generation**

### **Generate Claude Opus Review Prompt**
```bash
/ace-review --generate-prompt --area=docs
```

**Generated Prompt Structure**:
```markdown
# ACE-Flow Quality Review Request for Claude Opus

## Review Context
You are reviewing the ACE-Flow system - an intelligent workflow system for AWS Amplify Gen 2 development. Your task is to perform a comprehensive quality assessment.

## System Overview
[Detailed ACE-Flow description and architecture]

## Review Areas
1. Documentation accuracy and consistency
2. Code example validation (especially Gen 1 vs Gen 2)
3. Command system functionality
4. Architecture pattern completeness
5. Integration guide accuracy

## Specific Validation Tasks
[Detailed checklist of items to verify]

## Expected Deliverables
[Specific output format and requirements]

## Quality Standards
[Criteria for success and failure conditions]
```

### **Prompt Customization Options**
```bash
# Focus on specific concerns
/ace-review --generate-prompt --focus="gen1-vs-gen2"
/ace-review --generate-prompt --focus="typescript-accuracy"
/ace-review --generate-prompt --focus="user-experience"

# Different AI models
/ace-review --generate-prompt --model="claude-opus"
/ace-review --generate-prompt --model="gpt4"
/ace-review --generate-prompt --model="internal-review"
```

## 📊 **Review Output Formats**

### **Detailed Report (`--format=detailed`)**
```markdown
# ACE-Flow Quality Assessment Report
Generated: 2024-01-20 14:30:00

## Executive Summary
- Overall Quality Score: 92/100
- Critical Issues: 2
- High Priority Issues: 5
- Medium Priority Issues: 12
- Suggestions: 18

## Critical Issues
1. **Amplify Gen 1 Pattern Detected**
   - Location: docs/patterns/social_platform.md:45
   - Issue: Uses `API.graphql(graphqlOperation(...))` 
   - Fix: Replace with `client.models.Model.create()`
   - Priority: CRITICAL

## Detailed Findings by Area
[Comprehensive breakdown of all issues found]

## Recommendations
[Prioritized action items for improvement]
```

### **Summary Report (`--format=summary`)**
```yaml
Quality_Summary:
  overall_score: 92
  issues_by_severity:
    critical: 2
    high: 5
    medium: 12
    low: 8
  
  areas_reviewed:
    documentation: 95%
    commands: 90%
    patterns: 88%
    integrations: 94%
  
  top_priorities:
    - "Fix Amplify Gen 1 patterns in social platform docs"
    - "Add missing error handling in Stripe integration"
    - "Complete React 18+ hooks documentation"
```

### **Actionable Checklist (`--format=checklist`)**
```markdown
# ACE-Flow Quality Improvement Checklist

## Critical (Fix Immediately)
- [ ] Replace Gen 1 patterns in docs/patterns/social_platform.md:45
- [ ] Update outdated import statements in integration guides

## High Priority (Fix This Week)
- [ ] Complete missing error handling in Stripe webhook documentation
- [ ] Add TypeScript interfaces for SendGrid integration
- [ ] Validate all external links in documentation

## Medium Priority (Fix This Month)
- [ ] Add React 18+ hooks and patterns documentation
- [ ] Enhance command help system with better examples
- [ ] Improve architecture pattern comparison matrix
```

## 🔧 **Automation Features**

### **Scheduled Reviews**
```yaml
Review_Schedule:
  daily_quick_check:
    command: "/ace-review --quick --syntax-only"
    time: "06:00 UTC"
    alerts: "critical issues only"
    
  weekly_comprehensive:
    command: "/ace-review --format=detailed"
    time: "Sunday 02:00 UTC"
    output: "quality-report-YYYY-MM-DD.md"
    
  pre_release:
    command: "/ace-review --area=all --severity=high"
    trigger: "manual before major releases"
    required_score: ">95"
```

### **Continuous Integration**
```typescript
// GitHub Actions integration
const reviewWorkflow = {
  name: 'ACE-Flow Quality Review',
  on: {
    pull_request: {
      paths: ['.claude/**', 'docs/**', 'scripts/**']
    },
    schedule: [
      { cron: '0 6 * * *' } // Daily at 6 AM UTC
    ]
  },
  jobs: {
    quality_review: {
      steps: [
        { name: 'Run ACE-Flow Review', run: '/ace-review --format=summary' },
        { name: 'Check Quality Gate', run: 'check_quality_score.sh' },
        { name: 'Post Results', run: 'post_review_results.sh' }
      ]
    }
  }
};
```

## 🎯 **Quality Standards**

### **Acceptance Criteria**
```yaml
Quality_Gates:
  minimum_scores:
    overall: 90
    documentation: 95
    commands: 90
    patterns: 85
    integrations: 90
    
  zero_tolerance:
    - "Amplify Gen 1 patterns"
    - "Broken external links"
    - "Syntactically incorrect code examples"
    - "Security vulnerabilities in integration guides"
    
  success_metrics:
    - "All architecture patterns 100% complete"
    - "All code examples use Amplify Gen 2"
    - "All integrations use current API versions"
    - "User journey flows fully documented"
```

### **Review Success Indicators**
✅ **Documentation Excellence**: 100% Gen 2 compliance, no broken links  
✅ **Command Consistency**: All commands properly documented and functional  
✅ **Pattern Completeness**: Production-ready architecture patterns  
✅ **Integration Accuracy**: Current APIs, complete setup guides  
✅ **User Experience**: Clear, tested end-to-end workflows  

## 🚀 **Implementation Workflow**

### **Running a Complete Review**
```bash
# 1. Execute comprehensive review
/ace-review

# 2. Address critical issues first
/ace-review --severity=critical --format=checklist

# 3. Generate AI review for detailed analysis
/ace-review --generate-prompt > claude-opus-review.md

# 4. Validate fixes
/ace-review --quick --area=docs

# 5. Generate final report
/ace-review --format=summary > quality-report.md
```

### **Pre-Release Quality Gate**
```bash
# Required before any major release
/ace-review --severity=high
# Must achieve >95 overall score

/ace-review --focus="user-experience" 
# Must have zero critical UX issues

/ace-review --area=integrations --validate-apis
# All integrations must use current APIs
```

---

*The `/ace-review` command ensures ACE-Flow maintains the highest quality standards, providing comprehensive validation and actionable improvement recommendations for reliable, production-ready development workflows.*

**Command Version**: 1.0  
**Review Coverage**: Documentation, Commands, Patterns, Integrations, UX  
**AI Integration**: Claude Opus prompt generation for detailed analysis