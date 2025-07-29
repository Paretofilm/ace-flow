---
title: Set up your application
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/start/getting-started/flutter/setup.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Set up your application

## Set up your application

### Create a new Flutter application

Create a new project using Flutter CLI:

```bash
flutter create budget_tracker
```

### Add Amplify to your application

Amplify Flutter is distributed via [pub.dev](https://pub.dev/packages/amplify_flutter).

1. From your project root directory, find and modify your `pubspec.yaml` and add the Amplify plugins to the project dependencies.

    ```yaml
    dependencies:
      amplify_api: ^2.0.0
      amplify_auth_cognito: ^2.0.0
      amplify_authenticator: ^2.0.0
      amplify_flutter: ^2.0.0
      flutter:
        sdk: flutter
      go_router: ^6.5.5
    ```

2. Install the dependencies by running the following command. Depending on your development environment, you may perform this step via your IDE (or it may even be performed for you automatically).

    ```bash
    flutter pub get
    ```

### Platform Setup

Depending on the platform you're building for, some extra set up may be required. 

</Block>

</Block>

</Block>

</Block>

</Block>

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/start/getting-started/flutter/setup.mdx`