# AWS Amplify Gen 2 Configuration

**Complete guide to configuring AWS Amplify Gen 2 projects for optimal development and deployment.**

## 📋 Configuration Overview

AWS Amplify Gen 2 uses a modern, TypeScript-based configuration approach that provides type safety and improved developer experience.

## 🚀 Environment Configuration

### Development Environment

```bash
# Install dependencies
npm install

# Start local development sandbox
npx ampx sandbox

# Generate types from backend schema  
npx ampx generate
```

### Environment Variables

Create `.env.local` for development-specific configuration:

```env
# Development environment
AMPLIFY_ENV=development

# Optional: Custom GraphQL endpoint
AMPLIFY_GRAPHQL_ENDPOINT=https://your-custom-endpoint.com/graphql

# Optional: Custom region
AWS_REGION=us-east-1
```

## ⚙️ Backend Configuration

### Core Backend Setup

```typescript
// amplify/backend.ts
import { defineBackend } from '@aws-amplify/backend';
import { auth } from './auth/resource';
import { data } from './data/resource';
import { storage } from './storage/resource';

const backend = defineBackend({
  auth,
  data,
  storage,
});

// Configure additional resources
backend.addOutput({
  custom: {
    region: backend.auth.resources.userPool.stack.region,
  }
});
```

### Schema Configuration

```typescript
// amplify/data/resource.ts
import { type ClientSchema, a, defineData } from '@aws-amplify/backend';

const schema = a.schema({
  // Configure models with proper authorization
  Todo: a
    .model({
      content: a.string().required(),
      done: a.boolean().default(false),
      priority: a.enum(['LOW', 'MEDIUM', 'HIGH']),
      createdAt: a.datetime(),
    })
    .authorization((allow) => [
      allow.owner(),
      allow.group('admins')
    ]),
});

export type Schema = ClientSchema<typeof schema>;
export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
    // Enable API key for public access if needed
    apiKeyAuthorizationMode: {
      expiresInDays: 30,
    },
  },
});
```

## 🔐 Authentication Configuration

### Basic Auth Setup

```typescript
// amplify/auth/resource.ts
import { defineAuth } from '@aws-amplify/backend';

export const auth = defineAuth({
  loginWith: {
    email: true,
    phone: false,
  },
  userAttributes: {
    preferredUsername: {
      required: true,
      mutable: true,
    },
    profilePicture: {
      required: false,
      mutable: true,
    },
  },
});
```

### Social Login Configuration

```typescript
// amplify/auth/resource.ts (extended)
export const auth = defineAuth({
  loginWith: {
    email: true,
    externalProviders: {
      google: {
        clientId: process.env.GOOGLE_CLIENT_ID!,
        clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
      },
      facebook: {
        clientId: process.env.FACEBOOK_CLIENT_ID!,
        clientSecret: process.env.FACEBOOK_CLIENT_SECRET!,
      },
      callbackUrls: [
        'http://localhost:3000/auth/callback',
        'https://yourdomain.com/auth/callback',
      ],
      logoutUrls: [
        'http://localhost:3000',
        'https://yourdomain.com',
      ],
    },
  },
});
```

## 📁 Storage Configuration

### File Upload Setup

```typescript
// amplify/storage/resource.ts
import { defineStorage } from '@aws-amplify/backend';

export const storage = defineStorage({
  name: 'amplifyTeamDrive',
  access: (allow) => ({
    'profile-pictures/*': [
      allow.authenticated.to(['read', 'write', 'delete']),
    ],
    'public/*': [
      allow.guest.to(['read']),
      allow.authenticated.to(['read', 'write', 'delete']),
    ],
  }),
});
```

## 🌐 Frontend Configuration

### React/Next.js Setup

```typescript
// src/lib/amplify-config.ts
import { Amplify } from 'aws-amplify';
import outputs from '../../amplify_outputs.json';

Amplify.configure(outputs);

export default Amplify;
```

### Client Configuration

