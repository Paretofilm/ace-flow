---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib-v1/project-setup/flutter/create-application/40_verifyAmplifyLibraries.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

Before using any methods in the Amplify Flutter Library, it's important to add all necessary plugins and to call configure once in your app.  The steps below will guide you through configuring Amplify Flutter at the root level of your flutter app.

Add the necessary dart dependencies at the top of main.dart alongside to other imports:

```dart
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

// Generated in previous step
import 'amplifyconfiguration.dart';
```

Add the following code to your application's root Stateful Widget, for the default Flutter app this should be the `class _MyHomePageState extends State`.

```dart

class _MyHomePageState extends State 

  Future<void> _configureAmplify() async  on AmplifyAlreadyConfiguredException 
  }

  // customize the rest of your Widget below as you wish...

```

Note that all calls to `addPlugin()` or `addPlugins()` are made before `Amplify.configure()` is called.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/project-setup/flutter/create-application/40_verifyAmplifyLibraries.mdx`