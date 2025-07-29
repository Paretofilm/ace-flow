---
title: Confirm sign-up
source: pages/build-a-backend/auth/connect-your-frontend/sign-up/index.mdx
---

# Confirm sign-up

Amplify provides a client library that enables you to interact with backend resources such as Amplify Auth.

> **Note**: 

The quickest way to get started with Amplify Auth in your frontend application is with the [Authenticator component](https://ui.docs.amplify.aws/react/connected-components/authenticator), which provides a customizable UI and complete authentication flows.

</InlineFilter>

> **Note**: 

The quickest way to get started with Amplify Auth in your frontend application is with the [Authenticator component](https://ui.docs.amplify.aws/swift/connected-components/authenticator), which provides a customizable UI and complete authentication flows.

</InlineFilter>

> **Note**: 

The quickest way to get started with Amplify Auth in your frontend application is with the [Authenticator component](https://ui.docs.amplify.aws/flutter/connected-components/authenticator), which provides a customizable UI and complete authentication flows.

</InlineFilter>

> **Note**: 

The quickest way to get started with Amplify Auth in your frontend application is with the [Authenticator component](https://ui.docs.amplify.aws/android/connected-components/authenticator), which provides a customizable UI and complete authentication flows.

</InlineFilter>

To get started, you can use the `signUp()` API to create a new user in your backend:

```ts

const  = await signUp(,
  }
});
```

</InlineFilter>

 ```dart
/// Signs a user up with a username, password, and email. The required
/// attributes may be different depending on your app's configuration.
Future<void> signUpUser() async ;
    final result = await Amplify.Auth.signUp(
      username: username,
      password: password,
      options: SignUpOptions(
        userAttributes: userAttributes,
      ),
    );
    await _handleSignUpResult(result);
  } on AuthException catch (e) ');
  }
}
```

```dart
Future<void> _handleSignUpResult(SignUpResult result) async 
}

void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) . '
    'Please check your $ for the code.',
  );
}
```

</InlineFilter>

```java
ArrayList attributes = new ArrayList<>();
attributes.add(new AuthUserAttribute(AuthUserAttributeKey.email(), "my@email.com"));
attributes.add(new AuthUserAttribute(AuthUserAttributeKey.phoneNumber(), "+15551234567"));

Amplify.Auth.signUp(
    "username",
    "Password123",
    AuthSignUpOptions.builder().userAttributes(attributes).build(),
    result -> Log.i("AuthQuickstart", result.toString()),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
val attrs = mapOf(
    AuthUserAttributeKey.email() to "my@email.com",
    AuthUserAttributeKey.phoneNumber() to "+15551234567"
)
val options = AuthSignUpOptions.builder()
    .userAttributes(attrs.map )
    .build()
Amplify.Auth.signUp("username", "Password123", options,
    ,
    
)
```

</Block>

```kotlin
val attrs = mapOf(
    AuthUserAttributeKey.email() to "my@email.com",
    AuthUserAttributeKey.phoneNumber() to "+15551234567"
)
val options = AuthSignUpOptions.builder()
    .userAttributes(attrs.map )
    .build()
try  catch (error: AuthException) 
```

</Block>

```java
ArrayList attributes = new ArrayList<>();
attributes.add(new AuthUserAttribute(AuthUserAttributeKey.email(), "my@email.com"));
attributes.add(new AuthUserAttribute(AuthUserAttributeKey.phoneNumber(), "+15551234567"));

RxAmplify.Auth.signUp(
    "username",
    "Password123",
    AuthSignUpOptions.builder().userAttributes(attributes).build())
    .subscribe(
        result -> Log.i("AuthQuickstart", result.toString()),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
func signUp(username: String, password: String, email: String, phonenumber: String) async  else 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func signUp(username: String, password: String, email: String, phonenumber: String) -> AnyCancellable .sink 
    }
    receiveValue:  else 
    }
    return sink
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

The `signUp` API response will include a `nextStep` property, which can be used to determine if further action is required. It may return the following next steps:

| Next Step | Description |
| --------- | ----------- |
| `CONFIRM_SIGN_UP` | The sign up needs to be confirmed by collecting a code from the user and calling `confirmSignUp`. |
| `DONE` | The sign up process has been fully completed. |
| `COMPLETE_AUTO_SIGN_IN` | The sign up process needs to complete by invoking the `autoSignIn` API. |
</InlineFilter>

| Next Step | Description |
| --------- | ----------- |
| `CONFIRM_SIGN_UP_STEP` | The sign up needs to be confirmed by collecting a code from the user and calling `confirmSignUp`. |
| `DONE` | The sign up process has been fully completed. |
</InlineFilter>

| Next Step | Description |
| --------- | ----------- |
| `confirmSignUp` | The sign up needs to be confirmed by collecting a code from the user and calling `confirmSignUp`. |
| `done` | The sign up process has been fully completed. |
</InlineFilter>

## Confirm sign-up

By default, each user that signs up remains in the unconfirmed status until they verify with a confirmation code that was sent to their email or phone number. The following are the default verification methods used when either `phone` or `email` are used as `loginWith` options.

| Login option        | User account verification channel |
| ------------------- | --------------------------------- |
| `phone`             | Phone Number                      |
| `email`             | Email                             |
| `email` and `phone` | Email                             |

You can confirm the sign-up after receiving a confirmation code from the user:

```ts

const  = await confirmSignUp();
```

</InlineFilter>

```dart
Future<void> confirmUser() async  on AuthException catch (e) ');
  }
}
```

</InlineFilter>

```java
Amplify.Auth.confirmSignUp(
    "username",
    "the code you received via email",
    result -> Log.i("AuthQuickstart", result.isSignUpComplete() ? "Confirm signUp succeeded" : "Confirm sign up not complete"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.confirmSignUp(
    "username", "the code you received via email",
     else 
    },
    
)
```

</Block>

```kotlin
try  else 
} catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.confirmSignUp("username", "the code you received via email")
    .subscribe(
        result -> Log.i("AuthQuickstart", result.isSignUpComplete() ? "Confirm signUp succeeded" : "Confirm sign up not complete"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
func confirmSignUp(for username: String, with confirmationCode: String) async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func confirmSignUp(for username: String, with confirmationCode: String) -> AnyCancellable .sink 
    }
    receiveValue: 
}
```

</Block>

</BlockSwitcher>

</InlineFilter>

> **Note**: 

**Note:** When specifying `email` or `phone` as a way for your users to sign-in, these are attributes that are used in place of the username. Visit the [concepts page to learn more about usernames](/[platform]/build-a-backend/auth/concepts/).

</InlineFilter>

## Practical Example

```tsx title="src/App.tsx"
// highlight-next-line

Amplify.configure(outputs)

interface SignUpFormElements extends HTMLFormControlsCollection 

interface SignUpForm extends HTMLFormElement 

  return (
    <form onSubmit=>
      <label htmlFor="email">Email:</label>
      <input type="text" id="email" name="email" />
      <label htmlFor="password">Password:</label>
      <input type="password" id="password" name="password" />
      <input type="submit" />
    </form>
  )
}
```

</InlineFilter>
</InlineFilter>

## Sign up with passwordless methods

Your application's users can also sign up using passwordless methods. To learn more, visit the [concepts page for passwordless](/[platform]/build-a-backend/auth/concepts/passwordless/).

### SMS OTP

```typescript
// Sign up using a phone number
const  = await signUp(,
	},
});

