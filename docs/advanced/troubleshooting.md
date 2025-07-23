---
layout: docs
title: Troubleshooting
---

# Troubleshooting

Common issues and solutions when working with ACE-Flow and AWS Amplify Gen 2.

## Quick Fixes

### Installation Issues

#### ACE-Flow Commands Not Found

**Problem**: `/ace-genesis` or other commands return "command not found"

**Solution**:
```bash
# Re-install ACE-Flow aliases
/ace-flow-install --update

# Or manually source the aliases
source ~/.claude/ace-aliases.sh

# Check if aliases are loaded
alias | grep ace
```

#### Permission Denied Errors

**Problem**: Cannot execute ACE-Flow scripts

**Solution**:
```bash
# Make scripts executable
chmod +x .ace-flow/scripts/*.sh
chmod +x ~/.claude/*.sh

# Fix ownership if needed
sudo chown -R $USER ~/.claude/
```

### AWS Amplify Issues

#### Authentication Failures

**Problem**: AWS credentials not configured or expired

**Solution**:
```bash
# Configure AWS CLI
aws configure

# Or use AWS SSO
aws sso login --profile your-profile

# Verify credentials
aws sts get-caller-identity
```

#### Sandbox Deployment Failures

**Problem**: `npx amplify sandbox` fails to deploy

**Solutions**:

1. **Check AWS Region**:
```bash
# Verify region is supported
aws ec2 describe-regions --output table

# Set region explicitly
export AWS_DEFAULT_REGION=us-east-1
```

2. **Clean and Retry**:
```bash
# Delete existing sandbox
npx amplify sandbox delete --yes

# Clear Amplify cache
rm -rf .amplify/
rm -rf node_modules/.cache/

# Reinstall and retry
npm install
npx amplify sandbox
```

3. **Check Service Quotas**:
```bash
# List DynamoDB tables (limit 256)
aws dynamodb list-tables

# List Lambda functions (limit varies by region)
aws lambda list-functions
```

#### Schema Generation Errors

**Problem**: GraphQL schema fails to generate

**Solution**:
```bash
# Force regeneration
npx amplify generate graphql-client-code --force

# Check for syntax errors in schema
npx amplify sandbox --verbose

# Reset schema cache
rm -rf .amplify/generated/
```

### Frontend Issues

#### TypeScript Errors

**Problem**: Type errors after schema changes

**Solution**:
```bash
# Regenerate types
npx amplify generate graphql-client-code

# Clear TypeScript cache
rm -rf .tsbuildinfo
rm -rf dist/

# Restart TypeScript service in VS Code
# Command Palette -> "TypeScript: Restart TS Server"
```

#### Build Failures

**Problem**: `npm run build` fails with dependency errors

**Solution**:
```bash
# Clear package cache
npm cache clean --force

# Delete and reinstall dependencies
rm -rf node_modules package-lock.json
npm install

# Check for peer dependency conflicts
npm ls --depth=0
```

#### Real-time Subscription Issues

**Problem**: GraphQL subscriptions not working

**Solutions**:

1. **Check WebSocket Connections**:
```javascript
// Enable debug logging
import { Amplify } from 'aws-amplify';

Amplify.configure({
  ...amplifyconfig,
  API: {
    ...amplifyconfig.API,
    GraphQL: {
      ...amplifyconfig.API.GraphQL,
      defaultAuthMode: 'apiKey', // or 'userPool'
    }
  }
});
```

2. **Verify Authorization**:
```javascript
// Check subscription authorization
const subscription = client.models.Post.observeQuery().subscribe({
  next: (snapshot) => console.log(snapshot),
  error: (error) => console.error('Subscription error:', error)
});
```

## Advanced Debugging

### Enable Verbose Logging

```bash
# Amplify CLI debug mode
DEBUG=amplify* npx amplify sandbox

# AWS SDK debug
export AWS_SDK_JS_SUPPRESS_MAINTENANCE_MODE_MESSAGE=1
export DEBUG=aws-amplify*
```

### Check CloudFormation Stacks

```bash
# List Amplify stacks
aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE

# Describe specific stack
aws cloudformation describe-stacks --stack-name amplify-[project-name]-[branch]-[id]

# Check stack events for errors
aws cloudformation describe-stack-events --stack-name [stack-name]
```

### Monitor CloudWatch Logs

```bash
# List log groups
aws logs describe-log-groups --log-group-name-prefix /aws/lambda/

# Stream logs in real-time
aws logs tail /aws/lambda/[function-name] --follow
```

## Performance Issues

### Slow GraphQL Queries

**Problem**: Queries taking too long to execute

**Solutions**:

1. **Add Indexes**:
```typescript
// Add secondary indexes to your schema
export const schema = a.schema({
  Post: a.model({
    title: a.string(),
    authorId: a.id(),
    createdAt: a.datetime(),
    // Add index for common query patterns
  }).secondaryIndexes(index => [
    index('authorId').sortKeys(['createdAt']).name('byAuthor'),
    index('createdAt').name('byDate')
  ])
});
```

2. **Optimize Queries**:
```javascript
// Use specific fields instead of fetching all
const posts = await client.models.Post.list({
  selectionSet: ['id', 'title', 'createdAt'],
  limit: 20
});

// Use pagination
const posts = await client.models.Post.list({
  limit: 10,
  nextToken: lastToken
});
```

