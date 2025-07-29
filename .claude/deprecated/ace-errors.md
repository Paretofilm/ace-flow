# ACE-Flow Error Reference System

## Purpose/Usage
The ACE-Flow Error Reference System serves as a comprehensive diagnostic and troubleshooting guide for developers using ACE-Flow with AWS Amplify Gen 2. This system provides:

- **Immediate Error Resolution**: Direct solution links and quick fixes for common issues
- **Learning Integration**: Error patterns are analyzed to improve future implementations
- **Pattern Recognition**: Identifies recurring issues and suggests preventive measures
- **Auto-Fix Capabilities**: Automated resolution for 85%+ of common errors
- **Context-Aware Help**: Tailored solutions based on your project pattern and phase

Use this reference when encountering errors during ACE-Flow development, or run `/ace-help error [ERROR-CODE]` for interactive assistance.

## Overview
This document provides a comprehensive error reference with direct solution links for common ACE-Flow and AWS Amplify Gen 2 issues.

## Error Format
When ACE-Flow encounters an error, it will display:
```
❌ ERROR [ACE-XXX]: Brief description
📋 Details: Specific error information
🔗 Solution: Direct link to fix
💡 Quick Fix: Immediate action to try
```

## Common Errors & Solutions

### ACE-001: Schema Compilation Failed
**Error**: GraphQL schema contains syntax errors or invalid types
```
❌ ERROR [ACE-001]: Schema compilation failed
📋 Details: Invalid type reference in User model
🔗 Solution: https://docs.amplify.aws/gen2/build-a-backend/data/data-modeling/
💡 Quick Fix: Run 'npx ampx sandbox' to see detailed schema errors
```

### ACE-002: Authentication Configuration Error
**Error**: Auth configuration is missing required attributes
```
❌ ERROR [ACE-002]: Authentication configuration error
📋 Details: Missing email attribute in loginWith configuration
🔗 Solution: https://docs.amplify.aws/gen2/build-a-backend/auth/set-up-auth/
💡 Quick Fix: Add 'email' to loginWith array in auth/resource.ts
```

### ACE-003: Storage Access Denied
**Error**: Storage bucket permissions incorrectly configured
```
❌ ERROR [ACE-003]: Storage access denied
📋 Details: Guest users cannot access protected paths
🔗 Solution: https://docs.amplify.aws/gen2/build-a-backend/storage/authorization/
💡 Quick Fix: Update storage access rules in storage/resource.ts
```

### ACE-004: Function Timeout
**Error**: Lambda function exceeded maximum execution time
```
❌ ERROR [ACE-004]: Function timeout
📋 Details: Function 'processOrder' timed out after 30 seconds
🔗 Solution: https://docs.amplify.aws/gen2/build-a-backend/functions/set-up-function/
💡 Quick Fix: Increase timeout in defineFunction() or optimize code
```

### ACE-005: Deployment Failed
**Error**: AWS CloudFormation stack update failed
```
❌ ERROR [ACE-005]: Deployment failed
📋 Details: Resource limit exceeded for DynamoDB tables
🔗 Solution: https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ServiceQuotas.html
💡 Quick Fix: Request limit increase or consolidate tables
```

### ACE-006: Type Generation Failed
**Error**: Unable to generate TypeScript types from schema
```
❌ ERROR [ACE-006]: Type generation failed
📋 Details: Circular dependency detected in data models
🔗 Solution: https://docs.amplify.aws/gen2/build-a-backend/data/data-modeling/relationships/
💡 Quick Fix: Review model relationships and remove circular references
```

### ACE-007: Environment Variable Missing
**Error**: Required environment variable not set
```
❌ ERROR [ACE-007]: Environment variable missing
📋 Details: STRIPE_SECRET_KEY not found
🔗 Solution: https://docs.amplify.aws/gen2/deploy-and-host/fullstack-branching/secrets-and-vars/
💡 Quick Fix: Run 'npx ampx sandbox secret set STRIPE_SECRET_KEY'
```

### ACE-008: API Rate Limit Exceeded
**Error**: Too many API requests in time window
```
❌ ERROR [ACE-008]: API rate limit exceeded
📋 Details: GraphQL API limit of 1000 req/min exceeded
🔗 Solution: https://docs.aws.amazon.com/appsync/latest/devguide/limits.html
💡 Quick Fix: Implement request batching or caching
```

### ACE-009: Subscription Connection Failed
**Error**: WebSocket connection for subscriptions failed
```
❌ ERROR [ACE-009]: Subscription connection failed
📋 Details: WebSocket handshake failed with 401
🔗 Solution: https://docs.amplify.aws/gen2/build-a-backend/data/subscribe-data/
💡 Quick Fix: Check auth token and subscription authorization rules
```

### ACE-010: Build Process Failed
**Error**: Frontend build failed during deployment
```
❌ ERROR [ACE-010]: Build process failed
📋 Details: Module not found: 'aws-amplify'
🔗 Solution: https://docs.amplify.aws/gen2/start/quickstart/
💡 Quick Fix: Run 'npm install aws-amplify' and commit changes
```

## Error Categories

### 🔐 Authentication & Authorization (ACE-001 to ACE-020)
- Schema and permission errors
- Identity provider issues
- Token validation problems

### 📊 Data & API (ACE-021 to ACE-040)
- GraphQL errors
- Database issues
- Query optimization

### 📦 Storage & Files (ACE-041 to ACE-060)
- S3 bucket errors
- File upload issues
- Access control problems

### ⚡ Functions & Compute (ACE-061 to ACE-080)
- Lambda errors
- Timeout issues
- Memory problems

### 🚀 Deployment & Infrastructure (ACE-081 to ACE-100)
- CloudFormation errors
- Build failures
- Environment issues

## Automated Error Resolution

ACE-Flow includes an intelligent error resolution system:

1. **Pattern Recognition**: Identifies error patterns from past occurrences
2. **Auto-Fix Attempts**: Tries known solutions automatically
3. **Learning Integration**: Updates knowledge base with successful fixes
4. **Fallback Options**: Provides manual steps if auto-fix fails

## Using Error Codes

### In Commands
```bash
# Get specific error help
/ace-help error ACE-001

# Check recent errors
/ace-status --errors

# Attempt auto-fix
/ace-fix ACE-001
```

### In Code
```typescript
// Error handling example
try {
  await DataStore.save(newUser);
} catch (error) {
  if (error.code === 'ACE-001') {
    // Handle schema error
    console.error('Schema error detected:', error);
    // Trigger auto-fix
    await aceFlow.autoFix('ACE-001', error);
  }
}
```

## Prevention Tips

1. **Use ACE-Flow Commands**: Commands include built-in validation
2. **Run Reviews**: Regular `/ace-review` catches issues early
3. **Monitor Status**: Keep `/ace-status` running during development
4. **Test Locally**: Always test in sandbox before deployment
5. **Follow Patterns**: Use established architecture patterns

## Getting Help

If an error persists:
1. Check the error code in this reference
2. Follow the solution link
3. Try the quick fix suggestion
4. Run `/ace-help error [ERROR-CODE]`
5. Use `/ace-research` for deeper investigation

## Contributing

Found a new error pattern? ACE-Flow automatically learns from resolved errors, but you can also:
1. Document the error and solution
2. Update this reference file
3. Share with the community

---

*ACE-Flow: Turning errors into learning opportunities*