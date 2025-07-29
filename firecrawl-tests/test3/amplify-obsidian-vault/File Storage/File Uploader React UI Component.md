---
title: File Uploader React UI Component
topics: ['File Storage']
primary_topic: File Storage
source: pages/build-a-backend/storage/upload-files/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# File Uploader React UI Component

You can implement upload functionality in your app by either using the File Uploader UI component or further customizing the upload experience using the upload API.

## File Uploader React UI Component

Upload files from your app in minutes by using the cloud-connected File Uploader UI Component.

```bash title="Terminal" showLineNumbers=
npm add @aws-amplify/ui-react-storage aws-amplify
```
Then, use the component in your app.

```tsx
import '@aws-amplify/ui-react/styles.css';

![Showing File Uploader UI component](/images/gen2/storage/upload-ui-component.png)

Learn more about how you can further customize the UI component by referring to the [File Uploader documentation](https://ui.docs.amplify.aws/react/connected-components/storage/fileuploader).

</InlineFilter>

## Implement upload functionality

> **Note**: 

**Note:** Refer to [the Transfer Acceleration documentation](/[platform]/build-a-backend/storage/extend-s3-resources/#example---enable-transfer-acceleration) to learn how to enable transfer acceleration for storage APIs.

### Upload from file

The following is an example of how you would upload a file from a file object, this could be retrieved from the local machine or a different source.

```jsx

function App() ;

  const handleClick = () => 
    uploadData(`,
      data: file,
    });
  };

  return (
    <div>
      <input type="file" onChange= />
      <button onClick=>Upload</button>
    </div>
  );
}
```
</InlineFilter>

```javascript

const file = document.getElementById("file");
const upload = document.getElementById("upload");

upload.addEventListener("click", () => );
    } catch (e) 
  };
});
```
</InlineFilter>

### Upload from data

You can follow this example if you have data saved in memory and would like to upload this data to the cloud.

```javascript

try ) => `album/$/1.jpg`
    data: file,
  }).result;
  console.log('Succeeded: ', result);
} catch (error) 
```
</InlineFilter>

### Upload from file

```java
private void uploadFile()  catch (Exception exception) 

    Amplify.Storage.uploadFile(
            StoragePath.fromString("public/example"),
            exampleFile,
            result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
            storageFailure -> Log.e("MyAmplifyApp", "Upload failed", storageFailure)
    );
}
```

</Block>

```kotlin
private fun uploadFile() ") },
        
    )
}
```

</Block>

```kotlin
private suspend fun uploadFile() ")
    } catch (error: StorageException) 
}
```

</Block>

```java
private void uploadFile()  catch (Exception exception) 

    RxProgressAwareSingleOperation rxUploadOperation =
            RxAmplify.Storage.uploadFile(StoragePath.fromString("public/example"), exampleFile);

    rxUploadOperation
            .observeResult()
            .subscribe(
                result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
                error -> Log.e("MyAmplifyApp", "Upload failed", error)
            );
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

### Upload from Input Stream

```java
private void uploadInputStream()   catch (FileNotFoundException error) 
}
```

</Block>

```kotlin
private fun uploadInputStream(uri: Uri) ") },
        
    )
}
```

</Block>

```kotlin
private suspend fun uploadInputStream(uri: Uri) .")
    } catch (error: StorageException) 
}
```

</Block>

```java
private void uploadInputStream()  catch (FileNotFoundException error) 
}
```

</Block>
</BlockSwitcher>
</InlineFilter>

### Upload from file

When you have a file that you want to upload, you can specify the url to the file in the `local` parameter.
If a file with the same `path` already exists in S3, the existing S3 file will be overwritten.

```swift
let dataString = "My Data"
let fileName = "myFile.txt"
guard let fileUrl = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
).first?.appendingPathComponent(fileName)
else 

try dataString.write(
    to: fileUrl,
    atomically: true,
    encoding: .utf8
)

let uploadTask = Amplify.Storage.uploadFile(
    path: .fromString("public/example/path/myFile.txt"),
    local: fileUrl
)