3. **Enable Caching**:
```javascript
import { generateClient } from 'aws-amplify/api';

const client = generateClient({
  cachingPolicy: {
    ttl: 300000, // 5 minutes
    policy: 'cache-first'
  }
});
```

### High AWS Costs

**Problem**: Unexpected AWS charges

**Solutions**:

1. **Monitor Usage**:
```bash
# Check DynamoDB usage
aws dynamodb describe-table --table-name [table-name]

# Monitor Lambda invocations
aws logs filter-log-events --log-group-name /aws/lambda/[function-name] --start-time $(date -d '1 day ago' +%s)000
```

2. **Optimize DynamoDB**:
```typescript
// Use on-demand billing for dev environments
// Set up auto-scaling for production
export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'apiKey'
  }
});
```

3. **Clean Up Resources**:
```bash
# Delete unused sandboxes
npx amplify sandbox delete

# Remove old CloudFormation stacks
aws cloudformation delete-stack --stack-name [old-stack-name]
```

## Common Error Messages

### "AccessDenied" Errors

**Error**: `User: arn:aws:iam::account:user/username is not authorized to perform: action`

**Solution**:
```bash
# Check IAM permissions
aws iam get-user-policy --user-name [username] --policy-name [policy-name]

# Attach required policies
aws iam attach-user-policy --user-name [username] --policy-arn arn:aws:iam::aws:policy/AmplifyBackendDeployFullAccess
```

### "ValidationException" in DynamoDB

**Error**: `ValidationException: One or more parameter values were invalid`

**Solution**:
```javascript
// Check data types match schema
const result = await client.models.User.create({
  name: "John Doe",        // String
  age: 30,                 // Number, not string
  isActive: true,          // Boolean, not string
  createdAt: new Date()    // Date object, not string
});
```

### "NetworkingError" in GraphQL

**Error**: `NetworkingError: Network request failed`

**Solutions**:

1. **Check Endpoint URL**:
```javascript
// Verify amplify_outputs.json has correct endpoint
console.log(amplifyconfig.API.GraphQL.endpoint);
```

2. **CORS Issues**:
```typescript
// Add CORS headers to Lambda functions
export const handler = async (event) => {
  return {
    statusCode: 200,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "*",
      "Access-Control-Allow-Methods": "*"
    },
    body: JSON.stringify(response)
  };
};
```

### "ResourceNotFound" Errors

**Error**: `ResourceNotFoundException: Table not found`

**Solution**:
```bash
# Verify table exists
aws dynamodb list-tables

# Check if sandbox is running
npx amplify sandbox status

# Redeploy if necessary
npx amplify sandbox delete
npx amplify sandbox
```

## Migration Issues

### Schema Breaking Changes

**Problem**: Existing data incompatible with new schema

**Solution**:
```bash
# Create data migration script
node scripts/migrate-data.js

# Use gradual rollout
/ace-migrate --strategy=blue-green
```

### Authentication Migration

**Problem**: Users can't login after Cognito migration

**Solution**:
```javascript
// Implement fallback authentication
const authenticateUser = async (email, password) => {
  try {
    // Try new Cognito auth first
    const user = await signIn({ username: email, password });
    return user;
  } catch (error) {
    // Fallback to legacy auth
    return await legacyAuth(email, password);
  }
};
```

## Development Workflow Issues

### Git Conflicts in Generated Files

**Problem**: Merge conflicts in `.amplify/` or `amplify_outputs.json`

**Solution**:
```bash
# Add to .gitignore
echo ".amplify/" >> .gitignore
echo "amplify_outputs.json" >> .gitignore

# Regenerate after merge
npx amplify generate outputs
```

### Environment Mismatches

**Problem**: Different behavior between local and production

**Solution**:
```bash
# Use environment-specific configs
cp amplify_outputs.production.json amplify_outputs.json

# Set environment variables
export NODE_ENV=production
export AMPLIFY_ENV=production
```

## Getting Help

### Debug Information to Collect

When seeking help, include:

```bash
# System information
node --version
npm --version
npx amplify --version

# Project information
cat package.json | grep -A 20 '"dependencies"'
cat amplify_outputs.json | jq '.API.GraphQL.endpoint'

# Error logs
tail -50 ~/.npm/_logs/*.log
```

### Community Resources

- **Discord**: [ACE-Flow Community](https://discord.gg/ace-flow)
- **GitHub Issues**: [Report Bugs](https://github.com/ace-flow/ace-flow/issues)
- **Stack Overflow**: Tag questions with `ace-flow` and `aws-amplify`
- **AWS Forums**: [Amplify Community](https://forum.amplify.aws/)

### Professional Support

- **ACE-Flow Support**: [support@ace-flow.dev](mailto:support@ace-flow.dev)
- **AWS Support**: Available with AWS support plans
- **Consulting**: [Schedule consultation](https://ace-flow.dev/consulting)

## Preventive Measures

### Pre-deployment Checklist

- [ ] Run `/ace-validate` before deploying
- [ ] Test in sandbox environment first
- [ ] Check AWS service quotas
- [ ] Verify IAM permissions
- [ ] Review estimated costs with `/ace-cost`
- [ ] Backup existing data
- [ ] Plan rollback strategy

### Monitoring Setup

```bash
# Set up CloudWatch alarms
/ace-monitor --setup-alerts

# Enable AWS X-Ray tracing
/ace-enable-tracing

# Configure error reporting
/ace-setup-error-tracking
```

---

*Still having issues? Check our [FAQ](https://docs.ace-flow.dev/faq) or reach out to the community for help.*