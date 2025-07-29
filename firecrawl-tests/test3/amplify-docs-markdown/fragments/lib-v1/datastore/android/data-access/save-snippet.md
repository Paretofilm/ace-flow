---
title: Documentation
source: fragments/lib-v1/datastore/android/data-access/save-snippet.mdx
---

# Documentation

```java
Post post = Post.builder()
    .title("My First Post")
    .status(PostStatus.ACTIVE)
    .rating(10)
    .build();

Amplify.DataStore.save(post,
    saved -> Log.i("MyAmplifyApp", "Saved a post."),
    failure -> Log.e("MyAmplifyApp", "Save failed.", failure)
);
```

</Block>

```kotlin
val post = Post.builder()
    .title("My First Post")
    .status(PostStatus.ACTIVE)
    .rating(10)
    .build()

Amplify.DataStore.save(post,
    ,
    
)
```

</Block>

```kotlin
val post = Post.builder()
    .title("My First Post")
    .status(PostStatus.ACTIVE)
    .rating(10)
    .build()
try  catch (error: DataStoreException) 
```

</Block>

```java
Post post = Post.builder()
    .title("My First Post")
    .status(PostStatus.ACTIVE)
    .rating(10)
    .build();

RxAmplify.DataStore.save(post)
    .subscribe(
        () -> Log.i("MyAmplifyApp", "Saved a post."),
        failure -> Log.e("MyAmplifyApp", "Save failed.", failure)
    );
```

</Block>
</BlockSwitcher>
