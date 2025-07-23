# AWS Amplify Gen 2 Documentation

**Comprehensive reference for AWS Amplify Gen 2 fullstack development.**

## 📚 Documentation Index

### Core Concepts
- **[Getting Started](./getting-started.md)** - Installation, setup, and first application
- **[Data Modeling](./data-modeling.md)** - GraphQL schemas, DynamoDB, and relationships
- **[Authentication](./authentication.md)** - User management, social login, and security

### Coming Soon
- **Project Structure** - Understanding Amplify Gen 2 architecture
- **CLI Commands** - Essential ampx and amplify commands
- **Storage** - File upload, S3 integration, and CDN
- **Functions** - Lambda functions and custom business logic
- **Real-time** - GraphQL subscriptions and live updates
- **Client Libraries** - Using Amplify in React/Next.js
- **API Integration** - GraphQL client setup and usage
- **Authentication UI** - Frontend authentication patterns
- **Deployment** - CI/CD, environments, and production setup
- **Monitoring** - Logging, metrics, and debugging
- **Security** - Security best practices and compliance
- **API Reference** - Complete API documentation
- **Configuration** - See [getting-started.md](./getting-started.md) for environment setup
- **Troubleshooting** - Common issues covered in individual guides

## 🚀 Quick Start Reference

### Basic Setup
```bash
npm create amplify@latest
cd my-amplify-app
npx ampx sandbox
```

### Essential Patterns
```typescript
// Data schema definition
import { type ClientSchema, a, defineData } from '@aws-amplify/backend';

const schema = a.schema({
  Todo: a
    .model({
      content: a.string(),
      done: a.boolean(),
    })
    .authorization((allow) => [allow.owner()]),
});

export type Schema = ClientSchema<typeof schema>;
export const data = defineData({ schema });
```

### Client Integration
```typescript
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '../amplify/data/resource';

const client = generateClient<Schema>();

// Create
const todo = await client.models.Todo.create({
  content: "My new todo",
  done: false,
});

// List
const todos = await client.models.Todo.list();

// Subscribe
client.models.Todo.observeQuery().subscribe({
  next: (data) => setTodos([...data.items]),
});
```

## 📋 Framework Compatibility

| Feature | Next.js | React | Vue | Angular | Status |
|---------|---------|-------|-----|---------|--------|
| Data (GraphQL) | ✅ Full | ✅ Full | ✅ Full | ✅ Full | Stable |
| Authentication | ✅ Full | ✅ Full | ✅ Full | ✅ Full | Stable |
| Storage | ✅ Full | ✅ Full | ✅ Full | ✅ Full | Stable |
| Functions | ✅ Full | ✅ Full | ✅ Full | ✅ Full | Stable |
| Real-time | ✅ Full | ✅ Full | ✅ Full | ✅ Full | Stable |

## 🔧 Development Workflow

### Local Development
1. **Sandbox Mode**: `npx ampx sandbox` for local development
2. **Type Generation**: Automatic TypeScript types from schema
3. **Hot Reload**: Real-time updates during development

### Production Deployment
1. **Branch Deployment**: Connect Git repository
2. **CI/CD Pipeline**: Automatic build and deploy
3. **Environment Management**: Separate dev/staging/prod environments

---

*Last Updated: 2025-07-20*
*Version: Amplify Gen 2.x*
*Compatibility: Next.js 14+, React 18+*