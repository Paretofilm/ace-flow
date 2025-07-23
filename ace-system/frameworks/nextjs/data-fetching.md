# Next.js 14+ Data Fetching

**Comprehensive guide to data fetching patterns, caching strategies, and server/client data management in Next.js App Router.**

## 🏗️ Data Fetching Fundamentals

### Server Components (Default)
```typescript
// app/posts/page.tsx - Server Component
import { client } from '@/lib/amplify-client';

// This runs on the server
async function getPosts() {
  try {
    const result = await client.models.Post.list({
      limit: 20,
      sort: { field: 'createdAt', direction: 'desc' },
    });
    return result.data;
  } catch (error) {
    console.error('Error fetching posts:', error);
    return [];
  }
}

export default async function PostsPage() {
  const posts = await getPosts();
  
  return (
    <div>
      <h1>Latest Posts</h1>
      {posts.map((post) => (
        <article key={post.id}>
          <h2>{post.title}</h2>
          <p>{post.excerpt}</p>
          <time>{post.createdAt}</time>
        </article>
      ))}
    </div>
  );
}
```

### Client Components
```typescript
// app/components/InteractivePosts.tsx
'use client';

import { useState, useEffect } from 'react';
import { client } from '@/lib/amplify-client';
import type { Schema } from '../../amplify/data/resource';

type Post = Schema['Post']['type'];

export function InteractivePosts() {
  const [posts, setPosts] = useState<Post[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    fetchPosts();
    
    // Subscribe to real-time updates
    const subscription = client.models.Post.observeQuery().subscribe({
      next: (data) => {
        setPosts([...data.items]);
        setLoading(false);
      },
      error: (err) => {
        setError(err.message);
        setLoading(false);
      },
    });

    return () => subscription.unsubscribe();
  }, []);

  const fetchPosts = async () => {
    try {
      const result = await client.models.Post.list();
      setPosts(result.data);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to fetch posts');
    } finally {
      setLoading(false);
    }
  };

  const createPost = async (title: string, content: string) => {
    try {
      await client.models.Post.create({
        title,
        content,
        isPublished: false,
      });
      // Real-time subscription will update the UI
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to create post');
    }
  };

  if (loading) return <div>Loading posts...</div>;
  if (error) return <div>Error: {error}</div>;

  return (
    <div>
      <PostForm onSubmit={createPost} />
      <PostList posts={posts} />
    </div>
  );
}
```

## 🔄 Caching Strategies

### Static Generation
```typescript
// app/posts/[slug]/page.tsx
export async function generateStaticParams() {
  const posts = await client.models.Post.list({
    filter: { isPublished: { eq: true } },
  });
  
  return posts.data.map((post) => ({
    slug: post.slug,
  }));
}

export default async function PostPage({ 
  params 
}: { 
  params: { slug: string } 
}) {
  const post = await client.models.Post.get({ slug: params.slug });
  
  return (
    <article>
      <h1>{post?.title}</h1>
      <div>{post?.content}</div>
    </article>
  );
}
```

### Incremental Static Regeneration (ISR)
```typescript
// app/news/page.tsx
export const revalidate = 3600; // Revalidate every hour

async function getNews() {
  const res = await fetch('https://api.news.com/latest', {
    next: { 
      revalidate: 3600,
      tags: ['news'], // For on-demand revalidation
    },
  });
  
  if (!res.ok) throw new Error('Failed to fetch news');
  return res.json();
}

export default async function NewsPage() {
  const news = await getNews();
  
  return (
    <div>
      <h1>Latest News</h1>
      {news.map((article: any) => (
        <article key={article.id}>
          <h2>{article.title}</h2>
          <p>{article.summary}</p>
        </article>
      ))}
    </div>
  );
}
```

### Dynamic Rendering
```typescript
// app/dashboard/page.tsx
export const dynamic = 'force-dynamic'; // Always render on request

async function getUserData() {
  // This will run on every request
  const user = await getCurrentUser();
  const analytics = await getUserAnalytics(user.id);
  
  return { user, analytics };
}

export default async function DashboardPage() {
  const { user, analytics } = await getUserData();
  
  return (
    <div>
      <h1>Welcome, {user.name}</h1>
      <UserAnalytics data={analytics} />
    </div>
  );
}
```

