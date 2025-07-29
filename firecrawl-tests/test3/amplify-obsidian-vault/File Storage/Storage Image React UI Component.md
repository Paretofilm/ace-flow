---
title: Storage Image React UI Component
topics: ['File Storage']
primary_topic: File Storage
source: pages/build-a-backend/storage/download-files/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Storage Image React UI Component

## Storage Image React UI Component

You can easily display images in your app by using the cloud-connected Storage Image React UI component. This component fetches images securely from your storage resource and displays it on the web page.

```bash title="Terminal" showLineNumbers=
npm add @aws-amplify/ui-react-storage aws-amplify
```
```tsx

Learn more about how you can further customize the UI component by referring to the [Storage Image documentation](https://ui.docs.amplify.aws/react/connected-components/storage/storageimage).

</InlineFilter>

To further customize your in-app experience, you can use the `getUrl` or `downloadData` API from the Amplify Library for Storage.

> **Note**: 

**Note:** Refer to [the Transfer Acceleration documentation](/[platform]/build-a-backend/storage/extend-s3-resources/#example---enable-transfer-acceleration) to learn how to enable transfer acceleration for storage APIs.

## Get or download file from a URL

With the `getUrl` API, you can get a presigned URL which is valid for 900 seconds or 15 minutes by default. You can use this URL to create a download link for users to click on. The `expiresAt` property is a `Date` object that represents the time at which the URL will expire.

```typescript

const linkToStorageFile = await getUrl() => `album/$/1.jpg`
});
console.log('signed URL: ', linkToStorageFile.url);
console.log('URL expires at: ', linkToStorageFile.expiresAt);
```
Inside your template or JSX code, you can use the `url` property to create a link to the file:

```tsx
<a href= target="_blank" rel="noreferrer">
   
</a>
```

> **Note**: 

This function does not check if the file exists by default. As result, the signed URL may fail if the file to be downloaded does not exist.

### More getUrl options

The behavior of the `getUrl` API can be customized by passing in options.

```typescript

const linkToStorageFile = await getUrl(
});
```

Option | Type | Default | Description |
| :--: | :--: | :--: | ----------- |
| bucket | string \| <br />\ | Default bucket and region from Amplify configuration | A string representing the target bucket's assigned name in Amplify Backend or an object specifying the bucket name and region from the console.<br/><br/>Read more at [Configure additional storage buckets](/[platform]/build-a-backend/storage/set-up-storage/#configure-additional-storage-buckets) 
| validateObjectExistence | boolean | false | Whether to head object to make sure the object existence before downloading. |
| expiresIn | number | 900 | Number of seconds till the URL expires. <br/><br/> The expiration time of the presigned url is dependent on the session and will max out at 1 hour. |
| useAccelerateEndpoint | boolean | false | Whether to use accelerate endpoint. <br/><br/> Read more at [Transfer Acceleration](/[platform]/build-a-backend/storage/extend-s3-resources/#example---enable-transfer-acceleration) |
| expectedBucketOwner | string | Optional | The account ID that owns requested bucket. |

</InlineFilter>

```java
Amplify.Storage.getUrl(
    StoragePath.fromString("public/example"),
    result -> Log.i("MyAmplifyApp", "Successfully generated: " + result.getUrl()),
    error -> Log.e("MyAmplifyApp", "URL generation failure", error)
);
```

</Block>

```kotlin
Amplify.Storage.getUrl(
    StoragePath.fromString("public/example"),
    ") },
    
)
```

</Block>

```kotlin
try  catch (error: StorageException) 
```

</Block>

```java
RxAmplify.Storage.getUrl(StoragePath.fromString("public/example")).subscribe(
    result -> Log.i("MyAmplifyApp", "Successfully generated: " + result.getUrl()),
    error -> Log.e("MyAmplifyApp", "URL generation failure", error)
);
```

</Block>
</BlockSwitcher>

### Check the existence of a file

When creating a downloadable URL, you can choose to check if the file exists by setting `validateObjectExistence` to
`true` in `AWSS3StorageGetPresignedUrlOptions`. If the file is inaccessible or does not exist, a `StorageException` is thrown.
This allows you to check if an object exists when generating the presigned URL, which you can then use to download
that object.

```java
AWSS3StorageGetPresignedUrlOptions options = AWSS3StorageGetPresignedUrlOptions
  .builder()
  .setValidateObjectExistence(true)
  .build();

