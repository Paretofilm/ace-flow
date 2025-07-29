---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/android/user_attributes/20_update_user_attribute.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

To update a single user attribute, call `updateUserAttribute`:

```java
AuthUserAttribute userEmail =
    new AuthUserAttribute(AuthUserAttributeKey.email(), "email@email.com");
Amplify.Auth.updateUserAttribute(userEmail,
    result -> Log.i("AuthDemo", "Updated user attribute = " + result.toString()),
    error -> Log.e("AuthDemo", "Failed to update user attribute.", error)
);
```

</Block>

```kotlin
Amplify.Auth.updateUserAttribute(
    AuthUserAttribute(AuthUserAttributeKey.email(), "email@email.com"),
    ,
    
)
```

</Block>

```kotlin
val attribute =
    AuthUserAttribute(AuthUserAttributeKey.email(), "email@email.com")
try  catch (error: AuthException) 
```

</Block>

```java
AuthUserAttribute userEmail =
    new AuthUserAttribute(AuthUserAttributeKey.email(), "email@email.com");
RxAmplify.Auth.updateUserAttribute(userEmail)
    .subscribe(
        result -> Log.i("AuthDemo", "Updated user attribute = " + result.toString()),
        error -> Log.e("AuthDemo", "Failed to update user attribute.", error)
    );
```

</Block>
</BlockSwitcher>

To update multiple user attributes at a time, call `updateUserAttributes`:

```java
Amplify.Auth.updateUserAttributes(
    attributes, // attributes is a list of AuthUserAttribute
    result -> Log.i("AuthDemo", "Updated user attributes = " + result.toString()),
    error -> Log.e("AuthDemo", "Failed to update user attributes.", error)
);
```

</Block>

```kotlin
Amplify.Auth.updateUserAttributes(
    attributes, // attributes is a list of AuthUserAttribute
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
// attributes is a list of AuthUserAttribute
RxAmplify.Auth.updateUserAttributes(attributes)
    .subscribe(
        result -> Log.i("AuthDemo", "Updated user attributes = " + result.toString()),
        error -> Log.e("AuthDemo", "Failed to update user attributes.", error)
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/android/user_attributes/20_update_user_attribute.mdx`