### Request Memoization
```typescript
// lib/data.ts
import { cache } from 'react';

// Memoize function calls within a single request
export const getUser = cache(async (id: string) => {
  const result = await client.models.User.get({ id });
  return result.data;
});

// Multiple calls to getUser with same ID will use cached result
export default async function UserProfile({ userId }: { userId: string }) {
  const user = await getUser(userId); // First call
  const sameUser = await getUser(userId); // Uses cached result
  
  return <div>{user?.name}</div>;
}
```

## 🔄 Streaming and Loading States

### Streaming with Suspense
```typescript
// app/dashboard/page.tsx
import { Suspense } from 'react';

export default function DashboardPage() {
  return (
    <div>
      <h1>Dashboard</h1>
      
      {/* Parallel loading of different sections */}
      <div className="grid grid-cols-2 gap-4">
        <Suspense fallback={<AnalyticsLoading />}>
          <AnalyticsWidget />
        </Suspense>
        
        <Suspense fallback={<ActivityLoading />}>
          <ActivityFeed />
        </Suspense>
      </div>
      
      <Suspense fallback={<ReportsLoading />}>
        <RecentReports />
      </Suspense>
    </div>
  );
}

// Heavy component that fetches data
async function AnalyticsWidget() {
  const analytics = await getAnalytics(); // Slow API call
  
  return (
    <div className="analytics-widget">
      <h2>Analytics</h2>
      <AnalyticsChart data={analytics} />
    </div>
  );
}

async function ActivityFeed() {
  const activities = await getRecentActivity(); // Another slow call
  
  return (
    <div className="activity-feed">
      <h2>Recent Activity</h2>
      {activities.map((activity) => (
        <ActivityItem key={activity.id} activity={activity} />
      ))}
    </div>
  );
}
```

### Progressive Enhancement
```typescript
// app/posts/page.tsx
import { Suspense } from 'react';

export default async function PostsPage() {
  // Fast initial data
  const initialPosts = await getInitialPosts();
  
  return (
    <div>
      <h1>Blog Posts</h1>
      
      {/* Show initial posts immediately */}
      <PostList posts={initialPosts} />
      
      {/* Load additional content progressively */}
      <Suspense fallback={<LoadingMorePosts />}>
        <AdditionalPosts />
      </Suspense>
    </div>
  );
}

async function AdditionalPosts() {
  // Slower, additional data
  const morePosts = await getAdditionalPosts();
  
  return (
    <div>
      <h2>More Posts</h2>
      <PostList posts={morePosts} />
    </div>
  );
}
```

## 🌐 API Integration Patterns

### RESTful API Integration
```typescript
// lib/api.ts
const API_BASE_URL = process.env.API_URL || 'https://api.example.com';

class ApiClient {
  private baseUrl: string;
  
  constructor(baseUrl: string) {
    this.baseUrl = baseUrl;
  }
  
  async request<T>(
    endpoint: string, 
    options: RequestInit = {}
  ): Promise<T> {
    const url = `${this.baseUrl}${endpoint}`;
    const config: RequestInit = {
      headers: {
        'Content-Type': 'application/json',
        ...options.headers,
      },
      ...options,
    };
    
    const response = await fetch(url, config);
    
    if (!response.ok) {
      throw new Error(`API Error: ${response.status} ${response.statusText}`);
    }
    
    return response.json();
  }
  
  async get<T>(endpoint: string, options?: RequestInit): Promise<T> {
    return this.request<T>(endpoint, { ...options, method: 'GET' });
  }
  
  async post<T>(endpoint: string, data: any, options?: RequestInit): Promise<T> {
    return this.request<T>(endpoint, {
      ...options,
      method: 'POST',
      body: JSON.stringify(data),
    });
  }
  
  async put<T>(endpoint: string, data: any, options?: RequestInit): Promise<T> {
    return this.request<T>(endpoint, {
      ...options,
      method: 'PUT',
      body: JSON.stringify(data),
    });
  }
  
  async delete<T>(endpoint: string, options?: RequestInit): Promise<T> {
    return this.request<T>(endpoint, { ...options, method: 'DELETE' });
  }
}

export const apiClient = new ApiClient(API_BASE_URL);

// Usage in Server Components
export async function getProducts() {
  return apiClient.get<Product[]>('/products');
}

export async function getProduct(id: string) {
  return apiClient.get<Product>(`/products/${id}`);
}
```

