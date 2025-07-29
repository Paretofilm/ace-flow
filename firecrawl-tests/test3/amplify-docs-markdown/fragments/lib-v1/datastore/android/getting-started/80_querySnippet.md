---
title: Documentation
source: fragments/lib-v1/datastore/android/getting-started/80_querySnippet.mdx
---

# Documentation

```java
Amplify.DataStore.query(Post.class,
    queryMatches ->  else 
    },
    error -> Log.e("MyAmplifyApp",  "Error retrieving posts", error)
);
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class.java,
     else 
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class)
    .catch 
    .collect 
```

</Block>

```java
RxAmplify.DataStore.query(Post.class).subscribe(
    post -> Log.i("MyAmplifyApp", "Successful query, found post."),
    error -> Log.e("MyAmplifyApp",  "Error retrieving posts", error)
);
```

</Block>
</BlockSwitcher>
