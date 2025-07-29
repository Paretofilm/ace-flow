---
title: Documentation
source: fragments/lib/datastore/android/data-access/query-predicate-multiple-snippet.mdx
---

# Documentation

```java
Amplify.DataStore.query(
    Post.class,
    Where.matches(Post.RATING.gt(4).and(Post.STATUS.eq(PostStatus.ACTIVE))),
    goodActivePosts -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>

```kotlin
Amplify.DataStore.query(
    Post::class.java, Where.matches(Post.RATING.gt(4)
        .and(Post.STATUS.eq(PostStatus.ACTIVE))
    ),
    
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore
    .query(Post::class,
        Where.matches(Post.RATING.gt(4)
            .and(Post.STATUS.eq(PostStatus.ACTIVE)))
    )
    .catch 
    .collect 
```

</Block>

```java
RxAmplify.DataStore.query(
    Post.class,
    Where.matches(Post.RATING.gt(4).and(Post.STATUS.eq(PostStatus.ACTIVE))))
    .subscribe(
        post -> Log.i("MyAmplifyApp", "Post: " +  post),
        failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
    );
```

</Block>

</BlockSwitcher>
