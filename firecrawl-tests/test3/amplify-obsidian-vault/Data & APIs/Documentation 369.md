---
title: Documentation
topics: ['Data & APIs', 'Getting Started']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/android/other-methods/20_start.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, getting-started]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Getting Started/]]
**Primary**: [[Data & APIs/]]

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


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/android/other-methods/20_start.mdx`