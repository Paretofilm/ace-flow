---
title: Documentation
source: fragments/lib-v1/datastore/flutter/getting-started/60_initDataStore.mdx
---

# Documentation

To initialize the Amplify DataStore, use the `Amplify.addPlugin()` method to add the AWS DataStore Plugin. You also need to import the codegen dart file `ModelProvider.dart`. After that, finish configuring Amplify by calling `configure()`:

```dart
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_datastore/amplify_datastore.dart';

import 'amplifyconfiguration.dart';
import 'models/ModelProvider.dart';

class MyApp extends StatefulWidget ) : super(key: key);

  @override
  State createState() => _MyAppState();
}

class _MyAppState extends State 

  Future<void> _configureAmplify() async  on AmplifyAlreadyConfiguredException 
  }

  @override
  Widget build(BuildContext context) 
}
```
