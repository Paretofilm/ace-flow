---
title: Prerequisites
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/customize-auth-lifecycle/custom-auth-flows/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Prerequisites

The Auth category can be configured to perform a [custom authentication flow](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html) defined by you. The following guide shows how to setup a simple passwordless authentication flow.

## Prerequisites
An application with Amplify libraries integrated and a minimum target of any of the following:
- **iOS 13.0**, using **Xcode 14.1** or later.
- **macOS 10.15**, using **Xcode 14.1** or later.
- **tvOS 13.0**, using **Xcode 14.3** or later.
- **watchOS 9.0**, using **Xcode 14.3** or later.
- **visionOS 1.0**, using **Xcode 15** or later. (Preview support - see below for more details.)

For a full example, please follow the [project setup walkthrough](/[platform]/start/quickstart/).

> **Note**: 

visionOS support is currently in **preview** and can be used by using the latest [Amplify Release](https://github.com/aws-amplify/amplify-swift/releases). 
As new Xcode and visionOS versions are released, the support will be updated with any necessary fixes on a best effort basis.

> **Note**: 

To use Auth in a macOS project, you'll need to enable the Keychain Sharing capability. In Xcode, navigate to **your application target** > **Signing & Capabilities** > **+ Capability**, then select **Keychain Sharing.**

This capability is required because Auth uses the Data Protection Keychain on macOS as a platform best practice. See [TN3137: macOS keychain APIs and implementations](https://developer.apple.com/documentation/technotes/tn3137-on-mac-keychains) for more information on how Keychain works on macOS and the Keychain Sharing entitlement.

For more information on adding capabilities to your application, see [Xcode Capabilities](https://developer.apple.com/documentation/xcode/capabilities).

## Configure Auth

The custom auth flow can be [configured manually](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).

## Sign in a user

Implement a UI to get the username from the user. After the user enters the username you can start the sign in flow by calling the following method:

```swift
func signIn(username: String) async  else 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func signIn(username: String) -> AnyCancellable .sink 
    }
    receiveValue:  else 
    }
}
```

</Block>

</BlockSwitcher>

Since this is a custom authentication flow with a challenge, the result of the signin process has a next step `.confirmSignInWithCustomChallenge`. Implement a UI to allow the user to enter the custom challenge.

## Confirm sign in with custom challenge

To get a custom challenge from the user, create an appropriate UI for the user to submit the required value, and pass that value into the `confirmSignin()` API.

```swift
func customChallenge(response: String) async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func customChallenge(response: String) -> AnyCancellable .sink 
        }
        receiveValue: 
}
```

</Block>

</BlockSwitcher>

You will know the sign in flow is complete if you see the following in your console window:

```console
Confirm sign in succeeded
```

### Lambda Trigger Setup

AWS Amplify now supports creating functions as part of its new backend experience. For more information on the Functions and how to start with them check out [Functions documentation](/[platform]/build-a-backend/functions/). In addition, more information on available triggers can be found in the [Cognito documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html).

### Custom Auth Flow with Secure Remote Password (SRP)

Cognito User Pool allows to start the custom authentication flow with SRP as the first step. If you would like to use this flow, setup Define Auth Lambda trigger to handle SRP_A as the first challenge as shown below:

```javascript
exports.handler = (event, context) =>  else if (event.request.session.length == 2 && 
      event.request.session[1].challengeName == 'PASSWORD_VERIFIER' && 
      event.request.session[1].challengeResult == true)  else if (event.request.session.length == 3 && 
      event.request.session[2].challengeName == 'CUSTOM_CHALLENGE' && 
      event.request.session[2].challengeResult == true)  else 
  context.done(null, event);
};
```

If your lambda is setup to start with `SRP` as the first step, make sure to initiate the signIn process with `customWithSRP` as the authentication flow:

```swift
let options = AWSAuthSignInOptions(
    authFlowType: .customWithSRP)
let signInResult = try await Amplify.Auth.signIn(
    username: username,
    password: password,
    options: .init(pluginOptions: options))
```

</InlineFilter>

The Auth category can be configured to perform a [custom authentication flow](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html) defined by you. The following guide shows how to setup a simple passwordless authentication flow.

## Prerequisites

* An Android application targeting at least Android SDK API level 24 with Amplify libraries integrated
    * For a full example of creating Android project, please follow the [project setup walkthrough](/[platform]/start/quickstart/)

## Configure Auth

The custom auth flow can be [configured manually](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).

## Register a user

The flow as mentioned above requires a username and a valid email id as parameters to register a user. Invoke the following api to initiate a sign up flow.

```java
AuthSignUpOptions options = AuthSignUpOptions.builder()
    .userAttribute(AuthUserAttributeKey.email(), "my@email.com")
    .build();
Amplify.Auth.signUp("username", "Password123", options,
    result -> Log.i("AuthQuickStart", "Result: " + result.toString()),
    error -> Log.e("AuthQuickStart", "Sign up failed", error)
);
```

</Block>

```kotlin
val options = AuthSignUpOptions.builder()
    .userAttribute(AuthUserAttributeKey.email(), "my@email.com")
    .build()
Amplify.Auth.signUp("username", "Password123", options,
    ,
    
)
```

</Block>

```kotlin
val options = AuthSignUpOptions.builder()
    .userAttribute(AuthUserAttributeKey.email(), "my@email.com")
    .build()
try  catch (error: AuthException) 
```

</Block>

 ```java
RxAmplify.Auth.signUp(
    "username",
    "Password123",
    AuthSignUpOptions.builder().userAttribute(AuthUserAttributeKey.email(), "my@email.com").build())
    .subscribe(
        result -> Log.i("AuthQuickStart", "Result: " + result.toString()),
        error -> Log.e("AuthQuickStart", "Sign up failed", error)
    );
```

</Block>
</BlockSwitcher>

The next step in the sign up flow is to confirm the user. A confirmation code will be sent to the email id provided during sign up. Enter the confirmation code received via email in the `confirmSignUp` call.

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

You will know the sign up flow is complete if you see the following in your console window:

```console
Confirm signUp succeeded
```

## Sign in a user

Implement a UI to get the username from the user. After the user enters the username you can start the sign in flow by calling the following method:

```java
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.CUSTOM_AUTH_WITHOUT_SRP)
    .build();
Amplify.Auth.signIn(
    "username",
    "password",
    options,
    result -> Log.i("AuthQuickstart", result.isSignedIn() ? "Sign in succeeded" : "Sign in not complete"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.CUSTOM_AUTH_WITHOUT_SRP)
    .build()
Amplify.Auth.signIn(
    "username", 
    "password", 
    options,
     else 
    },
    
)
```

</Block>

```kotlin
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.CUSTOM_AUTH_WITHOUT_SRP)
    .build()
try  else 
} catch (error: AuthException) 
```

</Block>

```java
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.CUSTOM_AUTH_WITHOUT_SRP)
    .build();
RxAmplify.Auth.signIn("username", "password", options)
    .subscribe(
        result -> Log.i("AuthQuickstart", result.isSignedIn() ? "Sign in succeeded" : "Sign in not complete"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

Since this is a custom authentication flow with a challenge, the result of the signin process has a next step `.confirmSignInWithCustomChallenge`. Implement a UI to allow the user to enter the custom challenge.

## Confirm sign in with custom challenge

Get the custom challenge (`1234` in this case) from the user and pass it to the `confirmSignin()` api.

```java
Amplify.Auth.confirmSignIn(
    "confirmation",
    result -> Log.i("AuthQuickstart", "Confirm sign in succeeded: " + result.toString()),
    error -> Log.e("AuthQuickstart", "Failed to confirm sign in", error)
);
```

</Block>

```kotlin
Amplify.Auth.confirmSignIn("confirmation",
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.confirmSignIn("confirmation")
    .subscribe(
        result -> Log.i("AuthQuickstart", result.toString()),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>

</BlockSwitcher>

You will know the sign in flow is complete if you see the following in your console window:

```console
Confirm sign in succeeded
```

### Lambda Trigger Setup

AWS Amplify now supports creating functions as part of the AWS Amplify. For more information on the Functions and how to start with them check out [Functions documentation](/[platform]/build-a-backend/functions/). In addition, more information on available triggers can be found in the [Cognito documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html).

### Custom Auth Flow with Secure Remote Password (SRP)

Cognito User Pool allows to start the custom authentication flow with SRP as the first step. If you would like to use this flow, setup Define Auth Lambda trigger to handle SRP_A as the first challenge as shown below:

```javascript
exports.handler = (event, context) =>  else if (event.request.session.length == 2 &&
      event.request.session[1].challengeName == 'PASSWORD_VERIFIER' &&
      event.request.session[1].challengeResult == true)  else if (event.request.session.length == 3 &&
      event.request.session[2].challengeName == 'CUSTOM_CHALLENGE' &&
      event.request.session[2].challengeResult == true)  else 
  context.done(null, event);
};
```

If your lambda is setup to start with `SRP` as the first step, make sure to initiate the signIn process with `customWithSRP` as the authentication flow:

```java
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.CUSTOM_AUTH_WITH_SRP)
    .build();
Amplify.Auth.signIn(
    "username",
    "password",
    options,
    result -> Log.i("AuthQuickstart", result.isSignedIn() ? "Sign in succeeded" : "Sign in not complete"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.CUSTOM_AUTH_WITH_SRP)
    .build()
Amplify.Auth.signIn(
    "username", 
    "password", 
    options,
     else 
    },
    
)
```

</Block>

```kotlin
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.CUSTOM_AUTH_WITH_SRP)
    .build()
try  else 
} catch (error: AuthException) 
```

</Block>

```java
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.CUSTOM_AUTH_WITH_SRP)
    .build();
RxAmplify.Auth.signIn("username", "password", options)
    .subscribe(
        result -> Log.i("AuthQuickstart", result.isSignedIn() ? "Sign in succeeded" : "Sign in not complete"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

The Auth category can be configured to perform a [custom authentication flow](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html) defined by you. The following guide shows how to setup a simple passwordless authentication flow.

## Prerequisites

Amplify requires a minimum target platform for iOS (13.0), Android (API level 24), and macOS (10.15). Refer to [Flutter's supported deployment platforms](https://docs.flutter.dev/reference/supported-platforms) when targeting Web, Windows, or Linux. Additional setup is required for some target platforms. Please see the [platform setup](/[platform]/build-a-backend/auth/connect-your-frontend/sign-in/#platform-setup) for more details on platform specific setup.

## Configure Auth

The custom auth flow can be [configured manually](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).

## Register a user

The flow as mentioned above requires a username and a valid email id as parameters to register a user. Invoke the following api to initiate a sign up flow.

Because authentication flows in Cognito can be switched via your configuration, it is still required that users register with a password.

```dart
Future<void> signUpCustomFlow() async ;
    final result = await Amplify.Auth.signUp(
      username: 'myusername',
      password: 'mysupersecurepassword',
      options: SignUpOptions(userAttributes: userAttributes),
    );
    safePrint('Sign up result: $result');
  } on AuthException catch (e) ');
  }
}
```

The next step in the sign up flow is to confirm the user. A confirmation code will be sent to the email id provided during sign up. Enter the confirmation code received via email in the `confirmSignUp` call.

```dart
Future<void> confirmUser() async  on AuthException catch (e) ');
  }
}
```

## Sign in a user

Implement a UI to get the username from the user. After the user enters the username you can start the sign in flow by calling the following method:

```dart
// Create state variables for the sign in status
var isSignedIn = false;
String? challengeHint;

