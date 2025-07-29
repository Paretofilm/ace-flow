---
title: Documentation
source: fragments/lib/storage/android/escapehatch.mdx
---

# Documentation

For advanced use cases where Amplify does not provide the functionality, you can retrieve the escape hatch to access the `S3Client` instance:

```java
AWSS3StoragePlugin plugin = (AWSS3StoragePlugin) Amplify.Storage.getPlugin("awsS3StoragePlugin");
S3Client client = plugin.getEscapeHatch();
```

</Block>

```kotlin
val plugin = Amplify.Storage.getPlugin("awsS3StoragePlugin") as AWSS3StoragePlugin
val client = plugin.escapeHatch
```

</Block>
</BlockSwitcher>
