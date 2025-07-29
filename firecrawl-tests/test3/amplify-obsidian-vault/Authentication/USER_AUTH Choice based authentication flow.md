---
title: USER_AUTH (Choice-based authentication) flow
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/connect-your-frontend/switching-authentication-flows/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# USER_AUTH (Choice-based authentication) flow

`AWSCognitoAuthPlugin` allows you to switch between different auth flows while initiating signIn. You can configure the flow in the `amplify_outputs.json` file or pass the `authFlowType` as a runtime parameter to the `signIn` api call.

For client side authentication there are four different flows that can be configured during runtime:

1. `userSRP`: The `userSRP` flow uses the [SRP protocol (Secure Remote Password)](https://en.wikipedia.org/wiki/Secure_Remote_Password_protocol) where the password never leaves the client and is unknown to the server. This is the recommended flow and is used by default.

2. `userPassword`: The `userPassword` flow will send user credentials unencrypted to the back-end. If you want to migrate users to Cognito using the "Migration" trigger and avoid forcing users to reset their passwords, you will need to use this authentication type because the Lambda function invoked by the trigger needs to verify the supplied credentials.

3. `customWithSRP`: The `customWithSRP` flow is used to start with SRP authentication and then switch to custom authentication. This is useful if you want to use SRP for the initial authentication and then use custom authentication for subsequent authentication attempts.

4. `customWithoutSRP`: The `customWithoutSRP` flow is used to start authentication flow **WITHOUT** SRP and then use a series of challenge and response cycles that can be customized to meet different requirements.

5. `userAuth`: The `userAuth` flow is a choice-based authentication flow that allows the user to choose from the list of available authentication methods. This flow is useful when you want to provide the user with the option to choose the authentication method. The choices that may be available to the user are `emailOTP`, `smsOTP`, `webAuthn`, `password` or `passwordSRP`.

`Auth` can be configured to use the different flows at runtime by calling `signIn` with `AuthSignInOptions`'s `authFlowType` as `AuthFlowType.userPassword`, `AuthFlowType.customAuthWithoutSrp` or `AuthFlowType.customAuthWithSrp`. If you do not specify the `AuthFlowType` in `AuthSignInOptions`, the default flow (`AuthFlowType.userSRP`) will be used.

> **Note**: 

Runtime configuration will take precedence and will override any auth flow type configuration present in amplify_outputs.json

> For more information about authentication flows, please visit [Amazon Cognito developer documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow.html#amazon-cognito-user-pools-custom-authentication-flow)

## USER_AUTH (Choice-based authentication) flow

A use case for the `USER_AUTH` authentication flow is to provide the user with the option to choose the authentication method. The choices that may be available to the user are `emailOTP`, `smsOTP`, `webAuthn`, `password` or `passwordSRP`.

```swift
let pluginOptions = AWSAuthSignInOptions(
    authFlowType: .userAuth)
let signInResult = try await Amplify.Auth.signIn(
    username: username,
    password: password,
    options: .init(pluginOptions: pluginOptions))
guard case .continueSignInWithFirstFactorSelection(let availableFactors) = signInResult.nextStep else 
print("Available factors: \(availableFactors)")
```

The selection of the authentication method is done by the user. The user can choose from the available factors and proceed with the selected factor. You should call the `confirmSignIn` API with the selected factor to continue the sign-in process. Following is an example if you want to proceed with the `emailOTP` factor selection:

```swift
// Select emailOTP as the factor
var confirmSignInResult = try await Amplify.Auth.confirmSignIn(
    challengeResponse: AuthFactorType.emailOTP.challengeResponse)
```

## USER_PASSWORD_AUTH flow

A use case for the `USER_PASSWORD_AUTH` authentication flow is migrating users into Amazon Cognito

A user migration Lambda trigger helps migrate users from a legacy user management system into your user pool. If you choose the USER_PASSWORD_AUTH authentication flow, users don't have to reset their passwords during user migration. This flow sends your user's password to the service over an encrypted SSL connection during authentication.

When you have migrated all your users, switch flows to the more secure SRP flow. The SRP flow doesn't send any passwords over the network.

```swift
func signIn(username: String, password: String) async throws  catch 
}
```

### Migrate users with Amazon Cognito

Amazon Cognito provides a trigger to migrate users from your existing user directory seamlessly into Cognito. You achieve this by configuring your User Pool's "Migration" trigger which invokes a Lambda function whenever a user that does not already exist in the user pool authenticates, or resets their password.

In short, the Lambda function will validate the user credentials against your existing user directory and return a response object containing the user attributes and status on success. An error message will be returned if an error occurs. There's documentation around [how to set up this migration flow](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-import-using-lambda.html) and more detailed instructions on [how the lambda should handle request and response objects](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-migrate-user.html#cognito-user-pools-lambda-trigger-syntax-user-migration).

## CUSTOM_AUTH flow

Amazon Cognito User Pools supports customizing the authentication flow to enable custom challenge types, in addition to a password in order to verify the identity of users. The custom authentication flow is a series of challenge and response cycles that can be customized to meet different requirements. These challenge types may include CAPTCHAs or dynamic challenge questions.

To define your challenges for custom authentication flow, you need to implement three Lambda triggers for Amazon Cognito.

The flow is initiated by calling `signIn` with `AuthSignInOptions` configured with `AuthFlowType.customAuthWithSrp` OR `AuthFlowType.customAuthWithoutSrp`.

Follow the instructions in [Custom Auth Sign In](/gen1/[platform]/build-a-backend/auth/sign-in-custom-flow/) to learn about how to integrate custom authentication flow in your application with the Auth APIs.

</InlineFilter>

For client side authentication there are four different flows:

1. `USER_SRP_AUTH`: The `USER_SRP_AUTH` flow uses the [SRP protocol (Secure Remote Password)](https://en.wikipedia.org/wiki/Secure_Remote_Password_protocol) where the password never leaves the client and is unknown to the server. This is the recommended flow and is used by default.

2. `USER_PASSWORD_AUTH`: The `USER_PASSWORD_AUTH` flow will send user credentials to the backend without applying SRP encryption. If you want to migrate users to Cognito using the "Migration" trigger and avoid forcing users to reset their passwords, you will need to use this authentication type because the Lambda function invoked by the trigger needs to verify the supplied credentials.

3. `CUSTOM_WITH_SRP` & `CUSTOM_WITHOUT_SRP`: Allows for a series of challenge and response cycles that can be customized to meet different requirements.

4. `USER_AUTH`: The `USER_AUTH` flow is a choice-based authentication flow that allows the user to choose from the list of available authentication methods. This flow is useful when you want to provide the user with the option to choose the authentication method. The choices that may be available to the user are `EMAIL_OTP`, `SMS_OTP`, `WEB_AUTHN`, `PASSWORD` or `PASSWORD_SRP`.

The Auth flow can be customized when calling `signIn`, for example:

```ts title="src/main.ts"
await signIn(
})
```

> For more information about authentication flows, please visit [AWS Cognito developer documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow.html#amazon-cognito-user-pools-custom-authentication-flow)

## USER_AUTH flow

The `USER_AUTH` sign in flow supports the following methods as first factors for authentication: `WEB_AUTHN`, `EMAIL_OTP`, `SMS_OTP`, `PASSWORD`, and `PASSWORD_SRP`.

If the desired first factor is known when authentication is initiated, it can be passed to the `signIn` API as the `preferredChallenge` to initiate the corresponding authentication flow.

```ts
// PASSWORD_SRP / PASSWORD
// sign in with preferred challenge as password
// note password must be provided in same step
const  = await signIn(,
});

// WEB_AUTHN / EMAIL_OTP / SMS_OTP
// sign in with preferred passwordless challenge
// no additional user input required at this step 
const  = await signIn(,
});
```

If the desired first factor is not known or you would like to provide users with the available options, `preferredChallenge` can be omitted from the initial `signIn` API call. 

This allows you to discover which authentication first factors are available for a user via the `CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION` step. You can then present the available options to the user and use the `confirmSignIn` API to respond with the user's selection.

```ts
const  = await signIn(,
});

if (
	signInNextStep.signInStep === 'CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION'
) `);

	// respond with user selection using `confirmSignIn` API
	const  = await confirmSignIn();
}

```
Also, note that if the `preferredChallenge` passed to the initial `signIn` API call is unavailable for the user, Amplify will also respond with the `CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION` next step.

> **Note**: 
For more information about determining a first factor, and signing in with passwordless authentication factors, please visit the [Passwordless](/[platform]/build-a-backend/auth/concepts/passwordless/) concepts page.

## USER_PASSWORD_AUTH flow

A use case for the `USER_PASSWORD_AUTH` authentication flow is migrating users into Amazon Cognito

### Set up auth backend

In order to use the authentication flow `USER_PASSWORD_AUTH`, your Cognito app client has to be configured to allow it. In the AWS Console, this is done by ticking the checkbox at General settings > App clients > Show Details (for the affected client) > Enable username-password (non-SRP) flow. If you're using the AWS CLI or CloudFormation, update your app client by adding `USER_PASSWORD_AUTH` to the list of "Explicit Auth Flows".

### Migrate users with Amazon Cognito

Amazon Cognito provides a trigger to migrate users from your existing user directory seamlessly into Cognito. You achieve this by configuring your User Pool's "Migration" trigger which invokes a Lambda function whenever a user that does not already exist in the user pool authenticates, or resets their password.

In short, the Lambda function will validate the user credentials against your existing user directory and return a response object containing the user attributes and status on success. An error message will be returned if an error occurs. Visit [Amazon Cognito user pools import guide](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-import-using-lambda.html) for migration flow and more detailed instruction, and [Amazon Cognito Lambda trigger guide](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-migrate-user.html#cognito-user-pools-lambda-trigger-syntax-user-migration) on how to set up lambda to handle request and response objects.

## `CUSTOM_WITH_SRP` & `CUSTOM_WITHOUT_SRP` flows

Amazon Cognito user pools supports customizing the authentication flow to enable custom challenge types, 
in addition to a password in order to verify the identity of users. These challenge types may include CAPTCHAs
or dynamic challenge questions. The `CUSTOM_WITH_SRP` flow requires a password when calling `signIn`. Both of 
these flows map to the `CUSTOM_AUTH` flow in Cognito.

> **Note**: 

To define your challenges for custom authentication flow, you need to implement three Lambda triggers for Amazon Cognito. Please visit [AWS Amplify Custom Auth Challenge example](/[platform]/build-a-backend/functions/examples/custom-auth-flows/) for set up instructions. 

> **Note**: 

For more information about working with Lambda Triggers for custom authentication challenges, please visit [Amazon Cognito Developer Documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).

### Custom authentication flow

To initiate a custom authentication flow in your app, call `signIn` without a password. A custom challenge needs to be answered using the `confirmSignIn` API:

```ts title="src/main.ts"

const challengeResponse = 'the answer for the challenge';

const  = await signIn(,
});

if (nextStep.signInStep === 'CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE') );
}
```

### CAPTCHA authentication

To create a CAPTCHA challenge with a Lambda Trigger, please visit [AWS Amplify Google reCAPTCHA challenge example](/[platform]/build-a-backend/functions/examples/google-recaptcha-challenge/) for detailed examples. 

</InlineFilter>

`AWSCognitoAuthPlugin` allows you to switch between different auth flows while initiating signIn. You can configure the flow in the `amplify_outputs.json` file or pass the `authFlowType` as a option to the `signIn` api call.

For client side authentication there are four different flows that can be configured during runtime:

1. `USER_SRP_AUTH`: The `USER_SRP_AUTH` flow uses the [SRP protocol (Secure Remote Password)](https://en.wikipedia.org/wiki/Secure_Remote_Password_protocol) where the password never leaves the client and is unknown to the server. This is the recommended flow and is used by default.

2. `USER_PASSWORD_AUTH`: The `USER_PASSWORD_AUTH` flow will send user credentials unencrypted to the back-end. If you want to migrate users to Cognito using the "Migration" trigger and avoid forcing users to reset their passwords, you will need to use this authentication type because the Lambda function invoked by the trigger needs to verify the supplied credentials.

3. `CUSTOM_AUTH_WITH_SRP`: The `CUSTOM_AUTH_WITH_SRP` flow is used to start with SRP authentication and then switch to custom authentication. This is useful if you want to use SRP for the initial authentication and then use custom authentication for subsequent authentication attempts.

4. `CUSTOM_AUTH_WITHOUT_SRP`: The `CUSTOM_AUTH_WITHOUT_SRP` flow is used to start authentication flow **WITHOUT** SRP and then use a series of challenge and response cycles that can be customized to meet different requirements.

5. `USER_AUTH`: The `USER_AUTH` flow is a choice-based authentication flow that allows the user to choose from the list of available authentication methods. This flow is useful when you want to provide the user with the option to choose the authentication method. The choices that may be available to the user are `EMAIL_OTP`, `SMS_OTP`, `WEB_AUTHN`, `PASSWORD` or `PASSWORD_SRP`.

`Auth` can be configured to use the different flows at runtime by calling `signIn` with `AWSCognitoAuthSignInOptions`'s `authFlowType` as `AuthFlowType.USER_PASSWORD_AUTH`, `AuthFlowType.CUSTOM_AUTH_WITHOUT_SRP`, `AuthFlowType.CUSTOM_AUTH_WITH_SRP`, or `AuthFlowType.USER_AUTH`. If you do not specify the `AuthFlowType` in `AWSCognitoAuthSignInOptions`, the default flow specified in `amplify_outputs.json` will be used.

> **Note**: 

Runtime configuration will take precedence and will override any auth flow type configuration present in `amplify_outputs.json`.

For more information about authentication flows, please visit [Amazon Cognito developer documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow.html#amazon-cognito-user-pools-custom-authentication-flow)

## USER_AUTH (Choice-based authentication) flow

A use case for the `USER_AUTH` authentication flow is to provide the user with the option to choose the authentication method. The choices that may be available to the user are `EMAIL_OTP`, `SMS_OTP`, `WEB_AUTHN`, `PASSWORD` or `PASSWORD_SRP`.

> **Note**: 
Amplify requires an `Activity` reference to attach the PassKey UI to your Application's [Task](https://developer.android.com/guide/components/activities/tasks-and-back-stack) when using WebAuthn - if an `Activity` is not supplied then the UI will appear in a separate Task. For this reason, we strongly recommend passing the `callingActivity` option to both the `signIn` and `confirmSignIn` APIs if your application uses the `USER_AUTH` flow.

If the desired first factor is known before the sign in flow is initiated it can be passed to the initial sign in call.

```java
// PASSWORD_SRP / PASSWORD
// Sign in with preferred challenge as password
// NOTE: Password must be provided in the same step
AuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .callingActivity(activity)
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.PASSWORD_SRP) // or "PASSWORD"
    .build();