### GraphQL Integration
```typescript
// lib/graphql.ts
import { GraphQLClient } from 'graphql-request';

const endpoint = process.env.GRAPHQL_ENDPOINT!;
const client = new GraphQLClient(endpoint);

// Server-side queries
export async function getPostsQuery() {
  const query = `
    query GetPosts($limit: Int, $offset: Int) {
      posts(limit: $limit, offset: $offset) {
        id
        title
        excerpt
        createdAt
        author {
          name
          avatar
        }
      }
    }
  `;
  
  return client.request(query, { limit: 10, offset: 0 });
}

// Client-side with authentication
export function createAuthenticatedClient(token: string) {
  return new GraphQLClient(endpoint, {
    headers: {
      authorization: `Bearer ${token}`,
    },
  });
}
```

### Amplify Gen 2 Integration
```typescript
// lib/amplify-data.ts
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '../../amplify/data/resource';

export const client = generateClient<Schema>();

// Server-side data fetching helpers
export async function getPublishedPosts() {
  const result = await client.models.Post.list({
    filter: { isPublished: { eq: true } },
    sort: { field: 'createdAt', direction: 'desc' },
  });
  return result.data;
}

export async function getPostBySlug(slug: string) {
  const result = await client.models.Post.list({
    filter: { slug: { eq: slug } },
    limit: 1,
  });
  return result.data[0] || null;
}

export async function getUserPosts(userId: string) {
  const result = await client.models.Post.list({
    filter: { 
      and: [
        { authorId: { eq: userId } },
        { isPublished: { eq: true } },
      ],
    },
  });
  return result.data;
}

// Client-side real-time helpers
export function usePostSubscription() {
  const [posts, setPosts] = useState<Schema['Post']['type'][]>([]);
  
  useEffect(() => {
    const subscription = client.models.Post.observeQuery({
      filter: { isPublished: { eq: true } },
    }).subscribe({
      next: (data) => setPosts([...data.items]),
    });
    
    return () => subscription.unsubscribe();
  }, []);
  
  return posts;
}
```

## 🔄 Error Handling and Retry Logic

### Error Boundaries with Data Fetching
```typescript
// app/posts/error.tsx
'use client';

import { useEffect } from 'react';

export default function PostsError({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    // Log to error reporting service
    console.error('Posts page error:', error);
  }, [error]);

  return (
    <div className="error-container">
      <h2>Failed to load posts</h2>
      <p>There was an error loading the posts. Please try again.</p>
      <button onClick={reset} className="retry-button">
        Try again
      </button>
    </div>
  );
}
```

### Retry Logic
```typescript
// lib/retry.ts
export async function withRetry<T>(
  fn: () => Promise<T>,
  maxRetries: number = 3,
  delay: number = 1000
): Promise<T> {
  let lastError: Error;
  
  for (let i = 0; i <= maxRetries; i++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error as Error;
      
      if (i === maxRetries) {
        throw lastError;
      }
      
      // Exponential backoff
      await new Promise(resolve => setTimeout(resolve, delay * Math.pow(2, i)));
    }
  }
  
  throw lastError!;
}

// Usage
async function fetchDataWithRetry() {
  return withRetry(async () => {
    const response = await fetch('/api/data');
    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }
    return response.json();
  }, 3, 1000);
}
```

