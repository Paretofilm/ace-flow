---
title: Documentation
source: fragments/lib-v1/auth/android/social_signin_web_ui/20_signin.mdx
---

# Documentation

For now, just add this method to the `onCreate` method of MainActivity with whatever provider you're using (shown with Facebook below):

```java
Amplify.Auth.signInWithSocialWebUI(AuthProvider.facebook(), this,
    result -> Log.i("AuthQuickstart", result.toString()),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.signInWithSocialWebUI(AuthProvider.facebook(), this,
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.signInWithSocialWebUI(AuthProvider.facebook(), this)
    .subscribe(
        result -> Log.i("AuthQuickstart", result.toString()),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>