Amplify.Auth.signIn(
    username,
    password,
    options,
    result -> Log.i("AuthQuickStart", "Next step for sign in is " + result.getNextStep()),
    error -> Log.e("AuthQuickStart", "Failed to confirm sign in", error)
);

// WEB_AUTHN / EMAIL_OTP / SMS_OTP
// Sign in with preferred passwordless challenge
// No user input is required at this step
AuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .callingActivity(activity)
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.WEB_AUTHN) // or "EMAIL_OTP" or "SMS_OTP"
    .build();
Amplify.Auth.signIn(
    username,
    null,
    options,
    result -> Log.i("AuthQuickStart", "Next step for sign in is " + result.getNextStep()),
    error -> Log.e("AuthQuickStart", "Failed to confirm sign in", error)
);
```

</Block>

```kotlin
// PASSWORD_SRP / PASSWORD
// Sign in with preferred challenge as password
// NOTE: Password must be provided in the same step
val options = AWSCognitoAuthSignInOptions.builder()
    .callingActivity(activity)
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.PASSWORD_SRP) // or "PASSWORD"
    .build()
Amplify.Auth.signIn(
    username,
    password,
    options,
    ") },
    
)

// WEB_AUTHN / EMAIL_OTP / SMS_OTP
// Sign in with preferred passwordless challenge
// No user input is required at this step
val options = AWSCognitoAuthSignInOptions.builder()
    .callingActivity(activity)
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.WEB_AUTHN) // or "EMAIL_OTP" or "SMS_OTP"
    .build()
