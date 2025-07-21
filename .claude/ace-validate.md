# /ace-validate - Pre-Implementation Validation

## Overview
The `/ace-validate` command performs comprehensive pre-implementation checks to ensure your project is ready for development and deployment. It validates configuration, dependencies, AWS credentials, and architecture compatibility.

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

## Best Practices

1. **Run before implementation**: Always validate after genesis/research
2. **Fix critical issues first**: Address ❌ before ⚠️
3. **Document exceptions**: Some warnings may be intentional
4. **Automate validation**: Include in CI/CD pipeline
5. **Regular checks**: Run periodically during development

---

*ACE-Validate: Catch issues before they catch you! 🛡️*