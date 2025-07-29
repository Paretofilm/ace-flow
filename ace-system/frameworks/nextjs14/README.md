# Next.js 14 Documentation for ACE-Flow

This directory contains comprehensive Next.js 14 documentation optimized for ACE-Flow development workflows with AWS Amplify Gen 2.

## 📁 Structure

```
nextjs14/
├── app-router/          # App Router architecture
│   ├── installation.md  # Setup and configuration
│   ├── project-structure.md  # File organization
│   ├── layouts-and-pages.md  # Core concepts
│   └── dynamic-routes.md  # Dynamic routing patterns
├── server-components/   # React Server Components
│   └── server-and-client-components.md  # Component patterns
├── data-fetching/       # Data loading strategies
│   └── fetching-data.md  # Server/Client data fetching
├── api-routes/          # API endpoints
│   └── route-handlers.md  # Route handler patterns
├── middleware/          # Request middleware
│   └── middleware.md    # Middleware configuration
└── README.md           # This file
```

## 🚀 Key Features

### App Router (Next.js 13.4+)
- File-system based routing
- Nested layouts with state preservation
- Server Components by default
- Built-in data fetching and caching
- Streaming and Suspense support

### Server Components
- Zero client-side JavaScript by default
- Direct database queries
- Secure API key usage
- Improved performance with RSC Payload

### Route Handlers
- Web standard Request/Response APIs
- Support for all HTTP methods
- Streaming responses
- CORS and middleware integration

## 🔗 AWS Amplify Gen 2 Integration

### Compatibility
- **Recommended Version**: Next.js 14.2.16
- **Supported Range**: 14.0.0 - 14.2.x
- **Full App Router Support**: ✅
- **Server Components**: ✅ (with client component patterns for Auth UI)

### Key Integration Points

#### Authentication with Amplify UI
```tsx
// app/components/auth-provider.tsx
'use client'

import { Authenticator } from '@aws-amplify/ui-react'
import '@aws-amplify/ui-react/styles.css'

export default function AuthProvider({ children }: { children: React.ReactNode }) {
  return <Authenticator>{children}</Authenticator>
}
```

#### Server-Side Data Fetching
```tsx
// app/posts/page.tsx
import { generateClient } from 'aws-amplify/data'
import { type Schema } from '@/amplify/data/resource'

const client = generateClient<Schema>()

export default async function PostsPage() {
  const { data: posts } = await client.models.Post.list()
  
  return (
    <ul>
      {posts.map(post => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  )
}
```

#### API Routes with Amplify
```tsx
// app/api/posts/route.ts
import { generateClient } from 'aws-amplify/data'
import { type Schema } from '@/amplify/data/resource'

const client = generateClient<Schema>()

export async function GET() {
  const { data: posts } = await client.models.Post.list()
  return Response.json(posts)
}
```

## 📚 Common Patterns

### Protected Routes with Middleware
```tsx
// middleware.ts
import { NextRequest, NextResponse } from 'next/server'
import { fetchAuthSession } from 'aws-amplify/auth/server'

export async function middleware(request: NextRequest) {
  const session = await fetchAuthSession()
  
  if (!session.tokens) {
    return NextResponse.redirect(new URL('/login', request.url))
  }
  
  return NextResponse.next()
}

export const config = {
  matcher: '/protected/:path*'
}
```

### Streaming with Suspense
```tsx
// app/dashboard/page.tsx
import { Suspense } from 'react'
import { DashboardMetrics } from './metrics'
import { LoadingSkeleton } from './loading'

export default function DashboardPage() {
  return (
    <div>
      <h1>Dashboard</h1>
      <Suspense fallback={<LoadingSkeleton />}>
        <DashboardMetrics />
      </Suspense>
    </div>
  )
}
```

### Client Components for Interactivity
```tsx
// app/components/like-button.tsx
'use client'

import { useState } from 'react'
import { generateClient } from 'aws-amplify/data'

const client = generateClient()

export function LikeButton({ postId }: { postId: string }) {
  const [likes, setLikes] = useState(0)
  
  const handleLike = async () => {
    await client.models.Post.update({ id: postId, likes: likes + 1 })
    setLikes(likes + 1)
  }
  
  return <button onClick={handleLike}>Like ({likes})</button>
}
```

## 🛠️ Development Commands

```bash
# Create Next.js 14 app with App Router
npm create next-app@14 -- my-app --typescript --app --no-tailwind

# Add Amplify Gen 2
npm create amplify@latest
npm install aws-amplify @aws-amplify/ui-react

# Development
npm run dev

# Build for production
npm run build

# Start production server
npm run start
```

## ⚡ Performance Tips

1. **Use Server Components by default** - Only add `'use client'` when needed
2. **Implement streaming** - Use Suspense boundaries for better UX
3. **Optimize images** - Use Next.js Image component with Amplify Storage
4. **Cache effectively** - Leverage Next.js caching with Amplify data
5. **Minimize client bundles** - Keep interactive components small

## 🔍 Debugging

### Common Issues

1. **Hydration Errors**
   - Ensure server and client render the same content
   - Use `suppressHydrationWarning` for timestamps

2. **Amplify Auth in Server Components**
   - Auth UI components must be Client Components
   - Use `fetchAuthSession` for server-side auth checks

3. **Build Errors**
   - Check Next.js and Amplify version compatibility
   - Ensure all environment variables are set

## 📖 Additional Resources

- [Next.js 14 Documentation](https://nextjs.org/docs)
- [AWS Amplify Gen 2 Docs](https://docs.amplify.aws/gen2/)
- [ACE-Flow Integration Guide](../../README.md)

---

**Note**: This documentation is optimized for ACE-Flow workflows and contains patterns specific to AWS Amplify Gen 2 integration with Next.js 14.