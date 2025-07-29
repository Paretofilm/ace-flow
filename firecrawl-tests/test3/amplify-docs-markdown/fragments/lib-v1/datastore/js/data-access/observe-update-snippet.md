---
title: Documentation
source: fragments/lib-v1/datastore/js/data-access/observe-update-snippet.mdx
---

# Documentation

```js
// Example showing how to observe the model and keep state updated before
// performing a save. This uses the useEffect React hook, but you can
// substitute for a similar mechanism in your application lifecycle with
// other frameworks.

function App() ) => );

    return () => ;
  }, []);

  /**
   * Create a new Post
   */
  async function onCreate() `,
        rating: Math.floor(Math.random() * (8 - 1) + 1),
        status: PostStatus.ACTIVE
      })
    );
    setPost(post);
  }

  return (
    <>
      <h1></h1>
      <input type="button" value="NEW POST" onClick= />
      <input
        disabled=
        type="text"
        value=
        onChange= }) => )
          );
        }}
      />
      <input
        disabled=
        type="button"
        value="Save"
        onClick=}
      />
    </>
  );
}
```
