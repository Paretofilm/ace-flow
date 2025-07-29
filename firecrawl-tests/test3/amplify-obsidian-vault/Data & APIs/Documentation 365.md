---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/android/sync/20-savePredicate.mdx
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
Amplify.DataStore.save(post, Post.TITLE.beginsWith("[Amplify]"),
    update -> Log.i("MyAmplifyApp", "Post updated successfully!"),
    failure -> Log.e("MyAmplifyApp", "Could not update post, maybe the title has been changed?", failure)
);
```

</Block>

```kotlin
Amplify.DataStore.save(post, Post.TITLE.beginsWith("[Amplify]"),
    ,
    
)
```

</Block>

```kotlin
try  catch (error: DataStoreException) 
```

</Block>

```java
RxAmplify.DataStore.save(post, Post.TITLE.beginsWith("[Amplify]"))
    .subscribe(
        update -> Log.i("MyAmplifyApp", "Post updated successfully!"),
        failure -> Log.e("MyAmplifyApp", "Could not update post, maybe the title has been changed?", failure)
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/android/sync/20-savePredicate.mdx`