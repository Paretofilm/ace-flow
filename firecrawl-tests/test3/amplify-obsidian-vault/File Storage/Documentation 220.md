---
title: Documentation
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/flutter/upload/upload-create-file.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Documentation

```dart
import 'dart:io' as io;

import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_common/vm.dart';

Future<void> uploadIOFile(io.File file) async ');
  } on StorageException catch (e) ');
    rethrow;
  }
}
```
</Block>

```dart
import 'dart:html' as html;

import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:aws_common/web.dart';

Future<void> uploadHtmlFile(html.File file) async ');
  } on StorageException catch (e) ');
    rethrow;
  }
}
```
</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/flutter/upload/upload-create-file.mdx`