if (signUpNextStep.signUpStep === 'DONE') 

if (signUpNextStep.signUpStep === 'CONFIRM_SIGN_UP') `,
	);
	console.log(
		`Code Delivery Destination: $`,
	);
}

// Confirm sign up with the OTP received
const  = await confirmSignUp();

if (confirmSignUpNextStep.signUpStep === 'DONE') 
```

</InlineFilter>

```java
// Sign up using a phone number
ArrayList attributes = new ArrayList<>();
attributes.add(new AuthUserAttribute(AuthUserAttributeKey.phoneNumber(), "+15551234567"));

Amplify.Auth.signUp(
    "hello@example.com",
    null,
    AuthSignUpOptions.builder().userAttributes(attributes).build(),
    result ->  else if (result.getNextStep().getSignUpStep() == AuthSignUpStep.CONFIRM_SIGN_UP_STEP) 
    },
    error -> Log.e("AuthQuickstart", error.toString())
);

// Confirm sign up with the OTP received
Amplify.Auth.confirmSignUp(
    "hello@example.com",
    "123456",
    result -> 
    },
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
// Sign up using a phone number
val attributes = listOf(
    AuthUserAttribute(AuthUserAttributeKey.phoneNumber(), "+15555551234")
)
val options =
    AuthSignUpOptions
        .builder()
        .userAttributes(attributes)
        .build()

Amplify.Auth.signUp(
    "hello@example.com",
    null,
    options,
     else if (result.nextStep.signUpStep == AuthSignUpStep.CONFIRM_SIGN_UP_STEP) ")
            Log.i("AuthQuickstart", "Code Deliver Destination: " +
                "$")
        }
    },
    
)

// Confirm sign up with the OTP received
Amplify.Auth.confirmSignUp(
    "hello@example.com",
    "123456",
    
    },
    
)
```

