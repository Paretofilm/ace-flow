---
title: Download File
source: fragments/lib-v1/storage/flutter/download.mdx
---

# Download File

There are two ways of getting data that was previously uploaded:

## Download File

You can download file to a local directory using `Amplify.Storage.downloadFile`.

You can use the [path_provider](https://pub.dev/packages/path_provider) package to create a local file in the user's documents directory where you can store the downloaded data.

```dart
import 'package:path_provider/path_provider.dart';

Future<void> downloadToLocalFile(String key) async ');
      },
    ).result;

    safePrint('Downloaded file is located at: $');
  } on StorageException catch (e) 
}
```

</Block>

On Web, the download process will be handled by the browser. You can provide the downloaded file name by specifying the `path` parameter of `AWSFile.fromPath`. E.g. this instructs the browser to download the file `download.txt`.

```dart
Future<void> downloadToLocalFileOnWeb(String key) async ');
  } on StorageException catch (e) 
}
```

</Block>

</BlockSwitcher>

## Download data

You can download a file to in-memory buffer with `Amplify.Storage.downloadData`:

```dart
Future<void> downloadToMemory(String key) async ');
      },
    ).result;

    safePrint('Downloaded data: $');
  } on StorageException catch (e) 
}
```

## Generate a download URL

You can get a downloadable URL for the file in storage by its key and access level.

When creating a downloadable URL, you can choose to check if the file exists by setting `validateObjectExistence` to `true` in `S3GetUrlPluginOptions`. If the file is inaccessible or does not exist, a `StorageException` is thrown. This allows you to check if an object exists during generating the presigned URL, which you can then use to download that object.

```dart
Future getDownloadUrl() async  on StorageException catch (e) ');
    rethrow;
  }
}
```
