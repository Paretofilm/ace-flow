---
title: Documentation
source: fragments/lib-v1/datastore/android/other-methods/20_start.mdx
---

# Documentation

```java
Amplify.DataStore.start(
    () -> Log.i("MyAmplifyApp", "DataStore started"),
    error -> Log.e("MyAmplifyApp", "Error starting DataStore", error)
);
```

</Block>

```kotlin
Amplify.DataStore.start(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: DataStoreException) 
```

</Block>

```java
RxAmplify.DataStore.start()
    .subscribe(
        () -> Log.i("MyAmplifyApp", "DataStore started"),
        error -> Log.e("MyAmplifyApp", "Error starting DataStore", error)
    );
}
```

</Block>
</BlockSwitcher>