Future<void> signInCustomFlow(String username) async );
  } on AuthException catch (e) ');
  }
}
```

> **Note**: 

Please note that you will be prevented from successfully calling `signIn` if a
user has already signed in and a valid session is active. You must first call
`signOut` to remove the original session.

## Confirm sign in with custom challenge

To get a custom challenge from the user, create an appropriate UI for the user to submit the required value, and pass that value into the `confirmSignin()` API.

```dart
Future<void> confirmSignIn(String generatedNumber) async  on AuthException catch (e) ');
  }
}
```

Once the user provides the correct response, they should be authenticated in your application.

> **Note**: 

<b>Special Handling on ConfirmSignIn</b>

During a `confirmSignIn` call, if `failAuthentication: true` is returned by the Lambda, the session of the request gets invalidated by Cognito, and a `NotAuthorizedException` is thrown. To recover, the user must initiate a new sign in by calling `Amplify.Auth.signIn`.

Exception: `NotAuthorizedException` with a message `Invalid session for the user.`

## Custom authentication flow with password verification

The example in this documentation demonstrates the passwordless custom authentication flow. However, it is also possible to require that users supply a valid password as part of the custom authentication flow.

To require a valid password, you can alter the [DefineAuthChallenge](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-define-auth-challenge.html) code to handle a `PASSWORD_VERIFIER` step:

```js
exports.handler = async (event) =>  else if (
    event.request.session.length === 2 &&
    event.request.session[1].challengeName === 'PASSWORD_VERIFIER' &&
    event.request.session[1].challengeResult === true
  )  else if (
    event.request.session.length === 3 &&
    event.request.session[2].challengeName === 'CUSTOM_CHALLENGE' &&
    event.request.session[2].challengeResult === true
  )  else 

  return event;
};
```

</InlineFilter>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/customize-auth-lifecycle/custom-auth-flows/index.mdx`