```

### Upload from data

To upload a file from a data object, specify the `path` and the `data` object to be uploaded.

```swift
let dataString = "My Data"
let data = Data(dataString.utf8)
let uploadTask = Amplify.Storage.uploadData(
    path: .fromString("public/example/path/myFile.txt"),
    data: data
)
```

</InlineFilter>

### Upload from file

> **Note**: 

**Note**: To use `AWSFilePlatform`, add [aws_common](https://pub.dev/packages/aws_common) package to your Flutter project
by running: `flutter pub add aws_common`

```dart
import 'package:amplify_flutter/amplify_flutter.dart';

Future<void> uploadFile() async ');
  } on StorageException catch (e) 
}
```

</Block>

```dart
import 'dart:io' show File;

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_common/vm.dart';

Future<void> uploadFile(File file) async ');
  } on StorageException catch (e) 
}
```

</Block>

```dart
import 'dart:html' show File;

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_common/web.dart';

Future<void> uploadFile(File file) async ');
  } on StorageException catch (e) 
}
```

</Block>

</BlockSwitcher>

### Upload from Flutter's `file_picker` plugin

The [file_picker](https://pub.dev/packages/file_picker) plugin can be used to retrieve arbitrary file types from the user's device.

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';

Future<void> uploadImage() async 

  // Upload file using the filename
  final platformFile = result.files.single;
  try '),
      onProgress: (progress) ');
      },
    ).result;
    safePrint('Successfully uploaded file: $');
  } on StorageException catch (e) 
}
```

### Upload from data

To upload from a data object, specify the `path` and `data`, where `data` is an instance of `S3DataPayload` created from various data formats.

```dart
Future<void> uploadData() async ');
  } on StorageException catch (e) 
}
```

</Block>

```dart
Future<void> uploadData() async ,
      }),
      path: const StoragePath.fromString('public/example.json'),
    ).result;
    safePrint('Uploaded data: $');
  } on StorageException catch (e) 
}
```

</Block>

See more info about [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URLs).

```dart
Future<void> uploadData() async ');
  } on StorageException catch (e) 
}
```

</Block>

```dart
Future<void> uploadBytes() async ');
  } on StorageException catch (e) 
}
```

</Block>

</BlockSwitcher>

</InlineFilter>

### Monitor upload progress

```dart
final operation = Amplify.Storage.uploadFile(
  localFile: AWSFile.fromPath('/path/to/local/file'),
  path: const StoragePath.fromString('public/example.txt'),
  onProgress: (progress) ');
    safePrint('fraction transferredBytes: $');
    safePrint('fraction completed: $');
  }
);
```
</InlineFilter>

### Pause, resume, and cancel uploads

A call to `Amplify.Storage.uploadFile` or `Amplify.Storage.uploadData` returns a reference to the operation that is performing the upload.

```dart
Future<void> upload() async 
```

</InlineFilter>

### Upload to a specified bucket

You can also perform an `upload` operation to a specific bucket by providing the `bucket` option. You can pass in a `StorageBucket` object representing the target bucket from the name defined in the Amplify Backend.

```dart
final data = 'multi bucket upload data byte'.codeUnits;
final result = await Amplify.Storage.uploadData(
  data: StorageDataPayload.bytes(data),
  path: const StoragePath.fromString('path/to/file.txt'),
  options: StorageUploadDataOptions(
    // highlight-start
    // Specify a target bucket using name assigned in Amplify Backend
    bucket: StorageBucket.fromOutputs('secondBucket'),
    // highlight-end
  ),
).result;
```
Alternatively, you can also pass in an object by specifying the bucket name and region from the console.

```dart
final data = 'multi bucket upload data byte'.codeUnits;
final result = await Amplify.Storage.uploadData(
  data: StorageDataPayload.bytes(data),
  path: const StoragePath.fromString('path/to/file.txt'),
  options: StorageUploadDataOptions(
    // highlight-start
    // Alternatively, provide bucket name from console and associated region
   bucket: StorageBucket.fromBucketInfo(
        BucketInfo(
          bucketName: 'second-bucket-name-from-console',
          region: 'us-east-2',
        ),
      ),
      // highlight-end
  ),
).result;
```
</InlineFilter>

