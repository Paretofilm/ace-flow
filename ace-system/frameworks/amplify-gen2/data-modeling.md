# AWS Amplify Gen 2 Data Modeling

**Comprehensive guide to GraphQL schema design, relationships, and data patterns in Amplify Gen 2.**

## 🏗️ Schema Fundamentals

### Basic Model Definition
```typescript
import { type ClientSchema, a, defineData } from '@aws-amplify/backend';

const schema = a.schema({
  // Basic model with common field types
  Product: a
    .model({
      name: a.string().required(),
      description: a.string(),
      price: a.float().required(),
      inStock: a.boolean().default(true),
      category: a.enum(['electronics', 'clothing', 'books']),
      tags: a.string().array(),
      metadata: a.json(),
      createdAt: a.datetime(),
      updatedAt: a.datetime(),
    })
    .authorization((allow) => [
      allow.authenticated().to(['read']),
      allow.group('admins'),
    ]),
});

export type Schema = ClientSchema<typeof schema>;
export const data = defineData({ schema });
```

### Field Types Reference
```typescript
const schema = a.schema({
  Example: a.model({
    // String types
    title: a.string(),                    // Optional string
    slug: a.string().required(),          // Required string
    email: a.email(),                     // Email validation
    url: a.url(),                         // URL validation
    
    // Numeric types
    age: a.integer(),                     // Integer
    price: a.float(),                     // Decimal number
    rating: a.float().range(1, 5),        // Constrained range
    
    // Boolean and temporal
    isActive: a.boolean().default(true),   // Boolean with default
    createdAt: a.datetime(),              // ISO datetime
    publishDate: a.date(),                // Date only
    
    // Complex types
    tags: a.string().array(),             // Array of strings
    metadata: a.json(),                   // JSON object
    status: a.enum(['draft', 'published', 'archived']),
    
    // ID and references
    id: a.id(),                          // Auto-generated ID
    externalId: a.string().primaryKey(), // Custom primary key
  }),
});
```

## 🔗 Relationships

### One-to-Many (Has Many)
```typescript
const schema = a.schema({
  Blog: a
    .model({
      name: a.string().required(),
      description: a.string(),
      posts: a.hasMany('Post', 'blogId'), // One blog has many posts
    })
    .authorization((allow) => [allow.owner()]),
    
  Post: a
    .model({
      title: a.string().required(),
      content: a.string().required(),
      blogId: a.id(),
      blog: a.belongsTo('Blog', 'blogId'), // Post belongs to blog
    })
    .authorization((allow) => [allow.owner()]),
});
```

### Many-to-Many
```typescript
const schema = a.schema({
  User: a
    .model({
      name: a.string().required(),
      email: a.email().required(),
      groups: a.manyToMany('Group', 'UserGroup'), // Many users, many groups
    })
    .authorization((allow) => [allow.owner()]),
    
  Group: a
    .model({
      name: a.string().required(),
      description: a.string(),
      users: a.manyToMany('User', 'UserGroup'),
    })
    .authorization((allow) => [allow.authenticated()]),
    
  // Junction table (automatically created but can be customized)
  UserGroup: a
    .model({
      userId: a.id().required(),
      groupId: a.id().required(),
      role: a.enum(['member', 'admin']).default('member'),
      joinedAt: a.datetime().default(new Date().toISOString()),
    })
    .authorization((allow) => [allow.owner()]),
});
```

### Self-Referencing Relationships
```typescript
const schema = a.schema({
  Comment: a
    .model({
      content: a.string().required(),
      authorId: a.id().required(),
      postId: a.id().required(),
      parentCommentId: a.id(),
      
      // Self-referencing relationships for nested comments
      parentComment: a.belongsTo('Comment', 'parentCommentId'),
      replies: a.hasMany('Comment', 'parentCommentId'),
    })
    .authorization((allow) => [
      allow.authenticated().to(['read', 'create']),
      allow.owner().to(['update', 'delete']),
    ]),
});
```

