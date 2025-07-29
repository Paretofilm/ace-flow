# Requirements for Recipe Sharing App

## Overview
This document defines the comprehensive requirements for a recipe sharing application where users can create, share, and interact with recipes in real-time. All requirements follow EARS (Easy Approach to Requirements Syntax) notation and are backed by verified AWS Amplify Gen 2 implementations.

## Authentication Requirements

### User Registration
WHEN a new user visits the registration page
THE SYSTEM SHALL display a form with email, password, and confirm password fields

WHEN the user submits valid registration data
THE SYSTEM SHALL create a new Cognito user using the current auth configuration:

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
  }
});
```

WHEN the user submits invalid registration data
THE SYSTEM SHALL display specific validation errors using Amplify's built-in validation

WHEN the registration is successful
THE SYSTEM SHALL send a verification email automatically via Cognito

WHEN the user clicks the verification link
THE SYSTEM SHALL activate the account and redirect to the login page

### User Authentication
WHEN a user visits the login page
THE SYSTEM SHALL display email and password fields using Amplify UI components:

```typescript
import { Authenticator } from '@aws-amplify/ui-react';

export default function App() {
  return (
    <Authenticator>
      {({ signOut, user }) => (
        <main>
          <h1>Welcome {user.username}</h1>
          <button onClick={signOut}>Sign out</button>
        </main>
      )}
    </Authenticator>
  );
}
```

WHEN the user submits valid credentials
THE SYSTEM SHALL authenticate via Cognito and provide user session

WHEN the user submits invalid credentials
THE SYSTEM SHALL display Amplify's standardized error messages

WHEN a user exceeds failed login attempts
THE SYSTEM SHALL trigger Cognito's automatic account lockout policies

## Data Management Requirements

### Recipe Schema
WHEN defining the data model
THE SYSTEM SHALL implement the following schema with proper authorization:

```typescript
// amplify/data/resource.ts
import { type ClientSchema, a, defineData } from '@aws-amplify/backend';

const schema = a.schema({
  Recipe: a.model({
    title: a.string().required(),
    description: a.string().required(),
    ingredients: a.string().array().required(),
    instructions: a.string().required(),
    imageKey: a.string(),
    cookingTime: a.integer(),
    servings: a.integer(),
    authorName: a.string(),
    createdAt: a.datetime(),
    updatedAt: a.datetime(),
  }).authorization((allow) => [
    allow.owner(),
    allow.authenticated().to(['read']),
  ]),
  
  Comment: a.model({
    content: a.string().required(),
    recipeId: a.id().required(),
    recipe: a.belongsTo('Recipe', 'recipeId'),
    authorName: a.string().required(),
    createdAt: a.datetime(),
  }).authorization((allow) => [
    allow.owner(),
    allow.authenticated().to(['read']),
  ]),
});

export type Schema = ClientSchema<typeof schema>;
export const data = defineData({ schema });
```

### Recipe Creation
WHEN a user creates a new recipe
THE SYSTEM SHALL validate all required fields (title, description, ingredients, instructions)

WHEN validation passes
THE SYSTEM SHALL save the recipe using the current Amplify data client:

```typescript
import { generateClient } from 'aws-amplify/data';
import type { Schema } from '../amplify/data/resource';

const client = generateClient<Schema>();