### More upload options

Option | Type | Description |
| -- | -- | ----------- |
| bucket | StorageBucket | The target bucket from the assigned name in the Amplify Backend or from the bucket name and region in the console<br/><br/>Defaults to default bucket and region from the Amplify configuration if this option is not provided.<br/><br/>Read more at [Configure additional storage buckets](/[platform]/build-a-backend/storage/set-up-storage/#configure-additional-storage-buckets) |
| getProperties | boolean | Whether to retrieve properties for the uploaded object using theAmplify.Storage.getProperties() after the operation completes. When set to true the returned item will contain additional info such as metadata and content type. |
| useAccelerateEndpoint | boolean | Whether to use accelerate endpoint. <br/><br/> Read more at [Transfer Acceleration](/[platform]/build-a-backend/storage/upload-files/#transfer-acceleration) |

Example of `uploadFile` with options:

```dart
final operation = Amplify.Storage.uploadFile(
  localFile: AWSFile.fromPath('/path/to/local/file'),
  path: const StoragePath.fromString('public/example.txt'),
  options: const StorageUploadFileOptions(
    metadata: ,
    pluginOptions: S3UploadFilePluginOptions(
      getProperties: true,
      useAccelerateEndpoint: true,
    ),
  ),
);
```

Example of `uploadData` with options:

```dart
final operation = Amplify.Storage.uploadData(
  data: StorageDataPayload.string('example'),
  path: const StoragePath.fromString('public/example.txt'),
  options: const StorageUploadDataOptions(
    metadata: ,
    pluginOptions: S3UploadDataPluginOptions(
      getProperties: true,
      useAccelerateEndpoint: true,
    ),
  ),
);
```

</InlineFilter>

### Upload to a specified bucket

You can also perform an upload operation to a specific bucket by providing the `bucket` option. You can pass in a string representing the target bucket's assigned name in Amplify Backend.

```ts

const result = await uploadData(
}).result;
```
Alternatively, you can also pass in an object by specifying the bucket name and region from the console.

```ts

const result = await uploadData(
    // highlight-end
  }
}).result;

```
</InlineFilter>

### Upload to a specified bucket

You can also perform an upload operation to a specific bucket by providing the `bucket` option. You can pass in a string representing the target bucket's assigned name in Amplify Backend.

```java
private void uploadFile()  catch (Exception exception) 

    StorageBucket secondBucket = StorageBucket.fromOutputs("secondBucket");
    StorageUploadFileOptions options = StorageUploadFileOptions.builder().bucket(secondBucket).build();

    Amplify.Storage.uploadFile(
            StoragePath.fromString("public/example"),
            exampleFile,
            options,
            result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
            storageFailure -> Log.e("MyAmplifyApp", "Upload failed", storageFailure)
    );
}
```

</Block>

```kotlin
private fun uploadFile() ") },
        
    )
}
```

</Block>

```kotlin
private suspend fun uploadFile() ")
    } catch (error: StorageException) 
}
```

</Block>

```java
private void uploadFile()  catch (Exception exception) 

    StorageBucket secondBucket = StorageBucket.fromOutputs("secondBucket");
    StorageUploadFileOptions options = StorageUploadFileOptions.builder().bucket(secondBucket).build();

    RxProgressAwareSingleOperation rxUploadOperation =
            RxAmplify.Storage.uploadFile(StoragePath.fromString("public/example"), exampleFile, options);

    rxUploadOperation
            .observeResult()
            .subscribe(
                result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
                error -> Log.e("MyAmplifyApp", "Upload failed", error)
            );
}
```

</Block>
</BlockSwitcher>

Alternatively, you can also pass in an object by specifying the bucket name and region from the console.

```java
private void uploadFile()  catch (Exception exception) 

    BucketInfo bucketInfo = new BucketInfo("second-bucket-name-from-console", "us-east-2");
    StorageBucket secondBucket = StorageBucket.fromBucketInfo(bucketInfo);
    StorageUploadFileOptions options = StorageUploadFileOptions.builder().bucket(secondBucket).build();

    Amplify.Storage.uploadFile(
            StoragePath.fromString("public/example"),
            exampleFile,
            options,
            result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
            storageFailure -> Log.e("MyAmplifyApp", "Upload failed", storageFailure)
    );
}
```

</Block>

```kotlin
private fun uploadFile() ") },
        
    )
}
```

</Block>

```kotlin
private suspend fun uploadFile() ")
    } catch (error: StorageException) 
}
```

</Block>

```java
private void uploadFile()  catch (Exception exception) 

    BucketInfo bucketInfo = new BucketInfo("second-bucket-name-from-console", "us-east-2");
    StorageBucket secondBucket = StorageBucket.fromBucketInfo(bucketInfo);
    StorageUploadFileOptions options = StorageUploadFileOptions.builder().bucket(secondBucket).build();

    RxProgressAwareSingleOperation rxUploadOperation =
            RxAmplify.Storage.uploadFile(StoragePath.fromString("public/example"), exampleFile, options);

    rxUploadOperation
            .observeResult()
            .subscribe(
                result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
                error -> Log.e("MyAmplifyApp", "Upload failed", error)
            );
}
```

</Block>
</BlockSwitcher>
</InlineFilter>

### Upload to a specified bucket

You can perform an upload operation to a specific bucket by providing the `bucket` option.

You can use `.fromOutputs(name:)` to provide a string representing the target bucket's assigned name in the Amplify Backend.

```swift
// Upload from File
let uploadTask = Amplify.Storage.uploadFile(
    path: .fromString("public/example/path/myFile.txt"),
    local: fileUrl,
    options: .init(
        bucket: .fromOutputs(name: "secondBucket")
    )
)

// Upload from Data
let uploadTask = Amplify.Storage.uploadData(
    path: .fromString("public/example/path/myFile.txt"),
    data: data,
    options: .init(
        bucket: .fromOutputs(name: "secondBucket")
    )
)
```
</Block>

You can also use `.fromBucketInfo(_:)` to provide a bucket name and region directly.

```swift
// Upload from File
let uploadTask = Amplify.Storage.uploadFile(
    path: .fromString("public/example/path/myFile.txt"),
    local: fileUrl,
    options: .init(
        bucket: .fromBucketInfo(.init(
            bucketName: "another-bucket-name",
            region: "another-bucket-region")
        )    
    )
)

// Upload from Data
let uploadTask = Amplify.Storage.uploadData(
    path: .fromString("public/example/path/myFile.txt"),
    data: data,
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

### Monitor upload progress

Monitor progress of upload by using the `onProgress` option.

```javascript

const monitorUpload = async () => ) => `album/$/1.jpg`
      data: file,
      options: ) =>  %`
            );
          }
        },
      },
    }).result;
    console.log("Path from Response: ", result.path);
  } catch (error) 
}
```
</InlineFilter>

