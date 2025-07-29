---
title: Documentation
source: fragments/lib/auth/android/signin_next_steps/60_confirm_signup.mdx
---

# Documentation

If you receive `CONFIRM_SIGN_UP` as a next step, sign up could not proceed without confirming user information such as email or phone number. The next step is to invoke the `confirmSignUp` API and follow the confirm signup flow.

```java
 try  catch (Exception error) 
```
</Block>

```kotlin
 try ")
          }
      ) 
} catch (error: Exception) 
```
</Block>

```kotlin
try ")
} catch (error: Exception) 
```
</Block>

```java
RxAmplify.Auth.confirmSignUp(
        "username",
        "confirmation code").subscribe(
        result -> Log.i("AuthQuickstart", "Confirm signUp result completed: " + result.isSignUpComplete()),
        error -> Log.e("AuthQuickstart", "An error occurred while confirming sign up: " + error)
);
```
</Block>

</BlockSwitcher>
