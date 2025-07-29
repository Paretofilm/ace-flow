---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/relational/save-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/android/relational/save-snippet.mdx`