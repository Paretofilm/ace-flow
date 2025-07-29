---
title: Lambda Trigger Setup
source: fragments/lib/auth/android/signin_with_custom_flow/50_custom_challenge.mdx
---

# Lambda Trigger Setup

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

The Amplify CLI can be used to generate triggers required by a custom authentication flow. See the [CLI Documentation](/gen1/[platform]/tools/cli/usage/lambda-triggers/) for details. The CLI will create a custom auth flow skeleton that you can manually edit.

> More information on available triggers can be found in the [Cognito documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).

### Custom Auth Flow with SRP

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

### CAPTCHA-based authentication

Here is the sample for creating a CAPTCHA challenge with a Lambda Trigger.

The `Create Auth Challenge Lambda Trigger` creates a CAPTCHA as a challenge to the user. The URL for the CAPTCHA image and the expected answer are added to the private challenge parameters:

```javascript

This `Define Auth Challenge Lambda Trigger` defines a custom challenge:

```javascript

    return event;
};
```

The `Verify Auth Challenge Response Lambda Trigger` is used to verify a challenge answer:

```javascript

    return event;
};
```
