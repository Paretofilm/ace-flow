# AWS Amplify Gen 2 Authentication

**Complete guide to user authentication, authorization, and identity management in Amplify Gen 2.**

## 🔐 Authentication Setup

### Basic Configuration
```typescript
// amplify/auth/resource.ts
import { defineAuth } from '@aws-amplify/backend';

export const auth = defineAuth({
  loginWith: {
    email: true,
    username: false,
    phone: false,
  },
  userAttributes: {
    email: {
      required: true,
      mutable: true,
    },
    name: {
      required: true,
      mutable: true,
    },
    picture: {
      required: false,
      mutable: true,
    },
  },
  passwordPolicy: {
    minLength: 8,
    requireNumbers: true,
    requireLowercase: true,
    requireUppercase: true,
    requireSymbols: true,
  },
});
```

### Social Provider Configuration
```typescript
// amplify/auth/resource.ts
import { defineAuth } from '@aws-amplify/backend';

export const auth = defineAuth({
  loginWith: {
    email: true,
    externalProviders: {
      google: {
        clientId: process.env.GOOGLE_CLIENT_ID,
        clientSecret: process.env.GOOGLE_CLIENT_SECRET,
        scopes: ['email', 'profile'],
      },
      facebook: {
        clientId: process.env.FACEBOOK_CLIENT_ID,
        clientSecret: process.env.FACEBOOK_CLIENT_SECRET,
        scopes: ['email', 'public_profile'],
      },
      apple: {
        clientId: process.env.APPLE_CLIENT_ID,
        keyId: process.env.APPLE_KEY_ID,
        privateKey: process.env.APPLE_PRIVATE_KEY,
        teamId: process.env.APPLE_TEAM_ID,
        scopes: ['email', 'name'],
      },
      oidc: {
        name: 'CustomOIDC',
        clientId: process.env.OIDC_CLIENT_ID,
        clientSecret: process.env.OIDC_CLIENT_SECRET,
        issuerUrl: 'https://your-oidc-provider.com',
      },
      saml: {
        name: 'EnterpriseSSO',
        metadataURL: 'https://your-saml-provider.com/metadata',
      },
    },
    // Redirect URLs for social login
    callbackUrls: [
      'http://localhost:3000/',
      'https://yourdomain.com/',
    ],
    logoutUrls: [
      'http://localhost:3000/',
      'https://yourdomain.com/',
    ],
  },
});
```

## 👥 User Groups and Roles

### Group Configuration
```typescript
// amplify/auth/resource.ts with groups
import { defineAuth } from '@aws-amplify/backend';

export const auth = defineAuth({
  loginWith: { email: true },
  groups: ['admins', 'moderators', 'premium_users'],
  triggers: {
    postConfirmation: './post-confirmation-trigger.ts',
  },
});
```

### Post-Confirmation Trigger
```typescript
// amplify/auth/post-confirmation-trigger.ts
import { PostConfirmationTriggerHandler } from 'aws-lambda';
import { CognitoIdentityProviderClient, AdminAddUserToGroupCommand } from '@aws-sdk/client-cognito-identity-provider';

const cognitoClient = new CognitoIdentityProviderClient();

export const handler: PostConfirmationTriggerHandler = async (event) => {
  const { userPoolId, userName } = event;
  
  // Auto-assign user to default group
  const command = new AdminAddUserToGroupCommand({
    UserPoolId: userPoolId,
    Username: userName,
    GroupName: 'users', // Default group
  });
  
  try {
    await cognitoClient.send(command);
    console.log(`User ${userName} added to users group`);
  } catch (error) {
    console.error('Error adding user to group:', error);
  }
  
  return event;
};
```

## 🎯 Frontend Authentication

