---
title: Upload File
source: fragments/lib/storage/flutter/upload.mdx
---

# Upload File

## Upload File

To upload to S3 from a file, specify the `path` to upload the file to and the `localFile` to be uploaded. `localFile` can be an instance of `AWSFile` created from either an OS platform `File` instance or the result of Flutter file picker plugins such as [file_picker](https://pub.dev/packages/file_picker).

### Upload platform `File`

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

### Upload with Flutter file_picker plugin

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

## Upload Data

To upload to S3 from a data object, specify the `path` to upload the file to and the `data` to upload. `data` should be an instance of `StorageDataPayload` created from various data formats.

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

`StorageDataPayload.dataUrl()` parses the provided data URL string, and throws exception if the data URL is invalid. See more info about [data URL](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URLs).

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

## Upload Progress

To track progress of the upload, use the progress listener callback.

```dart
final operation = Amplify.Storage.uploadFile(
  localFile: AWSFile.fromPath('/path/to/local/file.txt'),
  path: const StoragePath.fromString('public/example.txt'),
  onProgress: (progress) ');
    safePrint('fraction transferredBytes: $');
    safePrint('fraction completed: $');
  }
);
```

</Block>

```dart
final operation = Amplify.Storage.uploadData(
  data: StorageDataPayload.string('hello world'),
  path: const StoragePath.fromString('public/example.txt'),
  onProgress: (progress) ');
    safePrint('fraction transferredBytes: $');
    safePrint('fraction completed: $');
  },
);
```

</Block>

</BlockSwitcher>

## Upload Options

You can attach metadata while uploading data or a file by specifying the `metadata` property in options. If you want the `metadata` to be included in the upload result, you can set the `getProperties` flag to `true` in options.

```dart
final result = await Amplify.Storage.uploadFile(
  localFile: AWSFile.fromPath('/path/to/local/file.txt'),
  path: const StoragePath.fromString('public/example.txt'),
  options: const StorageUploadFileOptions(
    metadata: ,
    pluginOptions: S3UploadFilePluginOptions(
      getProperties: true,
    ),
  ),
).result
safePrint('metadata: $');
```

</Block>

```dart
final result = await Amplify.Storage.uploadData(
  data: StorageDataPayload.string('example'),
  path: const StoragePath.fromString('public/example.txt'),
  options: const StorageUploadDataOptions(
    metadata: ,
    pluginOptions: S3UploadDataPluginOptions(
      getProperties: true,
    ),
  ),
).result;
safePrint('metadata: $');
```

</Block>

</BlockSwitcher>

The [`Amplify.Storage.getProperties` API](/gen1/[platform]/build-a-backend/storage/get-properties/) allows you to retrieve metadata without downloading the file.

In S3 console, you should see the metadata attached to your file as the following.

![Screenshot of the metadata properties in S3 console, defined from above, showing two rows of data. The first row is a system defined key value pair where the key is Content-Type with the value is text/plain. The second row is user defined key value pair where the key is x-amz-meta-project and the value is ExampleProject](/images/s3_metadata.png)

## Control of Upload Operations

A call to `Amplify.Storage.uploadFile` or `Amplify.Storage.uploadData` returns a reference to the operation that is performing the upload.

To cancel the upload (for example, in response to the user pressing a Cancel button), simply call `.cancel()` on the returned upload operation.

`Amplify.Storage.uploadFile` also allows for the operation to be paused and resumed.

```dart
Future<void> upload() async 
```

</Block>

```dart
Future<void> upload() async 
```

</Block>

</BlockSwitcher>

## Multipart Upload

Amplify will automatically perform a S3 multipart upload for files larger than 5MB. For more information about S3's multipart upload support, see [Uploading and copying objects using multipart upload](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html).
