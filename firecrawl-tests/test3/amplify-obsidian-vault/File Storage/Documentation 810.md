---
title: Documentation
topics: ['File Storage', 'Getting Started']
primary_topic: File Storage
source: fragments/lib/storage/flutter/getting-started/30_initStorage.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage, getting-started]
---


## 🧭 Navigation
**Topics**: [[File Storage/]] • [[Getting Started/]]
**Primary**: [[File Storage/]]

---


# Documentation

To initialize the Amplify Auth and Storage categories, call `Amplify.addPlugin()` for each plugin or pass all the plugins in `Amplify.addPlugins()`. To complete initialization, call `Amplify.configure()`.

Your code should look like this:

```dart
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';

Future<void> _configureAmplify() async  on Exception catch (e) 
}

Future<void> main() async 

class MyApp extends StatefulWidget ) : super(key: key);

  // ...
}
```


---

## 📚 Related Topics
- [[File Storage/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/storage/flutter/getting-started/30_initStorage.mdx`