### Monitor upload progress

To track progress of the upload, use the reference returned by the `uploadFile` or `uploadData` as shown below.

```swift
Task 
}

let value = try await uploadTask.value
print("Completed: \(value)")
```
</Block>

```swift
let progressSink = uploadTask
    .inProcessPublisher
    .sink 

let resultSink = uploadTask
    .resultPublisher
    .sink 
    }
    receiveValue: 
```
</Block>
</BlockSwitcher>

</InlineFilter>

### Monitor upload progress

To track progress of the upload, use the `uploadFile` API that includes a progress listener callback.

```java
private void uploadFile()  catch (Exception exception) 

    Amplify.Storage.uploadFile(
        StoragePath.fromString("public/example"),
        exampleFile,
        StorageUploadFileOptions.defaultInstance(),
        progress -> Log.i("MyAmplifyApp", "Fraction completed: " + progress.getFractionCompleted()),
        result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
        storageFailure -> Log.e("MyAmplifyApp", "Upload failed", storageFailure)
    );
}
```

</Block>

```kotlin
private fun uploadFile() ") },
        ") },
        
    )
}
```

</Block>

```kotlin
private suspend fun uploadFile() ")
        }
    }
    try ")
    } catch (error: StorageException) 
    progressJob.cancel()
}
```

