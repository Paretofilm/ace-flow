---
title: Documentation
topics: ['Data & APIs', 'Getting Started']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/android/getting-started/70_saveSnippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, getting-started]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Getting Started/]]
**Primary**: [[Data & APIs/]]

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


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/android/getting-started/70_saveSnippet.mdx`