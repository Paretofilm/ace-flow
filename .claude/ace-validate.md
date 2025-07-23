# /ace-validate - Pre-Implementation Validation with Steering Context

## Overview
The `/ace-validate` command performs comprehensive pre-implementation checks to ensure your project is ready for development and deployment. Enhanced with Kiro-style accountability and steering context, it validates configuration, dependencies, AWS credentials, architecture compatibility, and **specification compliance** using project-specific standards.

## Usage
```bash
# Validate entire project
/ace-validate

# Validate specific aspect
/ace-validate --check=auth
/ace-validate --check=storage
/ace-validate --check=api

# Quick validation (essential checks only)
/ace-validate --quick

# Detailed validation with recommendations
/ace-validate --detailed

# Specification compliance validation
/ace-validate --specs

# Pre-deployment compliance check
/ace-validate --pre-deploy

# Steering-aware validation
/ace-validate --with-steering
```

## 🎯 Steering Context Integration

### Active Steering Files
ACE-Validate automatically loads relevant steering context for enhanced validation:

```
🎯 Active Steering Context:
  • Quality standards and compliance requirements (conditional)
  • Technical context and constraints (conditional)
  • Compliance requirements and regulations (conditional)
  Total: 3 steering files loaded

📊 Validation Intelligence: Project-specific standards applied
```

### How Steering Enhances Validation

1. **Project-Specific Quality Standards**
   - Uses `quality-standards.md` for custom validation thresholds
   - Applies domain-specific quality requirements
   - Enforces project-established compliance levels

2. **Technical Context Awareness**
   - Leverages `technical-context.md` for framework-specific validations
   - Applies known constraints and limitations
   - Uses established performance benchmarks

3. **Compliance Intelligence**
   - Applies `compliance-requirements.md` for regulatory checks
   - Enforces industry-specific compliance standards
   - Validates against documented security requirements

### Automatic Standards Capture
Validation insights are captured back to steering:

```yaml
steering_updates:
  quality-standards.md:
    - New validation patterns discovered
    - Quality threshold adjustments
    - Testing approach refinements
    
  technical-context.md:
    - Performance validation results
    - Framework limitation discoveries
    - Configuration optimization insights
    
  compliance-requirements.md:
    - Regulatory validation outcomes
    - Security check results
    - Audit preparation improvements
```

## Validation Checks

### 🔐 Authentication & Authorization
```
✅ AWS Credentials configured
✅ Amplify CLI authenticated
✅ IAM permissions adequate
✅ Auth configuration valid
✅ User pool settings optimal
⚠️  MFA not configured (recommended for production)
```

### 📊 Data Schema Validation
```
✅ GraphQL schema syntax valid
✅ Model relationships correct
✅ Required fields defined
✅ Index configuration optimal
❌ Circular dependency detected: User → Post → User
   Fix: Add @hasMany/@belongsTo directives
```

### 📦 Storage Configuration
```
✅ S3 bucket naming valid
✅ Access rules defined
✅ File size limits set
⚠️  CORS not configured for web uploads
   Fix: Add CORS rules in storage/resource.ts
```

### ⚡ Function Configuration
```
✅ Runtime versions compatible
✅ Memory allocation sufficient
✅ Timeout values reasonable
✅ Environment variables set
❌ Missing required env var: STRIPE_SECRET_KEY
   Fix: Run 'npx ampx sandbox secret set STRIPE_SECRET_KEY'
```

### 🚀 Deployment Readiness
```
✅ Git repository initialized
✅ No uncommitted changes
✅ Branch protection configured
✅ CI/CD pipeline ready
⚠️  No staging environment
   Recommendation: Set up staging branch
```

## Validation Report Format

### Summary Report
```
🔍 ACE-Validate Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Project: fitness-tracker
Pattern: social_platform
Status: READY WITH WARNINGS

✅ Passed: 18/22 checks
⚠️  Warnings: 3
❌ Failures: 1

Estimated Fix Time: 15 minutes
Deployment Risk: Low

Run with --detailed for full report
```

