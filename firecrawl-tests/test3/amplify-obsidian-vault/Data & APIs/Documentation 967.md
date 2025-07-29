---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/data-access/save-snippet.mdx
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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/android/data-access/save-snippet.mdx`