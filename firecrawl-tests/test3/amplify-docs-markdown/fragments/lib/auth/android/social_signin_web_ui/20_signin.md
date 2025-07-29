---
title: Documentation
source: fragments/lib/auth/android/social_signin_web_ui/20_signin.mdx
---

# Documentation

For now, just add this method to the `onCreate` method of MainActivity with whatever provider you're using (shown with Facebook below):

```java
// Replace facebook with your chosen auth provider such as google, amazon, or apple
Amplify.Auth.signInWithSocialWebUI(
    AuthProvider.facebook(),
    this,
    result -> Log.i("AuthQuickstart", result.toString()),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
// Replace facebook with your chosen auth provider such as google, amazon, or apple
Amplify.Auth.signInWithSocialWebUI(
    AuthProvider.facebook(),
    this,
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
// Replace facebook with your chosen auth provider such as google, amazon, or apple
RxAmplify.Auth.signInWithSocialWebUI(AuthProvider.facebook(), this)
    .subscribe(
        result -> Log.i("AuthQuickstart", result.toString()),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>
