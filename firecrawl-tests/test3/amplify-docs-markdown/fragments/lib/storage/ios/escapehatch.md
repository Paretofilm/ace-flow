---
title: Documentation
source: fragments/lib/storage/ios/escapehatch.mdx
---

# Documentation

For advanced use cases where Amplify does not provide the functionality, you can retrieve the escape hatch to access the AWSS3 instance.

Add the following import:

```swift
import AWSS3StoragePlugin
```

Then retrieve the escape hatch with this code

```swift
do 

    // Retrieve the reference to S3Client
    let s3Client = storagePlugin.getEscapeHatch()

    // Make requests using s3Client...
    // ...
} catch 
```

For additional client documentation, see the [AWS SDK for Swift Client documentation](https://docs.aws.amazon.com/sdk-for-swift/latest/developer-guide/using-client-services.html). For S3Client code examples, see the [Amazon S3 examples using SDK for Swift](https://docs.aws.amazon.com/sdk-for-swift/latest/developer-guide/swift_s3_code_examples.html)
