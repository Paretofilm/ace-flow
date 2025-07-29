---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/android/other-methods/10_clear.mdx
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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/android/other-methods/10_clear.mdx`