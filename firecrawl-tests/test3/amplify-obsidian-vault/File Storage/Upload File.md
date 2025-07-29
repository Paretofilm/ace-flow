---
title: Upload File
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/flutter/upload.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Upload File

## Upload File

To upload to S3 from a file, specify the `key` to upload the file to and the `localFile` to be uploaded. `localFile` can be an instance of `AWSFile` created from either an OS platform `File` instance or the result of Flutter file picker plugins such as [file_picker](https://pub.dev/packages/file_picker).

### Upload platform `File`

> **Note**: 

**Note**: To use `AWSFilePlatform`, add [aws_common](https://pub.dev/packages/aws_common) package to your Flutter project
by running: `flutter pub add aws_common`

### Upload with Flutter file_picker plugin

The [file picker](https://pub.dev/packages/file_picker) plugin can be used to retrieve arbitrary file types from the user's device.

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:file_picker/file_picker.dart';

Future<void> uploadImage() async 

  // Upload file with its filename as the key
  final platformFile = result.files.single;
  try ');
      },
    ).result;
    safePrint('Successfully uploaded file: $');
  } on StorageException catch (e) 
}
```

## Upload Data 

To upload to S3 from a data object, specify the `key` and `data`, where `data` is an instance of `S3DataPayload` created from various data formats.

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

Future<void> uploadStringData() async ');
  } on StorageException catch (e) ');
    rethrow;
  }
}
```
</Block>

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

Future<void> uploadJsonObject() async ');
  } on StorageException catch (e) ');
    rethrow;
  }
}
```
</Block>

`S3DataPayload.dataUrl()` parses the provided data URL string, and throws exception if the data URL is invalid. See more info about [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URLs).

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

Future<void> uploadDataUrl() async ');
  } on StorageException catch (e) ');
    rethrow;
  }
}
```
</Block>

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

Future<void> uploadBytes() async ');
  } on StorageException catch (e) ');
    rethrow;
  }
}
```
</Block>

</BlockSwitcher>

## Upload Options

You can attach metadata while uploading data or a file by specifying the `metadata` property in options. If you want the `metadata` to be included in the upload result, you can set the `getProperties` flag to `true` in options.

```dart
Future<void> uploadWithOptions() async ,
      pluginOptions: S3UploadDataPluginOptions(
        getProperties: true,
      ),
    ),
  );
  final uploadDataResult = await uploadDataOperation.result;
  safePrint(
    'Uploaded data with metadata: $',
  );

  // When uploading a file, use `StorageUploadFileOptions`
  final uploadFileOperation = Amplify.Storage.uploadFile(
    localFile: AWSFile.fromPath('path/to/example.txt'),
    key: 'example.txt',
    options: const StorageUploadFileOptions(
      metadata: ,
      pluginOptions: S3UploadFilePluginOptions(
        getProperties: true,
      ),
    ),
  );
  final uploadFileResult = await uploadFileOperation.result;
  safePrint(
    'Uploaded file with metadata: $',
  );
}
```

The [`Amplify.Storage.getProperties` API](/gen1/[platform]/build-a-backend/storage/get-properties/) allows you to retrieve metadata without downloading the file.

In S3 console, you should see the metadata attached to your file as the following.

![S3 Metadata](/images/s3_metadata.png)

## Control of Upload Operations

A call to `Amplify.Storage.uploadFile` or `Amplify.Storage.uploadData` returns a reference to the operation that is performing the upload.

To cancel the upload (for example, in response to the user pressing a Cancel button), simply call `.cancel()` on the returned upload operation.

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

S3UploadFileOperation? uploadOperation;

Future<void> uploadFile(String path) async ');
  } on StorageException catch (e) ');
  }
}

void cancelUpload() 
```

## Multipart upload

Amplify will automatically perform a S3 multipart upload for files larger than 5MB. For more information about S3's multipart upload support, see [Uploading and copying objects using multipart upload](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html).


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/flutter/upload.mdx`