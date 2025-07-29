---
title: Documentation
source: fragments/lib-v1/datastore/android/data-access/query-sort-multiple-snippet.mdx
---

# Documentation

```java
Amplify.DataStore.query(Post.class,
    Where.sorted(Post.RATING.ascending(), Post.TITLE.descending()),
    posts -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class.java,
    Where.sorted(Post.RATING.ascending(), Post.TITLE.descending()),
    ")
        }
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore
    .query(Post::class,
        Where.sorted(Post.RATING.ascending(), Post.TITLE.descending())
    )
    .catch 
    .collect ") }
```

</Block>

```java
RxAmplify.DataStore.query(Post.class,
    Where.sorted(Post.RATING.ascending(), Post.TITLE.descending()))
    .subscribe(
        post -> Log.i("MyAmplifyApp", "Post: " +  post),
        failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
    );
```

</Block>

</BlockSwitcher>
