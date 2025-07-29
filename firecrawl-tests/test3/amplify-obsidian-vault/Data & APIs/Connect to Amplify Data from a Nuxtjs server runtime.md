---
title: Connect to Amplify Data from a Nuxt.js server runtime
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/connect-from-server-runtime/nuxtjs-server-runtime/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Connect to Amplify Data from a Nuxt.js server runtime

This guide walks through how you can connect to Amplify Data from Nuxt.js Server-side Runtime (SSR). For Nuxt.js applications, Amplify provides first-class support for [Routing (Pages)](https://nuxt.com/docs/getting-started/routing) , [API Routes](https://nuxt.com/docs/guide/directory-structure/server#server-routes) , and [Middleware](https://nuxt.com/docs/guide/directory-structure/server#server-middleware).

Before you begin, you will need:

- [A Nuxt.js application created](https://nuxt.com/docs/getting-started/installation)
- [Deployed Amplify Data resources](/[platform]/build-a-backend/data/set-up-data/), or directly using [AWS AppSync](https://aws.amazon.com/appsync/)

## Connect to Amplify Data from a Nuxt.js server runtime

Connecting to Amplify Data will include setting up the AmplifyAPIs Plugin with the `runWithAmplifyServerContext` adapter,  using the `useNuxtApp()` composable, setting up the Amplify server context utility and then using the `runAmplifyApi` function to call the API in an isolated server context.

### Step 1 - Set up the AmplifyAPIs Plugin

Nuxt 3 offers universal rendering by default, where your data fetching logic may be executed on both the client and server sides. Amplify offers APIs that are capable of running within a server context to support use cases such as server-side rendering (SSR) and static site generation (SSG), though Amplify's client-side APIs and server-side APIs of Amplify are slightly different. You can set up an AmplifyAPIs plugin to make your data fetching logic run smoothly across the client and server. To learn more about how to use Amplify categories APIs in server side rendering, refer to this [documentation](/[platform]/build-a-backend/server-side-rendering/).

1. Create a `plugins` directory under the root of your Nuxt project. 
2. Create two files `01.amplify-apis.client.ts` and `01.amplify-apis.server.ts` under the `plugins` directory.

In these files, you will register both client-specific and server-specific Amplify APIs that you will use in your Nuxt project as a plugin. You can then access these APIs via the `useNuxtApp` composable.

> **Note**: 

**NOTE:** The leading number in the files name indicate the plugin loading order, for more details see https://nuxt.com/docs/guide/directory-structure/plugins#registration-order. The `.client` and `.server` indicate the runtime that the logic contained in the file will run on, client or server. For details see: https://nuxt.com/docs/guide/directory-structure/plugins

Modify the `01.amplify-apis.client.ts` file, with the following code:

```ts title="nuxt-amplify-gen2/plugins/01.amplify-apis.client.ts"
import  from "aws-amplify/auth";

// configure the Amplify client library
if (process.client) );
}

// generate your data client using the Schema from your backend
const client = generateClient();

Make sure you call `Amplify.configure` as early as possible in your application’s life-cycle. A missing configuration or `NoCredentials` error is thrown if `Amplify.configure` has not been called before other Amplify JavaScript APIs. Review the [Library Not Configured Troubleshooting guide](/[platform]/build-a-backend/troubleshooting/library-not-configured/) for possible causes of this issue.

</Callout>

</Accordion>

Next, modify the `01.amplify-apis.server.ts` file, with the following code:

```ts title="nuxt-amplify-gen2/plugins/01.amplify-apis.server.ts"
import  from "aws-amplify/adapter-core";
import  from "aws-amplify/auth/server";
import type  from "@aws-amplify/core";
import type  from "@aws-amplify/api-graphql";

// parse the content of `amplify_outputs.json` into the shape of ResourceConfig
const amplifyConfig = parseAmplifyConfig(outputs);

// create the Amplify used token cookies names array
const userPoolClientId = amplifyConfig.Auth!.Cognito.userPoolClientId;
const lastAuthUserCookieName = `CognitoIdentityServiceProvider.$.LastAuthUser`;

// create a GraphQL client that can be used in a server context
const gqlServerClient = generateClient();

const getAmplifyAuthKeys = (lastAuthUser: string) =>
  ["idToken", "accessToken", "refreshToken", "clockDrift"]
    .map(
      (key) =>
        `CognitoIdentityServiceProvider.$.$.$`
    )
    .concat(lastAuthUserCookieName);

// define the plugin

    // Get the last auth user cookie value
    //
    // We use `sameSite: 'lax'` in this example, which allows the cookie to be
    // sent to your Nuxt server when your end user gets redirected to your Web
    // app from a different domain. You should choose an appropriate value for
    // your own use cases.
    const lastAuthUserCookie = useCookie(lastAuthUserCookieName, );

    // Get all Amplify auth token cookie names
    const authKeys = lastAuthUserCookie.value
      ? getAmplifyAuthKeys(lastAuthUserCookie.value)
      : [];

    // Create a key-value map of cookie name => cookie ref
    //
    // Using the composable `useCookie` here in the plugin setup prevents
    // cross-request pollution.
    const amplifyCookies = authKeys
      .map((name) => (),
      }))
      .reduce>>(
        (result, current) => (),
        
      );

    // Create a key value storage based on the cookies
    //
    // This key value storage is responsible for providing Amplify Auth tokens to
    // the APIs that you are calling.
    //
    // If you implement the `set` method, when Amplify needed to refresh the Auth
    // tokens on the server side, the new tokens would be sent back to the client
    // side via `SetCookie` header in the response. Otherwise the refresh tokens
    // would not be propagate to the client side, and Amplify would refresh
    // the tokens when needed on the client side.
    //
    // In addition, if you decide not to implement the `set` method, you don't
    // need to pass any `CookieOptions` to the `useCookie` composable.
    const keyValueStorage = createKeyValueStorageFromCookieStorageAdapter(;
        }

        return undefined;
      },
      getAll() ;
        });
      },
      set(name, value) 
      },
      delete(name) 
      },
    });

    // Create a token provider
    const tokenProvider = createUserPoolsTokenProvider(
      amplifyConfig.Auth!,
      keyValueStorage
    );

    // Create a credentials provider
    const credentialsProvider = createAWSCredentialsAndIdentityIdProvider(
      amplifyConfig.Auth!,
      keyValueStorage
    );

    // Create the libraryOptions object
    const libraryOptions: LibraryOptions = ,
    };

    return ,
          GraphQL: ,
          },
        },
      },
    };
  },
});
```
</Accordion>

### Step 2 - Use the `useNuxtApp()` composable

Using the GraphQL API in `~/app.vue`:

```ts title="nuxt-amplify-gen2/app.vue"
<script setup lang="ts">
import '@aws-amplify/ui-vue/styles.css';