Amplify.Storage.getUrl(
    StoragePath.fromString("public/example"),
    options,
    result -> Log.i("MyAmplifyApp", "Successfully generated: " + result.getUrl()),
    error -> Log.e("MyAmplifyApp", "URL generation failure", error)
);
```

</Block>

```kotlin
val options = AWSS3StorageGetPresignedUrlOptions
  .builder()
  .setValidateObjectExistence(true)
  .build()
  
Amplify.Storage.getUrl(
    StoragePath.fromString("public/example"),
    options,
    ") },
    
)
```
</Block>

```kotlin
try  catch (error: StorageException) 
```
</Block>

```java
AWSS3StorageGetPresignedUrlOptions options = AWSS3StorageGetPresignedUrlOptions
  .builder()
  .setValidateObjectExistence(true)
  .build();

RxAmplify.Storage.getUrl(StoragePath.fromString("public/example"), options).subscribe(
    result -> Log.i("MyAmplifyApp", "Successfully generated: " + result.getUrl()),
    error -> Log.e("MyAmplifyApp", "URL generation failure", error)
);
```
</Block>
</BlockSwitcher>

### All `getURL` options

Option | Type | Description |
| -- | -- | ----------- |
| bucket | StorageBucket | The bucket in which the object is stored. |
| expires | Integer | Number of seconds before the URL expires. |
| useAccelerateEndpoint | Boolean | Flag to configure use of acceleration mode. |
| validateObjectExistence | Boolean | Flag to check if the file exists. |

</InlineFilter>

```swift
let url = try await Amplify.Storage.getURL(
    path: .fromString("public/example/path")
)
print("Completed: \(url)")
```

### Check the existence of a file

When creating a downloadable URL, you can choose to check if the file exists by setting `validateObjectExistence` to
`true` in `AWSStorageGetURLOptions`. If the file is inaccessible or does not exist, a `StorageError` is thrown.
This allows you to check if an object exists during generating the presigned URL, which you can then use to download
that object.

```swift
let url = try await Amplify.Storage.getURL(
    path: .fromString("public/example/path"),
    options: .init(
        pluginOptions: AWSStorageGetURLOptions(
            validateObjectExistence: true
        )
    )
)
```

### All `getURL` options

Option | Type | Description |
| -- | -- | ----------- |
| expires | Int | Number of seconds before the URL expires |
| bucket | StorageBucket | The bucket in which the object is stored |

</InlineFilter>

When creating a downloadable URL, you can choose to check if the file exists by setting `validateObjectExistence` to
`true` in `S3GetUrlPluginOptions`. If the file is inaccessible or does not exist, a `StorageException` is thrown.
This allows you to check if an object exists during generating the presigned URL, which you can then use to download
that object. You may also pass in a bucket to target into `StorageGetUrlOptions` from either the chosen name in the 
backend or the console name and region. If no bucket is provided, the default bucket defined in the backend will be used. 
Read more at [Configure additional storage buckets](/[platform]/build-a-backend/storage/set-up-storage/#configure-additional-storage-buckets) 

```dart
Future<void> getDownloadUrl() async ');
  } on StorageException catch (e) 
}
```

</InlineFilter>

## Download to a file

Use the `downloadData` API to download the file locally.

```javascript

// Downloads file content to memory
const  = await downloadData().result;
```
</InlineFilter>

## Download to a file

Use the `downloadFile` API to download the file locally on the client.

> **Note**: 
**Note:** When downloading a file that will overwrite a preexisting file, ensure that your app has the proper write permission to overwrite it. If you are attempting to write to a file that a different app already contributed to the media store, you must request user consent[as described here](https://developer.android.com/training/data-storage/shared/media#update-other-apps-files).

To learn more, refer to Android's developer documentation about [Scoped Storage](https://developer.android.com/training/data-storage#scoped-storage).

Amplify will throw a `StorageException` if it is unable to modify a preexisting file.

```java
Amplify.Storage.downloadFile(
        StoragePath.fromString("public/example"),
        new File(getApplicationContext().getFilesDir() + "/download.txt"),
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
);
```

</Block>

```kotlin
val file = File("$/download.txt")
Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file,
    ") },
    
)
```

</Block>

```kotlin
try /download.txt")
    val download = Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file)
    try  catch (error: StorageException) 
}
```

</Block>

```java
RxProgressAwareSingleOperation download =
        RxAmplify.Storage.downloadFile(
            StoragePath.fromString("public/example"),
            new File(getApplicationContext().getFilesDir() + "/download.txt")
        );

