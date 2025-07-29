---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/data-access/query-basic-snippet.mdx
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
Amplify.DataStore.query(Post.class,
    allPosts -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class.java,
    ")
        }
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class)
    .catch 
    .collect ") }
```

</Block>

```java
RxAmplify.DataStore.query(Post.class).subscribe(
    post -> Log.i("MyAmplifyApp", "Title: " + post.getTitle()),
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/android/data-access/query-basic-snippet.mdx`