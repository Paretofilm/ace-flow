---
title: Documentation
topics: ['Data & APIs', 'Getting Started']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/getting-started/80_querySnippet.mdx
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
Amplify.DataStore.query(Post.class,
    queryMatches ->  else 
    },
    error -> Log.e("MyAmplifyApp",  "Error retrieving posts", error)
);
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class.java,
     else 
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class)
    .catch 
    .collect 
```

</Block>

```java
RxAmplify.DataStore.query(Post.class).subscribe(
    post -> Log.i("MyAmplifyApp", "Successful query, found post."),
    error -> Log.e("MyAmplifyApp",  "Error retrieving posts", error)
);
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/datastore/android/getting-started/80_querySnippet.mdx`