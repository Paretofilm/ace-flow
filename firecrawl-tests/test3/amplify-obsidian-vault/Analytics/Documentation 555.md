---
title: Documentation
topics: ['Analytics', 'Getting Started']
primary_topic: Analytics
source: fragments/lib-v1/analytics/flutter/getting-started/30_initAnalytics.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics, getting-started]
---


## 🧭 Navigation
**Topics**: [[Analytics/]] • [[Getting Started/]]
**Primary**: [[Analytics/]]

---


# Documentation

Add the Auth and Analytics plugin, along with any other plugins you may have added as described in the **Project Setup** section;

```dart
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';

Future<void> _configureAmplify() async 
```

> **Note**: 

When running your app on macOS you will need to enable keychain sharing in Xcode, as described in the [Project setup guide](/gen1/[platform]/prev/start/project-setup/platform-setup/#enable-keychain).

Make sure that the `amplifyconfiguration.dart` file generated in the project setup is included and sent to `Amplify.configure`:

```dart
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';

Future<void> _configureAmplify() async  on AmplifyAlreadyConfiguredException 
}
```

Your class will look like this:

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';

Future<void> _configureAmplify() async  on AmplifyAlreadyConfiguredException 
}

Future<void> main() async 

class MyApp extends StatefulWidget ): super(key: key);
  
  // ...
}
```


---

## 📚 Related Topics
- [[Analytics/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/analytics/flutter/getting-started/30_initAnalytics.mdx`