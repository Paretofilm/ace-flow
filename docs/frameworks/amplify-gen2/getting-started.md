# AWS Amplify Gen 2 Getting Started

**Complete guide to setting up and building your first AWS Amplify Gen 2 application.**

## 🚀 Installation & Setup

### Prerequisites
- **Node.js**: Version 18.0 or later
- **npm**: Version 8.0 or later  
- **AWS Account**: With appropriate permissions
- **Git**: For version control

### Create New Project
```bash
# Create new Amplify Gen 2 project
npm create amplify@latest my-amplify-app

# Navigate to project directory
cd my-amplify-app

# Install dependencies
npm install

# Start local development sandbox
npx ampx sandbox
```

### Project Structure
```
my-amplify-app/
├── amplify/                 # Backend configuration
│   ├── auth/
│   │   └── resource.ts     # Authentication configuration
│   ├── data/
│   │   └── resource.ts     # Data/API configuration
│   ├── storage/
│   │   └── resource.ts     # Storage configuration
│   └── backend.ts          # Main backend configuration
├── src/                    # Frontend application
│   ├── app/               # Next.js app (if using Next.js)
│   ├── components/        # React components
│   └── lib/              # Utility functions
├── amplify_outputs.json   # Generated outputs (local dev)
├── package.json
└── tsconfig.json
```

## 🔧 Core Configuration

### Backend Definition
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
```

### Data Schema Setup
```typescript
// amplify/data/resource.ts
import { type ClientSchema, a, defineData } from '@aws-amplify/backend';

const schema = a.schema({
  Todo: a
    .model({
      content: a.string(),
      done: a.boolean(),
      priority: a.enum(['low', 'medium', 'high']),
    })
    .authorization((allow) => [allow.owner()]),
    
  User: a
    .model({
      email: a.string().required(),
      name: a.string(),
      avatar: a.string(),
    })
    .authorization((allow) => [allow.owner()]),
});

export type Schema = ClientSchema<typeof schema>;
export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
  },
});
```

### Authentication Setup
```typescript
// amplify/auth/resource.ts
import { defineAuth } from '@aws-amplify/backend';

export const auth = defineAuth({
  loginWith: {
    email: true,
    // Optional: Add social providers
    externalProviders: {
      google: {
        clientId: process.env.GOOGLE_CLIENT_ID,
        clientSecret: process.env.GOOGLE_CLIENT_SECRET,
      },
    },
  },
});
```

### Storage Configuration
```typescript
// amplify/storage/resource.ts
import { defineStorage } from '@aws-amplify/backend';

export const storage = defineStorage({
  name: 'myProjectStorage',
  access: (allow) => ({
    'media/*': [
      allow.authenticated.to(['read', 'write', 'delete']),
      allow.guest.to(['read']),
    ],
    'public/*': [
      allow.guest.to(['read']),
      allow.authenticated.to(['read', 'write', 'delete']),
    ],
  }),
});
```

## 🎯 Frontend Integration

### Configure Amplify Client
```typescript
// src/lib/amplify.ts
import { Amplify } from 'aws-amplify';
import outputs from '../../amplify_outputs.json';

Amplify.configure(outputs);
```

### Data Client Setup
```typescript
// src/lib/data.ts
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '../../amplify/data/resource';

export const client = generateClient<Schema>();
```

### Basic Data Operations
```typescript
// src/components/TodoList.tsx
'use client';

import { useState, useEffect } from 'react';
import { client } from '@/lib/data';
import type { Schema } from '../../amplify/data/resource';

type Todo = Schema['Todo']['type'];

export function TodoList() {
  const [todos, setTodos] = useState<Todo[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Fetch todos
    fetchTodos();
    
    // Subscribe to real-time updates
    const subscription = client.models.Todo.observeQuery().subscribe({
      next: (data) => {
        setTodos([...data.items]);
        setLoading(false);
      },
    });

    return () => subscription.unsubscribe();
  }, []);

  const fetchTodos = async () => {
    try {
      const result = await client.models.Todo.list();
      setTodos(result.data);
    } catch (error) {
      console.error('Error fetching todos:', error);
    } finally {
      setLoading(false);
    }
  };

  const createTodo = async (content: string) => {
    try {
      await client.models.Todo.create({
        content,
        done: false,
        priority: 'medium',
      });
    } catch (error) {
      console.error('Error creating todo:', error);
    }
  };

  const updateTodo = async (id: string, updates: Partial<Todo>) => {
    try {
      await client.models.Todo.update({
        id,
        ...updates,
      });
    } catch (error) {
      console.error('Error updating todo:', error);
    }
  };

  const deleteTodo = async (id: string) => {
    try {
      await client.models.Todo.delete({ id });
    } catch (error) {
      console.error('Error deleting todo:', error);
    }
  };

  if (loading) return <div>Loading...</div>;

  return (
    <div>
      <h2>Todos</h2>
      {todos.map((todo) => (
        <div key={todo.id} className="todo-item">
          <input
            type="checkbox"
            checked={todo.done}
            onChange={(e) => updateTodo(todo.id, { done: e.target.checked })}
          />
          <span>{todo.content}</span>
          <button onClick={() => deleteTodo(todo.id)}>Delete</button>
        </div>
      ))}
    </div>
  );
}
```

### Authentication Component
```typescript
// src/components/AuthenticatedApp.tsx
'use client';

