---
title: Documentation
source: fragments/lib-v1/datastore/android/data-access/query-pagination-snippet.mdx
---

# Documentation

```java
Amplify.DataStore.query(Post.class,
    Where.matchesAll().paginated(Page.startingAt(0).withLimit(100)),
    matchingPosts -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class.java,
    Where.matchesAll().paginated(Page.startingAt(0).withLimit(100)),
    ")
        }
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore
    .query(Post::class,
        Where.matchesAll()
            .paginated(Page.startingAt(0).withLimit(100))
    )
    .catch 
    .collect ") }
```

</Block>

```java
RxAmplify.DataStore.query(
    Post.class,
    Where.matchesAll().paginated(Page.startingAt(0).withLimit(100)))
    .subscribe(
        post -> Log.i("MyAmplifyApp", "Title: " + post.getTitle()),
        failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
    );
```

</Block>
</BlockSwitcher>
