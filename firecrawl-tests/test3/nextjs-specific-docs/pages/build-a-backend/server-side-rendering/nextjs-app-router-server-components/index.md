---
title: Build UI
source: pages/build-a-backend/server-side-rendering/nextjs-app-router-server-components/index.mdx
---

# Build UI

This Quickstart guide will walk you through how to build a task list application with TypeScript, Next.js **App Router with Server Components**, and React. If you are new to these technologies, we recommend you go through the official [React](https://react.dev/learn/tutorial-tic-tac-toe), [Next.js](https://nextjs.org/docs/app/getting-started), and [TypeScript](https://www.typescriptlang.org/docs/handbook/typescript-from-scratch.html) tutorials first.

## Build UI

Let's add UI that connects to the backend data and auth resources.

### Configure Amplify Client Side

First, install the Amplify UI component library:

```bash showLineNumbers=
npm add @aws-amplify/ui-react
```

Next, create a `components` folder in the root of your project and copy the contents below to a file called `ConfigureAmplify.tsx`.

```ts title="components/ConfigureAmplify.tsx"
// components/ConfigureAmplify.tsx
"use client";

Amplify.configure(outputs, );

Update `app/layout.tsx` to import and render ``. This client component will configure Amplify for client pages in our application.

```ts title="app/layout.tsx"
// app/layout.tsx
import "@aws-amplify/ui-react/styles.css";
import "./globals.css";

const inter = Inter();

### Configure Amplify Server Side

First, install the Amplify Next.js adapter:

```bash showLineNumbers=
npm add @aws-amplify/adapter-nextjs
```

Next, create a `utils/amplify-utils.ts` file from the root of the project and paste the code below.  `runWithAmplifyServerContext`,  `cookiesClient`, and `AuthGetCurrentUserServer` are declared here and will be used to gain access to Amplify assets from the server.

```ts title="utils/amplify-utils.ts"
// utils/amplify-utils.ts

### Add server authentication routes

First, create a client-side `Login` component in the `components` folder that will be wrapped in `withAuthenticator`. If the user is logged in, they will be redirected to the index route; otherwise, the [Amplify UI Authenticator component](https://ui.docs.amplify.aws/react/connected-components/authenticator) will be rendered.

```ts title="components/Login.tsx"
// components/Login.tsx
"use client";

function Login(: ) 
  }, [user]);
  return null;
}

Next, create a new route under `app/login/page.tsx` to render the `Login` component.

```ts title="app/login/page.tsx"
// app/login/page.tsx

 example">

Some applications require more customization for the `` component. The following example shows how to add a custom Header to the ``. For this use, you will not need the `Login` file in the `components` folder, but can do everything through the `page` file in the `app/login/` folder. For more customization options, see [Authenticator Customization](https://ui.docs.amplify.aws/react/connected-components/authenticator/customization).

```ts title="app/login/page.tsx"
// app/login/page.tsx - Custom 

"use client";

import  from "@aws-amplify/ui-react";

const components = }>Authenticator Header</span></Text>
      </View>
    );
  },
};

function CustomAuthenticator()  = useAuthenticator((context) => [context.user]);

  useEffect(() => 
  }, [user]);

  return ;
}

```

</Accordion>

Finally, create a `Logout` component to be used later.

```ts title="components/Logout.tsx"
// components/Logout.tsx

"use client";

  return (
    <button
      onClick=}
      className="px-2 bg-white text-black"
    >
      Sign out
    </button>
  );
}
```

> **Note**: 

**Note**: If using [Amplify UI Social Providers](https://ui.docs.amplify.aws/react/connected-components/authenticator/configuration#social-providers), set the `callbackUrls` for the `/login` route when [configuring social sign-in for your Gen 2 backend](https://docs.amplify.aws/gen2/build-a-backend/auth/add-social-provider/#configure-social-sign-in-backend), as shown below.

```ts title="amplify/auth/resource.ts"

### Add middleware for server-side redirect

Create `middleware.ts` in the root of the project with the contents below.

This middleware runs `fetchAuthSession` wrapped in `runWithAmplifyServerContext` and will redirect to `/login` when a user is not logged in.

```ts title="middleware.ts"
// middleware.ts

  const authenticated = await runWithAmplifyServerContext(,
    operation: async (contextSpec) => );
        return session.tokens !== undefined;
      } catch (error) 
    },
  });

  if (authenticated) 

  return NextResponse.redirect(new URL("/login", request.url));
}

Run your application with `npm run dev` and navigate to `http://localhost:3000`. You should now see the authenticator, which is already configured and ready for your first sign-up! Create a new user account, confirm the account through email, and then sign in.

### View list of to-do items

Now, let's display data on our app's frontend.

The code below uses the `cookiesClient` to provide access to the `Todo` model defined in the backend.

Modify your app's home page file, `app/page.tsx`, with the following code:

```ts title="app/page.tsx"
// app/page.tsx

async function App()  = await cookiesClient.models.Todo.list();

  return (
    <>
      <h1>Hello, Amplify 👋</h1>
      <ul>
        ></li>)}
      </ul>
    </>
  );
}

Once you save the file and navigate back to `http://localhost:3000`, you should see "Hello, Amplify" with a blank page for now because you have only an empty list of to-dos.

### Create a new to-do item

Let's update the component to have a form for prompting the user for the title for creating a new to-do list item and run the `addTodo` method on form submission. In a production app, the additional fields of the `Todo` model would be added to the form.

After creating a to-do, `revalidatePath` is run to clear the Next.js cache for this route to instantly update the results from the server without a full page reload.

```ts title="app/page.tsx"
// app/page.tsx

async function App()  = await cookiesClient.models.Todo.list();

  async function addTodo(data: FormData) );
    revalidatePath("/");
  }

  return (
    <>
      <h1>Hello, Amplify 👋</h1>
      
      <form action=>
        <input type="text" name="title" />
        <button type="submit">Add Todo</button>
      </form>

      <ul>
        ></li>)}
      </ul>
    </>
  );
}

### Terminate dev server

Go to `localhost` in the browser to make sure you can now log in and create and list to-dos. You can end your development session by shutting down the frontend dev server and cloud sandbox. The sandbox prompts you to delete your backend resources. While you can retain your backend, we recommend deleting all resources so you can start clean again next time.
