---
title: Confirm signin with SMS MFA
source: fragments/lib/auth/native_common/signin_next_steps/common.mdx
---

# Confirm signin with SMS MFA

After a user has finished signup, they can proceed to sign in. Amplify Auth signin flows can be multi step processes. The required steps are determined by the configuration you provided when you ran `amplify add auth`. Depending on the configuration, you may need to call various APIs to finish authenticating a user's signin attempt. To identify the next step in a signin flow, inspect the `nextStep` parameter in the signin result.

> **Note**: 
<b>New enumeration values</b>

When Amplify adds a new enumeration value (e.g., a new enum class entry or sealed class subtype in Kotlin, or a new enum value in Swift/Dart/Kotlin), it will publish a new minor version of the Amplify Library. Plugins that switch over enumeration values should include default handlers (an else branch in Kotlin or a default statement in Swift/Dart/Kotlin) to ensure that they are not impacted by new enumeration values.

## Confirm signin with SMS MFA

## Confirm signin with TOTP MFA

If the next step is `CONFIRM_SIGN_IN_WITH_TOTP_CODE`, you should prompt the user to enter the TOTP code from their associated authenticator app during set up. The code is a six-digit number that changes every 30 seconds. The user must enter the code before the 30-second window expires.
</InlineFilter>

If the next step is `confirmSignInWithTOTPCode`, you should prompt the user to enter the TOTP code from their associated authenticator app during set up. The code is a six-digit number that changes every 30 seconds. The user must enter the code before the 30-second window expires.
</InlineFilter>

After the user enters the code, your implementation must pass the value to Amplify Auth `confirmSignIn` API.

```java
Amplify.Auth.confirmSignIn(
    "TOTP confirmation code",
    result ->  else 
    },
    error -> Log.e("AuthQuickstart", "Confirm sign in failed: " + error)
);
```
</Block>

```kotlin
Amplify.Auth.confirmSignIn(
    "TOTP confirmation code",
     else "
            )
            // Switch on the next step to take appropriate actions.
            // If `signInResult.isSignedIn` is true, the next step
            // is 'done', and the user is now signed in.
        }
    },
    
)
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
    "TOTP confirmation code"
).subscribe(
    result ->  else 
    },
    error -> Log.e("AuthQuickstart", "Confirm sign in failed: " + error)
);
```
</Block>
</BlockSwitcher>

</InlineFilter>

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

// Then, pass the TOTP code to `confirmSignIn`

Future<void> confirmTotpUser(String totpCode) async  on AuthException catch (e) ');
  }
}
```

</InlineFilter>

## Continue signin with MFA Selection

If the next step is `CONTINUE_SIGN_IN_WITH_MFA_SELECTION`, the user must select the MFA method to use. Amplify Auth currently only supports SMS and TOTP as MFA methods. After the user selects an MFA method, your implementation must pass the selected MFA method to Amplify Auth using `confirmSignIn` API.
</InlineFilter>

If the next step is `continueSignInWithMFASelection`, the user must select the MFA method to use. Amplify Auth currently only supports SMS and TOTP as MFA methods. After the user selects an MFA method, your implementation must pass the selected MFA method to Amplify Auth using `confirmSignIn` API.
</InlineFilter>

```java
Amplify.Auth.confirmSignIn(
    MFATypeUtil.getChallengeResponse(MFAType.TOTP),
    result -> 
        // ...
    },
    error -> Log.e("AuthQuickstart", "Confirm sign in failed: " + error)
);
```

</Block>

```kotlin
Amplify.Auth.confirmSignIn(
    MFAType.TOTP.challengeResponse,
    
        // ...
    },
    
)
```

</Block>

```kotlin
try 
  // ...
} catch(error: Exception) 
```

</Block>

```java
RxAmplify.Auth.confirmSignIn(
  MFATypeUtil.getChallengeResponse(MFAType.TOTP)
).subscribe(
  result -> 
    // ...
  },
  error -> Log.e("AuthQuickstart", "Confirm sign in failed: " + error)
);
```

</Block>
</BlockSwitcher>

</InlineFilter>

The MFA types which are currently supported by Amplify Auth are:

- `MfaType.sms`
- `MfaType.totp`

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

Future _promptUserPreference(Set allowedTypes) async 

Future<void> _handleMfaSelection(MfaType selection) async  on AuthException catch (e) ');
  }
}
```

</InlineFilter>

## Continue signin with TOTP Setup

If the next step is `CONTINUE_SIGN_IN_WITH_TOTP_SETUP`, then the user must provide a TOTP code to complete the sign in process. The step returns an associated value of type `TOTPSetupDetails` which would be used for generating TOTP. `TOTPSetupDetails` provides a helper method called `getSetupURI` that can be used to generate a URI, which can be used by native password managers for TOTP association. For example. if the URI is used on Apple platforms, it will trigger the platform's native password manager to associate TOTP with the account. For more advanced use cases, `TOTPSetupDetails` also contains the `sharedSecret` that will be used to either generate a QR code or can be manually entered into an authenticator app.
</InlineFilter>

If the next step is `continueSignInWithTOTPSetup`, then the user must provide a TOTP code to complete the sign in process. The step returns an associated value of type `TOTPSetupDetails` which would be used for generating TOTP. `TOTPSetupDetails` provides a helper method called `getSetupURI` that can be used to generate a URI, which can be used by native password managers for TOTP association. For example. if the URI is used on Apple platforms, it will trigger the platform's native password manager to associate TOTP with the account. For more advanced use cases, `TOTPSetupDetails` also contains the `sharedSecret` that will be used to either generate a QR code or can be manually entered into an authenticator app.
</InlineFilter>

Once the authenticator app is set up, the user can generate a TOTP code and provide it to the library to complete the sign in process.

```java

void handleSignInResult(AuthSignInResult result) 
}

// Then, pass the TOTP code to `confirmSignIn`

Amplify.Auth.confirmSignIn(
    totpCodeFromAuthenticatorApp,
    result ->  else 
    },
    error -> Log.e("AuthQuickstart", "Confirm sign in failed: " + error)
);
```

</Block>

```kotlin

fun handleSignInResult(result: AuthSignInResult) 
    }
}

// Then, pass the TOTP code to `confirmSignIn`

Amplify.Auth.confirmSignIn(
    totpCodeFromAuthenticatorApp,
     else ")
          // Switch on the next step to take appropriate actions.
          // If `signInResult.isSignedIn` is true, the next step
          // is 'done', and the user is now signed in.
      }
    },
    
)
```

</Block>

```kotlin

fun handleSignInResult(result: AuthSignInResult) 
    }
}

// Then, pass the TOTP code to `confirmSignIn`

try  else ")
      // Switch on the next step to take appropriate actions.
      // If `signInResult.isSignedIn` is true, the next step
      // is 'done', and the user is now signed in.
  }
} catch(error: Exception) 
```

</Block>

```java
    void handleSignInResult(AuthSignInResult result) 
    }

// Then, pass the TOTP code to `confirmSignIn`

RxAmplify.Auth.confirmSignIn(
  totpCodeFromAuthenticatorApp
).subscribe(
  result ->  else 
  },
  error -> Log.e("AuthQuickstart", "Confirm sign in failed: " + error)
);
```

</Block>
</BlockSwitcher>

</InlineFilter>

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

// Then, pass the TOTP code to `confirmSignIn`

Future<void> confirmTotpUser(String totpCode) async  on AuthException catch (e) ');
  }
}
```

</InlineFilter>

## Confirm signin with custom challenge

## Confirm signin with new password

## Reset password

## Confirm Signup

## Done
