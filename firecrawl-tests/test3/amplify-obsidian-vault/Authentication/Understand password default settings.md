---
title: Understand password default settings
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/manage-users/manage-passwords/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Understand password default settings

Amplify Auth provides a secure way for your users to change their password or recover a forgotten password.

## Understand password default settings

By default, your users can retrieve access to their accounts if they forgot their password by using either their phone or email. The following are the default account recovery methods used when either `phone` or `email` are used as login options.

| Login option        | User account verification channel |
| ------------------- | --------------------------------- |
| `phone`             | Phone Number                      |
| `email`             | Email                             |
| `email` and `phone` | Email                             |

## Reset Password

To reset a user's password, use the `resetPassword` API which will send a reset code to the destination (e.g. email or SMS) based on the user's settings.

```ts

const output = await resetPassword();

const  = output;
switch (nextStep.resetPasswordStep) `
    );
    // Collect the confirmation code from the user and pass to confirmResetPassword.
    break;
  case 'DONE':
    console.log('Successfully reset password.');
    break;
}
```

</InlineFilter>

```dart
Future<void> resetPassword(String username) async  on AuthException catch (e) ');
  }
}
```

```dart
Future<void> _handleResetPasswordResult(ResetPasswordResult result) async 
}
```

</InlineFilter>

```java
Amplify.Auth.resetPassword(
   "username",
   result -> Log.i("AuthQuickstart", result.toString()),
   error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.resetPassword("username",
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.resetPassword("username")
    .subscribe(
        result -> Log.i("AuthQuickstart", result.toString()),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
func resetPassword(username: String) async 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func resetPassword(username: String) -> AnyCancellable .sink 
        }
        receiveValue: 
        }
}
```

</Block>
</BlockSwitcher>

Usually, resetting the password require you to verify that it is the actual user that tried to reset the password. The next step above will be `.confirmResetPasswordWithCode`.

If you would like to display a more specific view or messaging to your users based the error that occurred, you can handle this by downcasting the `underlyingError` to `AWSCognitoAuthError`.

```swift
if let authError = error as? AuthError,
    let cognitoAuthError = authError.underlyingError as? AWSCognitoAuthError 
}
```

</InlineFilter>

To complete the password reset process, invoke the `confirmResetPassword` API with the code your user received and the new password they want to set.

```ts

await confirmResetPassword();
```

</InlineFilter>

```dart
Future<void> confirmResetPassword() async ');
  } on AuthException catch (e) ');
  }
}
```

</InlineFilter>

```java
Amplify.Auth.confirmResetPassword(
   "Username",
   "NewPassword123",
   "confirmation code you received",
   () -> Log.i("AuthQuickstart", "New password confirmed"),
   error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.confirmResetPassword("Username", "NewPassword123", "confirmation code",
   ,
   
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```
</Block>

```java
RxAmplify.Auth.confirmResetPassword("Username","NewPassword123", "confirmation code")
    .subscribe(
        () -> Log.i("AuthQuickstart", "New password confirmed"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
func confirmResetPassword(
    username: String,
    newPassword: String,
    confirmationCode: String
) async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func confirmResetPassword(
    username: String,
    newPassword: String,
    confirmationCode: String
) -> AnyCancellable .sink 
    }
    receiveValue: 
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

## Update password

You can update a signed in user's password using the `updatePassword` API.

```ts

await updatePassword();
```

</InlineFilter>

```dart
Future<void> updatePassword() async  on AuthException catch (e) ');
  }
}
```

</InlineFilter>

```java
Amplify.Auth.updatePassword(
    "existingPassword",
    "newPassword",
    () -> Log.i("AuthQuickstart", "Updated password successfully"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.updatePassword("existingPassword", "newPassword",
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.updatePassword("existingPassword", "newPassword")
    .subscribe(
        () -> Log.i("AuthQuickstart", "Updated password successfully"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
func changePassword(oldPassword: String, newPassword: String) async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func changePassword(oldPassword: String, newPassword: String) -> AnyCancellable .sink 
        }
        receiveValue: 
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

### Override default user account verification channel

You can always change the channel used by your authentication resources by overriding the following setting.

```ts title="amplify/auth/resource.ts"

## Override default password policy

By default your password policy is set to the following:

- `MinLength`: 8 characters
- `requireLowercase`: true
- `requireUppercase`: true
- `requireNumbers`: true
- `requireSymbols`: true
- `tempPasswordValidity`: 3 days

You can customize the password format acceptable by your auth resource by modifying the underlying `cfnUserPool` resource:

```ts title="amplify/backend.ts"

const backend = defineBackend();
// extract L1 CfnUserPool resources
const  = backend.auth.resources.cfnResources;
// modify cfnUserPool policies directly
cfnUserPool.policies = ,
};
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/manage-users/manage-passwords/index.mdx`