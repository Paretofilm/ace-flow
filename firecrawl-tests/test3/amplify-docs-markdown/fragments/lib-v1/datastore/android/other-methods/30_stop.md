---
title: Documentation
source: fragments/lib-v1/datastore/android/other-methods/30_stop.mdx
---

# Documentation

```java
Amplify.DataStore.stop(
    () -> Log.i("MyAmplifyApp", "DataStore stopped"),
    error -> Log.e("MyAmplifyApp", "Error stopping DataStore", error)
);
```

</Block>

```kotlin
Amplify.DataStore.stop(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: DataStoreException) 
```

</Block>

```java
RxAmplify.DataStore.stop()
    .subscribe(
        () -> Log.i("MyAmplifyApp", "DataStore stopped"),
        error -> Log.e("MyAmplifyApp", "Error stopping DataStore", error)
    );
}
```

</Block>
</BlockSwitcher>