Amplify.Auth.signIn(
    username,
    null,
    options,
    ") },
    
)
```

</Block>

```kotlin
// PASSWORD_SRP / PASSWORD
// Sign in with preferred challenge as password
// NOTE: Password must be provided in the same step
try ")
} catch (error: AuthException) 

// WEB_AUTHN / EMAIL_OTP / SMS_OTP
// Sign in with preferred passwordless challenge
// No user input is required at this step
try ")
} catch (error: AuthException) 
```

</Block>

```java
// PASSWORD_SRP / PASSWORD
// Sign in with preferred challenge as password
// NOTE: Password must be provided in the same step
AuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .callingActivity(activity)
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.PASSWORD_SRP) // or "PASSWORD"
    .build();
RxAmplify.Auth.signIn(username, password, options)
    .subscribe(
        result -> Log.i("AuthQuickstart", "Next step for sign in is " + result.getNextStep()),
        error -> Log.e("AuthQuickstart", "Failed to confirm sign in", error))
    );

// WEB_AUTHN / EMAIL_OTP / SMS_OTP
// Sign in with preferred passwordless challenge
// No user input is required at this step
AuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .callingActivity(activity)
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.WEB_AUTHN) // or "EMAIL_OTP" or "SMS_OTP"
    .build();
RxAmplify.Auth.signIn(username, null, options)
    .subscribe(
        result -> Log.i("AuthQuickstart", "Next step for sign in is " + result.getNextStep()),
        error -> Log.e("AuthQuickstart", "Failed to confirm sign in", error))
    );
