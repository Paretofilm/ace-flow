---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib/restapi/flutter/getting-started/30_initapi.mdx
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
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';

void main() 

class MyApp extends StatefulWidget 

class _MyAppState extends State 

  Future<void> _configureAmplify() async  on AmplifyAlreadyConfiguredException 
  }

  Future<void> onTestApi() async 

  @override
  Widget build(BuildContext context) 
}
```


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/restapi/flutter/getting-started/30_initapi.mdx`