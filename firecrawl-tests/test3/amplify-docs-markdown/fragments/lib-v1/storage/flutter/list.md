---
title: Documentation
source: fragments/lib-v1/storage/flutter/list.mdx
---

# Documentation

You can list all files uploaded under a given path.

This will list all files located under path `album` that:
* have `private` access level
* are in the root of `album/` (the result doesn't include files under any sub path)

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

Future<void> listAlbum() async ');
      nextToken = result.nextToken;
      hasNextPage = result.hasNextPage;
    } while (hasNextPage);
  } on StorageException catch (e) ');
    rethrow;
  }
}
```

Pagination is enabled by default. The default `pageSize` is `1000` if it is not set in the `StorageListOptions`.

You can also list all files under a given path without pagination by using the `pluginOptions` and `S3ListPluginOptions.listAll()` constructor.

This will list all public files (i.e. those with `guest` access level):

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

Future<void> listAllWithGuestAccessLevel() async ');
  } on StorageException catch (e) ');
    rethrow;
  }
}
```
