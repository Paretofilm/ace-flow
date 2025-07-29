# Authenticator

Authenticator component adds complete authentication flows to your application with minimal boilerplate.

**Note**: The `@aws-amplify/ui-react` package is currently on version 6. Working with `@aws-amplify/ui-react` version 5 or earlier? [See the migration guide.](https://ui.docs.amplify.aws/react/getting-started/migration)

The `Authenticator` component adds complete [authentication flows](https://docs.amplify.aws/lib/auth/getting-started/q/platform/js) to your application with minimal boilerplate.

## Quick start

**Next.js 13.4+ App Router Note**: Next.js 13.4+ introduces [App Router](https://nextjs.org/docs/app/building-your-application/routing#the-app-router) with the usage of [Server Components.](https://nextjs.org/docs/app/building-your-application/rendering/server-components) Amplify UI components are interactive and designed to work on the client side. To use them inside of Server Components you must wrap them in a Client Component with `"use client"`. For more info, visit [Next.js third party package documentation.](https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns#using-third-party-packages-and-providers)

If you are using [Next.js Pages Router,](https://nextjs.org/docs/pages/building-your-application/routing) no changes are required to use Amplify UI components.

### Setup with Amplify Gen 2 backend

To get up and running with the Authenticator, follow the [Amplify Gen2 quickstart guide](https://docs.amplify.aws/react/start/quickstart/).

### Setup with Amplify Gen 1 backend

To setup Amplify using the Gen1 CLI, follow the steps below:

#### Step 1. Configure backend

The Authenticator works seamlessly with the [Amplify CLI](https://docs.amplify.aws/cli/start/install/) to **automatically** work with your backend.

First, update `@aws-amplify/cli` with [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/) if you're using a version before `6.4.0`:

```bash
npm install -g @aws-amplify/cli@latest
# or
yarn global add @aws-amplify/cli@latest
```

Now that you have the Amplify CLI installed, you can set up your Amplify project by running `amplify init` in your project's root directory. Then run `amplify add auth` and follow the prompts to add authentication to your backend configuration.

_If you have an existing backend, run `amplify pull` to sync your `aws-exports.js` with your cloud backend._

You should now have an `aws-exports.js` file in your `src/` directory with your latest backend configuration.

#### Step 2. Install dependencies

```bash
npm install @aws-amplify/ui-react aws-amplify
# or
yarn add @aws-amplify/ui-react aws-amplify
```

#### Step 3. Add the Authenticator

The quickest way to get started is by wrapping your application with the Authenticator component. Once an end-user has created an account & signed in, the underlying component is rendered with access to the `user`.

You can use the `Authenticator` component directly, or wrap your app in `withAuthenticator` [Higher-Order Component](https://legacy.reactjs.org/docs/higher-order-components.html):

**Using Authenticator Component:**

```jsx
import React from 'react';
import { Amplify } from 'aws-amplify';

import { Authenticator } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';

import awsExports from './aws-exports';
Amplify.configure(awsExports);

export default function App() {
  return (
    <Authenticator>
      {({ signOut, user }) => (
        <main>
          <h1>Hello {user.username}</h1>
          <button onClick={signOut}>Sign out</button>
        </main>
      )}
    </Authenticator>
  );
}
```

**Using withAuthenticator HOC:**

`withAuthenticator` defaults the `variation` prop to `modal`.

```jsx
import { Amplify } from 'aws-amplify';

import { withAuthenticator } from '@aws-amplify/ui-react';
import '@aws-amplify/ui-react/styles.css';

import awsExports from './aws-exports';
Amplify.configure(awsExports);

function App({ isPassedToWithAuthenticator, signOut, user }) {
  if (!isPassedToWithAuthenticator) {
    throw new Error(`isPassedToWithAuthenticator was not provided`);
  }

  return (
    <>
      <h1>Hello {user.username}</h1>
      <button onClick={signOut}>Sign out</button>
    </>
  );
}

export default withAuthenticator(App);

export async function getStaticProps() {
  return {
    props: {
      isPassedToWithAuthenticator: true,
    },
  };
}
```

**TypeScript Version:**

```tsx
import { Amplify } from 'aws-amplify';

import {
  withAuthenticator,
  WithAuthenticatorProps,
} from '@aws-amplify/ui-react';

import '@aws-amplify/ui-react/styles.css';

import awsExports from './aws-exports';
Amplify.configure(awsExports);

interface Props extends WithAuthenticatorProps {
  isPassedToWithAuthenticator: boolean;
}

function App({ isPassedToWithAuthenticator, signOut, user }: Props) {
  if (!isPassedToWithAuthenticator) {
    throw new Error(`isPassedToWithAuthenticator was not provided`);
  }

  return (
    <>
      <h1>Hello {user?.username}</h1>
      <button onClick={signOut}>Sign out</button>
    </>
  );
}

export default withAuthenticator(App);

export async function getStaticProps() {
  return {
    props: {
      isPassedToWithAuthenticator: true,
    },
  };
}
```

## React Authenticator v1

Looking for a previous version of Authenticator? Check out the [Authenticator v1 documentation](https://github.com/aws-amplify/amplify-ui/tree/legacy/legacy/amplify-ui-react).

Please see [troubleshooting](https://ui.docs.amplify.aws/react/getting-started/troubleshooting) if you have trouble building or running your application with Authenticator.

## Next steps

- [Configuration](https://ui.docs.amplify.aws/react/connected-components/authenticator/configuration) - How to setup and configure your Authenticator component
- [Customization](https://ui.docs.amplify.aws/react/connected-components/authenticator/customization) - Override and customize your Authenticator
- [Advanced Usage](https://ui.docs.amplify.aws/react/connected-components/authenticator/advanced) - Access Authenticator UI component state outside of the UI component