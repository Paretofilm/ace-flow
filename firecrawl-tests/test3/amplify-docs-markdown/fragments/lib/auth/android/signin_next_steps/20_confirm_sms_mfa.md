---
title: Documentation
source: fragments/lib/auth/android/signin_next_steps/20_confirm_sms_mfa.mdx
---

# Documentation

If the next step is `CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE`, Amplify Auth has sent the user a random code over SMS, and is waiting to find out if the user successfully received it. To handle this step, your app's UI must prompt the user to enter the code. After the user enters the code, your implementation must pass the value to Amplify Auth `confirmSignIn` API.

Note: the signIn result also includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery such as the partial phone number of the SMS recipient.

```java
try  else 
            },
            error -> Log.e("AuthQuickstart", "Confirm sign in failed: " + error)
    );
} catch (Exception error) 
```
</Block>

```kotlin
try  else ")
                  // Switch on the next step to take appropriate actions.
                  // If `signInResult.isSignedIn` is true, the next step
                  // is 'done', and the user is now signed in.
              }
          }
    ) 
} catch (error: Exception) 
```
</Block>

```kotlin
try  else "
        )
        // Switch on the next step to take appropriate actions.
        // If `signInResult.isSignedIn` is true, the next step
        // is 'done', and the user is now signed in.
    }
} catch (error: Exception) 
```
</Block>

```java

RxAmplify.Auth.confirmSignIn(
                "confirmation code").subscribe(
                result ->  else 
                },
                error -> Log.e("AuthQuickstart", "Confirm sign in failed: " + error)
        );
```
</Block>

</BlockSwitcher>
