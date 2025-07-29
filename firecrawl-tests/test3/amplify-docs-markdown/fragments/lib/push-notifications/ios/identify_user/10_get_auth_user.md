---
title: Documentation
source: fragments/lib/push-notifications/ios/identify_user/10_get_auth_user.mdx
---

# Documentation

If the user is signed in through [Amplify.Auth.signIn](/gen1/[platform]/build-a-backend/auth/enable-sign-in/), then you can retrieve the current user's ID as shown below:

```swift
let user = try await Amplify.Auth.getCurrentUser().userId
```
