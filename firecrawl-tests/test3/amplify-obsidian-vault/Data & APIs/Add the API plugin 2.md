---
title: Add the API plugin
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/android/sync/10-installPlugin.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Add the API plugin

### Add the API plugin

Although DataStore presents a distinct API, its cloud synchronization functionality relies on the underlying [API category](/gen1/[platform]/prev/build-a-backend/graphqlapi/). Therefore, you will still be required to incorporate the API plugin when working with DataStore.

Make sure that you declare a dependency on the API plugin in your app-level `build.gradle`:

```groovy
dependencies 
```

Next, add the plugin in your Amplify initialization code alongside with the previously added `AWSDataStorePlugin`.

```java
Amplify.addPlugin(new AWSDataStorePlugin());
// Add this line.
Amplify.addPlugin(new AWSApiPlugin());
Amplify.configure(getApplicationContext());
```

</Block>

```kotlin
Amplify.addPlugin(AWSDataStorePlugin())
// Add this line.
Amplify.addPlugin(AWSApiPlugin())
Amplify.configure(applicationContext)
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/android/sync/10-installPlugin.mdx`