// create a reactive reference to the array of todos
const todos = ref([]);

async function listTodos()  = await useNuxtApp().$Amplify.GraphQL.client.models.Todo.list();
    todos.value = data;

  } catch (error) 
}

// fetch todos when the component is mounted
onMounted(() => );
</script>

<template>
  
    <template v-slot="">
      <h1>Hello, Amplify 👋</h1>
        <ul>
          <li v-for="todo in todos" :key="todo.id">}</li>
        </ul>
      <button @click="signOut">Sign Out</button>
    </template>
  </Authenticator>
</template>
```

The `app.vue` file can be rendered on both the client and server sides by default. The `useNuxtApp().$Amplify` composable will pick up the correct implementation of `01.amplify-apis.client.ts` and `01.amplify-apis.server.ts` to use, depending on the runtime.

> **Note**: 

Only a subset of Amplify APIs are usable on the server side, and as the libraries evolve, `amplify-apis.client` and `amplify-apis.server` may diverge further. You can guard your API calls to ensure an API is available in the context where you use it. E.g., you can use `if (process.client)` to ensure that a client-only API isn't executed on the server.

### Step 3 - Set up Amplify for API Routes

Following the specification of Nuxt, your API route handlers will live under `~/server`, which is a separate environment from other parts of your Nuxt app; hence, the plugins created in the previous step are not usable here, and extra work is required.

#### Setup Amplify Server Context Utility

1. Create a `utils` directory under the `server` directory of your Nuxt project. 
2. Create an `amplifyUtils.ts` file under the `utils` directory.

In this file, you will create a helper function to call Amplify APIs that are capable of running on the server side with context isolation. Modify the `amplifyUtils.ts` file, with the following code:

```ts title="nuxt-amplify-gen2/server/utils/amplifyUtils.ts"
import  from "aws-amplify/adapter-core";

const amplifyConfig = parseAmplifyConfig(outputs);

const createCookieStorageAdapter = (
  event: H3Event
): CookieStorage.Adapter => ;
      }
    },
    set(name, value, options) ,
    delete(name) ,
    getAll() ;
      });
    },
  };
};

const createLibraryOptions = (
  event: H3Event
): LibraryOptions => ,
  };
};

</Accordion>

Now, you can use the `runAmplifyApi` function to call Amplify APIs in an isolated server context. Create a new API route `/api/current-user` in the `server` directory and modify the `current-user.ts` file, with the following code:

```ts title="nuxt-amplify-gen2/server/api/current-user.ts"

  return user;
});
```

You can then fetch data from this API route, for example: `fetch('http://localhost:3000/api/current-user')`


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/connect-from-server-runtime/nuxtjs-server-runtime/index.mdx`