## 🔐 Authorization Patterns

### Owner-Based Authorization
```typescript
const schema = a.schema({
  UserProfile: a
    .model({
      displayName: a.string(),
      bio: a.string(),
      avatar: a.string(),
    })
    .authorization((allow) => [
      allow.owner(),                           // Owner can do everything
      allow.authenticated().to(['read']),      // Others can read
    ]),
});
```

### Group-Based Authorization
```typescript
const schema = a.schema({
  AdminSettings: a
    .model({
      key: a.string().required(),
      value: a.string().required(),
    })
    .authorization((allow) => [
      allow.group('admins'),                   // Only admins
      allow.group('moderators').to(['read']), // Moderators read-only
    ]),
});
```

### Custom Authorization
```typescript
const schema = a.schema({
  Post: a
    .model({
      title: a.string().required(),
      content: a.string().required(),
      authorId: a.id().required(),
      isPublished: a.boolean().default(false),
    })
    .authorization((allow) => [
      allow.owner(),
      allow.authenticated().to(['read']).where((post) => 
        post.isPublished.eq(true)
      ),
      allow.guest().to(['read']).where((post) => 
        post.isPublished.eq(true)
      ),
    ]),
});
```

### Multi-Owner Authorization
```typescript
const schema = a.schema({
  Project: a
    .model({
      name: a.string().required(),
      description: a.string(),
      owners: a.string().array(), // Array of owner IDs
    })
    .authorization((allow) => [
      allow.owners('owners'),      // Multiple owners
      allow.authenticated().to(['read']),
    ]),
});
```

## 📊 Advanced Patterns

### Audit Trail Pattern
```typescript
const schema = a.schema({
  // Base audit fields as a custom type
  AuditFields: a.customType({
    createdAt: a.datetime().required(),
    updatedAt: a.datetime().required(),
    createdBy: a.id().required(),
    updatedBy: a.id().required(),
    version: a.integer().default(1),
  }),
  
  Document: a
    .model({
      title: a.string().required(),
      content: a.string().required(),
      
      // Include audit fields
      audit: a.ref('AuditFields'),
      
      // Track document history
      history: a.hasMany('DocumentHistory', 'documentId'),
    })
    .authorization((allow) => [allow.owner()]),
    
  DocumentHistory: a
    .model({
      documentId: a.id().required(),
      title: a.string().required(),
      content: a.string().required(),
      changeReason: a.string(),
      changedBy: a.id().required(),
      changedAt: a.datetime().required(),
    })
    .authorization((allow) => [allow.owner()]),
});
```

### Soft Delete Pattern
```typescript
const schema = a.schema({
  Post: a
    .model({
      title: a.string().required(),
      content: a.string().required(),
      isDeleted: a.boolean().default(false),
      deletedAt: a.datetime(),
      deletedBy: a.id(),
    })
    .authorization((allow) => [
      allow.owner(),
      // Hide deleted posts from regular queries
      allow.authenticated().to(['read']).where((post) => 
        post.isDeleted.eq(false)
      ),
    ]),
});
```

### Hierarchical Data Pattern
```typescript
const schema = a.schema({
  Category: a
    .model({
      name: a.string().required(),
      slug: a.string().required(),
      parentId: a.id(),
      level: a.integer().default(0),
      path: a.string(), // e.g., "/electronics/computers/laptops"
      
      // Self-referencing relationships
      parent: a.belongsTo('Category', 'parentId'),
      children: a.hasMany('Category', 'parentId'),
      
      // Products in this category
      products: a.hasMany('Product', 'categoryId'),
    })
    .authorization((allow) => [
      allow.authenticated().to(['read']),
      allow.group('admins'),
    ]),
});
```

