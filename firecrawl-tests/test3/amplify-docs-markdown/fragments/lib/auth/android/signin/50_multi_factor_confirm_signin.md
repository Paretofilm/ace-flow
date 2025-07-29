---
title: Documentation
source: fragments/lib/auth/android/signin/50_multi_factor_confirm_signin.mdx
---

# Documentation

```java
Amplify.Auth.confirmSignIn(
    "confirmation code received via SMS",
    result -> Log.i("AuthQuickstart", result.toString()),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.confirmSignIn("code received via SMS",
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.confirmSignIn("confirmation code received via SMS")
    .subscribe(
        result -> Log.i("AuthQuickstart", result.toString()),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>