### Authenticator Component
```typescript
// src/components/AuthenticatedApp.tsx
'use client';

import { Authenticator, ThemeProvider, Theme } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';

// Custom theme
const theme: Theme = {
  name: 'custom-theme',
  tokens: {
    colors: {
      brand: {
        primary: {
          10: '#f0f9ff',
          80: '#1d4ed8',
          90: '#1e40af',
          100: '#1e3a8a',
        },
      },
    },
    components: {
      authenticator: {
        router: {
          borderWidth: '0',
          backgroundColor: 'white',
        },
      },
    },
  },
};

const formFields = {
  signUp: {
    name: {
      label: 'Full Name',
      placeholder: 'Enter your full name',
      required: true,
      order: 1,
    },
    email: {
      label: 'Email Address',
      placeholder: 'Enter your email',
      required: true,
      order: 2,
    },
    password: {
      label: 'Password',
      placeholder: 'Enter your password',
      required: true,
      order: 3,
    },
    confirm_password: {
      label: 'Confirm Password',
      placeholder: 'Confirm your password',
      required: true,
      order: 4,
    },
  },
};

const services = {
  async handleSignUp(formData: any) {
    const { username, password, attributes } = formData;
    // Custom sign-up logic
    return { username, password, attributes };
  },
};

export function AuthenticatedApp({ children }: { children: React.ReactNode }) {
  return (
    <ThemeProvider theme={theme}>
      <Authenticator
        formFields={formFields}
        services={services}
        components={{
          Header: () => (
            <div className="text-center p-4">
              <h1 className="text-2xl font-bold">Welcome to My App</h1>
            </div>
          ),
          Footer: () => (
            <div className="text-center p-4 text-sm text-gray-600">
              © 2024 My Company. All rights reserved.
            </div>
          ),
        }}
      >
        {({ signOut, user }) => (
          <div>
            <nav className="bg-white shadow">
              <div className="flex justify-between items-center p-4">
                <h1 className="text-xl font-semibold">My App</h1>
                <div className="flex items-center space-x-4">
                  <span>Hello, {user?.attributes?.name || user?.username}</span>
                  <button
                    onClick={signOut}
                    className="bg-red-500 text-white px-4 py-2 rounded"
                  >
                    Sign Out
                  </button>
                </div>
              </div>
            </nav>
            <main>{children}</main>
          </div>
        )}
      </Authenticator>
    </ThemeProvider>
  );
}
```

### Manual Authentication
```typescript
// src/lib/auth.ts
import {
  signUp,
  signIn,
  signOut,
  confirmSignUp,
  resendSignUpCode,
  resetPassword,
  confirmResetPassword,
  updatePassword,
  updateUserAttributes,
  getCurrentUser,
  fetchUserAttributes,
  signInWithRedirect,
} from 'aws-amplify/auth';

// Sign Up
export const handleSignUp = async (email: string, password: string, name: string) => {
  try {
    const result = await signUp({
      username: email,
      password,
      attributes: {
        email,
        name,
      },
    });
    return result;
  } catch (error) {
    console.error('Sign up error:', error);
    throw error;
  }
};

// Confirm Sign Up
export const handleConfirmSignUp = async (email: string, code: string) => {
  try {
    const result = await confirmSignUp({
      username: email,
      confirmationCode: code,
    });
    return result;
  } catch (error) {
    console.error('Confirm sign up error:', error);
    throw error;
  }
};

// Sign In
export const handleSignIn = async (email: string, password: string) => {
  try {
    const result = await signIn({
      username: email,
      password,
    });
    return result;
  } catch (error) {
    console.error('Sign in error:', error);
    throw error;
  }
};

// Social Sign In
export const handleSocialSignIn = (provider: 'Google' | 'Facebook' | 'Apple') => {
  signInWithRedirect({ provider });
};

// Sign Out
export const handleSignOut = async () => {
  try {
    await signOut();
  } catch (error) {
    console.error('Sign out error:', error);
    throw error;
  }
};

// Get Current User
export const getCurrentUserInfo = async () => {
  try {
    const user = await getCurrentUser();
    const attributes = await fetchUserAttributes();
    return { user, attributes };
  } catch (error) {
    console.error('Get current user error:', error);
    return null;
  }
};

// Update User Attributes
export const updateUserProfile = async (attributes: Record<string, string>) => {
  try {
    const result = await updateUserAttributes({
      userAttributes: attributes,
    });
    return result;
  } catch (error) {
    console.error('Update user attributes error:', error);
    throw error;
  }
};

// Password Reset
export const handlePasswordReset = async (email: string) => {
  try {
    const result = await resetPassword({ username: email });
    return result;
  } catch (error) {
    console.error('Password reset error:', error);
    throw error;
  }
};

export const handleConfirmPasswordReset = async (
  email: string,
  code: string,
  newPassword: string
) => {
  try {
    const result = await confirmResetPassword({
      username: email,
      confirmationCode: code,
      newPassword,
    });
    return result;
  } catch (error) {
    console.error('Confirm password reset error:', error);
    throw error;
  }
};
```

## 🔒 Authorization Patterns

### User Context Hook
```typescript
// src/hooks/useUser.ts
'use client';

import { useState, useEffect, createContext, useContext } from 'react';
import { getCurrentUser, fetchUserAttributes } from 'aws-amplify/auth';
import { Hub } from 'aws-amplify/utils';

interface UserContextType {
  user: any;
  attributes: Record<string, string>;
  isLoading: boolean;
  isAdmin: boolean;
  groups: string[];
  refreshUser: () => Promise<void>;
}

const UserContext = createContext<UserContextType | null>(null);

export function UserProvider({ children }: { children: React.ReactNode }) {
  const [user, setUser] = useState<any>(null);
  const [attributes, setAttributes] = useState<Record<string, string>>({});
  const [groups, setGroups] = useState<string[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  const refreshUser = async () => {
    try {
      const currentUser = await getCurrentUser();
      const userAttributes = await fetchUserAttributes();
      const userGroups = currentUser.signInDetails?.loginId || [];
      
      setUser(currentUser);
      setAttributes(userAttributes);
      setGroups(userGroups);
    } catch (error) {
      setUser(null);
      setAttributes({});
      setGroups([]);
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    refreshUser();

    // Listen for auth events
    const unsubscribe = Hub.listen('auth', (data) => {
      const { event } = data.payload;
      if (event === 'signedIn' || event === 'signedOut') {
        refreshUser();
      }
    });

    return unsubscribe;
  }, []);

  const isAdmin = groups.includes('admins');

  return (
    <UserContext.Provider
      value={{
        user,
        attributes,
        isLoading,
        isAdmin,
        groups,
        refreshUser,
      }}
    >
      {children}
    </UserContext.Provider>
  );
}

export const useUser = () => {
  const context = useContext(UserContext);
  if (!context) {
    throw new Error('useUser must be used within UserProvider');
  }
  return context;
};
```