</Block>

```kotlin
// Sign up using a phone number
val attributes = listOf(
    AuthUserAttribute(AuthUserAttributeKey.phoneNumber(), "+15555551234")
)
val options =
    AuthSignUpOptions
        .builder()
        .userAttributes(attributes)
        .build()
var result = Amplify.Auth.signUp("hello@example.com", null, options)

if (result.isSignUpComplete)  else if (result.nextStep.signUpStep == AuthSignUpStep.CONFIRM_SIGN_UP_STEP) ")
    Log.i("AuthQuickstart", "Code Deliver Destination: " +
        "$")
}

// Confirm sign up with the OTP received
result = Amplify.Auth.confirmSignUp(
    "hello@example.com",
    "123456"
)

if (result.nextStep.signUpStep == AuthSignUpStep.DONE) 
```

</Block>

```java
// Sign up using a phone number
ArrayList attributes = new ArrayList<>();
attributes.add(new AuthUserAttribute(AuthUserAttributeKey.phoneNumber(), "+15551234567"));

RxAmplify.Auth.signUp(
    "hello@example.com",
    null,
    AuthSignUpOptions.builder().userAttributes(attributes).build()
)
    .subscribe(
        result ->  else if (result.getNextStep().getSignUpStep() == AuthSignUpStep.CONFIRM_SIGN_UP_STEP) 
        },
        error -> Log.e("AuthQuickstart", error.toString())
    );

// Confirm sign up with the OTP received
RxAmplify.Auth.confirmSignUp(
    "hello@example.com",
    "123456"
)
    .subscribe(
        result -> 
        },
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
// Sign up using an phone number
func signUp(username: String, phonenumber: String) async  else 
    } catch let error as AuthError  catch 
}

// Confirm sign up with the OTP received
func confirmSignUp(for username: String, with confirmationCode: String) async  catch let error as AuthError  catch 
}
```

</Block>

```swift
// Sign up using a phone number
func signUp(username: String, phonenumber: String) -> AnyCancellable .sink 
    }
    receiveValue:  else 
    }
    return sink
}

// Confirm sign up with the OTP received
func confirmSignUp(for username: String, with confirmationCode: String) -> AnyCancellable .sink 
    }
    receiveValue: 
}
```

</Block>

</BlockSwitcher>

</InlineFilter>

### Email OTP

```typescript
// Sign up using an email address
const  = await signUp(,
	},
});

if (signUpNextStep.signUpStep === 'DONE') 

if (signUpNextStep.signUpStep === 'CONFIRM_SIGN_UP') `,
	);
	console.log(
		`Code Delivery Destination: $`,
	);
}

// Confirm sign up with the OTP received
const  = await confirmSignUp();

if (confirmSignUpNextStep.signUpStep === 'DONE') 
```

</InlineFilter>

```java
// Sign up using an email address
ArrayList attributes = new ArrayList<>();
attributes.add(new AuthUserAttribute(AuthUserAttributeKey.email(), "hello@example.com"));

Amplify.Auth.signUp(
    "hello@example.com",
    null,
    AuthSignUpOptions.builder().userAttributes(attributes).build(),
    result ->  else if (result.getNextStep().getSignUpStep() == AuthSignUpStep.CONFIRM_SIGN_UP_STEP) 
    },
    error -> Log.e("AuthQuickstart", error.toString())
);

// Confirm sign up with the OTP received
Amplify.Auth.confirmSignUp(
    "hello@example.com",
    "123456",
    result -> 
    },
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
// Sign up using an email address
val attributes = listOf(
    AuthUserAttribute(AuthUserAttributeKey.email(), "my@email.com")
)
val options =
    AuthSignUpOptions
        .builder()
        .userAttributes(attributes)
        .build()

Amplify.Auth.signUp(
    "hello@example.com",
    null,
    options,
     else if (result.nextStep.signUpStep == AuthSignUpStep.CONFIRM_SIGN_UP_STEP) ")
            Log.i("AuthQuickstart", "Code Deliver Destination: " +
                "$")
        }
    },
    
)

