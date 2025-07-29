---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/android/relational/save-many-snippet.mdx
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
    .build();

User editor = User.builder()
    .username("Nadia")
    .build();

PostEditor postEditor = PostEditor.builder()
    .post(post)
    .user(editor)
    .build();

Amplify.DataStore.save(post,
    savedPost -> ,
            failure -> Log.e("MyAmplifyApp", "Editor not saved.", failure)
        );
    },
    failure -> Log.e("MyAmplifyApp", "Post not saved.", failure)
);
```

</Block>

```kotlin
val post = Post.builder()
    .title("My First Post")
    .build()

val editor = User.builder()
    .username("Nadia")
    .build()

val postEditor = PostEditor.builder()
    .post(post)
    .user(editor)
    .build()

Amplify.DataStore.save(post,
    ,
                    
                )
            },
            
        )
    },
    
)
```

</Block>

```kotlin
val post = Post.builder()
    .title("My First Post")
    .build()

val editor = User.builder()
    .username("Nadia")
    .build()

val postEditor = PostEditor.builder()
    .post(post)
    .user(editor)
    .build()

try  catch (error: DataStoreException) 
```

</Block>

```java
Post post = Post.builder()
    .title("My First Post")
    .build();

User editor = User.builder()
    .username("Nadia")
    .build();

PostEditor postEditor = PostEditor.builder()
    .post(post)
    .user(editor)
    .build();

Completable.mergeArray(
    RxAmplify.DataStore.save(post),
    RxAmplify.DataStore.save(editor)
).andThen(
    RxAmplify.DataStore.save(postEditor)
).subscribe(
    () -> Log.i("MyAmplifyApp", "Post, Editor, and PostEditor saved."),
    failure -> Log.e("MyAmplifyApp", "Item not saved.", failure)
);
```

</Block>
</BlockSwitcher>

> **Note**: 

This example illustrates the complexity of working with multiple sequential save operations. To remove the nested callbacks, consider using Amplify's support for [RxJava](/gen1/[platform]/prev/start/project-setup/rxjava/) or [Coroutines](/gen1/[platform]/prev/start/project-setup/kotlin-coroutines/).


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/android/relational/save-many-snippet.mdx`