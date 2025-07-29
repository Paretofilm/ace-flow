---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/android/signin_web_ui/30_signin.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

Sweet! You're now ready to launch sign in with web UI. For now, just add this method to the `onCreate` method of MainActivity:

```java
Amplify.Auth.signInWithWebUI(
    this,
    result -> Log.i("AuthQuickStart", result.toString()),
    error -> Log.e("AuthQuickStart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.signInWithWebUI(this,
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.signInWithWebUI(this)
    .subscribe(
        result -> Log.i("AuthQuickStart", result.toString()),
        error -> Log.e("AuthQuickStart", error.toString())
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/android/signin_web_ui/30_signin.mdx`