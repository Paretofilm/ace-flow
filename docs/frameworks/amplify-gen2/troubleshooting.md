# AWS Amplify Gen 2 Troubleshooting

**Common issues, solutions, and debugging techniques for AWS Amplify Gen 2 applications.**

## 📋 Table of Contents

- [Build & Deployment Issues](#build--deployment-issues)
- [Authentication Problems](#authentication-problems)
- [GraphQL & Data Issues](#graphql--data-issues)
- [Storage Problems](#storage-problems)
- [Local Development Issues](#local-development-issues)
- [Performance Issues](#performance-issues)
- [Configuration Problems](#configuration-problems)
- [Debugging Tools](#debugging-tools)

## 🏗️ Build & Deployment Issues

### Build Fails with TypeScript Errors

**Problem**: TypeScript compilation fails during build
```bash
Error: Type 'Schema' is not assignable to type 'ClientSchema'
```

**Solutions**:
```bash
# 1. Regenerate types after schema changes
npx ampx generate --branch local

# 2. Clear Next.js cache
rm -rf .next
npm run build

# 3. Ensure correct imports
```

```typescript
// Correct import
import type { Schema } from '@/amplify/data/resource';
// Not: import { Schema } from '@/amplify/data/resource';
```

### Deployment Hangs or Fails

**Problem**: Amplify deployment gets stuck or fails
```bash
Error: Stack deployment failed
```

**Solutions**:
```bash
# 1. Check CloudFormation console for detailed errors
# 2. Delete and recreate sandbox
npx ampx sandbox delete
npx ampx sandbox

# 3. Check AWS region and permissions
aws sts get-caller-identity

# 4. Validate amplify_outputs.json
cat amplify_outputs.json | jq .
```

### Environment Variables Not Working

**Problem**: Environment variables undefined in deployed app

**Solutions**:
1. **Check Environment Configuration**:
```bash
# Verify in Amplify Console > App > Environment variables
# Ensure NEXT_PUBLIC_ prefix for client-side variables
```

2. **Update Build Settings**:
```yaml
# amplify.yml
version: 1
applications:
  - frontend:
      phases:
        preBuild:
          commands:
            - export NEXT_PUBLIC_API_URL=$API_URL
```

## 🔐 Authentication Problems

### Sign-in Not Working

**Problem**: Users cannot sign in or get authentication errors

**Solutions**:

1. **Check User Pool Configuration**:
```typescript
// Verify auth configuration
import { fetchAuthSession } from 'aws-amplify/auth';

const session = await fetchAuthSession();
console.log('Auth session:', session);
```

2. **CORS Issues**:
```typescript
// Update auth resource
export const auth = defineAuth({
  loginWith: {
    email: true,
  },
  // Add allowed origins
  callbackUrls: [
    'http://localhost:3000',
    'https://yourapp.amplifyapp.com'
  ],
  logoutUrls: [
    'http://localhost:3000',
    'https://yourapp.amplifyapp.com'
  ],
});
```

### Social Login Not Working

**Problem**: Google/Facebook/Apple sign-in fails

**Solutions**:
```typescript
// 1. Verify provider configuration
export const auth = defineAuth({
  loginWith: {
    email: true,
    externalProviders: {
      google: {
        clientId: process.env.GOOGLE_CLIENT_ID!,
        clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
        // Ensure correct redirect URIs in Google Console
      },
    },
  },
});

// 2. Check environment variables
console.log('Google Client ID:', process.env.GOOGLE_CLIENT_ID);
```

### Token Expiration Issues

**Problem**: Users get logged out unexpectedly

**Solutions**:
```typescript
// 1. Handle token refresh
import { fetchAuthSession } from 'aws-amplify/auth';

try {
  const session = await fetchAuthSession({ forceRefresh: true });
} catch (error) {
  // Handle re-authentication
  signOut();
}

// 2. Implement token refresh logic
useEffect(() => {
  const interval = setInterval(async () => {
    try {
      await fetchAuthSession({ forceRefresh: true });
    } catch (error) {
      console.error('Token refresh failed:', error);
    }
  }, 15 * 60 * 1000); // Refresh every 15 minutes

  return () => clearInterval(interval);
}, []);
```

## 📊 GraphQL & Data Issues

### GraphQL Schema Errors

**Problem**: Schema validation fails or types are incorrect

**Solutions**:
```bash
# 1. Validate schema syntax
npx ampx generate --branch local

# 2. Check for circular references
# 3. Ensure proper authorization rules
```

```typescript
// Common schema issues:
const schema = a.schema({
  Todo: a
    .model({
      content: a.string(),
      // Missing required authorization
    })
    .authorization((allow) => [allow.owner()]), // Add this
});
```

### CORS Errors in GraphQL

**Problem**: GraphQL requests fail with CORS errors

**Solutions**:
```typescript
// Update data resource CORS configuration
export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
  },
  cors: {
    allowOrigins: [
      'http://localhost:3000',
      'https://yourapp.amplifyapp.com'
    ],
    allowHeaders: [
      'Content-Type',
      'Authorization',
      'X-Api-Key',
    ],
    allowMethods: ['GET', 'POST', 'OPTIONS'],
    allowCredentials: true,
  },
});
```

### Subscription Not Working

**Problem**: Real-time subscriptions don't receive updates

**Solutions**:
```typescript
// 1. Check authorization on subscription
client.models.Todo.observeQuery({
  authMode: 'userPool', // Ensure correct auth mode
}).subscribe({
  next: (data) => console.log('Subscription data:', data),
  error: (error) => console.error('Subscription error:', error),
});

// 2. Verify WebSocket connection
// Check browser network tab for WebSocket connection

// 3. Test with different authorization modes
const subscription = client.models.Todo.observeQuery({
  authMode: 'apiKey', // Try different auth modes
});
```

## 📁 Storage Problems

### File Upload Fails

**Problem**: Unable to upload files to S3

**Solutions**:
```typescript
// 1. Check storage configuration
import { uploadData } from 'aws-amplify/storage';

try {
  const result = await uploadData({
    key: 'my-file.jpg',
    data: file,
    options: {
      accessLevel: 'guest', // or 'protected', 'private'
    }
  });
} catch (error) {
  console.error('Upload failed:', error);
  // Check S3 permissions and CORS
}

// 2. Verify storage resource configuration
export const storage = defineStorage({
  name: 'myStorage',
  access: (allow) => ({
    'public/*': [allow.guest.to(['read', 'write'])],
  }),
});
```

### File Download Issues

**Problem**: Cannot download or display uploaded files

**Solutions**:
```typescript
// 1. Check file permissions and path
import { getUrl } from 'aws-amplify/storage';

try {
  const signedURL = await getUrl({
    key: 'my-file.jpg',
    options: {
      accessLevel: 'guest', // Match upload access level
      expiresIn: 3600, // 1 hour
    }
  });
} catch (error) {
  console.error('Get URL failed:', error);
}

// 2. Verify S3 bucket policy
```

## 💻 Local Development Issues

### Sandbox Won't Start

**Problem**: `npx ampx sandbox` fails or hangs

**Solutions**:
```bash
# 1. Clear existing sandbox
npx ampx sandbox delete

# 2. Check AWS credentials
aws configure list

# 3. Verify AWS CLI version
aws --version

# 4. Check for port conflicts
lsof -i :3000

# 5. Clear npm/node cache
npm cache clean --force
rm -rf node_modules
npm install
```

### Hot Reload Not Working

**Problem**: Changes don't reflect in development

**Solutions**:
```bash
# 1. Restart development server
npm run dev

# 2. Clear Next.js cache
rm -rf .next

# 3. Check file watching limits (Linux/Mac)
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

### Types Not Updating

**Problem**: TypeScript types don't reflect schema changes

**Solutions**:
```bash
# 1. Force regeneration
npx ampx generate --branch local --force

# 2. Restart TypeScript server in VS Code
# Command Palette > "TypeScript: Restart TS Server"

# 3. Check amplify_outputs.json
cat amplify_outputs.json

# 4. Verify import paths
import type { Schema } from '@/amplify/data/resource';
```

## ⚡ Performance Issues

### Slow GraphQL Queries

**Problem**: Queries take too long to execute

**Solutions**:
```typescript
// 1. Add pagination
const todos = await client.models.Todo.list({
  limit: 20,
  nextToken: pageToken,
});

// 2. Use selective querying
const todos = await client.models.Todo.list({
  selectionSet: ['id', 'content', 'done'], // Only fetch needed fields
});

// 3. Implement caching
const [todos, setTodos] = useState([]);
const [isLoading, setIsLoading] = useState(false);

useEffect(() => {
  const fetchTodos = async () => {
    if (todos.length === 0) { // Simple cache check
      setIsLoading(true);
      const result = await client.models.Todo.list();
      setTodos(result.data);
      setIsLoading(false);
    }
  };
  
  fetchTodos();
}, [todos.length]);
```

### Bundle Size Too Large

**Problem**: Application bundle is too large

**Solutions**:
```javascript
// next.config.js - Optimize bundle
const nextConfig = {
  webpack: (config, { isServer }) => {
    if (!isServer) {
      config.optimization.splitChunks = {
        chunks: 'all',
        cacheGroups: {
          amplify: {
            test: /[\\/]node_modules[\\/](aws-amplify|@aws-amplify)[\\/]/,
            name: 'amplify',
            chunks: 'all',
            priority: 10,
            reuseExistingChunk: true,
          },
        },
      };
    }
    return config;
  },
  // Tree shake unused code
  experimental: {
    optimizePackageImports: ['aws-amplify'],
  },
};
```

## ⚙️ Configuration Problems

### Amplify Outputs Missing

**Problem**: `amplify_outputs.json` not found or corrupted

**Solutions**:
```bash
# 1. Regenerate outputs
npx ampx generate --branch local

# 2. Check sandbox status
npx ampx sandbox

# 3. Validate JSON format
cat amplify_outputs.json | jq .

# 4. Check file permissions
ls -la amplify_outputs.json
```

### Environment Mismatch

**Problem**: Different behavior between local and deployed app

**Solutions**:
```typescript
// 1. Check environment detection
console.log('Environment:', process.env.NODE_ENV);
console.log('AWS Branch:', process.env.AWS_BRANCH);

// 2. Verify outputs match environment
import outputs from '@/amplify_outputs.json';
console.log('API Endpoint:', outputs.data.url);

// 3. Use environment-specific configuration
const isProduction = process.env.NODE_ENV === 'production';
const apiEndpoint = isProduction 
  ? outputs.data.url 
  : 'http://localhost:20002/graphql';
```

## 🔧 Debugging Tools

### Enable Debug Logging

```typescript
// Enable Amplify debug logging
import { Amplify } from 'aws-amplify';

if (process.env.NODE_ENV === 'development') {
  Amplify.configure(outputs, {
    ssr: true,
    logging: {
      level: 'DEBUG',
      logger: console,
    },
  });
}
```

### Browser Developer Tools

1. **Network Tab**: Check GraphQL requests and responses
2. **Console**: Look for Amplify debug messages
3. **Application Tab**: Inspect localStorage for auth tokens
4. **WebSocket**: Monitor subscription connections

### AWS CloudWatch

```bash
# View CloudFormation events
aws cloudformation describe-stack-events --stack-name <stack-name>

# Check Lambda logs
aws logs describe-log-groups --log-group-name-prefix /aws/lambda/
```

### Command Line Debugging

```bash
# Verbose Amplify commands
npx ampx sandbox --debug
npx ampx generate --debug

# AWS CLI debugging
aws configure set cli_follow_redirects true
aws configure set default.debug true
```

## 📞 Getting Help

### Community Resources

- **Amplify Discord**: [https://discord.gg/amplify](https://discord.gg/amplify)
- **GitHub Issues**: [https://github.com/aws-amplify/amplify-js](https://github.com/aws-amplify/amplify-js)
- **AWS Forums**: [https://forums.aws.amazon.com/forum.jspa?forumID=189](https://forums.aws.amazon.com/forum.jspa?forumID=189)

### Documentation

- **Official Docs**: [https://docs.amplify.aws/](https://docs.amplify.aws/)
- **API Reference**: [https://aws-amplify.github.io/amplify-js/](https://aws-amplify.github.io/amplify-js/)
- **Examples**: [https://github.com/aws-amplify/amplify-js-samples](https://github.com/aws-amplify/amplify-js-samples)

### Support Options

- **AWS Support**: For production issues with AWS services
- **Community Support**: Discord, GitHub, Stack Overflow
- **Professional Services**: AWS Professional Services for architecture guidance

---

*Last Updated: 2025-07-21*  
*Version: Amplify Gen 2.x*  
*Need more help? Join the [Amplify Discord](https://discord.gg/amplify)*