download
    .observeResult()
    .subscribe(
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
    );
```

</Block>
</BlockSwitcher>
</InlineFilter>

## Download files
### Download to a local file

Use the `downloadFile` API to download the file locally on the client.

You can download to a file [URL](https://developer.apple.com/documentation/foundation/url) with `Amplify.Storage.downloadFile`:

```swift
let downloadToFileUrl = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
)[0].appendingPathComponent("myFile.txt")

let downloadTask = Amplify.Storage.downloadFile(
    path: .fromString("public/example/path"),
    local: downloadToFileUrl,
    options: nil
)
Task 
}
try await downloadTask.value
print("Completed")
```
</Block>

```swift
let downloadToFileUrl = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
)[0].appendingPathComponent("myFile.txt")

let downloadTask = Amplify.Storage.downloadFile(
    path: .fromString("public/example/path"),
    local: downloadToFileUrl,
    options: nil
)
let progressSink = downloadTask
    .inProcessPublisher
    .sink 

let resultSink = downloadTask
    .resultPublisher
    .sink 
    }
    receiveValue: 
```
</Block>
</BlockSwitcher>

### Download to data in memory

You can download to in-memory buffer [Data](https://developer.apple.com/documentation/foundation/data) object with `Amplify.Storage.downloadData`:

```swift
let downloadTask = Amplify.Storage.downloadData(
    path: .fromString("public/example/path")
)
Task 
}
let data = try await downloadTask.value
print("Completed: \(data)")
```

</Block>

```swift
let downloadTask = Amplify.Storage.downloadData(
    path: .fromString("public/example/path")
)
let progressSink = downloadTask
    .inProcessPublisher
    .sink 

let resultSink = downloadTask
    .resultPublisher
    .sink 
    }
    receiveValue: 
```

</Block>

</BlockSwitcher>

### Download from a specified bucket

You can also perform a download operation from a specific bucket by providing the `bucket` option

You can use `.fromOutputs(name:)` to provide a string representing the target bucket's assigned name in the Amplify Backend.

```swift
// Download to File
let downloadTask = Amplify.Storage.downloadFile(
    path: .fromString("public/example/path"),
    local: downloadToFileUrl,
    options: .init(
        bucket: .fromOutputs(name: "secondBucket")
    )
)

// Download to Data
let downloadTask = Amplify.Storage.downloadData(
    path: .fromString("public/example/path"),
    options: .init(
        bucket: .fromOutputs(name: "secondBucket")
    )
)
```
</Block>

You can also use `.fromBucketInfo(_:)` to provide a bucket name and region directly.

```swift
// Download to File
let downloadTask = Amplify.Storage.downloadFile(
    path: .fromString("public/example/path"),
    local: downloadToFileUrl,
    options: .init(
        bucket: .fromBucketInfo(.init(
            bucketName: "another-bucket-name",
            region: "another-bucket-region")
        )    
    )
)

// Download to Data
let downloadTask = Amplify.Storage.downloadData(
    path: .fromString("public/example/path"),
    options: .init(
        bucket: .fromBucketInfo(.init(
            bucketName: "another-bucket-name",
            region: "another-bucket-region")
        )    
    )
)
```
</Block>
</BlockSwitcher>

</InlineFilter>

## Download to a file

You can download a file to a local directory using `Amplify.Storage.downloadFile`.

You can use the [path_provider](https://pub.dev/packages/path_provider) package to create a local file in the user's documents directory where you can store the downloaded data.

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<void> downloadFile() async /example.txt';
  try ');
  } on StorageException catch (e) 
}
```

</Block>

On Web, the download process will be handled by the browser. You can provide the downloaded file name by specifying the `path` parameter of `AWSFile.fromPath`. E.g. this instructs the browser to download the file `download.txt`.

```dart
import 'package:amplify_flutter/amplify_flutter.dart';

Future<void> downloadFile() async ');
  } on StorageException catch (e) 
}
```

</Block>

</BlockSwitcher>

</InlineFilter>

### Get the text value of downloaded File

You can get the value of file in any of the three formats: `blob`, `json`, or `text`. You can call the respective method on the `body` property to consume the set data in the respective format.

