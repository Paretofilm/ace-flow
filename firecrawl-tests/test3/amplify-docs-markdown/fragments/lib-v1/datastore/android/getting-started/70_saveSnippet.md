---
title: Documentation
source: fragments/lib-v1/datastore/android/getting-started/70_saveSnippet.mdx
---

# Documentation

```java
Post post = Post.builder()
    .title("Create an Amplify DataStore app")
    .status(PostStatus.ACTIVE)
    .build();

Amplify.DataStore.save(post,
    result -> Log.i("MyAmplifyApp", "Created a new post successfully"),
    error -> Log.e("MyAmplifyApp",  "Error creating post", error)
);
```

</Block>

```kotlin
val post = Post.builder()
    .title("Create an Amplify DataStore app")
    .status(PostStatus.ACTIVE)
    .build()

Amplify.DataStore.save(post,
    ,
    
)
```

</Block>

```kotlin
val post = Post.builder()
    .title("Create an Amplify DataStore app")
    .status(PostStatus.ACTIVE)
    .build()

try  catch (error: DataStoreException) 
```

</Block>

```java
Post post = Post.builder()
    .title("Create an Amplify DataStore app")
    .status(PostStatus.ACTIVE)
    .build();

RxAmplify.DataStore.save(post).subscribe(
    () -> Log.i("MyAmplifyApp", "Created a new post successfully"),
    error -> Log.e("MyAmplifyApp",  "Error creating post", error)
);
```

</Block>
</BlockSwitcher>
