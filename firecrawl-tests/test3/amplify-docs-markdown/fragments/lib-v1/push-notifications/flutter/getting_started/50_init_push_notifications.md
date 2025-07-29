---
title: Documentation
source: fragments/lib-v1/push-notifications/flutter/getting_started/50_init_push_notifications.mdx
---

# Documentation

To initialize Amplify Push Notifications, you will need to configure Amplify add the Auth and Push Notifications plugins. To complete initialization, call `Amplify.configure`

Your resulting code should look something like the following:

```dart
// Example main.dart

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_push_notifications_pinpoint/amplify_push_notifications_pinpoint.dart';

import 'amplifyconfiguration.dart';

void main() 

class MyApp extends StatefulWidget ) : super(key: key);

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
