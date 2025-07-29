---
title: Documentation
source: fragments/lib/datastore/android/sync/20-savePredicate.mdx
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
