---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/android/signout/10_local_signout.mdx
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
Amplify.Auth.signOut(
    () -> Log.i("AuthQuickstart", "Signed out successfully"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.signOut(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.signOut()
    .subscribe(
        () -> Log.i("AuthQuickstart", "Signed out successfully"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/android/signout/10_local_signout.mdx`