### Detailed Report
```
🔍 ACE-Validate Detailed Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

## Critical Issues (Must Fix)

### ❌ Data Model Error
File: amplify/data/resource.ts
Line: 45
Issue: Circular dependency in relationships
Impact: Type generation will fail
Solution: 
  1. Add explicit relationship directives
  2. Use @hasMany on User model
  3. Use @belongsTo on Post model
Reference: https://docs.amplify.aws/gen2/build-a-backend/data/relationships

## Warnings (Recommended Fixes)

### ⚠️ Security Configuration
File: amplify/auth/resource.ts
Issue: MFA not enabled
Impact: Reduced account security
Recommendation: Enable MFA for production
Code:
```typescript
export const auth = defineAuth({
  loginWith: { email: true },
  multifactor: {
    mode: 'OPTIONAL',
    sms: true,
    totp: true
  }
});
```

### ⚠️ Performance Optimization
File: amplify/data/resource.ts
Issue: Missing indexes on frequently queried fields
Impact: Slower query performance
Recommendation: Add secondary indexes
Code:
```typescript
Post: a.model({
  title: a.string(),
  userId: a.id().required(),
  createdAt: a.datetime()
}).secondaryIndexes(index => [
  index('userId').sortKeys(['createdAt']).name('byUser')
])
```

## Best Practice Suggestions

### 📈 Scalability
- Consider implementing caching strategy
- Add rate limiting to API endpoints
- Configure auto-scaling for functions

### 🔒 Security
- Enable AWS WAF for API Gateway
- Implement request validation
- Add API key rotation policy

### 💰 Cost Optimization
- Review DynamoDB capacity settings
- Enable S3 lifecycle policies
- Monitor Lambda cold starts
```

## Architecture Compatibility Matrix

```
Pattern: social_platform
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Feature          | Required | Detected | Status
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Authentication   | Yes      | Yes      | ✅
Real-time Data   | Yes      | Yes      | ✅
File Storage     | Yes      | Yes      | ✅
User Profiles    | Yes      | Yes      | ✅
Social Features  | Yes      | Partial  | ⚠️
Push Notif.      | Optional | No       | ℹ️
Analytics        | Optional | No       | ℹ️
```

## Quick Fix Commands

Based on validation results, here are quick fixes:

```bash
# Fix authentication warnings
npx ampx sandbox secret set STRIPE_SECRET_KEY

# Fix schema errors
npx ampx generate

# Fix deployment warnings
git add -A && git commit -m "Fix validation issues"

# Update dependencies
npm update aws-amplify
```

## Validation Hooks

### Pre-Deploy Validation
Automatically runs before deployment:
```yaml
pre-deploy:
  - ace-validate --quick
  - ace-validate --check=security
  - ace-validate --check=cost
```

### CI/CD Integration
```yaml
# .github/workflows/validate.yml
- name: Run ACE Validation
  run: |
    npx ace-validate --detailed
    if [ $? -ne 0 ]; then
      echo "Validation failed"
      exit 1
    fi
```

## Custom Validation Rules

Add project-specific validation in `.ace-flow/validate/`:

```javascript
// .ace-flow/validate/custom-rules.js
export const customRules = {
  // Ensure all API endpoints have auth
  apiAuth: async (project) => {
    const apis = await project.getAPIs();
    return apis.every(api => api.hasAuth);
  },
  
  // Check data retention policy
  dataRetention: async (project) => {
    const tables = await project.getTables();
    return tables.every(table => table.ttl !== undefined);
  }
};
```

## Exit Codes

- `0` - All validations passed
- `1` - Critical errors found
- `2` - Warnings only
- `3` - Validation system error

## Examples

### Basic Project Validation
```bash
# Validate entire project before deployment
/ace-validate

🔍 ACE-Validate Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Project: recipe-sharing-app
Pattern: social_platform
Status: READY

✅ Passed: 22/22 checks
⚠️  Warnings: 0
❌ Failures: 0

All systems ready for deployment! 🚀
```