### Event Sourcing Pattern
```typescript
const schema = a.schema({
  // Aggregate root
  ShoppingCart: a
    .model({
      userId: a.id().required(),
      status: a.enum(['active', 'checked_out', 'abandoned']),
      totalItems: a.integer().default(0),
      totalAmount: a.float().default(0),
      lastUpdated: a.datetime(),
    })
    .authorization((allow) => [allow.owner()]),
    
  // Events that modify the cart
  CartEvent: a
    .model({
      cartId: a.id().required(),
      eventType: a.enum(['item_added', 'item_removed', 'quantity_changed', 'checkout']),
      eventData: a.json(), // Event-specific data
      timestamp: a.datetime().required(),
      userId: a.id().required(),
    })
    .authorization((allow) => [allow.owner()]),
});
```

## 🎯 Query Patterns

### Basic Queries
```typescript
// Generated client usage
const client = generateClient<Schema>();

// Create
const newPost = await client.models.Post.create({
  title: "My Post",
  content: "Post content",
  blogId: "blog-123",
});

// Read single
const post = await client.models.Post.get({ id: "post-123" });

// List with filters
const publishedPosts = await client.models.Post.list({
  filter: {
    isPublished: { eq: true },
    createdAt: { gt: "2024-01-01" },
  },
  limit: 20,
});

// Update
const updatedPost = await client.models.Post.update({
  id: "post-123",
  title: "Updated Title",
});

// Delete
await client.models.Post.delete({ id: "post-123" });
```

### Advanced Queries
```typescript
// Complex filtering
const results = await client.models.Product.list({
  filter: {
    and: [
      { category: { eq: 'electronics' } },
      { price: { between: [100, 500] } },
      { inStock: { eq: true } },
      {
        or: [
          { tags: { contains: 'featured' } },
          { rating: { ge: 4.5 } },
        ],
      },
    ],
  },
  sort: {
    field: 'price',
    direction: 'asc',
  },
});

// Nested queries with relationships
const blogWithPosts = await client.models.Blog.get(
  { id: "blog-123" },
  { 
    selectionSet: [
      'id',
      'name',
      'posts.id',
      'posts.title',
      'posts.createdAt',
    ],
  }
);
```

### Real-time Subscriptions
```typescript
// Subscribe to all changes
const subscription = client.models.Post.observeQuery().subscribe({
  next: ({ items, isSynced }) => {
    console.log('Posts updated:', items);
    console.log('Is synced with server:', isSynced);
  },
});

// Subscribe to specific operations
const createSubscription = client.models.Post.onCreate().subscribe({
  next: (post) => {
    console.log('New post created:', post);
  },
});

const updateSubscription = client.models.Post.onUpdate({
  filter: { authorId: { eq: currentUserId } },
}).subscribe({
  next: (post) => {
    console.log('My post updated:', post);
  },
});
```

## ⚠️ Data Modeling Best Practices

### Schema Design
- **Start Simple**: Begin with basic models, add complexity gradually
- **Normalize Carefully**: Balance normalization with query efficiency
- **Plan for Scale**: Consider query patterns and access frequency
- **Version Changes**: Plan for schema evolution and migrations

### Performance Optimization
- **Indexing**: Use secondary indexes for frequently queried fields
- **Batch Operations**: Group related operations when possible
- **Pagination**: Always implement pagination for list queries
- **Caching**: Leverage built-in caching mechanisms

### Security Considerations
- **Principle of Least Privilege**: Grant minimum necessary permissions
- **Data Validation**: Validate data on both client and server
- **Sensitive Data**: Use appropriate field types for PII
- **Audit Trails**: Implement logging for sensitive operations

### Common Pitfalls
- **Over-normalization**: Can lead to complex queries and poor performance
- **Missing Authorization**: Always define explicit authorization rules
- **Circular References**: Be careful with bidirectional relationships
- **Schema Breaking Changes**: Plan migrations for production schemas

---

*This data modeling guide provides patterns and best practices for building scalable, secure applications with AWS Amplify Gen 2.*

**Source**: AWS Amplify Gen 2 Data Documentation  
**Last Updated**: Current  
**Compatibility**: Amplify Gen 2.x, GraphQL specification