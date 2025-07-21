# AWS Amplify Gen 2 Configuration

**Complete guide to configuring and customizing your AWS Amplify Gen 2 application.**

## 📋 Table of Contents

- [Environment Configuration](#environment-configuration)
- [Build Configuration](#build-configuration)
- [Backend Configuration](#backend-configuration)
- [Frontend Configuration](#frontend-configuration)
- [Deployment Configuration](#deployment-configuration)
- [Security Configuration](#security-configuration)
- [Performance Optimization](#performance-optimization)
- [Troubleshooting](#troubleshooting)

## 🌍 Environment Configuration

### Environment Variables

Amplify Gen 2 uses environment-specific configuration files:

```bash
# .env.local (local development)
NEXT_PUBLIC_APP_NAME=MyApp
DATABASE_URL=your-database-url

# .env.staging (staging environment)
NEXT_PUBLIC_API_ENDPOINT=https://staging-api.example.com

# .env.production (production environment)  
NEXT_PUBLIC_API_ENDPOINT=https://api.example.com
```

### Amplify Environment Files

```typescript
// amplify/backend.ts
import { defineBackend } from '@aws-amplify/backend';
import { auth } from './auth/resource';
import { data } from './data/resource';
import { storage } from './storage/resource';

export const backend = defineBackend({
  auth,
  data,
  storage,
});

// Environment-specific overrides
if (process.env.NODE_ENV === 'production') {
  backend.addOutput({
    custom: {
      region: 'us-east-1',
      logLevel: 'error'
    }
  });
}
```

## 🏗️ Build Configuration

### Next.js Configuration

```javascript
// next.config.js
/** @type {import('next').NextConfig} */
const nextConfig = {
  experimental: {
    serverComponentsExternalPackages: ['@aws-amplify/backend']
  },
  webpack: (config) => {
    config.resolve.alias = {
      ...config.resolve.alias,
      '@': path.resolve(__dirname, './src'),
    };
    return config;
  },
  env: {
    AMPLIFY_SSR: process.env.NODE_ENV === 'production' ? 'true' : 'false'
  }
};

module.exports = nextConfig;
```

### Package.json Scripts

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "sandbox": "npx ampx sandbox",
    "sandbox:delete": "npx ampx sandbox delete",
    "generate": "npx ampx generate",
    "deploy": "npx ampx deploy"
  }
}
```

### TypeScript Configuration

```json
// tsconfig.json
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "es6"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "paths": {
      "@/*": ["./src/*"],
      "@/amplify/*": ["./amplify/*"]
    }
  },
  "include": [
    "next-env.d.ts",
    "**/*.ts",
    "**/*.tsx",
    ".next/types/**/*.ts",
    "amplify/**/*.ts"
  ],
  "exclude": ["node_modules"]
}
```

## ⚙️ Backend Configuration

### Data Schema Configuration

```typescript
// amplify/data/resource.ts
import { type ClientSchema, a, defineData } from '@aws-amplify/backend';

const schema = a.schema({
  Todo: a
    .model({
      content: a.string(),
      done: a.boolean().default(false),
      priority: a.enum(['LOW', 'MEDIUM', 'HIGH']),
      dueDate: a.datetime().optional(),
      tags: a.string().array().optional(),
    })
    .authorization((allow) => [
      allow.owner(),
      allow.groups(['Admins']).to(['read', 'update', 'delete'])
    ]),
    
  Project: a
    .model({
      name: a.string(),
      description: a.string().optional(),
      status: a.enum(['ACTIVE', 'INACTIVE', 'ARCHIVED']),
      todos: a.hasMany('Todo', 'projectId')
    })
    .authorization((allow) => [allow.owner()])
});

export type Schema = ClientSchema<typeof schema>;

export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
    apiKeyAuthorizationMode: {
      expiresInDays: 30,
    },
  },
});
```

### Authentication Configuration

```typescript
// amplify/auth/resource.ts
import { defineAuth } from '@aws-amplify/backend';

export const auth = defineAuth({
  loginWith: {
    email: {
      verificationEmailStyle: 'code',
      verificationEmailSubject: 'Welcome! Verify your email',
      verificationEmailBody: (createCode) =>
        `Use this code to confirm your account: ${createCode()}`,
    },
    externalProviders: {
      google: {
        clientId: process.env.GOOGLE_CLIENT_ID!,
        clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
        scopes: ['email', 'profile'],
      },
      loginWithAmazon: {
        clientId: process.env.AMAZON_CLIENT_ID!,
        clientSecret: process.env.AMAZON_CLIENT_SECRET!,
      },
      signInWithApple: {
        clientId: process.env.APPLE_CLIENT_ID!,
        keyId: process.env.APPLE_KEY_ID!,
        privateKey: process.env.APPLE_PRIVATE_KEY!,
        teamId: process.env.APPLE_TEAM_ID!,
      },
      callbackUrls: [
        'http://localhost:3000/profile',
        'https://myapp.amplifyapp.com/profile',
      ],
      logoutUrls: [
        'http://localhost:3000/',
        'https://myapp.amplifyapp.com/',
      ],
    },
  },
  userAttributes: {
    preferredUsername: {
      mutable: true,
      required: false,
    },
    profilePicture: {
      mutable: true,
      required: false,
    },
  },
  passwordPolicy: {
    minLength: 8,
    requireLowercase: true,
    requireUppercase: true,
    requireNumbers: true,
    requireSymbols: true,
  },
});
```

### Storage Configuration

```typescript
// amplify/storage/resource.ts
import { defineStorage } from '@aws-amplify/backend';

export const storage = defineStorage({
  name: 'myAppStorage',
  access: (allow) => ({
    'public/*': [
      allow.guest.to(['read']),
      allow.authenticated.to(['read', 'write', 'delete'])
    ],
    'protected/{entity_id}/*': [
      allow.authenticated.to(['read', 'write', 'delete'])
    ],
    'private/{entity_id}/*': [
      allow.entity('identity').to(['read', 'write', 'delete'])
    ],
  })
});
```

## 🌐 Frontend Configuration

### Amplify Client Configuration

```typescript
// src/lib/amplify.ts
import { Amplify } from 'aws-amplify';
import outputs from '@/amplify_outputs.json';

// Configure Amplify
Amplify.configure(outputs, {
  ssr: true, // Enable SSR support
});

// Client configuration options
export const amplifyConfig = {
  // API configuration
  API: {
    GraphQL: {
      endpoint: outputs.data.url,
      region: outputs.data.aws_region,
      defaultAuthMode: 'userPool',
    },
  },
  // Auth configuration
  Auth: {
    region: outputs.auth.aws_region,
    userPoolId: outputs.auth.user_pool_id,
    userPoolWebClientId: outputs.auth.user_pool_client_id,
    identityPoolId: outputs.auth.identity_pool_id,
  },
  // Storage configuration
  Storage: {
    S3: {
      bucket: outputs.storage.bucket_name,
      region: outputs.storage.aws_region,
    },
  },
};
```

### Client-side Data Configuration

```typescript
// src/lib/data.ts
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '@/amplify/data/resource';

export const client = generateClient<Schema>({
  authMode: 'userPool',
});

// Query configuration with caching
export const clientConfig = {
  cache: {
    ttl: 1000 * 60 * 5, // 5 minutes
    keyArgs: ['id'],
  },
  errorPolicy: 'all',
  fetchPolicy: 'cache-first',
};
```

## 🚀 Deployment Configuration

### Branch-based Deployments

```yaml
# amplify.yml
version: 1
applications:
  - appRoot: .
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
    backend:
      phases:
        preBuild:
          commands:
            - npm ci
        build:
          commands:
            - npx ampx generate --branch $AWS_BRANCH
            - npx ampx deploy --branch $AWS_BRANCH --appId $AWS_APP_ID
```

### Environment-specific Settings

```typescript
// amplify/backend.ts
import { defineBackend } from '@aws-amplify/backend';

const backend = defineBackend({
  auth,
  data,
  storage,
});

// Production optimizations
if (process.env.AWS_BRANCH === 'main') {
  backend.addOutput({
    custom: {
      domainName: 'myapp.com',
      certificateArn: process.env.SSL_CERTIFICATE_ARN,
      logLevel: 'error',
      cacheTtl: 3600,
    }
  });
}

// Staging configuration
if (process.env.AWS_BRANCH === 'staging') {
  backend.addOutput({
    custom: {
      domainName: 'staging.myapp.com',
      logLevel: 'info',
      cacheTtl: 300,
    }
  });
}
```

## 🔒 Security Configuration

### CORS Configuration

```typescript
// amplify/data/resource.ts
export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
  },
  cors: {
    allowOrigins: [
      'http://localhost:3000',
      'https://myapp.amplifyapp.com',
      'https://myapp.com'
    ],
    allowHeaders: [
      'Content-Type',
      'X-Amz-Date',
      'Authorization',
      'X-Api-Key',
      'X-Amz-Security-Token'
    ],
    allowMethods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowCredentials: true,
  },
});
```

### Content Security Policy

```typescript
// next.config.js
const nextConfig = {
  async headers() {
    return [
      {
        source: '/:path*',
        headers: [
          {
            key: 'Content-Security-Policy',
            value: [
              "default-src 'self'",
              "script-src 'self' 'unsafe-eval' 'unsafe-inline' *.amazonaws.com",
              "style-src 'self' 'unsafe-inline'",
              "img-src 'self' data: blob: *.amazonaws.com",
              "connect-src 'self' *.amazonaws.com *.amplify.aws",
              "frame-src 'none'",
            ].join('; '),
          },
        ],
      },
    ];
  },
};
```

## ⚡ Performance Optimization

### Caching Configuration

```typescript
// src/lib/cache.ts
import { InMemoryCache } from '@apollo/client';

