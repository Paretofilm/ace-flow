# Recipe Sharing App - Technical Architecture Design

## Architecture Overview

The Recipe Sharing App is built on AWS Amplify Gen 2, leveraging a serverless architecture that provides scalability, security, and real-time capabilities. The application follows a modern cloud-native pattern with TypeScript-first development.

### High-Level Service Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                          Frontend (React/Next.js)                    │
│  ┌─────────────┐  ┌──────────────┐  ┌─────────────┐  ┌──────────┐ │
│  │   Auth UI   │  │  Recipe UI   │  │  Comments   │  │  Upload  │ │
│  │ Components  │  │  Components  │  │  Real-time  │  │    UI    │ │
│  └─────────────┘  └──────────────┘  └─────────────┘  └──────────┘ │
└─────────────────────────────────────────────────────────────────────┘
                                    │
                    ┌───────────────┴───────────────┐
                    │   AWS Amplify Data Client     │
                    │   (GraphQL + Subscriptions)   │
                    └───────────────┬───────────────┘
                                    │
┌─────────────────────────────────────────────────────────────────────┐
│                        AWS Cloud Infrastructure                      │
│  ┌─────────────┐  ┌──────────────┐  ┌─────────────┐  ┌──────────┐ │
│  │  Cognito    │  │   AppSync    │  │  DynamoDB   │  │    S3    │ │
│  │   (Auth)    │  │  (GraphQL)   │  │   (Data)    │  │ (Storage)│ │
│  └─────────────┘  └──────────────┘  └─────────────┘  └──────────┘ │
└─────────────────────────────────────────────────────────────────────┘
```

### Technology Stack

- **Frontend**: React with TypeScript, AWS Amplify UI Components
- **Backend**: AWS Amplify Gen 2, AppSync GraphQL API
- **Authentication**: Amazon Cognito with email-based auth
- **Database**: DynamoDB (managed by Amplify Data)
- **Storage**: Amazon S3 for recipe photos
- **Real-time**: AppSync Subscriptions for live updates
- **Deployment**: Amplify Hosting with CI/CD

## Data Models

### Complete Schema Definition

```typescript
// amplify/data/resource.ts
import { type ClientSchema, a, defineData } from '@aws-amplify/backend';

const schema = a.schema({
  Recipe: a.model({
    // Core fields
    title: a.string().required(),
    description: a.string().required(),
    ingredients: a.string().array().required(),
    instructions: a.string().required(),
    
    // Optional fields
    imageKey: a.string(),
    cookingTime: a.integer(),
    servings: a.integer(),
    
    // Metadata
    authorName: a.string(),
    createdAt: a.datetime(),
    updatedAt: a.datetime(),
    
    // Relationships
    comments: a.hasMany('Comment', 'recipeId'),
  }).authorization((allow) => [
    // Owner can perform all operations
    allow.owner(),
    // Authenticated users can read all recipes
    allow.authenticated().to(['read']),
  ]),
  
  Comment: a.model({
    // Core fields
    content: a.string().required(),
    
    // Relationship
    recipeId: a.id().required(),
    recipe: a.belongsTo('Recipe', 'recipeId'),
    
    // Metadata
    authorName: a.string().required(),
    createdAt: a.datetime(),
  }).authorization((allow) => [
    // Owner can delete their own comments
    allow.owner(),
    // All authenticated users can read comments
    allow.authenticated().to(['read']),
  ]),
});

export type Schema = ClientSchema<typeof schema>;
export const data = defineData({ 
  schema,
  authorizationModes: {
    defaultAuthorizationMode: 'userPool',
  },
});
```

### Data Relationships

- **Recipe → Comments**: One-to-many relationship
- **User → Recipe**: Owner-based relationship (implicit via Cognito)
- **User → Comment**: Owner-based relationship (implicit via Cognito)

## Authentication Strategy

### Cognito Configuration

```typescript
// amplify/auth/resource.ts
import { defineAuth } from '@aws-amplify/backend';