```typescript
// src/lib/api-client.ts
import { generateClient } from 'aws-amplify/data';
import { generateClient as generateStorageClient } from 'aws-amplify/storage';
import type { Schema } from '../../amplify/data/resource';

// GraphQL client
export const client = generateClient<Schema>();

// Storage client
export const storageClient = generateStorageClient();
```

## 🚀 Deployment Configuration

### Branch-based Deployment

```yaml
# amplify.yml
version: 1
backend:
  phases:
    build:
      commands:
        - npm ci
        - npx ampx pipeline-deploy --branch $AWS_BRANCH --app-id $AWS_APP_ID
frontend:
  phases:
    preBuild:
      commands:
        - npm ci
    build:
      commands:
        - npm run build
  artifacts:
    baseDirectory: .next
    files:
      - '**/*'
  cache:
    paths:
      - node_modules/**/*
      - .next/cache/**/*
```

### Environment-specific Configuration

```typescript
// amplify/backend.ts (production)
const backend = defineBackend({
  auth,
  data,
  storage,
});

// Production-specific settings
if (process.env.NODE_ENV === 'production') {
  backend.addOutput({
    custom: {
      domainName: 'api.yourdomain.com',
      corsOrigin: 'https://yourdomain.com',
    }
  });
}
```

## 🔧 Advanced Configuration

### Custom Domain Setup

```typescript
// amplify/backend.ts
import { defineBackend } from '@aws-amplify/backend';

const backend = defineBackend({
  auth,
  data,
});

// Add custom domain configuration
backend.addOutput({
  auth: {
    aws_region: 'us-east-1',
    user_pool_id: backend.auth.resources.userPool.userPoolId,
    user_pool_client_id: backend.auth.resources.userPoolClient.userPoolClientId,
    oauth: {
      domain: 'auth.yourdomain.com',
      scope: ['email', 'openid', 'profile'],
      redirectSignIn: 'https://yourdomain.com/',
      redirectSignOut: 'https://yourdomain.com/',
      responseType: 'code',
    },
  },
});
```

### Performance Optimization

```typescript
// amplify/data/resource.ts (optimized)
const schema = a.schema({
  Todo: a
    .model({
      content: a.string().required(),
      done: a.boolean().default(false),
    })
    // Add database indexes for performance
    .secondaryIndexes((index) => [
      index('done').sortKeys(['createdAt']),
      index('userId').sortKeys(['updatedAt']),
    ])
    .authorization((allow) => [allow.owner()]),
});
```

## 🚨 Security Configuration

### API Security

```typescript
// amplify/data/resource.ts (secure)
export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
    // Remove API key for production
    // apiKeyAuthorizationMode: undefined,
  },
});
```

### CORS Configuration

```typescript
// amplify/backend.ts
backend.addOutput({
  storage: {
    aws_region: 'us-east-1',
    bucket_name: backend.storage.resources.bucket.bucketName,
    cors: {
      allowedOrigins: ['https://yourdomain.com'],
      allowedMethods: ['GET', 'POST', 'PUT', 'DELETE'],
      allowedHeaders: ['*'],
    },
  },
});
```

## 🐛 Troubleshooting Configuration

### Common Issues

1. **TypeScript Errors**: Regenerate types with `npx ampx generate`
2. **Auth Issues**: Check callback URLs match your environment
3. **CORS Errors**: Verify allowed origins in backend configuration
4. **Build Failures**: Ensure all environment variables are set

### Debug Configuration

```typescript
// src/lib/debug-config.ts
import { Amplify } from 'aws-amplify';

if (process.env.NODE_ENV === 'development') {
  Amplify.Logger.LOG_LEVEL = 'DEBUG';
}
```

## 📚 Best Practices

1. **Environment Separation**: Use different Amplify apps for dev/staging/prod
2. **Type Safety**: Always regenerate types after schema changes
3. **Security**: Remove API keys in production environments
4. **Performance**: Use secondary indexes for common queries
5. **Monitoring**: Enable CloudWatch logging for production

---

*Last Updated: 2025-07-21*  
*Version: Amplify Gen 2.x*  
*Compatibility: Next.js 14+, React 18+*  