export const cache = new InMemoryCache({
  typePolicies: {
    Todo: {
      keyFields: ['id'],
      fields: {
        dueDate: {
          merge: false,
        },
      },
    },
    Query: {
      fields: {
        listTodos: {
          keyArgs: ['filter'],
          merge(existing = [], incoming) {
            return [...existing, ...incoming];
          },
        },
      },
    },
  },
});
```

### Bundle Optimization

```javascript
// next.config.js
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
          },
        },
      };
    }
    return config;
  },
};
```

## 🛠️ Troubleshooting

### Common Issues

**Issue**: Build fails with TypeScript errors
```bash
# Solution: Regenerate types
npx ampx generate --branch local
```

**Issue**: CORS errors in development
```typescript
// Solution: Update CORS configuration in data resource
cors: {
  allowOrigins: ['http://localhost:3000']
}
```

**Issue**: Authentication not working
```bash
# Solution: Check environment variables and regenerate config
npx ampx sandbox delete
npx ampx sandbox
```

### Debug Configuration

```typescript
// src/lib/debug.ts
if (process.env.NODE_ENV === 'development') {
  // Enable Amplify logging
  Amplify.configure(outputs, {
    ssr: true,
    logging: {
      level: 'DEBUG',
      logger: console,
    },
  });
}
```

---

*Last Updated: 2025-07-21*  
*Version: Amplify Gen 2.x*  
*Compatibility: Next.js 14+, React 18+*