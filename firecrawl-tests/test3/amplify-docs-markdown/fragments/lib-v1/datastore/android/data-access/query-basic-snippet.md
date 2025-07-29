---
title: Documentation
source: fragments/lib-v1/datastore/android/data-access/query-basic-snippet.mdx
---

# Documentation

```java
Amplify.DataStore.query(Post.class,
    allPosts -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class.java,
    ")
        }
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class)
    .catch 
    .collect ") }
```

</Block>

```java
RxAmplify.DataStore.query(Post.class).subscribe(
    post -> Log.i("MyAmplifyApp", "Title: " + post.getTitle()),
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>
</BlockSwitcher>
