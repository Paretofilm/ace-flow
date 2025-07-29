---
title: Documentation
source: fragments/lib-v1/datastore/android/other-methods/10_clear.mdx
---

# Documentation

```java
Amplify.DataStore.clear(
    () -> Log.i("MyAmplifyApp", "DataStore cleared"),
    error -> Log.e("MyAmplifyApp", "Error clearing DataStore", error)
);

```

</Block>

```kotlin
Amplify.DataStore.clear(
    ,
    
)

```

</Block>

```kotlin
try  catch (error: DataStoreException) 

```

</Block>

```java
RxAmplify.DataStore.clear()
    .subscribe(
        () -> Log.i("MyAmplifyApp", "DataStore cleared"),
        error -> Log.e("MyAmplifyApp", "Error clearing DataStore", error)
    );
}
```

</Block>
</BlockSwitcher>
