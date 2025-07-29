---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/restapi/android/authz/22_none_headers.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

If you would like to add request headers, you can add it directly to the request

This implementation uses `CompletableFuture`, which requires `minSdkVersion >= 24`.

```java
RestOptions options = RestOptions.builder()
    .addHeaders(Collections.singletonMap("key", "value"))
    .build();
```

</Block>

This implementation uses `CompletableFuture`, which requires `minSdkVersion >= 24`.

```kotlin
val options = RestOptions.builder()
    .addHeaders(mapOf("key" to "value"))
    .build()
```

</Block>

This implementation uses `CompletableFuture`, which requires `minSdkVersion >= 24`.

```kotlin
val request = RestOptions.builder()
    .addHeaders(mapOf("key" to "value"))
    .build()
```

</Block>

```
RestOptions options = RestOptions.builder()
    .addHeaders(Collections.singletonMap("key", "value"))
    .build();
```
</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/restapi/android/authz/22_none_headers.mdx`