---
title: Documentation
source: fragments/lib-v1/auth/android/getting_started/40_fetchSession.mdx
---

# Documentation

For testing purposes, you can run this from your MainActivity's `onCreate` method.

```java
Amplify.Auth.fetchAuthSession(
    result -> Log.i("AmplifyQuickstart", result.toString()),
    error -> Log.e("AmplifyQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.fetchAuthSession(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

 ```java
RxAmplify.Auth.fetchAuthSession()
    .subscribe(
        result -> Log.i("AmplifyQuickstart", result.toString()),
        error -> Log.e("AmplifyQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>
