---
title: Documentation
topics: ['Authentication', 'Getting Started']
primary_topic: Authentication
source: fragments/lib/auth/flutter/getting_started/50_fetchSession.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication, getting-started]
---


## 🧭 Navigation
**Topics**: [[Authentication/]] • [[Getting Started/]]
**Primary**: [[Authentication/]]

---


# Documentation

After implementing Authentication in your app, you can check if a user is logged in. `CognitoAuthSession` will have the `isSignedIn` property set to `false` if the user has not signed in to your app. You can see how it works by using the below function:

```dart
Future<bool> isUserSignedIn() async 
```

In case you want to get the current user information, you can use the code below:

```dart
Future getCurrentUser() async 
```

`AuthUser` will have the `userId` and `username` will have the user details if they were logged in.


---

## 📚 Related Topics
- [[Authentication/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/auth/flutter/getting_started/50_fetchSession.mdx`