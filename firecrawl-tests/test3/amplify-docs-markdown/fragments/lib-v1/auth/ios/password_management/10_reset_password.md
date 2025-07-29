---
title: Documentation
source: fragments/lib-v1/auth/ios/password_management/10_reset_password.mdx
---

# Documentation

```swift
func resetPassword(username: String) 
        } catch 
    }
}
```

</Block>

```swift
func resetPassword(username: String) -> AnyCancellable 
        }
        receiveValue: 
        }
}
```

</Block>

</BlockSwitcher>

Usually resetting the password require you to verify that it is the actual user that tried to reset the password. The next step above will be `.confirmResetPasswordWithCode`.

If you are using Cognito and would like to display a more specific view or messaging to your users based the error that occurred, you can handle this by downcasting the `underlyingError` to `AWSCognitoAuthError`.

```swift
if let authError = error as? AuthError,
    let cognitoAuthError = authError.underlyingError as? AWSCognitoAuthError 
}
```

For examples of what errors are returned from Cognito for this API, see [ForgotPassword Errors](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_ForgotPassword.html#API_ForgotPassword_Errors)