```

</Block>
</BlockSwitcher>

If the preferred first factor is not supplied or is unavailable, and the user has multiple factors available, the flow will continue to select an available first factor by returning an `AuthNextSignInStep.signInStep` value of `CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION`, and a list of `AuthNextSignInStep.availableFactors`.

The selection of the authentication method is done by the user. The user can choose from the available factors and proceed with the selected factor. You should call the `confirmSignIn` API with the selected factor to continue the sign-in process. Following is an example if you want to proceed with the `WEB_AUTHN` factor selection:

```java
AuthConfirmSignInOptions options = AWSCognitoAuthConfirmSignInOptions.builder()
    .callingActivity(activity)
    .build();
Amplify.Auth.confirmSignIn(
    AuthFactorType.WEB_AUTHN.getChallengeResponse(),
    options,
    result -> Log.i("AuthQuickStart", "Next step for sign in is " + result.getNextStep()),
    error -> Log.e("AuthQuickStart", "Failed to confirm sign in", error)
);
```

</Block>

```kotlin
val options = AWSCognitoAuthConfirmSignInOptions.builder()
    .callingActivity(activity)
    .build()
Amplify.Auth.confirmSignIn(
    AuthFactorType.WEB_AUTHN.challengeResponse,
    options,
    ") },
    
)
```

</Block>

```kotlin
try ")
} catch (error: AuthException) 
```

</Block>

```java
AuthConfirmSignInOptions options = AWSCognitoAuthConfirmSignInOptions.builder()
    .callingActivity(activity)
    .build();