</Block>

```java
RxProgressAwareSingleOperation upload =
        RxAmplify.Storage.uploadFile("example", exampleFile);

upload
    .observeProgress()
    .subscribe(
      progress -> Log.i("MyAmplifyApp", progress.getFractionCompleted())
    );
```

</Block>
</BlockSwitcher>
</InlineFilter>

### All `upload` options

Option | Type | Description |
| -- | -- | ----------- |
| metadata | Map\ | Metadata for the object to store. |
| contentType | String | The standard MIME type describing the format of the object to store. |
| bucket | StorageBucket | The bucket in which the object should be stored. |
| serverSideEncryption | ServerSideEncryption | The server side encryption algorithm. |
| useAccelerateEndpoint | boolean | Flag to determine whether to use acceleration endpoint. |

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

### Transfer with Object Metadata

To upload a file accompanied by metadata, utilize the `StorageUploadFileOptions` builder. Start by creating a hashMap object, then incorporate it into the `StorageUploadFileOptions` during the build process before passing it along to the upload function.

```java
private void uploadFile()  catch (Exception exception) 

    // Create metadata
    Map userMetadata = new HashMap<>();
    userMetadata.put("myKey", "myVal");

    // Configure upload options with metadata
    StorageUploadFileOptions options = StorageUploadFileOptions.builder()
        .metadata(userMetadata)
        .build();

    // Perform the upload
    Amplify.Storage.uploadFile(
        StoragePath.fromString("public/example"),
        exampleFile,
        options,
        result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
        error -> Log.e("MyAmplifyApp", "Upload failed", error)
    );
}
```
</Block>

```kotlin
fun uploadFile() ") },
        
    )
}
```
</Block>

```kotlin
fun uploadFile() ")
        }
    }
    try ")
    } catch (error: StorageException) 
    progressJob.cancel()
}
```
</Block>

```Java
private void uploadFile()  catch (Exception exception) 

    Map userMetadata = new HashMap<>();
    userMetadata.put("myKey", "myVal");

    StorageUploadFileOptions options = StorageUploadFileOptions.builder()
            .metadata(userMetadata)
            .build();

    RxStorageBinding.RxProgressAwareSingleOperation rxUploadOperation =
            RxAmplify.Storage.uploadFile(StoragePath.fromString("public/example"), exampleFile, options);

    rxUploadOperation
            .observeResult()
            .subscribe(
                    result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
                    error -> Log.e("MyAmplifyApp", "Upload failed", error)
            );
}
 ```
</Block>
</BlockSwitcher>
</InlineFilter>

### Pause, resume, and cancel uploads

We have callback functions that support resuming, pausing, and cancelling `uploadData` requests.

```javascript

// Pause, resume, and cancel a task
const uploadTask = uploadData();
//...
uploadTask.pause();
//...
uploadTask.resume();
//...
uploadTask.cancel();
//...
try  catch (error) 
}
```
</InlineFilter>

### Pause, resume, and cancel uploads

Calls to `uploadData` or `uploadFile` return a reference to the task that is actually performing the upload.

You can pause then resume the task or cancel a task as shown below.

```swift
uploadTask.pause()
uploadTask.resume()
uploadTask.cancel()
```

> **Note**: 