```javascript

try ).result;
  const text = await downloadResult.body.text();
  // Alternatively, you can use `downloadResult.body.blob()`
  // or `downloadResult.body.json()` get read body in Blob or JSON format.
  console.log('Succeed: ', text);
} catch (error) 
```
</InlineFilter>

### Download from a specified bucket

You can also perform an upload operation to a specific bucket by providing the `bucket` option. You can pass in a string representing the target bucket's assigned name in Amplify Backend.

```ts

const result = await downloadData(
}).result;

```
Alternatively, you can also pass in an object by specifying the bucket name and region from the console.

```ts

const result = await downloadData(
    // highlight-end
  }
}).result;

```
### Monitor download progress

```javascript

// Download a file from S3 bucket
const  = await downloadData(
  %`);
      }
    }
  }
).result;
```

### Cancel download

```javascript

const downloadTask = downloadData();
downloadTask.cancel();
try  catch (error) 
}
```

</InlineFilter>

### Download from a specified bucket

You can also perform a download operation to a specific bucket by providing the `bucket` option. You can pass in a string representing the target bucket's assigned name in Amplify Backend.

```java
StorageBucket secondBucket = StorageBucket.fromOutputs("secondBucket");
StorageDownloadFileOptions options = StorageDownloadFileOptions.builder().bucket(secondBucket).build();
Amplify.Storage.downloadFile(
        StoragePath.fromString("public/example"),
        new File(getApplicationContext().getFilesDir() + "/download.txt"),
        options,
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
);
```

</Block>

```kotlin
val secondBucket = StorageBucket.fromOutputs("secondBucket")
val options = StorageDownloadFileOptions.builder().bucket(secondBucket).build()
val file = File("$/download.txt")
Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file, option,
    ") },
    
)
```

</Block>

```kotlin
val secondBucket = StorageBucket.fromOutputs("secondBucket")
val options = StorageDownloadFileOptions.builder().bucket(secondBucket).build()
val file = File("$/download.txt")
val download = Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file, options)
try  catch (error: StorageException) 
```

</Block>

```java      
StorageBucket secondBucket = StorageBucket.fromOutputs("secondBucket");
StorageDownloadFileOptions options = StorageDownloadFileOptions.builder().bucket(secondBucket).build();
RxProgressAwareSingleOperation download =
        RxAmplify.Storage.downloadFile(
            StoragePath.fromString("public/example"),
            new File(getApplicationContext().getFilesDir() + "/download.txt"),
            options
        );

download
    .observeResult()
    .subscribe(
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
    );
```

</Block>
</BlockSwitcher>

Alternatively, you can also pass in an object by specifying the bucket name and region from the console.

```java
BucketInfo bucketInfo = new BucketInfo("second-bucket-name-from-console", "us-east-2");
StorageBucket secondBucket = StorageBucket.fromBucketInfo(bucketInfo);
StorageDownloadFileOptions options = StorageDownloadFileOptions.builder().bucket(secondBucket).build();
Amplify.Storage.downloadFile(
        StoragePath.fromString("public/example"),
        new File(getApplicationContext().getFilesDir() + "/download.txt"),
        options,
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
);
```

</Block>

```kotlin
val bucketInfo = BucketInfo("second-bucket-name-from-console", "us-east-2")
val secondBucket = StorageBucket.fromBucketInfo(bucketInfo)
val options = StorageDownloadFileOptions.builder().bucket(secondBucket).build()
val file = File("$/download.txt")
Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file, options,
    ") },
    
)
```

</Block>

```kotlin
val bucketInfo = BucketInfo("second-bucket-name-from-console", "us-east-2")
val secondBucket = StorageBucket.fromBucketInfo(bucketInfo)
val options = StorageDownloadFileOptions.builder().bucket(secondBucket).build()
val file = File("$/download.txt")
val download = Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file, options)
try  catch (error: StorageException) 
```

</Block>

```java
BucketInfo bucketInfo = new BucketInfo("second-bucket-name-from-console", "us-east-2");
StorageBucket secondBucket = StorageBucket.fromBucketInfo(bucketInfo);
StorageDownloadFileOptions options = StorageDownloadFileOptions.builder().bucket(secondBucket).build();
RxProgressAwareSingleOperation download =
        RxAmplify.Storage.downloadFile(
            StoragePath.fromString("public/example"),
            new File(getApplicationContext().getFilesDir() + "/download.txt"),
            options,
        );

