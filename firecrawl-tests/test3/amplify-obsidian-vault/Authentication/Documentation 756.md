---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/signin_next_steps/50_reset_password.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

If you receive `PasswordResetRequiredException`, authentication flow could not proceed without resetting the password. The next step is to invoke `resetPassword` api and follow the reset password flow.

```java
try  catch (Exception error) 
```
</Block>

```kotlin
try 
      ) 
} catch (error: Exception) 
```
</Block>

```kotlin
try  catch (error: Exception) 
```
</Block>

```java
RxAmplify.Auth.resetPassword(
        "username").subscribe(
        result -> Log.i("AuthQuickstart", "Reset password succeeded"),
        error -> Log.e("AuthQuickstart", "Reset password failed : " + error)
);
```
</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/signin_next_steps/50_reset_password.mdx`