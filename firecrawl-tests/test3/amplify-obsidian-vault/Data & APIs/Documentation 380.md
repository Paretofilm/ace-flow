---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/android/data-access/query-sort-multiple-snippet.mdx
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
    Where.sorted(Post.RATING.ascending(), Post.TITLE.descending()),
    posts -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class.java,
    Where.sorted(Post.RATING.ascending(), Post.TITLE.descending()),
    ")
        }
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore
    .query(Post::class,
        Where.sorted(Post.RATING.ascending(), Post.TITLE.descending())
    )
    .catch 
    .collect ") }
```

</Block>

```java
RxAmplify.DataStore.query(Post.class,
    Where.sorted(Post.RATING.ascending(), Post.TITLE.descending()))
    .subscribe(
        post -> Log.i("MyAmplifyApp", "Post: " +  post),
        failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
    );
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/android/data-access/query-sort-multiple-snippet.mdx`