---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/android/device_features/20_forgetDevice.mdx
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
Amplify.Auth.forgetDevice(
    () -> Log.i("AuthQuickStart", "Forget device succeeded"),
    error -> Log.e("AuthQuickStart", "Forget device failed with error " + error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.forgetDevice(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.forgetDevice()
    .subscribe(
      () -> Log.i("AuthQuickStart", "Forget device succeeded"),
      error -> Log.e("AuthQuickStart", "Forget device failed with error " + error.toString())
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/android/device_features/20_forgetDevice.mdx`