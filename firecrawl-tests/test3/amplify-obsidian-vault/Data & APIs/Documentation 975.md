---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/data-access/query-predicate-snippet.mdx
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
Amplify.DataStore.query(Post.class, Where.matches(Post.RATING.gt(4)),
    goodPosts -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class.java,
    Where.matches(Post.RATING.gt(4)),
    
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore
    .query(Post::class, Where.matches(Post.RATING.gt(4)))
    .catch 
    .collect 
```

</Block>

```java
RxAmplify.DataStore.query(
    Post.class,
    Where.matches(Post.RATING.gt(4)))
    .subscribe(
        post -> Log.i("MyAmplifyApp", "Post: " +  post),
        failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
    );
```

</Block>
</BlockSwitcher>

> **Note**: 

**Note:** when constructing predicates, static `QueryField` instances such as `Post.RATING` do not own any information about the model to which the field belongs. In order to avoid any ambiguity between field names which are used across multiple models, it is recommended to construct a custom instance of `QueryField` in the form of `QueryField.field(".")` (i.e. `field("post.rating")`).


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/android/data-access/query-predicate-snippet.mdx`