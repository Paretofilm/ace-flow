---
title: Start using Amplify in your Nuxt 3 project
source: pages/build-a-backend/server-side-rendering/nuxt/index.mdx
---

# Start using Amplify in your Nuxt 3 project

If you have not already done so, please read the introduction documentation, [Use Amplify Categories APIs in Server-Side Rendering](/gen1/[platform]/build-a-backend/server-side-rendering/), to learn about how to use Amplify categories' APIs in server-side rendering.

This documentation provides a getting started guide to using the generic `runWithAmplifyServerContext` adapter (exported from `aws-amplify/adapter-core`) to enable Amplify in a Nuxt 3 project. The examples in this documentation may not present best practices for your Nuxt project. You are welcome to provide suggestions and contributions to improve this documentation or to create a Nuxt adapter package for Amplify and let others use it.

> **Note**: 

**Note:** This guide assumes that you have deep knowledge of Nuxt 3.

## Start using Amplify in your Nuxt 3 project

You can install relevant Amplify libraries by following the [manual installation](/[platform]/start/manual-installation/) guide.

## Set up the AmplifyAPIs plugin

Nuxt 3 offers universal rendering by default, where your data fetching logic may be executed in both client and server runtimes. Amplify offers APIs that are capable of running within a server context to support use cases such as server-side rendering (SSR) and static site generation (SSG), though Amplify's client-side APIs and server-side APIs are slightly different. You can set up an `AmplifyAPIs` plugin to make your data fetching logic run smoothly across the client and server.

1. If you haven’t already done so, create a `plugins` directory under the root of your Nuxt project
2. Create two files `01.amplifyApis.client.ts` and `01.amplifyApis.server.ts` under the `plugins` directory

> **Note**: 

**Note:** the leading number in the filenames indicates the plugin loading order, details see https://nuxt.com/docs/guide/directory-structure/plugins#registration-order. The `.client` and `.server` indicate the runtime that the logic contained in the file will run on, client or server. For details see: https://nuxt.com/docs/guide/directory-structure/plugins

In these files, you will register both client-specific and server-specific Amplify APIs that you will use in your Nuxt project as a plugin. You can then access these APIs via the `useNuxtApp` composable.

### Implement `01.amplifyApis.client.ts`

Example implementation:

```ts title="plugins/01.amplifyApis.client.ts"
import  from 'aws-amplify/auth';

const client = generateClient();

  setup() );

    return ,
          Storage: ,
          GraphQL: 
        }
      }
    };
  }
});
```

> **Note**: 

Make sure you call `Amplify.configure` as early as possible in your application’s lifecycle. A missing configuration or `NoCredentials` error is thrown if `Amplify.configure` has not been called before other Amplify JavaScript APIs. Review the [Library Not Configured Troubleshooting guide](/gen1/[platform]/build-a-backend/troubleshooting/library-not-configured/) for possible causes of this issue.

### Implement `01.amplifyApis.server.ts`

Example implementation:

```ts title="plugins/01.amplifyApis.server.ts"

import  from 'aws-amplify/adapter-core';
import  from 'aws-amplify/auth/server';

// parse the content of `amplify_outputs.json` into the shape of ResourceConfig
const amplifyConfig = parseAmplifyConfig(outputs);

// create the Amplify used token cookies names array
const userPoolClientId = amplifyConfig.Auth!.Cognito.userPoolClientId;
const lastAuthUserCookieName = `CognitoIdentityServiceProvider.$.LastAuthUser`;

// create a GraphQL client that can be used in a server context
const gqlServerClient = generateClient();

// extract the model operation function types for creating wrapper function later
type RemoveFirstParam = Params extends [infer _, ...infer Rest] ? Rest : never; 
type TodoListInput = RemoveFirstParam>;
type TodoCreateInput = RemoveFirstParam>;
type TodoUpdateInput = RemoveFirstParam>;

const getAmplifyAuthKeys = (lastAuthUser: string) =>
  ['idToken', 'accessToken', 'refreshToken', 'clockDrift']
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
      .map((name) => ()
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
      }
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
    const libraryOptions = 
    };

    return ,
          Storage: ,
          GraphQL: ,
                  create(...input: TodoCreateInput) ,
                  update(...input: TodoUpdateInput) 
                }
              }
            }
          }
        }
      }
    };
  }
});
```

#### Usage example

Using the Storage `list` API in `pages/storage-list.vue`:

```ts title="pages/storage-list.vue"

// `useAsyncData` and `useNuxtApp` are Nuxt composables
// `$Amplify` is generated by Nuxt according to the `provide` key in the plugins
// we've added above
<script setup lang="ts">
const  = useAsyncData(async () => );
  return listResult.items;
});
</script>

<template>
  <h3>Files under path: album</h3>
  <pre>}</pre>
</template>
```

Using the GraphQL API in `pages/todos-list.vue`:

```ts title="pages/todos-list.vue"
<script setup lang="ts">
const  = useAsyncData(async () =>  = await useNuxtApp().$Amplify.GraphQL.client.models.Todo.list();
  return data;
});
</script>

<template>
  <h3>Todos</h3>
  <pre>}</pre>
</template>
```

The above two pages can be rendered on both the client and server by default. `useNuxtApp().$Amplify` will pick up the correct implementation of `01.amplifyApis.client.ts` and `01.amplifyApis.server.ts` to use, depending on the runtime.

> **Note**: 

Only a subset of Amplify APIs are usable on the server side, and as the libraries evolve, `amplify-apis.client` and `amplify-apis.server` may diverge further. You can guard your API calls to ensure an API is available in the context where you use it (e.g., you can use `if (process.client)` to ensure that a client-only API isn't executed on the server).

## Set up Auth middleware to protect your routes

The auth middleware will use the plugin configured in the previous step as a dependency; therefore you can add the auth middleware via another plugin that will be loaded after the previous one.

1. Create a `02.authRedirect.ts` file under plugins directory

> **Note**: 

**Note:** This file will run on both client and server, details see: https://nuxt.com/docs/guide/directory-structure/middleware#when-middleware-runs. The `02` name prefix ensures this plugin loads after the previous so `useNuxtApp().$Amplify` becomes available.

### Implement `02.authRedirect.ts`

Example implementation:

```ts title="plugins/02.authRedirect.ts"

// Amplify.configure() only needs to be called on the client side
if (process.client) );
}

          // If the request is not associated with a valid user session
          // redirect to the `/sign-in` route.
          // You can also add route match rules against `to.path`
          if (session.tokens === undefined && to.path !== '/sign-in') 

          if (session.tokens !== undefined && to.path === '/sign-in') 
        } catch (e) 
        }
      }),
      
    );
  }
});
```

> **Note**: 

Make sure you call `Amplify.configure` as early as possible in your application’s life-cycle. A missing configuration or `NoCredentials` error is thrown if `Amplify.configure` has not been called before other Amplify JavaScript APIs. Review the [Library Not Configured Troubleshooting guide](/gen1/[platform]/build-a-backend/troubleshooting/library-not-configured/) for possible causes of this issue.

## Set Up Amplify for API Route Use Cases

Following the specification of Nuxt, your API route handlers will live under `~/server`, which is a separate environment from other parts of your Nuxt app; hence, the plugins created in the previous sections are not usable here, and extra work is required.

### Set up Amplify server context utility

1. If you haven’t already done so, create a `utils` directory under the server directory of your Nuxt project
2. Create an `amplifyUtils.ts` file under the `utils` directory

In this file, you will create a helper function to call Amplify APIs that are capable of running on the server side with context isolation.

Example implementation:

```ts title="utils/amplifyUtils.ts"

import  from 'aws-amplify/adapter-core';

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
    }
  };
};

const createLibraryOptions = (
  event: H3Event
) => 
  };
};

You can then use `runAmplifyApi` function to call Amplify APIs in an isolated server context.

#### Usage example

Take implementing an API route `GET /api/current-user` , in `server/api/current-user.ts`:

```ts title="server/api/current-user.ts"

  return user;
});
```

Then you can fetch data from this route, for example, `fetch('http://localhost:3000/api/current-user')`.

## Set up server middleware to protect your API routes

Similar to API routes, the previously added auth middleware are not usable under `/server`, hence extra work is required to set up a auth middleware to protect your routes.

1. If you haven’t already done so, create a `middleware` directory under the `server` directory of your Nuxt project
2. Create an `amplifyAuthMiddleware.ts` file under the `middleware` directory

This middleware will be executed before a request reach your API route.

Example implementation:

```ts title="middleware/amplifyAuthMiddleware.ts"

      // You can add extra logic to match the requested routes to apply
      // the auth protection
      if (session.tokens === undefined) ;
      }
    } catch (error) ;
    }
  }
});
```

With this middleware, when executing `fetch('http://localhost:3000/api/current-user')` without signing in a user on the client side, the `fetch` will receive a 403 error, and the request won’t reach route `/api/current-user`.