import { Authenticator } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';

export function AuthenticatedApp({ children }: { children: React.ReactNode }) {
  return (
    <Authenticator>
      {({ signOut, user }) => (
        <div>
          <nav>
            <h1>My App</h1>
            <div>
              <span>Hello, {user?.username}</span>
              <button onClick={signOut}>Sign Out</button>
            </div>
          </nav>
          <main>{children}</main>
        </div>
      )}
    </Authenticator>
  );
}
```

## 🛠️ Development Workflow

### Local Development
```bash
# Start development sandbox
npx ampx sandbox

# Generate TypeScript types (auto-generated during sandbox)
npx ampx generate

# Deploy to cloud (creates cloud environment)
npx ampx pipeline-deploy --branch main
```

### Environment Management
```bash
# List environments
npx ampx list-branches

# Switch environments
npx ampx checkout prod

# Delete environment
npx ampx delete-branch dev
```

### Database Operations
```bash
# Reset local database
npx ampx sandbox delete
npx ampx sandbox

# View database in AWS Console
npx ampx console data
```

## 🔍 Key Concepts

### Authorization Patterns
```typescript
// Owner-based authorization
.authorization((allow) => [allow.owner()])

// Group-based authorization
.authorization((allow) => [
  allow.group('admins'),
  allow.group('editors').to(['read', 'create']),
])

// Public access
.authorization((allow) => [
  allow.authenticated().to(['read', 'create']),
  allow.guest().to(['read']),
])

// Custom authorization
.authorization((allow) => [
  allow.custom(),  // Use custom authorization logic
])
```

### Data Relationships
```typescript
const schema = a.schema({
  Blog: a
    .model({
      name: a.string(),
    })
    .authorization((allow) => [allow.owner()]),
    
  Post: a
    .model({
      title: a.string(),
      content: a.string(),
      blog: a.belongsTo('Blog'),  // Many-to-one relationship
    })
    .authorization((allow) => [allow.owner()]),
});
```

### Real-time Subscriptions
```typescript
// Subscribe to model changes
const subscription = client.models.Todo.observeQuery().subscribe({
  next: (data) => {
    console.log('Todos updated:', data.items);
  },
});

// Subscribe to specific operations
const createSubscription = client.models.Todo.onCreate().subscribe({
  next: (data) => {
    console.log('New todo created:', data);
  },
});
```

## ⚠️ Common Gotchas

### Schema Changes
- **Breaking Changes**: Adding `required()` to existing fields requires data migration
- **Field Deletion**: Removing fields from schema doesn't delete existing data
- **Type Changes**: Changing field types may cause validation errors

### Authorization
- **Owner Fields**: Owner authorization automatically adds `owner` field to records
- **Group Membership**: Users must be added to Cognito groups for group-based auth
- **Public Access**: Be careful with `allow.guest()` for sensitive data

### Development vs Production
- **Sandbox vs Cloud**: Sandbox is for development, use `pipeline-deploy` for production
- **Environment Variables**: Different environments need separate configuration
- **Data Persistence**: Sandbox data is temporary, cloud data persists

## 🚀 Next Steps

1. **Explore Data Modeling**: Learn advanced schema patterns
2. **Add Storage**: Implement file upload and management
3. **Customize Authentication**: Add social providers and custom flows
4. **Deploy to Production**: Set up CI/CD pipelines
5. **Add Functions**: Implement custom business logic with Lambda

---

*This guide provides the foundation for AWS Amplify Gen 2 development. Continue with specific feature documentation for advanced implementation patterns.*

**Source**: AWS Amplify Gen 2 Documentation  
**Last Updated**: Current  
**Compatibility**: Amplify Gen 2.x, Node.js 18+