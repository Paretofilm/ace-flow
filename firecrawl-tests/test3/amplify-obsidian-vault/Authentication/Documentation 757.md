---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/signin_next_steps/40_confirm_new_password.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

If you receive a `UserNotConfirmedException` while signing in, Amplify Auth requires a new password for the user before they can proceed. Prompt the user for a new password and pass it to the `confirmSignIn` API.

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
              }
          }
      ) 
} catch (error: Exception) 
}
```

</Block>

```kotlin
try  else ")
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


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/signin_next_steps/40_confirm_new_password.mdx`