---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/logging/android/configure_user/auth_current_user.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

```java
Amplify.Auth.getCurrentUser(
   user.userId,
   error -> // failed to fetch user
);
```
</Block>

```kotlin
Amplify.Auth.getCurrentUser()
```

</Block>

```java
RxAmplify.Auth.getCurrentUser().subscribe(
        result -> result.userId,
        error -> // failed to get user
 );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/logging/android/configure_user/auth_current_user.mdx`