// Confirm sign up with the OTP received
Amplify.Auth.confirmSignUp(
    "hello@example.com",
    "123456",
    
    },
    
)
```

</Block>

```kotlin
// Sign up using an email address
val attributes = listOf(
    AuthUserAttribute(AuthUserAttributeKey.email(), "my@email.com")
)
val options =
    AuthSignUpOptions
        .builder()
        .userAttributes(attributes)
        .build()
var result = Amplify.Auth.signUp("hello@example.com", null, options)

if (result.isSignUpComplete)  else if (result.nextStep.signUpStep == AuthSignUpStep.CONFIRM_SIGN_UP_STEP) ")
    Log.i("AuthQuickstart", "Code Deliver Destination: " +
        "$")
}

// Confirm sign up with the OTP received
result = Amplify.Auth.confirmSignUp(
    "hello@example.com",
    "123456"
)

if (result.nextStep.signUpStep == AuthSignUpStep.DONE) 
```

</Block>

```java
// Sign up using an email address
ArrayList attributes = new ArrayList<>();
attributes.add(new AuthUserAttribute(AuthUserAttributeKey.email(), "my@email.com"));

RxAmplify.Auth.signUp(
    "hello@example.com",
    null,
    AuthSignUpOptions.builder().userAttributes(attributes).build()
)
    .subscribe(
        result ->  else if (result.getNextStep().getSignUpStep() == AuthSignUpStep.CONFIRM_SIGN_UP_STEP) 
        },
        error -> Log.e("AuthQuickstart", error.toString())
    );

// Confirm sign up with the OTP received
RxAmplify.Auth.confirmSignUp(
    "hello@example.com",
    "123456"
)
    .subscribe(
        result -> 
        },
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
// Sign up using an email
func signUp(username: String, email: String) async  else 
    } catch let error as AuthError  catch 
}

// Confirm sign up with the OTP received
func confirmSignUp(for username: String, with confirmationCode: String) async  catch let error as AuthError  catch 
}
```

</Block>

```swift
// Sign up using an email
func signUp(username: String, email: String) -> AnyCancellable .sink 
    }
    receiveValue:  else 
    }
    return sink
}

// Confirm sign up with the OTP received
func confirmSignUp(for username: String, with confirmationCode: String) -> AnyCancellable .sink 
    }
    receiveValue: 
}
```

</Block>

</BlockSwitcher>

</InlineFilter>

### Auto Sign In

```typescript
// Call `signUp` API with `USER_AUTH` as the authentication flow type for `autoSignIn`
const  = await signUp(,
		autoSignIn: ,
	},
});

if (signUpNextStep.signUpStep === 'CONFIRM_SIGN_UP') `,
	);
	console.log(
		`Code Delivery Destination: $`,
	);
}

// Call `confirmSignUp` API with the OTP received
const  = await confirmSignUp();

if (confirmSignUpNextStep.signUpStep === 'COMPLETE_AUTO_SIGN_IN')  = await autoSignIn();

	if (nextStep.signInStep === 'DONE') 
}

```
</InlineFilter>

```java
private void confirmSignUp(String username, String confirmationCode) 
        },
        error -> Log.e("AuthQuickstart", error.toString())
    );
}

private void autoSignIn() 
```

</Block>

```kotlin
fun confirmSignUp(username: String, confirmationCode: String) 
        },
        
    )
}
fun autoSignIn() ,
        
    )
}
```

</Block>

```kotlin
suspend fun confirmSignUp(username: String, confirmationCode: String) 
}

suspend fun autoSignIn()  else 
}
```

</Block>

```java
private void confirmSignUp(String username, String confirmationCode) 
            },
            error -> Log.e("AuthQuickstart", error.toString())
        );
}

private void autoSignIn() 
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
// Confirm sign up with the OTP received and auto sign in
func confirmSignUp(for username: String, with confirmationCode: String) async  else 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
// Confirm sign up with the OTP received and auto sign in
func confirmSignUp(for username: String, with confirmationCode: String) -> AnyCancellable .sink 
    }
    receiveValue:  else 
    }
}

func autoSignIn() -> AnyCancellable .sink 
    }
    receiveValue: 
    }
}
```

</Block>

</BlockSwitcher>

</InlineFilter>

</InlineFilter>
