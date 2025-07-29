---
title: Documentation
source: fragments/lib/datastore/android/relational/save-snippet.mdx
---

# Documentation

```java
Post post = Post.builder()
    .title("My Post with comments")
    .rating(10)
    .status(PostStatus.ACTIVE)
    .build();

Comment comment = Comment.builder()
    .post(post) // Directly pass in the post instance
    .content("Loving Amplify DataStore!")
    .build();

Amplify.DataStore.save(post,
    savedPost -> ,
    failure -> Log.e("MyAmplifyApp", "Post not saved.", failure)
);
```

</Block>

```kotlin
val post = Post.builder()
    .title("My Post with comments")
    .rating(10)
    .status(PostStatus.ACTIVE)
    .build()

val comment = Comment.builder()
    .post(post) // Directly pass in the post instance
    .content("Loving Amplify DataStore!")
    .build()

Amplify.DataStore.save(post,
    ,
            
        )
    },
    
)
```

</Block>

```kotlin
val post = Post.builder()
    .title("My Post with comments")
    .rating(10)
    .status(PostStatus.ACTIVE)
    .build()

val comment = Comment.builder()
    .post(post) // Directly pass in the post instance
    .content("Loving Amplify DataStore!")
    .build()

try  catch (error: DataStoreException) 
```

</Block>

```java
Post post = Post.builder()
    .title("My Post with comments")
    .rating(10)
    .status(PostStatus.ACTIVE)
    .build();

Comment comment = Comment.builder()
    .post(post) // Directly pass in the post instance
    .content("Loving Amplify DataStore!")
    .build();

RxAmplify.DataStore.save(post))
    .andThen(RxAmplify.DataStore.save(comment))
    .subscribe(
        () -> Log.i("MyAmplifyApp", "Saved Post and Comment."),
        failure -> Log.e("MyAmplifyApp", "Failed to save at least one item.", failure)
    );
```

</Block>
</BlockSwitcher>
