---
title: Documentation
source: fragments/lib-v1/auth/android/device_features/20_forgetDevice.mdx
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