RxAmplify.Auth.confirmSignIn(AuthFactorType.WEB_AUTHN.getChallengeResponse(), options)
    .subscribe(
        result -> Log.i("AuthQuickstart", "Next step for sign in is " + result.getNextStep()),
        error -> Log.e("AuthQuickstart", "Failed to confirm sign in", error))
    );
```

</Block>
</BlockSwitcher>

## USER_PASSWORD_AUTH flow

A use case for the `USER_PASSWORD_AUTH` authentication flow is migrating users into Amazon Cognito

A user migration Lambda trigger helps migrate users from a legacy user management system into your user pool. If you choose the USER_PASSWORD_AUTH authentication flow, users don't have to reset their passwords during user migration. This flow sends your user's password to the service over an encrypted SSL connection during authentication.

When you have migrated all your users, switch flows to the more secure SRP flow. The SRP flow doesn't send any passwords over the network.

```java
AuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_PASSWORD_AUTH)
    .build();
Amplify.Auth.signIn(
    "hello@example.com",
    "password",
    options,
    result -> Log.i("AuthQuickStart", "Sign in succeeded with result " + result),
    error -> Log.e("AuthQuickStart", "Failed to sign in", error)
);
```

</Block>

```kotlin
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_PASSWORD_AUTH)
    .build()