download
    .observeResult()
    .subscribe(
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
    );
```

</Block>
</BlockSwitcher>

### Monitor download progress

```java
Amplify.Storage.downloadFile(
        StoragePath.fromString("public/example"),
        new File(getApplicationContext().getFilesDir() + "/download.txt"),
        StorageDownloadFileOptions.defaultInstance(),
        progress -> Log.i("MyAmplifyApp", "Fraction completed: " + progress.getFractionCompleted()),
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
);
```

</Block>

```kotlin
val file = File("$/download.txt")
val options = StorageDownloadFileOptions.defaultInstance()
Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file, options,
    ") },
    ") },
    
)
```

</Block>

```kotlin
val file = File("$/download.txt")
val options = StorageDownloadFileOptions.defaultInstance()
val download = Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file, options)
val progressJob = activityScope.async ")
    }
}
try  catch (error: StorageException) 
progressJob.cancel()
```

</Block>

```java
RxProgressAwareSingleOperation download =
        RxAmplify.Storage.downloadFile(StoragePath.fromString("public/example"), localFile);

download
    .observeProgress()
    .subscribe(
      progress -> Log.i("MyAmplifyApp", progress.getFractionCompleted())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

### Monitor download progress

```dart
final operation = Amplify.Storage.downloadData(
  path: const StoragePath.fromString('public/example.txt'),
  onProgress: (progress) ');
    safePrint('fraction transferredBytes: $');
    safePrint('fraction completed: $');
  },
);
```

</InlineFilter>

### Pause, resume, and cancel downloads

```dart

Future<void> upload() async 

```

</InlineFilter>

### Query transfers

When an upload or download operation is requested using the Amplify Android library, the request is first persisted in the local SQLite Database and then queued for execution. You can query the transfer operation queued in the local database using the transfer ID returned by an upload or download API. Get-Transfer API could retrieve a pending transfer previously en-queued and enable attaching a listener to receive updates on progress change, on-error or on-success, or pause, cancel or resume it.

```java
Amplify.Storage.getTransfer("TRANSFER_ID",
    operation -> );
        operation.setOnSuccess( result -> );
        operation.setOnError(error -> );

        // possible actions
        operation.pause();
        operation.resume();
        operation.start();
        operation.cancel();
    },
    
);
```

</Block>

```kotlin
Amplify.Storage.getTransfer("TRANSFER_ID",
    
        operation.setOnSuccess 
        operation.setOnError 

        // possible actions
        operation.pause()
        operation.resume()
        operation.start()
        operation.cancel()
    },
    
)
```

</Block>

```kotlin
try 
    operation.setOnSuccess 
    operation.setOnError 

    // possible actions
    operation.pause()
    operation.resume()
    operation.start()
    operation.cancel()
} catch (error: StorageException) 
```

</Block>

```java
RxAmplify.Storage.getTransfer("TRANSFER_ID")
    .subscribe(
        operation -> );
            operation.setOnSuccess( result -> );
            operation.setOnError(error -> );

            // possible actions
            operation.pause();
            operation.resume();
            operation.start();
            operation.cancel();
        },
        error -> Log.e("MyAmplifyApp", "Failed to query transfer", error);
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

## API to download data in memory

You can download a file to in-memory buffer with `Amplify.Storage.downloadData`:

```dart
Future<void> download() async ');
  } on StorageException catch (e) 
}
```

## More download options

Option | Type | Description |
| -- | -- | ----------- |
| bucket | StorageBucket | The target bucket from the assigned name in the Amplify Backend or from the bucket name and region in the console<br/><br/>Defaults to the default bucket and region from the Amplify configuration if this option is not provided.<br/><br/>Read more at [Configure additional storage buckets](/[platform]/build-a-backend/storage/set-up-storage/#configure-additional-storage-buckets) |
| getProperties | boolean | Whether to retrieve properties for the downloaded object using theAmplify.Storage.getProperties() after the operation completes. When set to true the returned item will contain additional info such as metadata and content type. |
| useAccelerateEndpoint | boolean | Whether to use accelerate endpoint. <br/><br/> Read more at [Transfer Acceleration](/[platform]/build-a-backend/storage/upload-files/#transfer-acceleration) |
| bytesRange | S3DataBytesRange | The byte range to download from the object |

### Example of `downloadFile` with options

```dart
final operation = Amplify.Storage.downloadFile(
  path: const StoragePath.fromString('public/example.txt'),
  localFile: AWSFile.fromPath('/path/to/local/file.txt'),
  options: const StorageDownloadFileOptions(
    pluginOptions: S3DownloadFilePluginOptions(
      getProperties: true,
      useAccelerateEndpoint: true,
    ),
    bucket: StorageBucket.fromOutputs('secondBucket'),
  ),
);
```

### Example of `downloadData` with options

```dart
final operation = Amplify.Storage.downloadData(
  path: const StoragePath.fromString('public/example.txt'),
  options: StorageDownloadDataOptions(
    pluginOptions: S3DownloadDataPluginOptions(
      getProperties: true,
      useAccelerateEndpoint: true,
      bytesRange: S3DataBytesRange(start: 0, end: 100),
    ),
  ),
);
```

You can also perform a `downloadData` or `downloadFile` operation to a specific bucket by providing the `bucket` option. You can pass in a `StorageBucket` object representing the target bucket from the name defined in the Amplify Backend.

```dart
final operation = Amplify.Storage.downloadFile(
  path: const StoragePath.fromString('public/example.txt'),
  localFile: AWSFile.fromPath('/path/to/local/file.txt'),
  options: const StorageDownloadFileOptions(
    pluginOptions: S3DownloadFilePluginOptions(
      getProperties: true,
      useAccelerateEndpoint: true,
    ),
    bucket: StorageBucket.fromOutputs('secondBucket'),
  ),
);
```

Alternatively, you can also pass in an object by specifying the bucket name and region from the console.

```dart
final operation = Amplify.Storage.downloadData(
  path: const StoragePath.fromString('public/example.txt'),
  options: StorageDownloadDataOptions(
    pluginOptions: S3DownloadDataPluginOptions(
      getProperties: true,
      useAccelerateEndpoint: true,
      bytesRange: S3DataBytesRange(start: 0, end: 100),
    ),
    bucket: StorageBucket.fromBucketInfo(
      BucketInfo(
        bucketName: 'second-bucket-name-from-console',
        region: 'us-east-2',
      ),
    ),
  ),
);
```
</InlineFilter>

### Pause, resume, and cancel downloads

Calls to `downloadData` or `downloadFile` return a reference to the task that is actually performing the download.

You can pause then resume the task or cancel a task as shown below.

```swift
downloadTask.pause()
downloadTask.resume()
downloadTask.cancel()
```

> **Note**: 

Download tasks are run using `URLSessionTask` instances internally. You can learn more about them in [Apple's official documentation](https://developer.apple.com/documentation/foundation/urlsessiontask).

</InlineFilter>

### More download options
The behavior of the `downloadData` API can be customized by passing in options.

```javascript

