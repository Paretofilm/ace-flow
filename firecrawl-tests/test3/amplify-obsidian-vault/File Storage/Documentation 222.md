---
title: Documentation
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/android/escapehatch.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Documentation

For advanced use cases where Amplify does not provide the functionality, you can retrieve the escape hatch to access the `AmazonS3Client` instance:

```java
AWSS3StoragePlugin plugin = (AWSS3StoragePlugin) Amplify.Storage.getPlugin("awsS3StoragePlugin");
AmazonS3Client client = plugin.getEscapeHatch();
```

</Block>

```kotlin
val plugin = Amplify.Storage.getPlugin("awsS3StoragePlugin") as AWSS3StoragePlugin
val client = plugin.escapeHatch
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/android/escapehatch.mdx`