### Graceful Degradation
```typescript
// app/components/PostList.tsx
interface PostListProps {
  fallbackPosts?: Post[];
}

export async function PostList({ fallbackPosts = [] }: PostListProps) {
  let posts: Post[];
  
  try {
    posts = await getPosts();
  } catch (error) {
    console.error('Failed to fetch posts:', error);
    posts = fallbackPosts; // Use fallback data
  }
  
  if (posts.length === 0) {
    return (
      <div className="empty-state">
        <h3>No posts available</h3>
        <p>Check back later for new content.</p>
      </div>
    );
  }
  
  return (
    <div className="post-list">
      {posts.map((post) => (
        <PostCard key={post.id} post={post} />
      ))}
    </div>
  );
}
```

## 🎯 Performance Optimization

### Data Prefetching
```typescript
// app/components/PostCard.tsx
'use client';

import Link from 'next/link';
import { useRouter } from 'next/navigation';

interface PostCardProps {
  post: Post;
}

export function PostCard({ post }: PostCardProps) {
  const router = useRouter();
  
  // Prefetch on hover
  const handleMouseEnter = () => {
    router.prefetch(`/posts/${post.slug}`);
  };
  
  return (
    <Link 
      href={`/posts/${post.slug}`} 
      onMouseEnter={handleMouseEnter}
      className="post-card"
    >
      <h3>{post.title}</h3>
      <p>{post.excerpt}</p>
    </Link>
  );
}
```

### Optimistic Updates
```typescript
// app/components/LikeButton.tsx
'use client';

import { useState, useTransition } from 'react';

interface LikeButtonProps {
  postId: string;
  initialLikes: number;
  initialLiked: boolean;
}

export function LikeButton({ postId, initialLikes, initialLiked }: LikeButtonProps) {
  const [likes, setLikes] = useState(initialLikes);
  const [liked, setLiked] = useState(initialLiked);
  const [isPending, startTransition] = useTransition();
  
  const handleLike = () => {
    // Optimistic update
    setLiked(!liked);
    setLikes(liked ? likes - 1 : likes + 1);
    
    startTransition(async () => {
      try {
        const response = await fetch(`/api/posts/${postId}/like`, {
          method: 'POST',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ liked: !liked }),
        });
        
        if (!response.ok) {
          // Revert optimistic update
          setLiked(liked);
          setLikes(initialLikes);
          throw new Error('Failed to update like');
        }
        
        const data = await response.json();
        setLikes(data.likes);
        setLiked(data.liked);
      } catch (error) {
        console.error('Like error:', error);
        // Revert on error
        setLiked(liked);
        setLikes(initialLikes);
      }
    });
  };
  
  return (
    <button 
      onClick={handleLike}
      disabled={isPending}
      className={`like-button ${liked ? 'liked' : ''}`}
    >
      ❤️ {likes}
    </button>
  );
}
```

## 📊 Data Fetching Best Practices

### Server vs Client Decision Matrix

| Use Server Components When: | Use Client Components When: |
|----------------------------|----------------------------|
| Fetching data at build/request time | Need real-time updates |
| SEO is important | Handling user interactions |
| Sensitive data/API keys | Using browser APIs |
| Large dependencies | Managing local state |
| Static or rarely changing data | Optimistic updates |

### Caching Strategy Guidelines

| Data Type | Strategy | Revalidation |
|-----------|----------|-------------|
| Static content | Static generation | On deployment |
| Product catalog | ISR | Every hour |
| User-specific data | Dynamic | No caching |
| News/blog posts | ISR with tags | On-demand |
| Real-time data | Client-side | Live subscriptions |

### Performance Checklist
- ✅ Use Server Components for initial data loading
- ✅ Implement proper loading states
- ✅ Add error boundaries for graceful failures
- ✅ Use Suspense for progressive loading
- ✅ Implement prefetching for critical routes
- ✅ Cache static data appropriately
- ✅ Use optimistic updates for better UX

---

*This data fetching guide provides comprehensive patterns for building fast, reliable data-driven applications with Next.js App Router and AWS Amplify Gen 2.*

**Source**: Next.js 14+ Data Fetching Documentation  
**Last Updated**: Current  
**Compatibility**: Next.js 14+, React 18+, AWS Amplify Gen 2.x