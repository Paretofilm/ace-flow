# Next.js 14+ App Router

**Complete guide to Next.js App Router architecture, routing patterns, and modern React development.**

## 🏗️ App Router Fundamentals

### Directory Structure
```
app/
├── layout.tsx              # Root layout (required)
├── page.tsx               # Home page
├── loading.tsx            # Loading UI
├── error.tsx             # Error UI
├── not-found.tsx         # 404 page
├── global-error.tsx      # Global error boundary
├── template.tsx          # Template wrapper
├── default.tsx           # Parallel route fallback
├── (auth)/               # Route group (doesn't affect URL)
│   ├── layout.tsx        # Nested layout
│   ├── login/
│   │   ├── page.tsx      # /login
│   │   └── loading.tsx   # Login loading state
│   └── register/
│       └── page.tsx      # /register
├── dashboard/
│   ├── layout.tsx        # Dashboard layout
│   ├── page.tsx          # /dashboard
│   ├── @sidebar/         # Parallel route slot
│   │   └── page.tsx      # Sidebar content
│   ├── @header/          # Parallel route slot
│   │   └── page.tsx      # Header content
│   └── settings/
│       ├── page.tsx      # /dashboard/settings
│       └── profile/
│           └── page.tsx  # /dashboard/settings/profile
├── blog/
│   ├── page.tsx          # /blog
│   ├── [slug]/           # Dynamic route
│   │   ├── page.tsx      # /blog/[slug]
│   │   └── opengraph-image.tsx # OG image generation
│   └── [...slug]/        # Catch-all route
│       └── page.tsx      # /blog/[...slug]
├── api/                  # API routes
│   ├── route.ts          # /api
│   ├── auth/
│   │   └── route.ts      # /api/auth
│   └── posts/
│       ├── route.ts      # /api/posts
│       └── [id]/
│           └── route.ts  # /api/posts/[id]
└── globals.css           # Global styles
```

### Core Files

#### Root Layout (Required)
```typescript
// app/layout.tsx
import type { Metadata } from 'next';
import { Inter } from 'next/font/google';
import './globals.css';

const inter = Inter({ subsets: ['latin'] });

export const metadata: Metadata = {
  title: {
    template: '%s | My App',
    default: 'My App - Welcome',
  },
  description: 'Modern Next.js application with App Router',
  keywords: ['Next.js', 'React', 'TypeScript'],
  authors: [{ name: 'Your Name' }],
  creator: 'Your Company',
  metadataBase: new URL('https://myapp.com'),
  openGraph: {
    type: 'website',
    locale: 'en_US',
    url: 'https://myapp.com',
    title: 'My App',
    description: 'Modern Next.js application',
    siteName: 'My App',
    images: [
      {
        url: '/og-image.jpg',
        width: 1200,
        height: 630,
        alt: 'My App',
      },
    ],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'My App',
    description: 'Modern Next.js application',
    creator: '@yourusername',
    images: ['/og-image.jpg'],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-video-preview': -1,
      'max-image-preview': 'large',
      'max-snippet': -1,
    },
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={inter.className}>
      <body>
        <header>
          <nav>Global Navigation</nav>
        </header>
        <main>{children}</main>
        <footer>Global Footer</footer>
      </body>
    </html>
  );
}
```

#### Home Page
```typescript
// app/page.tsx
import Link from 'next/link';
import { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'Home',
  description: 'Welcome to our application',
};

export default function HomePage() {
  return (
    <div>
      <h1>Welcome to My App</h1>
      <p>This is the home page using App Router.</p>
      <nav>
        <Link href="/dashboard">Go to Dashboard</Link>
        <Link href="/blog">Read Blog</Link>
      </nav>
    </div>
  );
}
```

## 🛤️ Routing Patterns

### Dynamic Routes
```typescript
// app/blog/[slug]/page.tsx
interface BlogPostProps {
  params: { slug: string };
  searchParams: { [key: string]: string | string[] | undefined };
}

export async function generateMetadata(
  { params }: BlogPostProps
): Promise<Metadata> {
  const post = await getPost(params.slug);
  
  return {
    title: post.title,
    description: post.excerpt,
    openGraph: {
      title: post.title,
      description: post.excerpt,
      images: [post.featuredImage],
    },
  };
}

export async function generateStaticParams() {
  const posts = await getAllPosts();
  
  return posts.map((post) => ({
    slug: post.slug,
  }));
}

export default async function BlogPost({ params }: BlogPostProps) {
  const post = await getPost(params.slug);
  
  if (!post) {
    notFound(); // Triggers not-found.tsx
  }
  
  return (
    <article>
      <h1>{post.title}</h1>
      <time>{post.publishedAt}</time>
      <div dangerouslySetInnerHTML={{ __html: post.content }} />
    </article>
  );
}

// Data fetching function
async function getPost(slug: string) {
  // Fetch from API, database, or CMS
  const res = await fetch(`${process.env.API_URL}/posts/${slug}`, {
    next: { revalidate: 3600 }, // Revalidate every hour
  });
  
  if (!res.ok) return null;
  return res.json();
}
```

