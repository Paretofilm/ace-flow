---
title: Documentation
source: fragments/lib/datastore/android/relational/query-snippet.mdx
---

# Documentation

```java
Amplify.DataStore.query(Comment.class, Post.STATUS.eq(PostStatus.ACTIVE),
    matches -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>

```kotlin
Amplify.DataStore.query(Comment::class.java, Post.STATUS.eq(PostStatus.ACTIVE),
    ")
        }
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore
    .query(Comment::class, Where.matches(Post.STATUS.eq(PostStatus.ACTIVE)))
    .catch 
    .collect ") }
```

</Block>

```java
RxAmplify.DataStore.query(Comment.class, Post.STATUS.eq(PostStatus.ACTIVE))
    .subscribe(
        comment -> Log.i("MyAmplifyApp", "Content: " + comment.getContent()),
        failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
    );
```

</Block>
</BlockSwitcher>
