---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/sync/30-savePredicateComparison.mdx
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
// Tests only against the local state
if (post.getTitle().startsWith("[Amplify]")) 

// Only applies the update if the data in the remote backend satisfies the criteria
Amplify.DataStore.save(post, Post.TITLE.beginsWith("[Amplify]"),
    update -> ,
    failure -> 
);
```

</Block>

```kotlin
// Tests only against the local state
if (post.title.startsWith("[Amplify]")) 

// Only applies the update if the data in the remote backend satisfies the criteria
Amplify.DataStore.save(post, Post.TITLE.beginsWith("[Amplify]"),
    ,
    
)
```

</Block>

```kotlin
// Tests only against the local state
if (post.title.starts("[Amplify]"))  catch (error: DataStoreException) 
}

// Only applies the update if the data in the remote backend satisfies the criteria
Amplify.DataStore.save(post, Post.TITLE.beginsWith("[Amplify]"),
    ,
    
)
```

</Block>

```java
// Tests only against the local state
if (post.getTitle().startsWith("[Amplify]")) 

// Only applies the update if the data in the remote backend satisfies the criteria
RxAmplify.DataStore.save(post, Post.TITLE.beginsWith("[Amplify]"))
    .subscribe(
        update -> ,
        failure -> 
    );
```
</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/android/sync/30-savePredicateComparison.mdx`