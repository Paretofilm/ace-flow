---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/signin_next_steps/10_signin.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

When called successfully, the signin APIs will return an `AuthSignInResult`. Inspect the `nextStep` property in the result to see if additional signin steps are required.
The `nextStep` property is of enum type `AuthSignInStep`. Depending on its value, your code should take one of the following actions:

```java
try 
                      case CONTINUE_SIGN_IN_WITH_TOTP_SETUP -> 
                      case CONTINUE_SIGN_IN_WITH_MFA_SELECTION -> 
                      case CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE: 
                      case CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE: 
                      case CONFIRM_SIGN_IN_WITH_NEW_PASSWORD: 
                      case DONE: 
                  }
              },
              error ->  else if (error instanceof PasswordResetRequiredException)  else 
              }

      );
} catch (Exception error) 
```

</Block>

```kotlin
val options = AWSCognitoAuthSignInOptions.builder().authFlowType(AuthFlowType.USER_SRP_AUTH).build()
try 
                  AuthSignInStep.CONTINUE_SIGN_IN_WITH_TOTP_SETUP -> ")
                      // Prompt the user to enter the TOTP code generated in their authenticator app
                      // Then invoke `confirmSignIn` api with the code
                  }
                  AuthSignInStep.CONTINUE_SIGN_IN_WITH_MFA_SELECTION -> ")
                      // Prompt the user to select the MFA type they want to use
                      // Then invoke `confirmSignIn` api with the MFA type
                  }
                  AuthSignInStep.CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE -> ")
                      Log.i("AuthQuickstart", "Additional Info $")
                      // Prompt the user to enter the SMS MFA code they received
                      // Then invoke `confirmSignIn` api with the code
                  }
                  AuthSignInStep.CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE -> ")
                      // Prompt the user to enter custom challenge answer
                      // Then invoke `confirmSignIn` api with the answer
                  }
                  AuthSignInStep.CONFIRM_SIGN_IN_WITH_NEW_PASSWORD -> ")
                      // Prompt the user to enter a new password
                      // Then invoke `confirmSignIn` api with new password
                  }
                  AuthSignInStep.DONE -> 
              }

          }
      )  else if (error is PasswordResetRequiredException)  else 
         }
} catch (error: Exception) 
```

</Block>

```kotlin
val options =
            AWSCognitoAuthSignInOptions.builder().authFlowType(AuthFlowType.USER_SRP_AUTH).build()
try 
        AuthSignInStep.CONTINUE_SIGN_IN_WITH_TOTP_SETUP -> ")
            // Prompt the user to enter the TOTP code generated in their authenticator app
            // Then invoke `confirmSignIn` api with the code
        }
        AuthSignInStep.CONTINUE_SIGN_IN_WITH_MFA_SELECTION -> ")
            // Prompt the user to select the MFA type they want to use
            // Then invoke `confirmSignIn` api with the MFA type
        }
        AuthSignInStep.CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE -> ")
            Log.i("AuthQuickstart", "Additional Info $")
            // Prompt the user to enter the SMS MFA code they received
            // Then invoke `confirmSignIn` api with the code
        }
        AuthSignInStep.CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE -> ")
            // Prompt the user to enter custom challenge answer
            // Then invoke `confirmSignIn` api with the answer
        }
        AuthSignInStep.CONFIRM_SIGN_IN_WITH_NEW_PASSWORD -> "
            )
            // Prompt the user to enter a new password
            // Then invoke `confirmSignIn` api with new password
        }
        AuthSignInStep.DONE -> 
    }
} catch (error: Exception)  else if (error is PasswordResetRequiredException)  else 
}
```

</Block>

```java

AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder().authFlowType(AuthFlowType.USER_SRP_AUTH).build();
RxAmplify.Auth.signIn("username", "password", options).subscribe(
        result ->
        
                case CONTINUE_SIGN_IN_WITH_TOTP_SETUP -> 
                case CONTINUE_SIGN_IN_WITH_MFA_SELECTION -> 
                case CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE: 
                case CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE: 
                case CONFIRM_SIGN_IN_WITH_NEW_PASSWORD: 
                case DONE: 
            }
        },
        error ->  else if (error instanceof PasswordResetRequiredException)  else 
        }
);
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/signin_next_steps/10_signin.mdx`