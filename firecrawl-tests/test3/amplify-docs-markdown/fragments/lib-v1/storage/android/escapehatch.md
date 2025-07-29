---
title: Documentation
source: fragments/lib-v1/storage/android/escapehatch.mdx
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
