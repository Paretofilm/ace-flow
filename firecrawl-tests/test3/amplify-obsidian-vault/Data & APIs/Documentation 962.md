---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/other-methods/30_stop.mdx
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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/android/other-methods/30_stop.mdx`