### Catch-all Routes
```typescript
// app/docs/[...slug]/page.tsx
interface DocsPageProps {
  params: { slug: string[] };
}

export default async function DocsPage({ params }: DocsPageProps) {
  const path = params.slug.join('/');
  const doc = await getDocumentation(path);
  
  return (
    <div>
      <nav>
        <Breadcrumbs path={params.slug} />
      </nav>
      <article>
        <h1>{doc.title}</h1>
        <div>{doc.content}</div>
      </article>
    </div>
  );
}
```

### Route Groups
```typescript
// app/(marketing)/layout.tsx - Marketing pages layout
export default function MarketingLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="marketing-layout">
      <header>Marketing Header</header>
      {children}
      <footer>Marketing Footer</footer>
    </div>
  );
}

// app/(app)/layout.tsx - Application layout
export default function AppLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="app-layout">
      <aside>App Sidebar</aside>
      <main>{children}</main>
    </div>
  );
}
```

### Parallel Routes
```typescript
// app/dashboard/layout.tsx - Layout with parallel routes
export default function DashboardLayout({
  children,
  sidebar,
  header,
}: {
  children: React.ReactNode;
  sidebar: React.ReactNode;
  header: React.ReactNode;
}) {
  return (
    <div className="dashboard-layout">
      <div className="header">{header}</div>
      <div className="main-content">
        <aside className="sidebar">{sidebar}</aside>
        <main className="content">{children}</main>
      </div>
    </div>
  );
}

// app/dashboard/@sidebar/page.tsx
export default function DashboardSidebar() {
  return (
    <nav>
      <ul>
        <li><Link href="/dashboard">Overview</Link></li>
        <li><Link href="/dashboard/analytics">Analytics</Link></li>
        <li><Link href="/dashboard/settings">Settings</Link></li>
      </ul>
    </nav>
  );
}

// app/dashboard/@header/page.tsx
export default function DashboardHeader() {
  return (
    <header>
      <h1>Dashboard</h1>
      <UserProfile />
    </header>
  );
}
```

### Intercepting Routes
```typescript
// app/photos/[id]/page.tsx - Regular photo page
export default function PhotoPage({ params }: { params: { id: string } }) {
  return (
    <div>
      <img src={`/photos/${params.id}.jpg`} alt="Photo" />
      <PhotoDetails id={params.id} />
    </div>
  );
}

// app/photos/(..)photos/[id]/page.tsx - Intercepting route (modal)
export default function PhotoModal({ params }: { params: { id: string } }) {
  return (
    <Modal>
      <img src={`/photos/${params.id}.jpg`} alt="Photo" />
      <PhotoDetails id={params.id} />
    </Modal>
  );
}
```

## 🔄 Navigation

### Link Component
```typescript
import Link from 'next/link';

export function Navigation() {
  return (
    <nav>
      {/* Basic link */}
      <Link href="/about">About</Link>
      
      {/* Link with dynamic route */}
      <Link href={`/posts/${postId}`}>Read Post</Link>
      
      {/* Link with query parameters */}
      <Link 
        href={{
          pathname: '/search',
          query: { q: 'nextjs', category: 'web' },
        }}
      >
        Search Next.js
      </Link>
      
      {/* External link */}
      <Link href="https://nextjs.org" target="_blank" rel="noopener noreferrer">
        Next.js Docs
      </Link>
      
      {/* Conditional styling */}
      <Link 
        href="/dashboard"
        className={`nav-link ${pathname === '/dashboard' ? 'active' : ''}`}
      >
        Dashboard
      </Link>
      
      {/* Prefetch control */}
      <Link href="/heavy-page" prefetch={false}>
        Heavy Page (No Prefetch)
      </Link>
      
      {/* Replace instead of push */}
      <Link href="/login" replace>
        Login
      </Link>
    </nav>
  );
}
```

### Programmatic Navigation
```typescript
'use client';

import { useRouter, usePathname, useSearchParams } from 'next/navigation';

export function NavigationControls() {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();
  
  const navigateToPost = (id: string) => {
    router.push(`/posts/${id}`);
  };
  
  const navigateBack = () => {
    router.back();
  };
  
  const refreshPage = () => {
    router.refresh();
  };
  
  const replaceUrl = () => {
    router.replace('/new-url');
  };
  
  const updateSearchParams = (key: string, value: string) => {
    const params = new URLSearchParams(searchParams.toString());
    params.set(key, value);
    router.push(`${pathname}?${params.toString()}`);
  };
  
  return (
    <div>
      <button onClick={() => navigateToPost('123')}>Go to Post 123</button>
      <button onClick={navigateBack}>Go Back</button>
      <button onClick={refreshPage}>Refresh</button>
      <button onClick={() => updateSearchParams('filter', 'active')}>
        Add Filter
      </button>
    </div>
  );
}
```

