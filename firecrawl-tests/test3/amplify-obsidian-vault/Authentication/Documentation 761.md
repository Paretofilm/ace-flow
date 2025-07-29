---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/signin_next_steps/30_confirm_custom_challenge.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

If the next step is `CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE`, Amplify Auth is awaiting completion of a custom authentication challenge. The challenge is based on the Lambda trigger you setup when you configured a [custom sign in flow](/gen1/[platform]/build-a-backend/auth/sign-in-custom-flow/). To complete this step, you should prompt the user for the custom challenge answer, and pass the answer to the `confirmSignIn` API.

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
try  else ")
        // Switch on the next step to take appropriate actions.
        // If `signInResult.isSignedIn` is true, the next step
        // is 'done', and the user is now signed in.
    }
} catch (error: Exception) 
```

</Block>

```java

RxAmplify.Auth.confirmSignIn(
                "challenge answer").subscribe(
                result ->  else 
                },
                error -> Log.e("AuthQuickstart", "Confirm sign in failed: " + error)
        );
```

</Block>
</BlockSwitcher>

> **Note**: 

<b>Special Handling on ConfirmSignIn</b>

During a confirmSignIn call if `failAuthentication=true` is returned by the lambda the session of the request gets invalidated by cognito, a NotAuthorizedException is returned and a new signIn call is expected via Amplify.Auth.signIn

```java
NotAuthorizedException
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/signin_next_steps/30_confirm_custom_challenge.mdx`