export const auth = defineAuth({
  loginWith: {
    email: true,
    phone: false
  },
  userAttributes: {
    email: {
      required: true,
      mutable: false
    },
    preferredUsername: {
      required: true,
      mutable: true
    }
  },
  passwordPolicy: {
    minLength: 8,
    requireLowercase: true,
    requireUppercase: true,
    requireNumbers: true,
    requireSymbols: true,
  },
  accountRecovery: 'EMAIL_ONLY',
  userAttributeVerification: {
    email: {
      required: true,
      verifyEmailSubject: 'Welcome to Recipe Sharing App!',
      verifyEmailMessage: (code) => `Your verification code is ${code}`,
    },
  },
});
```

### Authentication Flow

1. **Registration**: Email + Password → Cognito User Pool
2. **Email Verification**: Automatic via Cognito
3. **Login**: JWT tokens managed by Amplify
4. **Session Management**: Automatic refresh token handling
5. **Logout**: Clear all session data

## Storage Design

### S3 Bucket Configuration

```typescript
// amplify/storage/resource.ts
import { defineStorage } from '@aws-amplify/backend';

export const storage = defineStorage({
  name: 'recipePhotos',
  access: (allow) => ({
    'recipe-photos/{entity_id}/*': [
      // Owner can upload, update, delete their photos
      allow.entity('identity').to(['read', 'write', 'delete']),
      // Authenticated users can view photos
      allow.authenticated.to(['read']),
      // Public can view photos (for sharing)
      allow.guest.to(['read']),
    ],
  }),
});
```

### File Organization

```
recipe-photos/
├── {userId}/
│   ├── {recipeId}/
│   │   ├── {timestamp}-main.jpg
│   │   ├── {timestamp}-step1.jpg
│   │   └── {timestamp}-step2.jpg
```

### Upload Implementation

```typescript
import { uploadData, getUrl } from 'aws-amplify/storage';

// Upload with progress tracking
const uploadRecipePhoto = async (
  file: File, 
  recipeId: string,
  onProgress?: (percentage: number) => void
) => {
  // Validation
  const validTypes = ['image/jpeg', 'image/jpg', 'image/png'];
  if (!validTypes.includes(file.type)) {
    throw new Error('Invalid file type. Only JPG and PNG allowed.');
  }
  
  if (file.size > 5 * 1024 * 1024) {
    throw new Error('File too large. Maximum size is 5MB.');
  }
  
  // Upload
  const userId = getCurrentUser().userId;
  const path = `recipe-photos/${userId}/${recipeId}/${Date.now()}-${file.name}`;
  
  try {
    const result = await uploadData({
      path,
      data: file,
      options: {
        contentType: file.type,
        onProgress: ({ loaded, total }) => {
          const percentage = (loaded / total) * 100;
          onProgress?.(percentage);
        },
      },
    }).result;
    
    return result.path;
  } catch (error) {
    console.error('Upload failed:', error);
    throw new Error('Failed to upload photo');
  }
};

// Retrieve photo URL
const getRecipePhotoUrl = async (photoPath: string) => {
  try {
    const { url } = await getUrl({
      path: photoPath,
      options: {
        expiresIn: 3600, // 1 hour
        validateObjectExistence: true,
      },
    });
    return url.toString();
  } catch (error) {
    console.error('Failed to get photo URL:', error);
    return null;
  }
};
```

## API Design

### GraphQL Operations

#### Queries

```typescript
// List recipes with pagination
const listRecipes = async (nextToken?: string) => {
  const { data, errors, nextToken: newToken } = await client.models.Recipe.list({
    limit: 20,
    nextToken,
  });
  
  if (errors) {
    console.error('Failed to fetch recipes:', errors);
    throw new Error('Failed to load recipes');
  }
  
  return { recipes: data, nextToken: newToken };
};

