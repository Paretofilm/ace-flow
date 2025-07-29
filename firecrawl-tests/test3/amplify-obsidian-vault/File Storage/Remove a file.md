---
title: Remove a file
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/flutter/remove.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Remove a file

## Remove a file

You can remove a single file using `Amplify.Storage.remove` with the `key` and its associated access level:

```dart
import 'package:amplify_flutter/amplify_flutter.dart';

Future<void> removeFile() async ');
  } on StorageException catch (e) ');
    rethrow;
  }
}
```

## Remove multiple files

You can remove multiple files using `Amplify.Storage.removeMany` with the `keys`, the files to be removed in a batch should have the same access level:

```dart
import 'package:amplify_flutter/amplify_flutter.dart';

Future<void> removePrivateFiles() async ');
  } on StorageException catch (e) ');
    rethrow;
  }
}
```


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/flutter/remove.mdx`