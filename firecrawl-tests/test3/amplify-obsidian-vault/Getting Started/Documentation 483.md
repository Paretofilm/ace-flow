---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib-v1/graphqlapi/flutter/getting-started/30_initapi.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Documentation

To initialize the Amplify API category you call `Amplify.addPlugin()` method. To complete initialization call `Amplify.configure()`.

Your code should look like this:

```dart
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';

class MyApp extends StatefulWidget );

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State 

  Future<void> _configureAmplify() async  on Exception catch (e) 
  }

  @override
  Widget build(BuildContext context) 
}
```


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/flutter/getting-started/30_initapi.mdx`