---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/device_features/10_rememberDevice.mdx
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
Amplify.Auth.rememberDevice(
    () -> Log.i("AuthQuickStart", "Remember device succeeded"),
    error -> Log.e("AuthQuickStart", "Remember device failed with error " + error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.rememberDevice(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.rememberDevice()
    .subscribe(
      () -> Log.i("AuthQuickStart", "Remember device succeeded"),
      error -> Log.e("AuthQuickStart", "Remember device failed with error " + error.toString())
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/device_features/10_rememberDevice.mdx`