// Get single recipe with comments
const getRecipeWithComments = async (recipeId: string) => {
  const { data: recipe, errors } = await client.models.Recipe.get({ 
    id: recipeId 
  });
  
  if (errors || !recipe) {
    throw new Error('Recipe not found');
  }
  
  // Load comments separately for better control
  const { data: comments } = await client.models.Comment.list({
    filter: { recipeId: { eq: recipeId } },
    sortDirection: 'ASC',
  });
  
  return { recipe, comments };
};
```

#### Mutations

```typescript
// Create recipe
const createRecipe = async (recipeData: RecipeInput) => {
  const user = await getCurrentUser();
  
  const { data: recipe, errors } = await client.models.Recipe.create({
    ...recipeData,
    authorName: user.username,
  });
  
  if (errors) {
    console.error('Recipe creation failed:', errors);
    throw new Error('Failed to create recipe');
  }
  
  return recipe;
};

// Update recipe
const updateRecipe = async (id: string, updates: Partial<RecipeInput>) => {
  const { data: updatedRecipe, errors } = await client.models.Recipe.update({
    id,
    ...updates,
  });
  
  if (errors) {
    console.error('Recipe update failed:', errors);
    throw new Error('Failed to update recipe');
  }
  
  return updatedRecipe;
};

// Delete recipe with cascade
const deleteRecipe = async (id: string) => {
  // Delete associated comments first
  const { data: comments } = await client.models.Comment.list({
    filter: { recipeId: { eq: id } },
  });
  
  // Delete all comments
  await Promise.all(
    comments.map(comment => 
      client.models.Comment.delete({ id: comment.id })
    )
  );
  
  // Delete recipe photos from S3
  const { data: recipe } = await client.models.Recipe.get({ id });
  if (recipe?.imageKey) {
    await remove({ path: recipe.imageKey });
  }
  
  // Delete the recipe
  const { data: deletedRecipe, errors } = await client.models.Recipe.delete({ id });
  
  if (errors) {
    console.error('Recipe deletion failed:', errors);
    throw new Error('Failed to delete recipe');
  }
  
  return deletedRecipe;
};
```

### Real-time Subscriptions

```typescript
// Recipe list subscription
export function useRealTimeRecipes() {
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    const subscription = client.models.Recipe.observeQuery().subscribe({
      next: ({ items, isSynced }) => {
        if (isSynced) {
          setRecipes([...items]);
          setLoading(false);
        }
      },
      error: (error) => console.error('Subscription error:', error),
    });
    
    return () => subscription.unsubscribe();
  }, []);
  
  return { recipes, loading };
}

// Comments subscription for specific recipe
export function useRecipeComments(recipeId: string) {
  const [comments, setComments] = useState<Comment[]>([]);
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    // Load existing comments
    const loadComments = async () => {
      const { data, errors } = await client.models.Comment.list({
        filter: { recipeId: { eq: recipeId } },
        sortDirection: 'ASC',
      });
      
      if (!errors) {
        setComments(data);
      }
      setLoading(false);
    };
    
    loadComments();
    
    // Subscribe to new comments
    const createSub = client.models.Comment.onCreate({
      filter: { recipeId: { eq: recipeId } },
    }).subscribe({
      next: (newComment) => {
        setComments(prev => [...prev, newComment]);
      },
      error: (error) => console.error('Subscription error:', error),
    });
    
    // Subscribe to comment deletions
    const deleteSub = client.models.Comment.onDelete({
      filter: { recipeId: { eq: recipeId } },
    }).subscribe({
      next: (deletedComment) => {
        setComments(prev => 
          prev.filter(comment => comment.id !== deletedComment.id)
        );
      },
      error: (error) => console.error('Subscription error:', error),
    });
    
    return () => {
      createSub.unsubscribe();
      deleteSub.unsubscribe();
    };
  }, [recipeId]);
  
  return { comments, loading };
}
```

## Frontend Architecture

### Component Structure

```
src/
├── components/
│   ├── auth/
│   │   ├── LoginForm.tsx
│   │   ├── RegisterForm.tsx
│   │   └── AuthWrapper.tsx
│   ├── recipes/
│   │   ├── RecipeList.tsx
│   │   ├── RecipeCard.tsx
│   │   ├── RecipeDetail.tsx
│   │   ├── RecipeForm.tsx
│   │   └── RecipePhotoUpload.tsx
│   ├── comments/
│   │   ├── CommentList.tsx
│   │   ├── CommentForm.tsx
│   │   └── CommentItem.tsx
│   └── common/
│       ├── LoadingSpinner.tsx
│       ├── ErrorBoundary.tsx
│       └── ConnectionStatus.tsx
├── hooks/
│   ├── useAuth.ts
│   ├── useRecipes.ts
│   ├── useComments.ts
│   └── useConnection.ts
├── utils/
│   ├── errorHandling.ts
│   ├── validation.ts
│   └── formatting.ts
└── types/
    └── index.ts
