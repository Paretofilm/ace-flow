---
title: Documentation
source: fragments/lib/datastore/android/real-time/observe-snippet.mdx
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
