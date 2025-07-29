---
title: Download File
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib/storage/flutter/download.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Download File

There are three ways of getting data that was previously uploaded:

## Download File

You can download file to a local directory using `Amplify.Storage.downloadFile`.

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

## Download data

You can download a file to in-memory buffer with `Amplify.Storage.downloadData`:

```dart
Future<void> download() async ');
  } on StorageException catch (e) 
}
```

## Download Progress

To track progress of the download, use the progress listener callback.

```dart
final operation = Amplify.Storage.downloadFile(
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
final operation = Amplify.Storage.downloadData(
  path: const StoragePath.fromString('public/example.txt'),
  onProgress: (progress) ');
    safePrint('fraction transferredBytes: $');
    safePrint('fraction completed: $');
  },
);
```

</Block>

</BlockSwitcher>

## Control of Download Operations

A call to `Amplify.Storage.downloadFile` or `Amplify.Storage.downloadData` returns a reference to the operation that is performing the upload.

To cancel the upload (for example, in response to the user pressing a Cancel button), simply call `.cancel()` on the returned upload operation. Download operations also allows for the operation to be paused and resumed.

```dart
Future<void> download() async 
```

</Block>

```dart
Future<void> download() async 
```

</Block>

</BlockSwitcher>

## Generate a download URL

You can get a downloadable URL for the file in storage by its path.

When creating a downloadable URL, you can choose to check if the file exists by setting `validateObjectExistence` to
`true` in `S3GetUrlPluginOptions`. If the file is inaccessible or does not exist, a `StorageException` is thrown.
This allows you to check if an object exists during generating the presigned URL, which you can then use to download
that object.

```dart
Future<void> getDownloadUrl() async ');
  } on StorageException catch (e) 
}
```


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib/storage/flutter/download.mdx`