```

### State Management

Using React Context + Hooks for state management:

```typescript
// contexts/AppContext.tsx
interface AppContextType {
  user: AuthUser | null;
  connectionState: ConnectionState;
  recipes: Recipe[];
  loading: boolean;
}

export const AppContext = createContext<AppContextType>({
  user: null,
  connectionState: ConnectionState.Connected,
  recipes: [],
  loading: false,
});

// Custom hook for app state
export function useAppState() {
  const context = useContext(AppContext);
  if (!context) {
    throw new Error('useAppState must be used within AppProvider');
  }
  return context;
}
```

### Data Flow

1. **Authentication Flow**
   - User registers/logs in via Amplify UI components
   - Cognito returns JWT tokens
   - Tokens automatically attached to API requests

2. **Recipe CRUD Flow**
   - Create: Form → Validation → Photo Upload → GraphQL Mutation → Redirect
   - Read: GraphQL Query → Cache → Display with real-time updates
   - Update: Load current data → Edit → Validation → Mutation → Update cache
   - Delete: Confirmation → Delete comments → Delete photos → Delete recipe

3. **Real-time Comment Flow**
   - User posts comment → GraphQL Mutation
   - AppSync broadcasts to all subscribers
   - UI updates automatically without refresh

## Security Considerations

### Authorization Patterns

1. **Model-Level Authorization**
   - Recipes: Owners have full access, others read-only
   - Comments: Owners can delete, others read-only
   - Deny-by-default principle

2. **Field-Level Security**
   - Sensitive fields protected by authorization rules
   - Input validation on all user data
   - XSS prevention through proper escaping

3. **Storage Security**
   - Path-based access control
   - Signed URLs with expiration
   - File type and size validation

### Best Practices Implementation

```typescript
// Input sanitization
const sanitizeInput = (input: string): string => {
  return input
    .trim()
    .replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, '')
    .replace(/[<>]/g, '');
};

// Error handling without exposing internals
const handleError = (error: any, context: string): string => {
  console.error(`Error in ${context}:`, error);
  
  if (error.message.includes('Network')) {
    return 'Connection error. Please check your internet and try again.';
  }
  if (error.message.includes('Unauthorized')) {
    return 'You do not have permission to perform this action.';
  }
  if (error.message.includes('ValidationException')) {
    return 'Please check your input and try again.';
  }
  
  return 'An unexpected error occurred. Please try again.';
};

