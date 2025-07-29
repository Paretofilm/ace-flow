---
title: Documentation
source: fragments/lib/auth/android/user_attributes/10_fetch_attributes.mdx
---

# Documentation

```java
Amplify.Auth.fetchUserAttributes(
    attributes -> Log.i("AuthDemo", "User attributes = " + attributes.toString()),
    error -> Log.e("AuthDemo", "Failed to fetch user attributes.", error)
);
```

</Block>

```kotlin
Amplify.Auth.fetchUserAttributes(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.fetchUserAttributes()
    .doOnSubscribe(() -> Log.i("AuthDemo", "Attributes:"))
    .flatMapObservable(Observable::fromIterable)
    .subscribe(
        eachAttribute -> Log.i("AuthDemo", eachAttribute.toString()),
        error -> Log.e("AuthDemo", "Failed to fetch attributes.", error)
    );
```

</Block>
</BlockSwitcher>