Amplify.Auth.signIn(
    "hello@example.com",
    "password",
    options,
    ")
    },
    
)
```

</Block>

```kotlin
try ")
} catch (error: AuthException) 
```

</Block>

```java
AuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_PASSWORD_AUTH)
    .build();
RxAmplify.Auth.signIn("hello@example.com", "password", options)
    .subscribe(
        result -> Log.i("AuthQuickstart", "Next step for sign in is " + result.getNextStep()),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

### Set up auth backend

In order to use the authentication flow `USER_PASSWORD_AUTH`, your Cognito app client has to be configured to allow it. Amplify Gen 2 enables SRP auth by default. To enable USER_PASSWORD_AUTH, you can update the `backend.ts` file with the following changes:

```ts title="amplify/backend.ts"

const backend = defineBackend();

// highlight-start
backend.auth.resources.cfnResources.cfnUserPoolClient.explicitAuthFlows = [
  "ALLOW_USER_PASSWORD_AUTH",
  "ALLOW_USER_SRP_AUTH",
  "ALLOW_USER_AUTH",
  "ALLOW_REFRESH_TOKEN_AUTH"
];
// highlight-end
```

### Migrate users with Amazon Cognito

Amazon Cognito provides a trigger to migrate users from your existing user directory seamlessly into Cognito. You achieve this by configuring your User Pool's "Migration" trigger which invokes a Lambda function whenever a user that does not already exist in the user pool authenticates, or resets their password.

In short, the Lambda function will validate the user credentials against your existing user directory and return a response object containing the user attributes and status on success. An error message will be returned if an error occurs. There's documentation around [how to set up this migration flow](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-import-using-lambda.html) and more detailed instructions on [how the lambda should handle request and response objects](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-migrate-user.html#cognito-user-pools-lambda-trigger-syntax-user-migration).

## CUSTOM_AUTH flow

Amazon Cognito User Pools supports customizing the authentication flow to enable custom challenge types, in addition to a password in order to verify the identity of users. The custom authentication flow is a series of challenge and response cycles that can be customized to meet different requirements. These challenge types may include CAPTCHAs or dynamic challenge questions.

To define your challenges for custom authentication flow, you need to implement three Lambda triggers for Amazon Cognito.

The flow is initiated by calling `signIn` with `AWSCognitoAuthSignInOptions` configured with `AuthFlowType.CUSTOM_AUTH_WITH_SRP` OR `AuthFlowType.CUSTOM_AUTH_WITHOUT_SRP`.

Follow the instructions in [Custom Auth Sign In](/gen1/[platform]/build-a-backend/auth/sign-in-custom-flow/) to learn about how to integrate custom authentication flow in your application with the Auth APIs.

</InlineFilter>

> **Note**: 

For more information about working with Lambda Triggers for custom authentication challenges, please visit [Amazon Cognito Developer Documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/connect-your-frontend/switching-authentication-flows/index.mdx`