// Secure file upload
const secureFileUpload = async (file: File, allowedTypes: string[]) => {
  // Type validation
  if (!allowedTypes.includes(file.type)) {
    throw new Error(`Invalid file type. Allowed: ${allowedTypes.join(', ')}`);
  }
  
  // Size validation
  const maxSize = 5 * 1024 * 1024; // 5MB
  if (file.size > maxSize) {
    throw new Error('File too large. Maximum size is 5MB.');
  }
  
  // Filename sanitization
  const sanitizedName = file.name.replace(/[^a-zA-Z0-9.-]/g, '_');
  
  return { ...file, name: sanitizedName };
};
```

## Performance Optimizations

### Caching Strategy

```typescript
// Amplify's built-in caching with observeQuery
const useOptimizedRecipes = () => {
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  
  useEffect(() => {
    // ObserveQuery provides automatic caching and sync
    const subscription = client.models.Recipe.observeQuery({
      limit: 50,
    }).subscribe({
      next: ({ items, isSynced }) => {
        setRecipes([...items]);
        if (isSynced) {
          setIsLoading(false);
        }
      },
    });
    
    return () => subscription.unsubscribe();
  }, []);
  
  return { recipes, isLoading };
};
```

### Image Optimization

```typescript
// Progressive image loading
const ProgressiveImage: React.FC<{ src: string; alt: string }> = ({ src, alt }) => {
  const [imageSrc, setImageSrc] = useState<string>('');
  const [imageRef, setImageRef] = useState<string>('');
  const [loading, setLoading] = useState(true);
  
  useEffect(() => {
    // Load low-quality placeholder first
    const loadImage = async () => {
      try {
        // Get thumbnail URL (if implemented)
        const thumbnailUrl = await getUrl({
          path: src.replace(/\.(jpg|jpeg|png)$/i, '_thumb.$1'),
          options: { expiresIn: 3600 },
        });
        setImageRef(thumbnailUrl.toString());
        
        // Load full image
        const fullUrl = await getUrl({
          path: src,
          options: { expiresIn: 3600 },
        });
        
        // Preload full image
        const img = new Image();
        img.onload = () => {
          setImageSrc(fullUrl.toString());
          setLoading(false);
        };
        img.src = fullUrl.toString();
      } catch (error) {
        console.error('Failed to load image:', error);
        setLoading(false);
      }
    };
    
    loadImage();
  }, [src]);
  
  return (
    <div className="progressive-image">
      {loading && <div className="image-placeholder" />}
      <img
        src={imageSrc || imageRef}
        alt={alt}
        className={loading ? 'loading' : 'loaded'}
      />
    </div>
  );
};
```

### Pagination Implementation

```typescript
const usePaginatedRecipes = (pageSize: number = 20) => {
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [nextToken, setNextToken] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const [hasMore, setHasMore] = useState(true);
  
  const loadMore = useCallback(async () => {
    if (loading || !hasMore) return;
    
    setLoading(true);
    try {
      const { data, errors, nextToken: newToken } = await client.models.Recipe.list({
        limit: pageSize,
        nextToken,
      });
      
      if (!errors) {
        setRecipes(prev => [...prev, ...data]);
        setNextToken(newToken || null);
        setHasMore(!!newToken);
      }
    } catch (error) {
      console.error('Failed to load recipes:', error);
    } finally {
      setLoading(false);
    }
  }, [nextToken, loading, hasMore, pageSize]);
  
  return { recipes, loadMore, loading, hasMore };
};
```

### Offline Support

```typescript
// Connection state management
import { CONNECTION_STATE_CHANGE, ConnectionState } from 'aws-amplify/data';
import { Hub } from 'aws-amplify/utils';

export function useConnectionState() {
  const [connectionState, setConnectionState] = useState<ConnectionState>(
    ConnectionState.Connected
  );
  const [pendingChanges, setPendingChanges] = useState<number>(0);
  
  useEffect(() => {
    const hubListener = Hub.listen('api', (data: any) => {
      const { payload } = data;
      if (payload.event === CONNECTION_STATE_CHANGE) {
        const state = payload.data.connectionState as ConnectionState;
        setConnectionState(state);
        
        // Track pending changes
        if (state === ConnectionState.Disconnected) {
          console.log('Lost connection - changes will be queued');
        } else if (state === ConnectionState.Connected) {
          console.log('Connection restored - syncing changes');
        }
      }
    });
    
    return () => hubListener();
  }, []);
  
  return { connectionState, pendingChanges };
}

