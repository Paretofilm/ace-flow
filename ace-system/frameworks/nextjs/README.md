# Next.js 14+ Documentation

**Modern Next.js development with App Router, Server Components, and performance optimization.**

## 📚 Documentation Index

### Core Concepts
- **[App Router](./app-router.md)** - File-based routing, layouts, and navigation
- **Server Components** - Server-side rendering and data fetching (see [app-router.md](./app-router.md))
- **Client Components** - Interactive UI and client-side logic (see [data-fetching.md](./data-fetching.md))
- **Routing** - Dynamic routes, route groups, and middleware (covered in [app-router.md](./app-router.md))

### Data & State Management
- **[Data Fetching](./data-fetching.md)** - Server/client data patterns and caching
- **State Management** - React state, Context, and external libraries (patterns in [data-fetching.md](./data-fetching.md))
- **API Routes** - Backend API development with Next.js

### UI & Styling
- **Components** - Component patterns and best practices (see existing guides)
- **Styling** - CSS Modules, Tailwind, and styling approaches
- **Images & Media** - Image optimization and media handling

### Performance & Optimization
- **Optimization** - Performance, bundling, and Core Web Vitals (see [app-router.md](./app-router.md))
- **Caching** - Data caching, ISR, and cache strategies (see [data-fetching.md](./data-fetching.md))
- **Loading & Streaming** - Loading UI and streaming patterns (covered in existing guides)

### Production & Deployment
- **Deployment** - Production deployment and hosting
- **Monitoring** - Analytics, error tracking, and performance monitoring
- **SEO** - Search engine optimization and metadata

## 🚀 Quick Start Reference

### App Router Structure
```
app/
├── layout.tsx          # Root layout
├── page.tsx           # Home page
├── globals.css        # Global styles
├── (auth)/           # Route group
│   ├── login/
│   │   └── page.tsx
│   └── register/
│       └── page.tsx
├── dashboard/
│   ├── layout.tsx    # Nested layout
│   ├── page.tsx
│   └── settings/
│       └── page.tsx
└── api/
    └── todos/
        └── route.ts  # API endpoint
```

### Essential Patterns

#### Server Component Data Fetching
```typescript
// app/todos/page.tsx - Server Component
import { getTodos } from '@/lib/data';

export default async function TodosPage() {
  const todos = await getTodos(); // Server-side data fetching
  
  return (
    <div>
      <h1>Todos</h1>
      {todos.map(todo => (
        <div key={todo.id}>{todo.content}</div>
      ))}
    </div>
  );
}
```

#### Client Component Interactivity
```typescript
'use client' // Client Component directive

import { useState } from 'react';

export function TodoForm() {
  const [content, setContent] = useState('');
  
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    await fetch('/api/todos', {
      method: 'POST',
      body: JSON.stringify({ content }),
    });
  };
  
  return (
    <form onSubmit={handleSubmit}>
      <input 
        value={content}
        onChange={(e) => setContent(e.target.value)}
        placeholder="Add todo..."
      />
      <button type="submit">Add</button>
    </form>
  );
}
```

#### Layout with Metadata
```typescript
// app/layout.tsx
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'My App',
  description: 'Modern Next.js application',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        <nav>Navigation</nav>
        <main>{children}</main>
        <footer>Footer</footer>
      </body>
    </html>
  );
}
```

## 📋 Feature Compatibility

| Feature | App Router | Pages Router | Status | Recommended |
|---------|------------|--------------|--------|-------------|
| Server Components | ✅ Native | ❌ No | Stable | ✅ Use |
| Streaming | ✅ Built-in | 🟡 Manual | Stable | ✅ Use |
| Nested Layouts | ✅ Native | 🟡 Manual | Stable | ✅ Use |
| Route Groups | ✅ Native | ❌ No | Stable | ✅ Use |
| Middleware | ✅ Enhanced | ✅ Basic | Stable | ✅ Use App Router |
| API Routes | ✅ Enhanced | ✅ Basic | Stable | ✅ Use App Router |

## 🔧 Development Best Practices

### Component Organization
- **Server Components**: Use for data fetching and static content
- **Client Components**: Use for interactivity and browser APIs
- **Hybrid Approach**: Combine server and client components effectively

### Performance Optimization
- **Image Optimization**: Use Next.js Image component
- **Bundle Optimization**: Code splitting and dynamic imports
- **Caching Strategy**: Leverage built-in caching mechanisms

### SEO & Accessibility
- **Metadata API**: Use Next.js metadata for SEO
- **Semantic HTML**: Proper HTML structure for accessibility
- **Core Web Vitals**: Optimize for performance metrics

---

*Last Updated: 2025-07-20*
*Version: Next.js 14+*
*Compatibility: React 18+, Node.js 18+*