### Validation with Issues Found
```bash
# Validation revealing issues
/ace-validate

🔍 ACE-Validate Report
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Project: e-commerce-store
Pattern: e_commerce
Status: NEEDS ATTENTION

✅ Passed: 18/22 checks
⚠️  Warnings: 3
❌ Failures: 1

Critical Issues:
❌ Missing Stripe API key
   Fix: Run 'npx ampx sandbox secret set STRIPE_SECRET_KEY'

Warnings:
⚠️  CORS not configured for file uploads
⚠️  No MFA enabled for production
⚠️  Missing database indexes for search queries

Estimated Fix Time: 12 minutes
```

### Specific Component Validation
```bash
# Validate only authentication setup
/ace-validate --check=auth

🔐 Authentication Validation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ AWS Credentials configured
✅ Cognito User Pool exists
✅ Auth configuration valid
⚠️  MFA not enabled (recommended for production)
❌ Missing social login providers

Recommendations:
- Enable MFA: Update auth/resource.ts with MFA config
- Add Google/Facebook login: Configure social providers
```

### Quick Validation During Development
```bash
# Fast validation for development workflow
/ace-validate --quick

🔍 Quick Validation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Essential Checks: ✅ 8/8 passed

✅ Schema syntax valid
✅ Auth configured
✅ Required secrets present
✅ Git repository clean
✅ Dependencies up to date
✅ No obvious conflicts
✅ Basic security OK
✅ Ready for sandbox deploy

Status: GOOD TO GO! 🚀
```

### Pattern-Specific Validation Examples
```bash
# Social platform validation
/ace-validate --pattern=social_platform

📱 Social Platform Validation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Real-time Features: ✅ Configured
File Upload: ✅ Ready (S3 + CloudFront)
Push Notifications: ⚠️  Setup incomplete
User Profiles: ✅ Validated
Social Graph: ✅ Models defined
Content Moderation: ❌ Not configured

Next Steps:
1. Complete push notification setup
2. Add content moderation rules
3. Test real-time subscriptions
```

### CI/CD Integration Example
```bash
# Validation in GitHub Actions
name: Validate ACE-Flow Project
on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install ACE-Flow
        run: npm install -g ace-flow
      - name: Run Validation
        run: /ace-validate --detailed --format=json > validation-report.json
      - name: Upload Report
        uses: actions/upload-artifact@v3
        with:
          name: validation-report
          path: validation-report.json
```

### Validation Report Examples
```bash
# Generate detailed validation report
/ace-validate --detailed --format=markdown > validation-report.md

# Example output in validation-report.md:
# ACE-Flow Validation Report
## Project Summary
- **Name**: fitness-tracker
- **Pattern**: social_platform  
- **Status**: READY WITH WARNINGS
- **Quality Score**: 8.7/10

## Validation Results
### ✅ Passed (18 checks)
- Authentication properly configured
- Data schema valid and optimized
- File storage permissions correct
- API endpoints secured
- Real-time subscriptions working

### ⚠️ Warnings (3 items)
- Consider enabling MFA for production
- Add rate limiting to API endpoints
- Optimize image sizes for mobile

### 🎯 Recommendations
1. Performance optimization available
2. Security hardening suggested
3. Mobile experience can be improved
```

## Best Practices

1. **Run before implementation**: Always validate after genesis/research
2. **Fix critical issues first**: Address ❌ before ⚠️
3. **Document exceptions**: Some warnings may be intentional
4. **Automate validation**: Include in CI/CD pipeline
5. **Regular checks**: Run periodically during development

## 📊 Specification Compliance Validation

### Pre-Deploy Compliance Check
```bash
# Comprehensive compliance validation before deployment
/ace-validate --pre-deploy

📊 Pre-Deployment Compliance Check
================================

## Technical Validation: ✅ PASSED
- AWS Configuration: ✅ Valid
- Dependencies: ✅ Up to date  
- Schema: ✅ No errors
- Security: ✅ All checks passed

## Specification Compliance: ⚠️ 87% (Below 90% threshold)
- User Stories: 92% ✅ (23/25 implemented)
- Acceptance Criteria: 85% ⚠️ (34/40 met)
- Technical Architecture: 90% ✅
- Test Coverage: 80% ⚠️

❌ DEPLOYMENT BLOCKED: Compliance below 90% threshold

Critical Issues:
1. Missing real-time workout sharing feature (User Story #12)
2. 6 acceptance criteria not implemented
3. Test coverage gaps in social features

Recommended Actions:
- Implement missing features or update specifications
- Run '/ace-spec-check --fix-drift' to resolve deviations
- Achieve 90%+ compliance before deployment
```

