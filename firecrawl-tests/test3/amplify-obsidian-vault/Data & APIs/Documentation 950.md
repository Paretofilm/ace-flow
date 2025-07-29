---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/real-time/observe-snippet.mdx
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
Amplify.DataStore.observe(Post.class,
    cancelable -> Log.i("MyAmplifyApp", "Observation began."),
    postChanged -> ,
    failure -> Log.e("MyAmplifyApp", "Observation failed.", failure),
    () -> Log.i("MyAmplifyApp", "Observation complete.")
);
```

</Block>

```kotlin
Amplify.DataStore.observe(Post::class.java,
    ,
    ,
    ,
    
)
```

</Block>

```kotlin
Amplify.DataStore.observe(Post::class)
    .onStart 
    .catch 
    .onCompletion 
    .collect ") }
```

</Block>

```java
RxAmplify.DataStore.observe(Post.class)
    .subscribe(
        post -> Log.i("MyAmplifyApp", "Post: " + post),
        failure -> Log.e("MyAmplifyApp", "Observation failed.", failure),
        () -> Log.i("MyAmplifyApp", "Observation complete.")
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/android/real-time/observe-snippet.mdx`