const createRecipe = async (recipeData) => {
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
```

WHEN a recipe is successfully created
THE SYSTEM SHALL redirect the user to the recipe detail page

### Recipe Viewing
WHEN a user visits the recipes list page
THE SYSTEM SHALL display all recipes with pagination support:

```typescript
const fetchRecipes = async (nextToken?: string) => {
  const { data: recipes, errors, nextToken: newToken } = await client.models.Recipe.list({
    limit: 20,
    nextToken,
  });
  
  if (errors) {
    console.error('Failed to fetch recipes:', errors);
    return { recipes: [], nextToken: null };
  }
  
  return { recipes, nextToken: newToken };
};
```

WHEN a user clicks on a recipe
THE SYSTEM SHALL display the full recipe details including all fields

### Recipe Editing
WHEN a recipe owner clicks the edit button
THE SYSTEM SHALL load the current recipe data in an editable form

WHEN the owner submits valid changes
THE SYSTEM SHALL update the recipe:

```typescript
const updateRecipe = async (id: string, updates: any) => {
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
```

WHEN a non-owner attempts to edit a recipe
THE SYSTEM SHALL display an error message and prevent the action

### Recipe Deletion
WHEN a recipe owner clicks the delete button
THE SYSTEM SHALL display a confirmation dialog

WHEN the owner confirms deletion
THE SYSTEM SHALL delete the recipe and all associated data:

```typescript
const deleteRecipe = async (id: string) => {
  // Delete associated comments first
  const { data: comments } = await client.models.Comment.list({
    filter: { recipeId: { eq: id } },
  });
  
  for (const comment of comments) {
    await client.models.Comment.delete({ id: comment.id });
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

WHEN a non-owner attempts to delete a recipe
THE SYSTEM SHALL display an error message and prevent the action

## File Upload Requirements

### Photo Upload Configuration
WHEN configuring storage
THE SYSTEM SHALL implement the following S3 bucket configuration:

```typescript
// amplify/storage/resource.ts
import { defineStorage } from '@aws-amplify/backend';

export const storage = defineStorage({
  name: 'recipePhotos',
  access: (allow) => ({
    'recipe-photos/{entity_id}/*': [
      allow.entity('identity').to(['read', 'write', 'delete']),
      allow.authenticated.to(['read']),
      allow.guest.to(['read']),
    ],
  }),
});
```

### Photo Upload Process
WHEN a user selects a photo for their recipe
THE SYSTEM SHALL validate the file type (jpg, jpeg, png only) and size (max 5MB)

WHEN validation passes
THE SYSTEM SHALL upload the photo to S3 with progress tracking:

```typescript
import { uploadData } from 'aws-amplify/storage';

const uploadRecipePhoto = async (file: File, recipeId: string, onProgress?: (progress: number) => void) => {
  // Validate file
  const validTypes = ['image/jpeg', 'image/jpg', 'image/png'];
  if (!validTypes.includes(file.type)) {
    throw new Error('Invalid file type. Only JPG and PNG are allowed.');
  }
  
  if (file.size > 5 * 1024 * 1024) {
    throw new Error('File too large. Maximum size is 5MB.');
  }
  
  try {
    const result = await uploadData({
      path: `recipe-photos/${recipeId}/${Date.now()}-${file.name}`,
      data: file,
      options: {
        contentType: file.type,
        onProgress: (progress) => {
          const percentage = (progress.loaded / progress.total) * 100;
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
```

### Photo Display
WHEN displaying a recipe with photos
THE SYSTEM SHALL retrieve and display the photos from S3:

```typescript
import { getUrl } from 'aws-amplify/storage';

const getRecipePhotoUrl = async (photoPath: string) => {
  try {
    const { url } = await getUrl({
      path: photoPath,
      options: {
        expiresIn: 3600, // 1 hour
      },
    });
    return url;
  } catch (error) {
    console.error('Failed to get photo URL:', error);
    return null;
  }
};
```

## Real-time Comment Requirements

### Comment Creation
WHEN a user adds a comment to a recipe
THE SYSTEM SHALL validate the comment content (not empty, max 500 characters)

WHEN validation passes
THE SYSTEM SHALL save the comment and broadcast it to all viewers:

```typescript
const addComment = async (recipeId: string, content: string) => {
  if (!content || content.trim().length === 0) {
    throw new Error('Comment cannot be empty');
  }
  
  if (content.length > 500) {
    throw new Error('Comment cannot exceed 500 characters');
  }
  
  const { data: comment, errors } = await client.models.Comment.create({
    content: content.trim(),
    recipeId,
    authorName: user.username,
  });
  
  if (errors) {
    console.error('Failed to add comment:', errors);
    throw new Error('Failed to add comment');
  }
  
  return comment;
};
```

### Real-time Comment Updates
WHEN a user is viewing a recipe
THE SYSTEM SHALL display existing comments and subscribe to new comments in real-time:

```typescript
export function RecipeComments({ recipeId }: { recipeId: string }) {
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
    const subscription = client.models.Comment.onCreate({
      filter: { recipeId: { eq: recipeId } },
    }).subscribe({
      next: (newComment) => {
        setComments(prev => [...prev, newComment]);
      },
      error: (error) => console.error('Subscription error:', error),
    });

    return () => subscription.unsubscribe();
  }, [recipeId]);

  if (loading) return <div>Loading comments...</div>;

  return (
    <div className="comments-section">
      {comments.map(comment => (
        <div key={comment.id} className="comment">
          <strong>{comment.authorName}</strong>
          <time>{new Date(comment.createdAt).toLocaleString()}</time>
          <p>{comment.content}</p>
        </div>
      ))}
    </div>
  );
}
```

### Comment Deletion
WHEN a comment owner clicks delete on their comment
THE SYSTEM SHALL remove the comment from the database

WHEN a non-owner attempts to delete a comment
THE SYSTEM SHALL display an error and prevent the action

## Performance Requirements

### Response Time
WHEN a user performs any database query
THE SYSTEM SHALL return results within 2 seconds for 95% of requests

WHEN uploading photos
THE SYSTEM SHALL provide real-time progress feedback to the user

WHEN loading the application
THE SYSTEM SHALL display the main interface within 3 seconds

### Caching
WHEN fetching recipe data
THE SYSTEM SHALL implement caching using Amplify's built-in query caching:

```typescript
const { data: recipes } = await client.models.Recipe.observeQuery().subscribe({
  next: ({ items, isSynced }) => {
    // Items are automatically cached and updated
    setRecipes([...items]);
  },
});
```

### Offline Support
WHEN the network connection is lost
THE SYSTEM SHALL queue changes locally and sync when connection is restored:

```typescript
import { CONNECTION_STATE_CHANGE, ConnectionState } from 'aws-amplify/data';
import { Hub } from 'aws-amplify/utils';

export function useConnectionState() {
  const [connectionState, setConnectionState] = useState<ConnectionState>();

  useEffect(() => {
    const hubListener = Hub.listen('api', (data: any) => {
      const { payload } = data;
      if (payload.event === CONNECTION_STATE_CHANGE) {
        setConnectionState(payload.data.connectionState);
      }
    });

    return () => hubListener();
  }, []);

  return connectionState;
}
```

## Security Requirements

### Authentication
WHEN accessing any authenticated endpoint
THE SYSTEM SHALL verify the user's Cognito JWT token

WHEN a token expires
THE SYSTEM SHALL automatically refresh it or redirect to login

### Authorization
WHEN a user attempts to modify a recipe
THE SYSTEM SHALL verify they are the owner before allowing the operation

WHEN a user attempts to delete a comment
THE SYSTEM SHALL verify they are the comment author

### Data Validation
WHEN receiving any user input
THE SYSTEM SHALL sanitize and validate the data before processing

WHEN storing user-generated content
THE SYSTEM SHALL escape HTML and prevent XSS attacks

## Error Handling Requirements

### User-Friendly Errors
WHEN any operation fails
THE SYSTEM SHALL display a user-friendly error message

WHEN network errors occur
THE SYSTEM SHALL inform the user and suggest retry actions

### Error Logging
WHEN errors occur
THE SYSTEM SHALL log detailed information for debugging:

```typescript
const handleError = (error: any, context: string) => {
  console.error(`Error in ${context}:`, error);
  
  // User-friendly message mapping
  const userMessage = error.message.includes('Network')
    ? 'Connection error. Please check your internet and try again.'
    : error.message.includes('Unauthorized')
    ? 'You do not have permission to perform this action.'
    : 'An unexpected error occurred. Please try again.';
    
  return userMessage;
};
```

## Acceptance Criteria

### Authentication
- Users can register with email and password
- Email verification is required before login
- Login persists across browser sessions
- Logout clears all session data

### Recipe Management
- Recipes display with all fields correctly
- Only owners can edit/delete their recipes
- Photo upload shows progress indicator
- Photos display correctly in recipe view

### Real-time Features
- Comments appear instantly for all viewers
- No page refresh required for updates
- Connection status is visible to users
- Offline changes sync when reconnected

### Performance
- Page loads complete within 3 seconds
- API responses return within 2 seconds
- Photo uploads show real-time progress
- Pagination works smoothly for large datasets

### Security
- Non-owners cannot modify others' content
- All inputs are validated and sanitized
- Authentication is required for protected actions
- Errors do not expose sensitive information