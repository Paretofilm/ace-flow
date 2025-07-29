---
title: Use AWS SDK for S3 APIs
source: pages/build-a-backend/storage/use-aws-sdk/index.mdx
---

# Use AWS SDK for S3 APIs

For advanced use cases where Amplify does not provide the functionality, you can retrieve the escape hatch to access the `S3Client` instance:

> **Note**: 

Learn more about consuming Kotlin clients from Java using either a blocking interface or an equivalent async interface based on futures [here](https://github.com/awslabs/smithy-kotlin/blob/main/docs/design/kotlin-smithy-sdk.md#java-interop).

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

</InlineFilter>

Add the following import:

```swift
import AWSS3StoragePlugin
```

Then retrieve the escape hatch with this code:

```swift
do 

    // Retrieve the reference to S3Client
    let s3Client = storagePlugin.getEscapeHatch()

    // Make requests using s3Client...
    // ...
} catch 
```

For additional client documentation, see the [AWS SDK for Swift Client documentation](https://docs.aws.amazon.com/sdk-for-swift/latest/developer-guide/using-client-services.html). For S3Client code examples, see the [Amazon S3 examples using SDK for Swift](https://docs.aws.amazon.com/sdk-for-swift/latest/developer-guide/swift_s3_code_examples.html)

</InlineFilter>