Upload tasks are run using `URLSessionTask` instances internally. You can learn more about them in [Apple's official documentation](https://developer.apple.com/documentation/foundation/urlsessiontask).

</InlineFilter>

### All `upload` options

Option | Type | Description |
| -- | -- | ----------- |
| metadata | [String: String] | Metadata for the object to store. |
| contentType | String | The standard MIME type describing the format of the object to store. |
| bucket | StorageBucket | The bucket in which the object should be stored |

</InlineFilter>

## Working with Security Scoped Resources (from iCloud)
Security scoped resources refer to files that are retrieved from iCloud  or other cloud storage providers. You're likely to run into these file types when using system components that provide access to files stored in iCloud, e.g. [UIDocumentBrowserViewController](https://developer.apple.com/documentation/uikit/uidocumentbrowserviewcontroller).

To upload security scoped resources, you'll need to:
1. use [startAccessingSecurityScopedResource()](https://developer.apple.com/documentation/foundation/url/1779698-startaccessingsecurityscopedreso) and [stopAccessingSecurityScopedResource()](https://developer.apple.com/documentation/foundation/url/1780153-stopaccessingsecurityscopedresou) to access the data within security scoped files
2. temporarily persist the data from the security scoped files in your app's sandbox
3. upload files using the temporary URLs
4. delete temporarily persisted files (optional)
```swift
struct ScopedResourceFile 

func getTempUrls(securityScopedUrls: [URL]) -> [URL] 
        defer 
        do  catch 
    }

    // 2. write the file contents to temporary files and return the URLs of the temp files
    let localFileURLs = persistTemporaryFiles(fileContents)

    // 3. Now you have local URLs for the files you'd like to upload.
    return localFileURLs
}
```

</InlineFilter>

### Transfer with Object Metadata

Custom metadata can be associated with your uploaded object by passing the metadata option.

```ts

const result = await uploadData(,
  },
});
```

### More upload options

The behavior of `uploadData` and properties of the uploaded object can be customized by passing in additional options.

```ts

const result = await uploadData(,
});
```
Option | Type | Default | Description |
| -- | :--: | :--: | ----------- |
| bucket | string \| <br />\ | Default bucket and region from Amplify configuration | A string representing the target bucket's assigned name in Amplify Backend or an object specifying the bucket name and region from the console.<br/><br/> Read more at [Configure additional storage buckets](/[platform]/build-a-backend/storage/set-up-storage/#configure-additional-storage-buckets) |
| contentType | string | application/octet-stream | The default content-type header value of the file when downloading it. <br/><br/> Read more at [Content-Type documentation](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Type) |
| contentEncoding | string | — | The default content-encoding header value of the file when downloading it.<br/><br/> Read more at [Content-Encoding documentation](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Encoding) |
| contentDisposition | string | — | Specifies presentational information for the object. <br/><br/> Read more at [Content-Disposition documentation](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Disposition) |
| metadata | map\<string\> | — | A map of metadata to store with the object in S3. <br/><br/> Read more at [S3 metadata documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/UsingMetadata.html#UserMetadata) |
| useAccelerateEndpoint | boolean | false | Whether to use accelerate endpoint. <br/><br/> Read more at [Transfer Acceleration](/[platform]/build-a-backend/storage/upload-files/#transfer-acceleration) |
| expectedBucketOwner | string | - | The account ID that owns requested bucket. |
| preventOverwrite | boolean | false | Whether to check if an object with the same key already exists before completing the upload. If exists, a `Precondition Failed` error will be thrown |
| checksumAlgorithm | "crc-32" | - | Whether to compute the checksum for the data to be uploaded, so the S3 can verify the data integrity. Only 'crc-32' is supported currently |

> **Note**: 

Uploads that were initiated over one hour ago will be cancelled automatically. There are instances (e.g. device went offline, user logs out) where the incomplete file remains in your Amazon S3 account. It is recommended to [setup a S3 lifecycle rule](https://aws.amazon.com/blogs/aws-cloud-financial-management/discovering-and-deleting-incomplete-multipart-uploads-to-lower-amazon-s3-costs/) to automatically cleanup incomplete upload requests.

</InlineFilter>

## MultiPart upload

Amplify will automatically perform an Amazon S3 multipart upload for objects that are larger than 5MB. For more information about S3's multipart upload, see [Uploading and copying objects using multipart upload](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html)


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `pages/build-a-backend/storage/upload-files/index.mdx`