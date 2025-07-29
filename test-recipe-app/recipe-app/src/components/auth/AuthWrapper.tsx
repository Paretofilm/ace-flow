import { Authenticator, useAuthenticator } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';
import { ReactNode } from 'react';

interface AuthWrapperProps {
  children: ReactNode;
}

export default function AuthWrapper({ children }: AuthWrapperProps) {
  return (
    <Authenticator>
      {({ signOut, user }) => (
        <div className="auth-wrapper">
          <header className="app-header">
            <h1>Recipe Sharing App</h1>
            <div className="user-info">
              <span>Welcome, {user?.signInDetails?.loginId || 'User'}</span>
              <button onClick={signOut} className="sign-out-button">
                Sign Out
              </button>
            </div>
          </header>
          <main className="app-main">{children}</main>
        </div>
      )}
    </Authenticator>
  );
}