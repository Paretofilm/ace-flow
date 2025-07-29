---
title: Prefer private session during signIn on iOS.
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/flutter/signin_web_ui/40_private_session.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Prefer private session during signIn on iOS.

### Prefer private session during signIn on iOS.

Amplify.Auth.signInWithWebUI uses [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession) internally for iOS. ASWebAuthenticationSession has a property, [prefersEphemeralWebBrowserSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/3237231-prefersephemeralwebbrowsersessio) which can be used to indicate whether the session should ask the browser for a private authentication session. To set this flag to true, set `preferPrivateSession` to true using `CognitoSignInWithWebUIPluginOptions`.

This will bypass the permissions dialog that is displayed to the end user during sign in and sign out. However, it will also prevent reuse of existing sessions from the user's browser. For example, if the user is logged into Google in their browser and try to sign in using Google in your app, they would now need to re-enter their credentials.

```dart
Future<void> signInWithWebUIAndPrivateSession() async 
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/flutter/signin_web_ui/40_private_session.mdx`