### Specification-Only Validation
```bash
# Focus only on specification compliance
/ace-validate --specs

📋 Specification Compliance Validation
=====================================

## Genesis Requirements Analysis: ✅
- Original specifications found: 2025-01-15 09:15:00
- User stories: 25 total, 23 implemented
- Acceptance criteria: 40 total, 34 met
- Architecture pattern: social_platform ✅

## Implementation vs Specification:

### ✅ Fully Compliant Features:
├── User authentication (100%)
├── User profiles (100%) 
├── Workout logging (100%)
├── Data persistence (100%)
└── Security implementation (95%)

### ⚠️ Partially Compliant Features:
├── Social features (60% - missing real-time sharing)
├── Notification system (40% - basic only, no push)
├── Data export (80% - missing advanced formats)
└── Mobile optimization (70% - responsive but not native)

### ❌ Non-Compliant Features:
├── Real-time workout sharing (0% - not implemented)
├── Offline synchronization (0% - not implemented)
└── Advanced analytics (0% - basic metrics only)

### 🆕 Extra Features (Not in Original Specs):
├── Premium subscription system (fully implemented)
├── Enhanced user profiles (social media links)
└── Workout streak tracking (gamification)

## Test-Specification Alignment: 80%
- Tests covering acceptance criteria: 32/40 (80%)
- Missing critical test coverage:
  * Real-time sync functionality
  * Offline data handling
  * Premium feature boundaries
  * Social interaction workflows

## Compliance Trend: ↘ Declining
- Week 1: 100% (genesis completion)
- Week 2: 95% (minor deviations)
- Week 3: 89% (scope additions)
- Week 4: 87% (feature delays)

## Recommendations:
1. 🔥 CRITICAL: Address missing real-time features
2. ⚠️ UPDATE: Incorporate premium features into specifications
3. 📝 ALIGN: Update specs to reflect current architecture decisions
4. 🧪 TEST: Add missing test coverage for acceptance criteria
```

### Smart Hook Integration
The validation system now integrates with smart hooks for automated compliance checking:

```yaml
smart_hooks:
  pre_commit_compliance:
    trigger: "Before git commit"
    action: "/ace-validate --specs --quick"
    threshold: "85% minimum compliance"
    auto_fix: "Suggest specification updates for new features"
    
  pre_deploy_gate:
    trigger: "Before deployment"
    action: "/ace-validate --pre-deploy"
    threshold: "90% compliance required"
    block_deployment: true
    notifications: ["team@company.com"]
    
  weekly_compliance_review:
    trigger: "Weekly schedule (Mondays)"
    action: "/ace-validate --specs --report"
    stakeholders: ["product-manager", "tech-lead"]
    trend_analysis: true
```

### Integration with ace-spec-check
```bash
# Combined validation and specification check
/ace-validate --with-spec-check

This command combines technical validation with specification compliance:
1. Runs all technical validations (AWS, dependencies, schema)
2. Performs comprehensive specification compliance check
3. Provides unified report with actionable recommendations
4. Suggests fixes for both technical and compliance issues

Quick Actions Available:
- Fix technical issues automatically
- Update specifications interactively
- Generate compliance improvement plan
- Schedule specification review meeting
```

### Compliance Gating
The validation system now supports compliance-based deployment gating:

```yaml
deployment_gates:
  development:
    minimum_compliance: "70%"
    block_on_critical: true
    
  staging:
    minimum_compliance: "85%"
    require_test_coverage: "80%"
    
  production:
    minimum_compliance: "95%"
    require_stakeholder_approval: true
    require_full_test_coverage: "90%"
    security_scan_required: true
```

---

*ACE-Validate: Enhanced with Kiro-style accountability - ensuring specs and code stay aligned! 🛡️📊*