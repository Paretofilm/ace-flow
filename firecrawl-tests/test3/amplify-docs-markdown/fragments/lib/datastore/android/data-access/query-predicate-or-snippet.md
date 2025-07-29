---
title: Documentation
source: fragments/lib/datastore/android/data-access/query-predicate-or-snippet.mdx
---

# Documentation

```java
Amplify.DataStore.query(
    Post.class,
    Where.matches(Post.RATING.gt(4).or(Post.STATUS.eq(PostStatus.ACTIVE))),
    posts -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>

```kotlin
Amplify.DataStore.query(
    Post::class.java, Where.matches(
        Post.RATING.gt(4)
            .or(Post.STATUS.eq(PostStatus.ACTIVE))
    ),
    
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore
    .query(Post::class,
        Where.matches(Post.RATING.gt(4)
            .or(Post.STATUS.eq(PostStatus.ACTIVE)))
    )
    .catch 
    .collect 
```

</Block>

```java
RxAmplify.DataStore.query(
    Post.class,
    Where.matches(Post.RATING.gt(4).or(Post.STATUS.eq(PostStatus.ACTIVE))))
    .subscribe(
        post -> Log.i("MyAmplifyApp", "Post: " +  post),
        failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
    );
```

</Block>
</BlockSwitcher>