// Offline indicator component
const OfflineIndicator: React.FC = () => {
  const { connectionState } = useConnectionState();
  
  if (connectionState === ConnectionState.Connected) {
    return null;
  }
  
  return (
    <div className="offline-indicator">
      <span>Offline - Changes will sync when reconnected</span>
    </div>
  );
};
```

## Deployment Architecture

### Backend Deployment

```typescript
// amplify/backend.ts
import { defineBackend } from '@aws-amplify/backend';
import { auth } from './auth/resource';
import { data } from './data/resource';
import { storage } from './storage/resource';

defineBackend({
  auth,
  data,
  storage,
});
```

### Environment Configuration

```typescript
// Environment-specific settings
const getConfig = () => {
  const branch = process.env.AWS_BRANCH || 'main';
  
  return {
    // Different configs per environment
    imageUpload: {
      maxSize: branch === 'prod' ? 5 * 1024 * 1024 : 10 * 1024 * 1024,
      allowedTypes: ['image/jpeg', 'image/jpg', 'image/png'],
    },
    pagination: {
      defaultPageSize: branch === 'prod' ? 20 : 10,
    },
    cache: {
      ttl: branch === 'prod' ? 3600 : 300, // 1 hour prod, 5 min dev
    },
  };
};
```

### Monitoring and Logging

```typescript
// Structured logging
const logger = {
  info: (message: string, meta?: any) => {
    console.log(JSON.stringify({
      level: 'info',
      message,
      timestamp: new Date().toISOString(),
      ...meta,
    }));
  },
  error: (message: string, error: any, meta?: any) => {
    console.error(JSON.stringify({
      level: 'error',
      message,
      error: error.message,
      stack: error.stack,
      timestamp: new Date().toISOString(),
      ...meta,
    }));
  },
};

// Performance monitoring
const measurePerformance = async <T>(
  operation: string,
  fn: () => Promise<T>
): Promise<T> => {
  const start = performance.now();
  try {
    const result = await fn();
    const duration = performance.now() - start;
    logger.info(`Operation completed: ${operation}`, { duration });
    return result;
  } catch (error) {
    const duration = performance.now() - start;
    logger.error(`Operation failed: ${operation}`, error, { duration });
    throw error;
  }
};
```

## Cost Optimization

### Resource Usage Patterns

1. **DynamoDB**: On-demand pricing, auto-scaling
2. **S3 Storage**: Lifecycle policies for old images
3. **AppSync**: Caching to reduce resolver calls
4. **Cognito**: Free tier covers most small apps

### Cost Monitoring

```typescript
// Track API usage
const trackApiUsage = (operation: string) => {
  // Send to CloudWatch custom metrics
  logger.info('API Usage', {
    operation,
    timestamp: Date.now(),
    userId: getCurrentUser()?.userId,
  });
};

// Implement rate limiting
const rateLimiter = {
  uploads: new Map<string, number[]>(),
  
  checkLimit: (userId: string, limit: number = 10) => {
    const now = Date.now();
    const userUploads = rateLimiter.uploads.get(userId) || [];
    
    // Remove uploads older than 1 hour
    const recentUploads = userUploads.filter(
      time => now - time < 3600000
    );
    
    if (recentUploads.length >= limit) {
      throw new Error('Upload limit exceeded. Please try again later.');
    }
    
    recentUploads.push(now);
    rateLimiter.uploads.set(userId, recentUploads);
  },
};
```

## Summary

This architecture provides a scalable, secure, and performant foundation for the Recipe Sharing App using AWS Amplify Gen 2. Key benefits include:

- **Serverless scalability** with no infrastructure management
- **Real-time updates** for collaborative features
- **Type-safe development** with TypeScript throughout
- **Built-in security** with AWS best practices
- **Cost-effective** with pay-per-use pricing
- **Offline support** for better user experience
- **Modern development** experience with hot reloading and local testing

The implementation follows AWS Well-Architected Framework principles and leverages Amplify Gen 2's latest features for optimal results.