### Protected Routes
```typescript
// src/components/ProtectedRoute.tsx
'use client';

import { useUser } from '@/hooks/useUser';
import { useRouter } from 'next/navigation';
import { useEffect } from 'react';

interface ProtectedRouteProps {
  children: React.ReactNode;
  requiredGroups?: string[];
  fallbackUrl?: string;
}

export function ProtectedRoute({
  children,
  requiredGroups = [],
  fallbackUrl = '/unauthorized',
}: ProtectedRouteProps) {
  const { user, groups, isLoading } = useUser();
  const router = useRouter();

  useEffect(() => {
    if (!isLoading) {
      if (!user) {
        router.push('/login');
        return;
      }

      if (requiredGroups.length > 0) {
        const hasRequiredGroup = requiredGroups.some(group => groups.includes(group));
        if (!hasRequiredGroup) {
          router.push(fallbackUrl);
          return;
        }
      }
    }
  }, [user, groups, isLoading, requiredGroups, router, fallbackUrl]);

  if (isLoading) {
    return <div>Loading...</div>;
  }

  if (!user) {
    return null;
  }

  if (requiredGroups.length > 0) {
    const hasRequiredGroup = requiredGroups.some(group => groups.includes(group));
    if (!hasRequiredGroup) {
      return null;
    }
  }

  return <>{children}</>;
}

// Usage examples
export function AdminRoute({ children }: { children: React.ReactNode }) {
  return (
    <ProtectedRoute requiredGroups={['admins']}>
      {children}
    </ProtectedRoute>
  );
}

export function ModeratorRoute({ children }: { children: React.ReactNode }) {
  return (
    <ProtectedRoute requiredGroups={['admins', 'moderators']}>
      {children}
    </ProtectedRoute>
  );
}
```

## 🔧 Advanced Features

### Custom Authentication Flow
```typescript
// Custom sign-up with additional validation
export const customSignUp = async (formData: {
  email: string;
  password: string;
  name: string;
  companyCode?: string;
}) => {
  // Custom validation
  if (formData.companyCode) {
    const isValidCompany = await validateCompanyCode(formData.companyCode);
    if (!isValidCompany) {
      throw new Error('Invalid company code');
    }
  }

  // Standard sign-up
  const result = await signUp({
    username: formData.email,
    password: formData.password,
    attributes: {
      email: formData.email,
      name: formData.name,
      'custom:company_code': formData.companyCode || '',
    },
  });

  return result;
};
```

### Multi-Factor Authentication
```typescript
// Enable MFA for user
import { updateMFAPreference } from 'aws-amplify/auth';

export const enableMFA = async () => {
  try {
    await updateMFAPreference({
      sms: 'PREFERRED',
      totp: 'ENABLED',
    });
  } catch (error) {
    console.error('Error enabling MFA:', error);
    throw error;
  }
};
```

## ⚠️ Security Best Practices

### Password Security
- **Strong Policies**: Enforce complex password requirements
- **Regular Updates**: Encourage periodic password changes
- **Breach Detection**: Monitor for compromised passwords

### Session Management
- **Token Rotation**: Automatic token refresh
- **Session Timeout**: Configure appropriate timeouts
- **Device Tracking**: Monitor sign-ins from new devices

### Data Protection
- **Attribute Encryption**: Encrypt sensitive user attributes
- **PII Handling**: Follow privacy regulations (GDPR, CCPA)
- **Audit Logging**: Track authentication events

### Common Security Pitfalls
- **Client-side Validation Only**: Always validate on server
- **Exposed Credentials**: Never store secrets in client code
- **Insufficient Authorization**: Implement proper role-based access
- **Missing Rate Limiting**: Protect against brute force attacks

---

*This authentication guide provides comprehensive patterns for secure user management in AWS Amplify Gen 2 applications.*

**Source**: AWS Amplify Gen 2 Auth Documentation  
**Last Updated**: Current  
**Compatibility**: Amplify Gen 2.x, AWS Cognito