## 🎨 Layouts and Templates

### Nested Layouts
```typescript
// app/blog/layout.tsx
export default function BlogLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="blog-layout">
      <aside className="blog-sidebar">
        <BlogNavigation />
        <RecentPosts />
      </aside>
      <main className="blog-content">
        {children}
      </main>
    </div>
  );
}
```

### Templates (Re-render on Navigation)
```typescript
// app/template.tsx
'use client';

import { motion } from 'framer-motion';

export default function Template({ children }: { children: React.ReactNode }) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      exit={{ opacity: 0, y: -20 }}
      transition={{ duration: 0.3 }}
    >
      {children}
    </motion.div>
  );
}
```

## 🔄 Loading and Error States

### Loading UI
```typescript
// app/dashboard/loading.tsx
export default function DashboardLoading() {
  return (
    <div className="animate-pulse">
      <div className="h-8 bg-gray-200 rounded mb-4"></div>
      <div className="space-y-3">
        <div className="h-4 bg-gray-200 rounded"></div>
        <div className="h-4 bg-gray-200 rounded w-5/6"></div>
        <div className="h-4 bg-gray-200 rounded w-4/6"></div>
      </div>
    </div>
  );
}

// Streaming loading with Suspense
import { Suspense } from 'react';

export default function DashboardPage() {
  return (
    <div>
      <h1>Dashboard</h1>
      <Suspense fallback={<AnalyticsLoading />}>
        <AnalyticsWidget />
      </Suspense>
      <Suspense fallback={<ReportsLoading />}>
        <ReportsWidget />
      </Suspense>
    </div>
  );
}
```

### Error Boundaries
```typescript
// app/error.tsx
'use client';

import { useEffect } from 'react';

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    console.error('Error:', error);
    // Log to error reporting service
  }, [error]);

  return (
    <div className="error-boundary">
      <h2>Something went wrong!</h2>
      <details>
        <summary>Error details</summary>
        <pre>{error.message}</pre>
      </details>
      <button onClick={reset}>Try again</button>
    </div>
  );
}

// Global error boundary
// app/global-error.tsx
'use client';

export default function GlobalError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  return (
    <html>
      <body>
        <div className="global-error">
          <h1>Application Error</h1>
          <p>Something went wrong with the application.</p>
          <button onClick={reset}>Try again</button>
        </div>
      </body>
    </html>
  );
}
```

### Not Found Page
```typescript
// app/not-found.tsx
import Link from 'next/link';

export default function NotFound() {
  return (
    <div className="not-found">
      <h1>404 - Page Not Found</h1>
      <p>The page you're looking for doesn't exist.</p>
      <Link href="/">Return Home</Link>
    </div>
  );
}
```

## ⚡ Performance Optimization

### Route Prefetching
```typescript
// Automatic prefetching for Link components in viewport
<Link href="/dashboard" prefetch={true}>Dashboard</Link>

// Manual prefetching
'use client';

import { useRouter } from 'next/navigation';

export function PrefetchButton() {
  const router = useRouter();
  
  const prefetchDashboard = () => {
    router.prefetch('/dashboard');
  };
  
  return (
    <button onMouseEnter={prefetchDashboard}>
      Hover to prefetch Dashboard
    </button>
  );
}
```

### Route Segments Config
```typescript
// app/posts/[slug]/page.tsx
// Force static generation
export const dynamic = 'force-static';

// Force dynamic rendering
export const dynamic = 'force-dynamic';

// Revalidate every hour
export const revalidate = 3600;

// Generate at request time but cache
export const dynamic = 'force-dynamic';
export const revalidate = 0;

export default function BlogPost() {
  // Component implementation
}
```

## 🎯 Best Practices

### File Organization
- **Colocation**: Keep related files close to where they're used
- **Feature Grouping**: Group by feature rather than file type
- **Route Groups**: Use parentheses for organization without affecting URLs
- **Private Folders**: Use underscore prefix for non-routable folders

### Performance
- **Static Generation**: Use static generation when possible
- **Streaming**: Implement progressive loading with Suspense
- **Prefetching**: Leverage automatic and manual prefetching
- **Bundle Optimization**: Use dynamic imports for large components

### SEO & Accessibility
- **Metadata**: Define comprehensive metadata for each route
- **Semantic HTML**: Use proper HTML structure
- **Loading States**: Provide meaningful loading indicators
- **Error Handling**: Implement graceful error recovery

---

*This App Router guide provides the foundation for building modern, performant Next.js applications with excellent developer experience.*

**Source**: Next.js 14+ App Router Documentation  
**Last Updated**: Current  
**Compatibility**: Next.js 14+, React 18+