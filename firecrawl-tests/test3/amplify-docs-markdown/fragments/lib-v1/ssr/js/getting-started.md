---
title: Amplify
source: fragments/lib-v1/ssr/js/getting-started.mdx
---

# Amplify

To work well with server-rendered pages, Amplify JS requires slight modifications from how you would use it in a client-only environment.

## Amplify

### Enabling SSR

When using the Amplify CLI, the **aws-exports.js** file gets created and updated automatically for you based upon the resources you have added and configured.

For client-only apps, `Amplify.configure(awsExports)` is all you need.

To enable SSR support, also provide `ssr: true`:

```js

Amplify.configure();
```

By providing `ssr: true`, Amplify persists credentials on the client in cookies so that subsequent requests to the server have access to them.

> **Note**: Once [vercel/next.js#16977](https://github.com/vercel/next.js/issues/16977) is resolved, you can hoist `Amplify.configure` into **pages/\_app.js**. Until then, be sure that all **pages/\*** run `Amplify.configure()`.

### withSSRContext

Once an application has been configured with `ssr: true`, client-side credentials are passed to the server via cookies.

The `withSSRContext` utility creates an instance of `Amplify` scoped to a single request (`req`) using those cookie credentials.

For client-side code rendered in the browser, your page should continue using top-level imports as usual:

```js

Amplify.configure();

  useEffect(() => ).then(() => setPosts(data.listPosts.items));
  }, [])

  return ( ... );
}
```

When on the server, use `withSSRContext()`:

```js

  return 
  };
}
```

> **Note**: 

Server-side functions that don't have a req object (e.g. Next.js' getStaticProps & getStaticPaths) should still use withSSRContext(). Please note that it's not possible to perform authenticated requests with Amplify when using these functions.

## Use Amplify with Next.js App Router ("app/" directory)

Amplify JavaScript can be used with the Next.js App Router (Next.js v13.4+) by applying the following changes:

### 1. Run `Amplify.configure()` in **both** the client-side and server-side code

To use Amplify with Next.js App Router, you **must** run `Amplify.configure()` in both Client and Server Components. The `ssr` option **must** be enabled.

Example Next.js App Router Client Component containing your login flow (e.g. `app/page.tsx`):

```js
'use client';

Amplify.configure();

Example Next.js App Router Server Component (e.g. `app/posts/page.tsx`):

```js

Amplify.configure();

### 2. Prepare a request object for `withSSRContext` to perform server-side operations that require authentication

Example Next.js App Router Server Component that queries data from GraphQL (e.g. `app/posts/page.tsx`):

```js

Amplify.configure();

  const  = await SSR.API.graphql();

  // ...
}
```

## DataStore

### Serializing

For Next.js, returned `props` from the server have to be valid JSON. Because `DataStore.query(Model)` returns _instances_ of `Model`, you need the `serializeModel` helper to convert it to JSON instead:

```js

...

	return ,
	};
}
```

### Deserializing

If your client-side code only reads from the server-side props and doesn't perform any updates to these models, then your client-side code won't need any changes.

However, if you receive models from the server and need to `DataStore.delete(model)` or `DataStore.save(...)` changes to them, you'll need the `deserializeModel` utility to convert them from server-friendly JSON back into model _instances_:

```js

    ...
}
```

### Example:

Using the following schema:

```graphql
type Post
  @model
  @auth(rules: [, ]) 
```

Open **pages/index.js** and replace it with the following code:

```jsx
// pages/index.js
import  from 'aws-amplify';

Amplify.configure(,
  ssr: true
});

  return 
  };
}

async function handleCreatePost(event) )
    );

    window.location.href = `/posts/$`;
  } catch (error) 
}

      <main className=>
        <h1 className=>Amplify DataStore + Next.js</h1>
        <p className=>
          <code className=></code>
          posts
        </p>

        <div className=>
           href=`} key=>
              <h3></h3>
              <p></p>
            </a>
          ))}

          <div className=>
            <h3 className=>New Post</h3>

              <form onSubmit=>
                <fieldset>
                  <legend>Title</legend>
                  <input
                    defaultValue=`}
                    name="title"
                  />
                </fieldset>

                <fieldset>
                  <legend>Content</legend>
                  <textarea
                    defaultValue="I built an Amplify project with Next.js and DataStore!"
                    name="content"
                  />
                </fieldset>

                <button>Create Post</button>
                <button type="button" onClick=>
                  Sign out
                </button>
              </form>
            </Authenticator>
          </div>
        </div>
      </main>
    </div>
  );
}
```
