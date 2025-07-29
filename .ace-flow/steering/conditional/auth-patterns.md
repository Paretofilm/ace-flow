---
name: auth-patterns
description: Authentication patterns and best practices for AWS Cognito
version: 1.0.0
inclusion: conditional
patterns:
  - "**/auth/**"
  - "**/authentication/**"
  - "**/login/**"
  - "**/signup/**"
  - "**/user/**"
keywords:
  - authentication
  - auth
  - login
  - signup
  - cognito
  - user management
  - password
---

# Authentication Patterns

This steering file is automatically loaded when working with authentication-related features.

## Cognito Configuration

### Standard Setup
```typescript
// amplify/auth/resource.ts
import { defineAuth } from '@aws-amplify/backend';

export const auth = defineAuth({
  loginWith: {
    email: true
  },
  userAttributes: {
    email: {
      required: true,
      mutable: false
    },
    preferredUsername: {
      required: false,
      mutable: true
    }
  },
  passwordPolicy: {
    minimumLength: 8,
    requireLowercase: true,
    requireUppercase: true,
    requireNumbers: true,
    requireSymbols: true
  },
  accountRecovery: 'EMAIL_ONLY'
});
```

## UI Components

### Login/Signup Flow
Always use Amplify UI components for consistency:

```typescript
import { Authenticator } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';

export function AuthFlow() {
  return (
    <Authenticator
      variation="modal"
      formFields={{
        signUp: {
          preferredUsername: {
            label: 'Username',
            placeholder: 'Choose a username',
            required: false
          }
        }
      }}
    >
      {({ signOut, user }) => (
        <App user={user} signOut={signOut} />
      )}
    </Authenticator>
  );
}
```

## Protected Routes

### Pattern for Next.js App Router
```typescript
// app/protected/layout.tsx
import { getCurrentUser } from 'aws-amplify/auth/server';
import { redirect } from 'next/navigation';

export default async function ProtectedLayout({
  children
}: {
  children: React.ReactNode
}) {
  try {
    await getCurrentUser();
  } catch (error) {
    redirect('/login');
  }
  
  return <>{children}</>;
}
```

## User Management

### Getting Current User
```typescript
import { getCurrentUser } from 'aws-amplify/auth';

export async function getUserInfo() {
  try {
    const { username, userId, signInDetails } = await getCurrentUser();
    return {
      username,
      userId,
      email: signInDetails?.loginId
    };
  } catch (error) {
    console.error('Not authenticated');
    return null;
  }
}
```

### Updating User Attributes
```typescript
import { updateUserAttributes } from 'aws-amplify/auth';

export async function updateProfile(attributes: Record<string, string>) {
  try {
    const result = await updateUserAttributes({
      userAttributes: attributes
    });
    
    // Handle verification if needed
    const unverified = Object.entries(result).filter(
      ([key, value]) => !value.isUpdated
    );
    
    return { success: true, unverified };
  } catch (error) {
    console.error('Update failed:', error);
    return { success: false, error };
  }
}
```

## Error Handling

### Auth Error Types
```typescript
import { isAuthError } from 'aws-amplify/auth';

export function handleAuthError(error: unknown) {
  if (!isAuthError(error)) {
    return 'An unexpected error occurred';
  }
  
  switch (error.name) {
    case 'UserNotFoundException':
      return 'No account found with this email';
    case 'NotAuthorizedException':
      return 'Incorrect password';
    case 'UserNotConfirmedException':
      return 'Please verify your email first';
    case 'UsernameExistsException':
      return 'An account with this email already exists';
    default:
      return error.message;
  }
}
```

## Session Management

### Auto Refresh
Sessions are automatically refreshed by Amplify. Monitor auth events:

```typescript
import { Hub } from 'aws-amplify/utils';

Hub.listen('auth', (data) => {
  switch (data.payload.event) {
    case 'signIn':
      console.log('User signed in');
      break;
    case 'signOut':
      console.log('User signed out');
      break;
    case 'tokenRefresh':
      console.log('Token refreshed');
      break;
  }
});
```

## Security Best Practices

1. **Never store tokens manually** - Let Amplify handle it
2. **Always validate on backend** - Don't trust client claims
3. **Use HTTPS only** - Never send auth data over HTTP
4. **Implement rate limiting** - Prevent brute force attacks
5. **Log auth events** - Track suspicious activity

## Multi-Factor Authentication

### Enable MFA
```typescript
import { setUpTOTP, verifyTOTPSetup } from 'aws-amplify/auth';

// Set up TOTP
const { secret, uri } = await setUpTOTP();
// Show QR code using uri

// Verify setup
await verifyTOTPSetup({ code: userEnteredCode });
```

## Social Sign-In

When adding social providers:
```typescript
export const auth = defineAuth({
  loginWith: {
    email: true,
    externalProviders: {
      google: {
        clientId: process.env.GOOGLE_CLIENT_ID!,
        clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
        scopes: ['email', 'profile']
      }
    }
  }
});
```

---

These patterns ensure secure, consistent authentication across the application. All auth-related code should follow these patterns.