// Downloads file content to memory
const  = await downloadData(,
    useAccelerateEndpoint: true,
  }
}).result;

```

Option | Type | Default | Description |
| :--: | :--: | :--: | ----------- |
| bucket | string \| <br />\ | Default bucket and region from Amplify configuration | A string representing the target bucket's assigned name in Amplify Backend or an object specifying the bucket name and region from the console.<br/><br/>Read more at [Configure additional storage buckets](/[platform]/build-a-backend/storage/set-up-storage/#configure-additional-storage-buckets) |
| onProgress | callback | — | Callback function tracking the upload/download progress. |
| bytesRange |  \ | — | Bytes range parameter to download a part of the file. |
| useAccelerateEndpoint | boolean | false | Whether to use accelerate endpoint.<br/><br/>Read more at [Transfer Acceleration](/[platform]/build-a-backend/storage/extend-s3-resources/#example---enable-transfer-acceleration) |
| expectedBucketOwner | string | Optional | The account ID that owns requested bucket. |

## Frequently Asked Questions

- [Image compression](https://github.com/aws-amplify/amplify-js/issues/6081) or CloudFront CDN caching for your S3 buckets is not yet possible.
- `downloadData` does not provide a cache control option and it replies on runtime HTTP caching behavior. If you need to bypass the cache, you can use the `getUrl` API to create a presigned URL for downloading the file.
- `downloadData` does not support S3 object versioning, it always downloads the latest version.

</InlineFilter>


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `pages/build-a-backend/storage/download-files/index.mdx`