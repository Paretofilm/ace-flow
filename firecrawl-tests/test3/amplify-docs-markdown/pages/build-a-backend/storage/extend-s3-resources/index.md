---
title: For Amplify-generated S3 resources
source: pages/build-a-backend/storage/extend-s3-resources/index.mdx
---

# For Amplify-generated S3 resources

## For Amplify-generated S3 resources

Amplify Storage generates Amazon S3 resources to offer storage features. You can access the underlying Amazon S3 resources to further customize your backend configuration by using the AWS Cloud Developer Kit (AWS CDK).

### Example - Enable Transfer Acceleration

The following is an example of how you would enable Transfer Acceleration on the bucket ([CDK documentation](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_s3.CfnBucket.AccelerateConfigurationProperty.html)). In order to enable Transfer Acceleration on the bucket, you will have to unwrap the L1 CDK construct from the L2 CDK construct like the following.

```tsx
// highlight-next-line

const backend = defineBackend();

// highlight-start
const s3Bucket = backend.storage.resources.bucket;

const cfnBucket = s3Bucket.node.defaultChild as s3.CfnBucket;

cfnBucket.accelerateConfiguration = 
// highlight-end
```

### Upload files using the accelerated S3 endpoint

We switch to the accelerated S3 endpoint by using the `useAccelerateEndpoint` parameter set to `true` in the `AWSS3StorageUploadFileOptions`.

```java
AWSS3StorageUploadFileOptions awsS3StorageUploadFileOptions =
              AWSS3StorageUploadFileOptions.builder().setUseAccelerateEndpoint(true).build();
 Amplify.Storage.uploadFile(
   StoragePath.fromString("public/example"),
   file
   awsS3StorageUploadFileOptions,
   result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
   storageFailure -> Log.e("MyAmplifyApp", "Upload failed", storageFailure)
);
```
</Block>

```kotlin
val awsS3StorageUploadFileOptions = AWSS3StorageUploadFileOptions.builder().
                                                  setUseAccelerateEndpoint(true).
                                                  build()
 Amplify.Storage.uploadFile(
   StoragePath.fromString("public/example"),
   file
   awsS3StorageUploadFileOptions,
   ,
   
)
```
</Block>

```kotlin
val awsS3StorageUploadFileOptions = AWSS3StorageUploadFileOptions.builder().
                                                    setUseAccelerateEndpoint(true).
                                                    build()
val upload = Amplify.Storage.uploadFile(StoragePath.fromString("public/example"), file, awsS3StorageUploadFileOptions)
try ")
} catch (error: StorageException) 

```
</Block>

```java
AWSS3StorageUploadFileOptions awsS3StorageUploadFileOptions =
            AWSS3StorageUploadFileOptions.builder().setUseAccelerateEndpoint(true).build();
RxProgressAwareSingleOperation rxUploadOperation =
            RxAmplify.Storage.uploadFile(StoragePath.fromString("public/example"), file, awsS3StorageUploadFileOptions);
rxUploadOperation
            .observeResult()
            .subscribe(
                result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
                error -> Log.e("MyAmplifyApp", "Upload failed", error)
            );

```
</Block>
</BlockSwitcher>
</InlineFilter>

### Upload files using the accelerated S3 endpoint

You can use transfer acceleration by setting `"useAccelerateEndpoint"` to `true` in the corresponding `pluginOptions` for any of the following Storage APIs:
- `getUrl(key:options:)`
- `downloadData(key:options:)`
- `downloadFile(key:local:options:)`
- `uploadData(key:data:options:)`
- `uploadFile(key:local:options:)`

For example, to upload a file using transfer acceleration:

```swift
let uploadTask = Amplify.Storage.uploadFile(
    key: aKey,
    local: aLocalFile,
    options: .init(
        pluginOptions: [
            "useAccelerateEndpoint": true
        ]
    )
)

let data = try await uploadTask.value
```

</InlineFilter>

### Upload files using the accelerated S3 endpoint

You can use transfer acceleration when calling the following APIs:

* `getUrl`
* `downloadData`
* `downloadFile`
* `uploadData`
* `uploadFile`

Set `useAccelerateEndpoint` to `true` in the corresponding Storage S3 plugin options to apply an accelerated S3 endpoint to the operation. For example, upload a file using transfer acceleration:

```dart
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

Future<void> uploadFileUsingAcceleration(String filePath, String key) async ');
  } on StorageException catch (error) ');
  }
}
```

</InlineFilter>

Read more about [escape hatches in the CDK](https://docs.aws.amazon.com/cdk/v2/guide/cfn_layer.html#develop-customize-escape).

## For Manually configured S3 resources

Follow this guide if you are building against a web target.

</InlineFilter>

> **Note**: 

To make calls to your S3 bucket from your App, you need to set up a CORS Policy for your S3 bucket. This callout is only for manual configuration of your S3 bucket.

The following steps will set up your CORS Policy:

1. Go to [Amazon S3 console](https://s3.console.aws.amazon.com/s3/home?region=us-east-1) and click on your project's `userfiles` bucket, which is normally named as [Bucket Name][Id]-dev. ![Go to [Amazon S3 Console]](/images/storage/CORS1.png)
2. Click on the **Permissions** tab for your bucket. ![Click on the **Permissions** tab for your bucket](/images/storage/CORS2.png)
3. Click the edit button in the **Cross-origin resource sharing (CORS)** section. ![Click the edit button in the **Cross-origin resource sharing (CORS)** section](/images/storage/CORS3.png)
4. Make the Changes and click on Save Changes. You can add required metadata to be exposed in `ExposeHeaders` with `x-amz-meta-XXXX` format. ![Click on Save Changes:](/images/storage/CORS4.png)

```json
[
  
]
```

> **Note**: 

**Note:** You can restrict the access to your bucket by updating AllowedOrigin to include individual domains.

</InlineFilter>
