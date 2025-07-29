---
title: Documentation
topics: ['Authentication', 'Getting Started']
primary_topic: Authentication
source: fragments/lib/auth/flutter/getting_started/30_initAuth.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication, getting-started]
---


## 🧭 Navigation
**Topics**: [[Authentication/]] • [[Getting Started/]]
**Primary**: [[Authentication/]]

---


# Documentation

Add the Auth plugin, along with any other plugins you may have added as described in the **Prerequisites** section. To complete initialization call `Amplify.configure()`.

Your code should look like this:

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';

void main() 

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
- [[Authentication/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/auth/flutter/getting_started/30_initAuth.mdx`