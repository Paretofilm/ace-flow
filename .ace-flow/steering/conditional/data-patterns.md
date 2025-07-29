---
name: data-patterns
description: Data modeling patterns and best practices for DynamoDB with Amplify
version: 1.0.0
inclusion: conditional
patterns:
  - "**/data/**"
  - "**/models/**"
  - "**/schema/**"
  - "amplify/data/resource.ts"
keywords:
  - data
  - model
  - schema
  - database
  - dynamodb
  - relationships
---

# Data Modeling Patterns

This steering file is automatically loaded when working with data models and schemas.

## Schema Design Principles

### 1. Start with Access Patterns
Before designing your schema, list all access patterns:
- Get user by ID
- List recipes by user
- Get recipe with comments
- List trending recipes

### 2. Use Consistent Naming
- Models: Singular, PascalCase (e.g., `Recipe`, not `Recipes`)
- Fields: camelCase (e.g., `createdAt`, not `created_at`)
- Relationships: descriptive names (e.g., `authorProfile`, not just `user`)

## Common Patterns

### One-to-Many Relationships
```typescript
const schema = a.schema({
  Recipe: a.model({
    title: a.string().required(),
    description: a.string(),
    authorId: a.id().required(),
    author: a.belongsTo('User', 'authorId'),
    comments: a.hasMany('Comment', 'recipeId'),
  }),
  
  Comment: a.model({
    content: a.string().required(),
    recipeId: a.id().required(),
    recipe: a.belongsTo('Recipe', 'recipeId'),
    authorId: a.id().required(),
    author: a.belongsTo('User', 'authorId'),
  }),
  
  User: a.model({
    username: a.string().required(),
    email: a.email().required(),
    recipes: a.hasMany('Recipe', 'authorId'),
    comments: a.hasMany('Comment', 'authorId'),
  })
});
```

### Many-to-Many Relationships
```typescript
const schema = a.schema({
  Recipe: a.model({
    title: a.string().required(),
    tags: a.hasMany('RecipeTag', 'recipeId'),
  }),
  
  Tag: a.model({
    name: a.string().required(),
    recipes: a.hasMany('RecipeTag', 'tagId'),
  }),
  
  RecipeTag: a.model({
    recipeId: a.id().required(),
    tagId: a.id().required(),
    recipe: a.belongsTo('Recipe', 'recipeId'),
    tag: a.belongsTo('Tag', 'tagId'),
  })
  .identifier(['recipeId', 'tagId']), // Composite key
});
```

## Authorization Patterns

### Owner-Based Access
```typescript
Recipe: a.model({
  // ... fields
}).authorization((allow) => [
  allow.owner(), // Owner can do everything
  allow.authenticated().to(['read']), // Others can read
  allow.guest().to(['read']), // Guests can read
])
```

### Group-Based Access
```typescript
Project: a.model({
  // ... fields
  teamId: a.id().required(),
}).authorization((allow) => [
  allow.group('Admin'), // Admins can do everything
  allow.owner(), // Owner has full access
  allow.authenticated()
    .to(['read'])
    .withClaimIn('teamId', ['teamId']), // Team members can read
])
```

### Custom Authorization
```typescript
Document: a.model({
  // ... fields
  visibility: a.enum(['public', 'private', 'team']),
}).authorization((allow) => [
  allow.custom({
    provider: 'visibilityAuth',
    operations: ['read'],
  }),
  allow.owner(),
])
```

## Data Types and Validation

### Common Field Types
```typescript
const schema = a.schema({
  Example: a.model({
    // Basic types
    text: a.string(),
    number: a.integer(),
    decimal: a.float(),
    bool: a.boolean(),
    
    // With constraints
    requiredText: a.string().required(),
    limitedText: a.string().required().maxLength(100),
    positiveInt: a.integer().min(0),
    percentage: a.float().min(0).max(100),
    
    // Special types
    email: a.email().required(),
    url: a.url(),
    phone: a.phone(),
    timestamp: a.datetime(),
    date: a.date(),
    time: a.time(),
    
    // Complex types
    metadata: a.json(),
    tags: a.string().array(),
    status: a.enum(['draft', 'published', 'archived']),
    
    // Relationships
    userId: a.id().required(),
    user: a.belongsTo('User', 'userId'),
  })
});
```

## Indexing Strategies

### Secondary Indexes
```typescript
const schema = a.schema({
  Post: a.model({
    title: a.string().required(),
    authorId: a.id().required(),
    categoryId: a.id().required(),
    publishedAt: a.datetime(),
    status: a.enum(['draft', 'published']),
  })
  .secondaryIndexes((index) => [
    index('authorId').sortKeys(['publishedAt']).name('byAuthor'),
    index('categoryId').sortKeys(['publishedAt']).name('byCategory'),
    index('status').sortKeys(['publishedAt']).name('byStatus'),
  ])
});
```

## Query Patterns

### Efficient Queries
```typescript
// Get all recipes by author, sorted by date
const { data: recipes } = await client.models.Recipe.list({
  filter: { authorId: { eq: userId } },
  sortDirection: 'DESC',
});

// Paginated queries
const { data: page1, nextToken } = await client.models.Recipe.list({
  limit: 20,
});

const { data: page2 } = await client.models.Recipe.list({
  limit: 20,
  nextToken,
});

// Complex filtering
const { data: filtered } = await client.models.Recipe.list({
  filter: {
    and: [
      { status: { eq: 'published' } },
      { rating: { ge: 4 } },
      { or: [
        { category: { eq: 'dessert' } },
        { category: { eq: 'snack' } },
      ]},
    ],
  },
});
```

## Real-Time Subscriptions

### Subscription Patterns
```typescript
// Subscribe to all changes
const subscription = client.models.Recipe.observeQuery().subscribe({
  next: ({ items, isSynced }) => {
    if (isSynced) {
      setRecipes(items);
    }
  },
});

// Subscribe with filter
const myRecipesSub = client.models.Recipe.observeQuery({
  filter: { authorId: { eq: currentUserId } },
}).subscribe({
  next: ({ items }) => setMyRecipes(items),
});

// Subscribe to specific operations
const createSub = client.models.Recipe.onCreate().subscribe({
  next: (newRecipe) => addRecipeToList(newRecipe),
});
```

## Data Migration

### Adding Fields
```typescript
// Safe to add optional fields
Recipe: a.model({
  title: a.string().required(),
  description: a.string(),
  // New optional field - safe to add
  featured: a.boolean().default(false),
});
```

### Changing Field Types
```typescript
// Create new field, migrate data, remove old field
Recipe: a.model({
  // Old field (mark for removal)
  ratingOld: a.integer(),
  // New field
  rating: a.float(),
});
```

## Performance Optimization

### Denormalization When Needed
```typescript
// Instead of multiple queries
Comment: a.model({
  content: a.string().required(),
  recipeId: a.id().required(),
  // Denormalized for performance
  recipeTitle: a.string(), // Copy from Recipe
  authorUsername: a.string(), // Copy from User
});
```

### Batch Operations
```typescript
// Batch create
const recipes = recipesData.map(data => 
  client.models.Recipe.create(data)
);
const results = await Promise.all(recipes);

// Batch delete with error handling
const deleteOps = ids.map(async (id) => {
  try {
    await client.models.Recipe.delete({ id });
    return { id, success: true };
  } catch (error) {
    return { id, success: false, error };
  }
});
const deleteResults = await Promise.all(deleteOps);
```

---

These patterns ensure efficient, scalable data modeling with DynamoDB through Amplify. Always consider your access patterns first, then design your schema to support them.