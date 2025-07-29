---
title: Documentation
source: fragments/lib-v1/datastore/android/data-access/query-sort-snippet.mdx
---

# Documentation

```java
Amplify.DataStore.query(Post.class,
    Where.sorted(Post.RATING.ascending()),
    posts -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class.java,
    Where.sorted(Post.RATING.ascending()),
    ")
        }
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore
    .query(Post::class, Where.sorted(Post.RATING.ascending()))
    .catch 
    .collect ") }
```

</Block>

```java
RxAmplify.DataStore.query(Post.class,
    Where.sorted(Post.RATING.ascending())
    .subscribe(
        post -> Log.i("MyAmplifyApp", "Post: " +  post),
        failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
    );
```

</Block>

</BlockSwitcher>
