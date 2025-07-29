---
title: SignUp
topics: ['Authentication']
primary_topic: Authentication
source: fragments/sdk/auth/ios/working-with-api.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# SignUp

## SignUp

Creates a new user in Cognito User Pools:

```swift
AWSMobileClient.default().signUp(
    username: "your_username",
    password: "Abc@123!",
    userAttributes: ["email":"john@doe.com", "phone_number": "+1973123456"]
) 
    } else if let error = error 
        }
        print("\(error.localizedDescription)")
    }
}
```

## User Attributes

You can provide custom user attributes in the `signUp()` method by passing them into the `userAttributes` argument as key-value pairs. For example:

```swift
AWSMobileClient.default().signUp(
    username: "your_username",
    password: "Abc@123!",
    userAttributes: [
        "nickname":"Johnny",
        "badge_number": "ABC123XYZ"
]) 
```

## Confirm SignUp

Confirms a new user after signing up (MFA):

```swift
AWSMobileClient.default().confirmSignUp(
    username: "your_username",
    confirmationCode: signUpCodeTextField.text!
) 
    } else if let error = error 
}
```

## Re-send a Confirmation Code (MFA)

```swift
AWSMobileClient.default().resendSignUpCode(
    username: "your_username",
    completionHandler:  else if let error = error 
    }
)
```

## SignIn

Sign in with user credentials:

```swift
AWSMobileClient.default().signIn(
    username: "your_username",
    password: "Abc@123!"
)  else if let signInResult = signInResult 
    }
}
```

## Confirm SignIn (MFA)

```swift
AWSMobileClient.default().confirmSignIn(
    challengeResponse: "code_here"
)  else if let signInResult = signInResult 
    }
}
```

## Force a Password Reset

If a user is required to change their password on first login, a `newPasswordRequired` state will be returned when `signIn` is called and you will need to provide a new password. This can be done by using `confirmSignIn`:

```swift
AWSMobileClient.default().signIn(
    username: "abc123",
    password: "Abc123!@"
) 
    } else if let error = error 
}

AWSMobileClient.default().confirmSignIn(
    challengeResponse: "NEW_PASSWORD_HERE"
) 
    } else if let error = error 
}
```

## SignOut

```swift
AWSMobileClient.default().signOut()
```

## Global SignOut

Using global signout, you can signout a user from all active login sessions. By doing this, you are invalidating all tokens (id token, access token and refresh token) which means the user is signed out from **all** devices.

> **Note** Although the tokens are revoked the temporary AWS credentials (Access and Secret Keys) will remain valid until they expire, which by default is 1 hour.

```swift
AWSMobileClient.default().signOut(
    options: SignOutOptions(signOutGlobally: true)
) 
```

## Forgot Password

Forgot password is a 2 step process.

1. Call a `forgotPassword()` method which sends a confirmation code via email or phone number. The details of how the code was sent are included in the response of `forgotPassword()`.
2. Once the code is given call `confirmForgotPassword()` with the confirmation code.

```swift
AWSMobileClient.default().forgotPassword(
    username: "my_username"
) 
        } else if let error = error 
}
```

```swift
AWSMobileClient.default().confirmForgotPassword(
    username: "my_username",
    newPassword: "MyNewPassword123!!",
    confirmationCode: "ConfirmationCode"
) 
    } else if let error = error 
}
```

## Utility Properties

AWSMobileClient provides several property helpers that are automatically cached locally.

```swift
AWSMobileClient.default().username       //String
AWSMobileClient.default().isSignedIn     //Boolean
AWSMobileClient.default().identityId     //String
```

> Note: The property `username` is available only when using username-password based auth with Cognito User Pools.

## Managing Security Tokens

When using Authentication with AWSMobileClient, you do not need to refresh Amazon Cognito tokens manually. The tokens are automatically refreshed by the SDK when necessary.

### OIDC Tokens

```swift
AWSMobileClient.default().getTokens  else if let tokens = tokens 
}
```

### AWS Credentials

```swift
AWSMobileClient.default().getAWSCredentials  else if let credentials = credentials 
}
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/sdk/auth/ios/working-with-api.mdx`