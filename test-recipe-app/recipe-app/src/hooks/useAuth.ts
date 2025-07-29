import { useAuthenticator } from '@aws-amplify/ui-react';
import { getCurrentUser, fetchUserAttributes } from 'aws-amplify/auth';
import { useState, useEffect } from 'react';
import type { AuthUser } from '../types';

export function useAuth() {
  const { user, authStatus } = useAuthenticator(context => [context.user, context.authStatus]);
  const [currentUser, setCurrentUser] = useState<AuthUser | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadUser = async () => {
      if (authStatus === 'authenticated') {
        try {
          const cogntoUser = await getCurrentUser();
          const attributes = await fetchUserAttributes();
          
          setCurrentUser({
            userId: cogntoUser.userId,
            username: attributes.preferred_username || cogntoUser.username,
            email: attributes.email || '',
          });
        } catch (error) {
          console.error('Failed to load user:', error);
        }
      } else {
        setCurrentUser(null);
      }
      setLoading(false);
    };

    loadUser();
  }, [authStatus]);

  return {
    user: currentUser,
    isAuthenticated: authStatus === 'authenticated',
    loading,
  };
}