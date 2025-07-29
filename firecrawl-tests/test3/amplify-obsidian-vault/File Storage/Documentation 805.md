---
title: Documentation
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib/storage/flutter/list.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Documentation

You can list all files uploaded under a given path.

This will list all files located under path `album` that:
* have `private` access level
* are in the root of `album/` (the result doesn't include files under any sub path)

`excludeSubPaths` can be used to exclude nested paths. `/` is used by as the delimiter for nested paths. This can be customized with the `delimiter` option. 

```dart
Future<void> listAlbum() async ');
      nextToken = result.nextToken;
      hasNextPage = result.hasNextPage;
    } while (hasNextPage);
  } on StorageException catch (e) 
}
```

Pagination is enabled by default. The default `pageSize` is `1000` if it is not set in the `StorageListOptions`.

You can also list all files under a given path without pagination by using the `pluginOptions` and `S3ListPluginOptions.listAll()` constructor.

This will list all public files (i.e. those with `guest` access level):

```dart
Future<void> listAll() async ');
  } on StorageException catch (e) 
}
```


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib/storage/flutter/list.mdx`