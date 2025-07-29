---
title: Using the signIn API
source: pages/build-a-backend/auth/connect-your-frontend/sign-in/index.mdx
---

# Using the signIn API

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

## Using the signIn API

```ts

await signIn()
```

</InlineFilter>

```dart
Future<void> signInUser(String username, String password) async  on AuthException catch (e) ');
  }
}
```

Depending on your configuration and how the user signed up, one or more confirmations will be necessary. Use the `SignInResult` returned from `Amplify.Auth.signIn` to check the next step for signing in. When the value is `done`, the user has successfully signed in.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) . '
    'Please check your $ for the code.',
  );
}
```

</InlineFilter>

```java
Amplify.Auth.signIn(
    "username",
    "password",
    result -> Log.i("AuthQuickstart", result.isSignedIn() ? "Sign in succeeded" : "Sign in not complete"),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.signIn("username", "password",
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
RxAmplify.Auth.signIn("username", "password")
    .subscribe(
        result -> Log.i("AuthQuickstart", result.isSignedIn() ? "Sign in succeeded" : "Sign in not complete"),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
func signIn(username: String, password: String) async 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func signIn(username: String, password: String) -> AnyCancellable .sink 
    }
    receiveValue: 
    }
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

The `signIn` API response will include a `nextStep` property, which can be used to determine if further action is required. It may return the following next steps:

| Next Step | Description |
| --------- | ----------- |
| `CONFIRM_SIGN_IN_WITH_NEW_PASSWORD_REQUIRED` | The user was created with a temporary password and must set a new one. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE` | The sign-in must be confirmed with a custom challenge response. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_TOTP_CODE` | The sign-in must be confirmed with a TOTP code from the user. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_SMS_CODE` | The sign-in must be confirmed with an SMS code from the user. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_EMAIL_CODE` | The sign-in must be confirmed with an EMAIL code from the user. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_PASSWORD` | The sign-in must be confirmed with the password from the user. Complete the process with `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION` | The user must select their mode of first factor authentication. Complete the process by passing the desired mode to the `challengeResponse` field of `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_MFA_SELECTION` | The user must select their mode of MFA verification before signing in. Complete the process with `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_MFA_SETUP_SELECTION` | The user must select their mode of MFA verification to setup. Complete the process by passing either `"EMAIL"` or `"TOTP"` to `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_TOTP_SETUP` | The TOTP setup process must be continued. Complete the process with `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_EMAIL_SETUP` | The EMAIL setup process must be continued. Complete the process by passing a valid email address to `confirmSignIn`. |
| `RESET_PASSWORD` | The user must reset their password via `resetPassword`. |
| `CONFIRM_SIGN_UP` | The user hasn't completed the sign-up flow fully and must be confirmed via `confirmSignUp`. |
| `DONE` | The sign in process has been completed. |
</InlineFilter>

| Next Step | Description |
| --------- | ----------- |
| `CONFIRM_SIGN_IN_WITH_NEW_PASSWORD` | The user was created with a temporary password and must set a new one. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE` | The sign-in must be confirmed with a custom challenge response. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_TOTP_CODE` | The sign-in must be confirmed with a TOTP code from the user. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE` | The sign-in must be confirmed with a SMS code from the user. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_OTP` | The sign-in must be confirmed with a code from the user (sent via SMS or Email). Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_PASSWORD` | The sign-in must be confirmed with the password from the user. Complete the process with `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_MFA_SETUP_SELECTION` | The user must select their mode of MFA verification to setup. Complete the process by passing either `MFAType.EMAIL.challengeResponse` or `MFAType.TOTP.challengeResponse` to `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_MFA_SELECTION` | The user must select their mode of MFA verification before signing in. Complete the process with `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_TOTP_SETUP` | The TOTP setup process must be continued. Complete the process with `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_EMAIL_MFA_SETUP` | The EMAIL setup process must be continued. Complete the process by passing a valid email address to `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION` | The user must select their mode of first factor authentication. Complete the process by passing the desired mode to the `challengeResponse` field of `confirmSignIn`. |
| `RESET_PASSWORD` | The user must reset their password via `resetPassword`. |
| `CONFIRM_SIGN_UP` | The user hasn't completed the sign-up flow fully and must be confirmed via `confirmSignUp`. |
| `DONE` | The sign in process has been completed. |
</InlineFilter>

| Next Step | Description |
| --------- | ----------- |
| `confirmSignInWithNewPassword` | The user was created with a temporary password and must set a new one. Complete the process with `confirmSignIn`. |
| `confirmSignInWithCustomChallenge` | The sign-in must be confirmed with a custom challenge response. Complete the process with `confirmSignIn`. |
| `confirmSignInWithTOTPCode` | The sign-in must be confirmed with a TOTP code from the user. Complete the process with `confirmSignIn`. |
| `confirmSignInWithSMSMFACode` | The sign-in must be confirmed with a SMS code from the user. Complete the process with `confirmSignIn`. |
| `confirmSignInWithOTP` | The sign-in must be confirmed with a code from the user (sent via SMS or Email). Complete the process with `confirmSignIn`. |
| `confirmSignInWithPassword` | The user must set a new password. Complete the process with `confirmSignIn`. |
| `continueSignInWithFirstFactorSelection` | The user must select their preferred mode of First Factor authentication. Complete the process with `confirmSignIn`. |
| `continueSignInWithMFASelection` | The user must select their mode of MFA verification before signing in. Complete the process with `confirmSignIn`. |
| `continueSignInWithMFASetupSelection` | The user must select their mode of MFA verification to setup. Complete the process by passing either `MFAType.email.challengeResponse` or `MFAType.totp.challengeResponse ` to `confirmSignIn`. |
| `continueSignInWithTOTPSetup` | The TOTP setup process must be continued. Complete the process with `confirmSignIn`. |
| `continueSignInWithEmailMFASetup` | The EMAIL setup process must be continued. Complete the process by passing a valid email address to `confirmSignIn`. |
| `resetPassword` | The user must reset their password via `resetPassword`. |
| `confirmSignUp` | The user hasn't completed the sign-up flow fully and must be confirmed via `confirmSignUp`. |
| `done` | The sign in process has been completed. |
</InlineFilter>

| Next Step | Description |
| --------- | ----------- |
| `confirmSignInWithNewPassword` | The user was created with a temporary password and must set a new one. Complete the process with `confirmSignIn`. |
| `confirmSignInWithCustomChallenge` | The sign-in must be confirmed with a custom challenge response. Complete the process with `confirmSignIn`. |
| `confirmSignInWithTotpMfaCode` | The sign-in must be confirmed with a TOTP code from the user. Complete the process with `confirmSignIn`. |
| `confirmSignInWithSmsMfaCode` | The sign-in must be confirmed with a SMS code from the user. Complete the process with `confirmSignIn`. |
| `confirmSignInWithOtpCode` | The sign-in must be confirmed with a code from the user (sent via SMS or Email). Complete the process with `confirmSignIn`. |
| `continueSignInWithMfaSelection` | The user must select their mode of MFA verification before signing in. Complete the process with `confirmSignIn`. |
| `continueSignInWithMfaSetupSelection` | The user must select their mode of MFA verification to setup. Complete the process by passing either `"EMAIL"` or `"TOTP"` to `confirmSignIn`. |
| `continueSignInWithTotpSetup` | The TOTP setup process must be continued. Complete the process with `confirmSignIn`. |
| `continueSignInWithEmailMfaSetup` | The EMAIL setup process must be continued. Complete the process by passing a valid email address to `confirmSignIn`. |
| `resetPassword` | The user must reset their password via `resetPassword`. |
| `confirmSignUp` | The user hasn't completed the sign-up flow fully and must be confirmed via `confirmSignUp`. |
| `done` | The sign in process has been completed. |
</InlineFilter>

For more information on handling the MFA steps that may be returned, see [multi-factor authentication](/[platform]/build-a-backend/auth/concepts/multi-factor-authentication/).

</InlineFilter>

```swift
func confirmSignIn() async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func confirmSignIn() -> AnyCancellable .sink 
        }
        receiveValue: 
}
```

</Block>
</BlockSwitcher>
</InlineFilter>

</InlineFilter>

### Practical Example

```tsx title="src/App.tsx"
// highlight-next-line

Amplify.configure(outputs)

interface SignInFormElements extends HTMLFormControlsCollection 

interface SignInForm extends HTMLFormElement 

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

## With multi-factor auth enabled

When you have Email or SMS MFA enabled, Cognito will send messages to your users on your behalf. Email and SMS messages require that your users have email address and phone number attributes respectively. It is recommended to set these attributes as required in your user pool if you wish to use either Email MFA or SMS MFA. When these attributes are required, a user must provide these details before they can complete the sign up process.

If you have set MFA to be required and you have activated more than one authentication factor, Cognito will prompt new users to select an MFA factor they want to use. Users must have a phone number to select SMS and an email address to select email MFA.

If a user doesn't have the necessary attributes defined for any available message based MFA, Cognito will prompt them to set up TOTP.

Visit the [multi-factor authentication documentation](/[platform]/build-a-backend/auth/concepts/multi-factor-authentication/) to learn more about enabling MFA on your backend auth resource.

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

### Confirm sign-in

Following sign in, you will receive a `nextStep` in the sign-in result of one of the following types. Collect the user response and then pass to the `confirmSignIn` API to complete the sign in flow.
| Next Step | Description |
| --------- | ----------- |
| `CONFIRM_SIGN_IN_WITH_TOTP_CODE` | The sign-in must be confirmed with a TOTP code from the user. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_SMS_CODE` | The sign-in must be confirmed with a SMS code from the user. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_EMAIL_CODE` | The sign-in must be confirmed with a EMAIL code from the user. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_PASSWORD` | The sign-in must be confirmed with the password from the user. Complete the process with `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION` | The user must select their mode of first factor authentication. Complete the process by passing the desired mode to the `challengeResponse` field of `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_MFA_SELECTION` | The user must select their mode of MFA verification before signing in. Complete the process with `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_MFA_SETUP_SELECTION` | The user must select their mode of MFA verification to setup. Complete the process by passing either `"EMAIL"` or `"TOTP"` to `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_TOTP_SETUP` | The TOTP setup process must be continued. Complete the process with `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_EMAIL_SETUP` | The EMAIL setup process must be continued. Complete the process by passing a valid email address to `confirmSignIn`. |
</InlineFilter>

Following sign in, you will receive a `nextStep` in the sign-in result of one of the following types. Collect the user response and then pass to the `confirmSignIn` API to complete the sign in flow.
| Next Step | Description |
| --------- | ----------- |
| `CONFIRM_SIGN_IN_WITH_TOTP_CODE` | The sign-in must be confirmed with a TOTP code from the user. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE` | The sign-in must be confirmed with a SMS code from the user. Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_OTP` | The sign-in must be confirmed with a code from the user (sent via SMS or Email). Complete the process with `confirmSignIn`. |
| `CONFIRM_SIGN_IN_WITH_PASSWORD` | The sign-in must be confirmed with the password from the user. Complete the process with `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION` | The user must select their mode of first factor authentication. Complete the process by passing the desired mode to the `challengeResponse` field of `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_MFA_SELECTION` | The user must select their mode of MFA verification before signing in. Complete the process with `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_MFA_SETUP_SELECTION` | The user must select their mode of MFA verification to setup. Complete the process by passing either `MFAType.EMAIL.challengeResponse` or `MFAType.TOTP.challengeResponse` to `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_TOTP_SETUP` | The TOTP setup process must be continued. Complete the process with `confirmSignIn`. |
| `CONTINUE_SIGN_IN_WITH_EMAIL_MFA_SETUP` | The EMAIL setup process must be continued. Complete the process by passing a valid email address to `confirmSignIn`. |
</InlineFilter>

Following sign in, you will receive a `nextStep` in the sign-in result of one of the following types. Collect the user response and then pass to the `confirmSignIn` API to complete the sign in flow.
| Next Step | Description |
| --------- | ----------- |
| `confirmSignInWithTOTPCode` | The sign-in must be confirmed with a TOTP code from the user. Complete the process with `confirmSignIn`. |
| `confirmSignInWithSMSMFACode` | The sign-in must be confirmed with a SMS code from the user. Complete the process with `confirmSignIn`. |
| `confirmSignInWithOTP` | The sign-in must be confirmed with a code from the user (sent via SMS or Email). Complete the process with `confirmSignIn`. |
| `confirmSignInWithPassword` | The user must set a new password. Complete the process with `confirmSignIn`. |
| `continueSignInWithFirstFactorSelection` | The user must select their preferred mode of First Factor authentication. Complete the process with `confirmSignIn`. |
| `continueSignInWithMFASelection` | The user must select their mode of MFA verification before signing in. Complete the process with `confirmSignIn`. |
| `continueSignInWithMFASetupSelection` | The user must select their mode of MFA verification to setup. Complete the process by passing either `MFAType.email.challengeResponse` or `MFAType.totp.challengeResponse ` to `confirmSignIn`. |
| `continueSignInWithTOTPSetup` | The TOTP setup process must be continued. Complete the process with `confirmSignIn`. |
| `continueSignInWithEmailMFASetup` | The EMAIL setup process must be continued. Complete the process by passing a valid email address to `confirmSignIn`. |
</InlineFilter>

Following sign in, you will receive a `nextStep` in the sign-in result of one of the following types. Collect the user response and then pass to the `confirmSignIn` API to complete the sign in flow.
| Next Step | Description |
| --------- | ----------- |
| `confirmSignInWithTotpMfaCode` | The sign-in must be confirmed with a TOTP code from the user. Complete the process with `confirmSignIn`. |
| `confirmSignInWithSmsMfaCode` | The sign-in must be confirmed with a SMS code from the user. Complete the process with `confirmSignIn`. |
| `confirmSignInWithOtpCode` | The sign-in must be confirmed with a code from the user (sent via SMS or Email). Complete the process with `confirmSignIn`. |
| `continueSignInWithMfaSelection` | The user must select their mode of MFA verification before signing in. Complete the process with `confirmSignIn`. |
| `continueSignInWithMfaSetupSelection` | The user must select their mode of MFA verification to setup. Complete the process by passing either `MfaType.email.confirmationValue` or `MfaType.totp.confirmationValue` to `confirmSignIn`. |
| `continueSignInWithTotpSetup` | The TOTP setup process must be continued. Complete the process with `confirmSignIn`. |
| `continueSignInWithEmailMfaSetup` | The EMAIL setup process must be continued. Complete the process by passing a valid email address to `confirmSignIn`. |
</InlineFilter>

> **Note**: 

**Note:** you must call `confirmSignIn` in the same app session as you call `signIn`. If you close the app, you will need to call `signIn` again. As a result, for testing purposes, you'll at least need an input field where you can enter the code sent via SMS and pass it to `confirmSignIn`.

</InlineFilter>

```ts title="src/main.ts"

const  = await signIn();

if (
  nextStep.signInStep === "CONFIRM_SIGN_IN_WITH_SMS_CODE" ||
  nextStep.signInStep === "CONFIRM_SIGN_IN_WITH_EMAIL_CODE" ||
  nextStep.signInStep === "CONFIRM_SIGN_IN_WITH_TOTP_CODE"
) );
}

if (nextStep.signInStep === "CONTINUE_SIGN_IN_WITH_MFA_SELECTION") );
}

if (nextStep.signInStep === "CONTINUE_SIGN_IN_WITH_MFA_SETUP_SELECTION") );
}

if (nextStep.signInStep === "CONTINUE_SIGN_IN_WITH_EMAIL_SETUP") );
}

if (nextStep.signInStep === "CONTINUE_SIGN_IN_WITH_TOTP_SETUP") );
}

```
> **Note**: 

**Note:** The Amplify authentication flow will persist relevant session data throughout the lifespan of a page session. This enables the `confirmSignIn` API to be leveraged even after a full page refresh in a multi-page application, such as when redirecting from a login page to a sign in confirmation page.

</InlineFilter>

```java
Amplify.Auth.confirmSignIn(
    "confirmation code received via SMS",
    result -> Log.i("AuthQuickstart", result.toString()),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.confirmSignIn("code received via SMS",
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.confirmSignIn("confirmation code received via SMS")
    .subscribe(
        result -> Log.i("AuthQuickstart", result.toString()),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
func confirmSignIn() async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func confirmSignIn() -> AnyCancellable .sink 
        }
        receiveValue: 
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

## Sign in with an external identity provider

To sign in using an external identity provider such as Google, use the `signInWithRedirect` function.

> **Note**: 

For guidance on configuring an external Identity Provider with Amplify see [External Identity Providers](/[platform]/build-a-backend/auth/concepts/external-identity-providers/)

```ts

signInWithRedirect()
```

> **Note**: 

**Note:** if you do not pass an argument to `signInWithRedirect` it will redirect your users to the [Cognito Hosted UI](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-app-integration.html), which has limited support for customization.

Alternatively if you have configured OIDC or SAML-based identity providers in your auth resource, you can specify a "custom" provider in `signInWithRedirect`:

```ts

signInWithRedirect(})
```

## Auto sign-in

The `autoSignIn` API will automatically sign-in a user when it was previously enabled by the `signUp` API and after any of the following cases has completed:

- User confirmed their account with a verification code sent to their phone or email (default option).
- User confirmed their account with a verification link sent to their phone or email. In order to enable this option you need to go to the [Amazon Cognito console](https://aws.amazon.com/pm/cognito), look for your userpool, then go to the `Messaging` tab and enable `link` mode inside the `Verification message` option. Finally you need to define the `signUpVerificationMethod` to `link` inside the `Cognito` option of your `Auth` config.

```ts title="src/main.ts"

await autoSignIn();
```
> **Note**: 
**Note**: When MFA is enabled, your users may be presented with multiple consecutive steps that require them to enter an OTP to proceed with the sign up and subsequent sign in flow. This requirement is not present when using the `USER_AUTH` flow.

</InlineFilter>

### Install native module

`signInWithRedirect` displays the sign-in UI inside a platform-dependent webview. On iOS devices, an [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession) will be launched and, on Android, a [Custom Tab](https://developer.chrome.com/docs/android/custom-tabs/). After the sign-in process is complete, the sign-in UI will redirect back to your app.

To enable this capability, an additional dependency must be installed.

```bash title="Terminal" showLineNumbers=
npm add @aws-amplify/rtn-web-browser
```

### Platform Setup

On iOS, there are no additional setup steps.

#### Android

After a successful sign-in, the sign-in UI will attempt to redirect back to your application. To register the redirect URI scheme you configured above with the device, an `intent-filter` must be added to your application's `AndroidManifest.xml` file which should be located in your React Native app's `android/app/src/main` directory.

Add the `intent-filter` to your application's main activity, replacing `myapp` with your redirect URI scheme as necessary.

```xml title="android/app/src/main/AndroidManifest.xml"
<application ...>
    <activity android:name=".MainActivity" ...>
        ...
        <intent-filter>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
            <data android:scheme="myapp" />
        </intent-filter>
        ...
    </activity>
</application>
```

</InlineFilter>

To sign in using an external identity provider such as Google, use the `signInWithWebUI` function.

### How It Works

Sign-in with web UI will display the sign-in UI inside a webview. After the sign-in process is complete, the sign-in UI will redirect back to your app.

### Platform Setup

#### Web

To use Hosted UI in your Flutter web application locally, you must run the app with the `--web-port=3000` argument (with the value being whichever port you assigned to localhost host when configuring your redirect URIs).

#### Android

Add the following `queries` element to the `AndroidManifest.xml` file in your app's `android/app/src/main` directory, as well as the following `intent-filter` to the `MainActivity` in the same file.

Replace `myapp` with your redirect URI scheme as necessary:

```xml
<queries>
    <intent>
        <action android:name=
            "android.support.customtabs.action.CustomTabsService" />
    </intent>
</queries>
<application>
  ...
  <activity
        android:name=".MainActivity" android:exported="true">
        <intent-filter>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
            <data android:scheme="myapp" />
        </intent-filter>
  </activity>
  ...
</application>
```

#### macOS

Open XCode and enable the App Sandbox capability and then select "Incoming Connections (Server)" under "Network".

![Incoming Connections setting selected in the App Sandbox section of the runner signing and capabilities tab.](/images/project-setup/flutter/mac/xcode-entitlements.png)

#### iOS, Windows and Linux

No specific platform configuration is required.

### Launch Social Web UI Sign In

You're now ready to launch sign in with your external provider's web UI.

```dart
Future<void> socialSignIn() async  on AuthException catch (e) ');
  }
}
```
</InlineFilter>

To sign in using an external identity provider such as Google, use the `signInWithSocialWebUI` function.

### Update AndroidManifest.xml

Add the following activity and queries tag to your app's `AndroidManifest.xml` file, replacing `myapp` with
your redirect URI prefix if necessary:

```xml
<application ...>
  ...
  <activity
      android:name="com.amplifyframework.auth.cognito.activities.HostedUIRedirectActivity"
      android:exported="true">
      <intent-filter>
          <action android:name="android.intent.action.VIEW" />
          <category android:name="android.intent.category.DEFAULT" />
          <category android:name="android.intent.category.BROWSABLE" />
          <data android:scheme="myapp" />
      </intent-filter>
  </activity>
  ...
</application>
```

### Launch Social Web UI Sign In

Sweet! You're now ready to launch sign in with your social provider's web UI.

For now, just add this method to the `onCreate` method of MainActivity with whatever provider you're using (shown with Facebook below):

```java
// Replace facebook with your chosen auth provider such as google, amazon, or apple
Amplify.Auth.signInWithSocialWebUI(
    AuthProvider.facebook(),
    this,
    result -> Log.i("AuthQuickstart", result.toString()),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
// Replace facebook with your chosen auth provider such as google, amazon, or apple
Amplify.Auth.signInWithSocialWebUI(
    AuthProvider.facebook(),
    this,
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
// Replace facebook with your chosen auth provider such as google, amazon, or apple
RxAmplify.Auth.signInWithSocialWebUI(AuthProvider.facebook(), this)
    .subscribe(
        result -> Log.i("AuthQuickstart", result.toString()),
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

To sign in using an external identity provider such as Google, use the `signInWithWebUI` function.

### Update Info.plist

Sign-in with web UI requires the Amplify plugin to show up the sign-in UI inside a webview. After the sign-in process is complete it will redirect back to your app.
You have to enable this in your app's `Info.plist`. Right click Info.plist and then choose Open As > Source Code. Add the following entry in the URL scheme:

```xml

 <plist version="1.0">

     <dict>
     <!-- YOUR OTHER PLIST ENTRIES HERE -->

     <!-- ADD AN ENTRY TO CFBundleURLTypes for Cognito Auth -->
     <!-- IF YOU DO NOT HAVE CFBundleURLTypes, YOU CAN COPY THE WHOLE BLOCK BELOW -->
     <key>CFBundleURLTypes</key>
     <array>
         <dict>
             <key>CFBundleURLSchemes</key>
             <array>
                 <string>myapp</string>
             </array>
         </dict>
     </array>

     <!-- ... -->
     </dict>
```

When creating a new SwiftUI app using Xcode 13 no longer require configuration files such as the Info.plist. If you are missing this file, click on the project target, under Info, Url Types, and click '+' to add a new URL Type. Add `myapp` to the URL Schemes. You should see the Info.plist file now with the entry for CFBundleURLSchemes.

### Launch Social Web UI Sign In

Invoke the following API with the provider you're using (shown with Facebook below):

```swift
func socialSignInWithWebUI() async 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func socialSignInWithWebUI() -> AnyCancellable .sink 
        }
        receiveValue: 
        }
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

## Sign in with passwordless methods

Your application's users can also sign in using passwordless methods. To learn more, including how to setup the various passwordless authentication flows, visit the [concepts page for passwordless](/[platform]/build-a-backend/auth/concepts/passwordless/).

### SMS OTP

Pass `SMS_OTP` as the `preferredChallenge` when calling the `signIn` API in order to initiate a passwordless authentication flow with SMS OTP.

```ts
const  = await signIn(,
});

if (signInNextStep.signInStep === 'CONFIRM_SIGN_IN_WITH_SMS_CODE')  = await confirmSignIn();

	if (confirmSignInNextStep.signInStep === 'DONE') 
}
```

</InlineFilter>

Pass `SMS_OTP` as the `preferredFirstFactor` when calling the `signIn` API in order to initiate a passwordless authentication flow with SMS OTP.

```java
// Use options to specify the preferred first factor
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.SMS_OTP) // Sign in using SMS OTP
    .build();

// Sign in the user
Amplify.Auth.signIn(
    username,
    null, // no password
    options,
    result -> 
    },
    error -> Log.e("AuthQuickstart", error.toString())
);

// Then pass that OTP into the confirmSignIn API
Amplify.Auth.confirmSignIn(
    "123456",
    result -> ,
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
// Use options to specify the preferred first factor
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.SMS_OTP) // Sign in using SMS OTP
    .build()

// Sign in the user
Amplify.Auth.signIn(
    username,
    null, // no password
    options,
    
    },
    
)

// Then pass that OTP into the confirmSignIn API
Amplify.Auth.confirmSignIn(
    "123456",
    ,
    
)
```

</Block>

```kotlin
// Use options to specify the preferred first factor
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.SMS_OTP) // Sign in using SMS OTP
    .build()

// Sign in the user
val result = Amplify.Auth.signIn(
    username = username,
    password = null,
    options = options
)
if (result.nextStep.signInStep == AuthSignInStep.CONFIRM_SIGN_IN_WITH_OTP) 

// Then pass that OTP into the confirmSignIn API
val confirmResult = Amplify.Auth.confirmSignIn(
    challengeResponse = "123456"
)
// confirmResult.nextStep.signInStep should be "DONE"
```

</Block>

```java
// Use options to specify the preferred first factor
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.SMS_OTP) // Sign in using SMS OTP
    .build();

// Sign in the user
RxAmplify.Auth.signIn(
    username,
    null, // no password
    options
).subscribe(
    result -> 
    },
    error -> Log.e("AuthQuickstart", error.toString())
)

// Then pass that OTP into the confirmSignIn API
RxAmplify.Auth.confirmSignIn("123456")
    .subscribe(
        result -> ,
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

Pass `smsOTP` as the `preferredFirstFactor` when calling the `signIn` API in order to initiate a passwordless authentication flow with SMS OTP.

```swift
// sign in with `smsOTP` as preferred factor
func signIn(username: String) async  catch let error as AuthError  catch 
}

// confirm sign in with the code received
func confirmSignIn() async  catch let error as AuthError  catch 
}

```

</Block>

```swift
// sign in with `smsOTP` as preferred factor
func signIn(username: String) -> AnyCancellable .sink 
    }
    receiveValue: 
}

// confirm sign in with the code received
func confirmSignIn() -> AnyCancellable .sink 
    }
    receiveValue: 
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

### Email OTP

Pass `EMAIL_OTP` as the `preferredChallenge` when calling the `signIn` API in order to initiate a passwordless authentication flow using email OTP.

```ts
const  = await signIn(,
});

if (signInNextStep.signInStep === 'CONFIRM_SIGN_IN_WITH_EMAIL_CODE')  = await confirmSignIn();

	if (confirmSignInNextStep.signInStep === 'DONE') 
}
```

</InlineFilter>

Pass `EMAIL_OTP` as the `preferredFirstFactor` when calling the `signIn` API in order to initiate a passwordless authentication flow with Email OTP.

```java
// Use options to specify the preferred first factor
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.EMAIL_OTP) // Sign in using Email OTP
    .build();

// Sign in the user
Amplify.Auth.signIn(
    username,
    null, // no password
    options,
    result -> 
    },
    error -> Log.e("AuthQuickstart", error.toString())
);

// Then pass that OTP into the confirmSignIn API
Amplify.Auth.confirmSignIn(
    "123456",
    result -> ,
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
// Use options to specify the preferred first factor
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.EMAIL_OTP) // Sign in using Email OTP
    .build()

// Sign in the user
Amplify.Auth.signIn(
    username,
    null, // no password
    options,
    
    },
    
)

// Then pass that OTP into the confirmSignIn API
Amplify.Auth.confirmSignIn(
    "123456",
    ,
    
)
```

</Block>

```kotlin
// Use options to specify the preferred first factor
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.EMAIL_OTP) // Sign in using Email OTP
    .build()

// Sign in the user
val result = Amplify.Auth.signIn(
    username = username,
    password = null,
    options = options
)
if (result.nextStep.signInStep == AuthSignInStep.CONFIRM_SIGN_IN_WITH_OTP) 

// Then pass that OTP into the confirmSignIn API
val confirmResult = Amplify.Auth.confirmSignIn(
    challengeResponse = "123456"
)
// confirmResult.nextStep.signInStep should be "DONE"
```

</Block>

```java
// Use options to specify the preferred first factor
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.EMAIL_OTP) // Sign in using Email OTP
    .build();

// Sign in the user
RxAmplify.Auth.signIn(
    username,
    null, // no password
    options
).subscribe(
    result -> 
    },
    error -> Log.e("AuthQuickstart", error.toString())
)

// Then pass that OTP into the confirmSignIn API
RxAmplify.Auth.confirmSignIn("123456")
    .subscribe(
        result -> ,
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

Pass `emailOTP` as the `preferredFirstFactor` when calling the `signIn` API in order to initiate a passwordless authentication flow with Email OTP.

```swift
// sign in with `emailOTP` as preferred factor
func signIn(username: String) async  catch let error as AuthError  catch 
}

// confirm sign in with the code received
func confirmSignIn() async  catch let error as AuthError  catch 
}

```

</Block>

```swift
// sign in with `emailOTP` as preferred factor
func signIn(username: String) -> AnyCancellable .sink 
    }
    receiveValue: 
}

// confirm sign in with the code received
func confirmSignIn() -> AnyCancellable .sink 
    }
    receiveValue: 
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

### WebAuthn Passkeys

Pass `WEB_AUTHN` as the `preferredChallenge` in order to initiate the passwordless authentication flow using a WebAuthn credential.

```ts
const  = await signIn(,
});

if (signInNextStep.signInStep === 'DONE') 
```

</InlineFilter>

Pass `WEB_AUTHN` as the `preferredFirstFactor` in order to initiate the passwordless authentication flow using a WebAuthn credential. This flow
completes without any additional interaction from your application, so there is only one `Amplify.Auth` call needed for WebAuthn.

> **Note**: 
The user must have previously associated a credential to use this auth factor. To learn more, visit the [manage WebAuthn credentials page](/[platform]/build-a-backend/auth/manage-users/manage-webauthn-credentials/).

> **Note**: 
Amplify requires an `Activity` reference to attach the PassKey UI to your Application's [Task](https://developer.android.com/guide/components/activities/tasks-and-back-stack) when using WebAuthn - if an `Activity` is not supplied then the UI will appear in a separate Task. For this reason, we strongly recommend always passing the `callingActivity` option to both the `signIn` and `confirmSignIn` APIs if your application allows users to sign in with passkeys.

```java
// Use options to specify the preferred first factor
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .callingActivity(callingActivity)
    .preferredFirstFactor(AuthFactorType.WEB_AUTHN) // Sign in using WebAuthn
    .build();

// Sign in the user
Amplify.Auth.signIn(
    username,
    null, // no password
    options,
    result -> Log.i("AuthQuickStart", "Next sign in step: " + result.getNextStep()),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
// Use options to specify the preferred first factor
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .callingActivity(callingActivity)
    .preferredFirstFactor(AuthFactorType.WEB_AUTHN) // Sign in using WebAuthn
    .build()

// Sign in the user
Amplify.Auth.signIn(
    username,
    null, // no password
    options,
    ") },
    
)
```

</Block>

```kotlin
// Use options to specify the preferred first factor
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .callingActivity(callingActivity)
    .preferredFirstFactor(AuthFactorType.WEB_AUTHN) // Sign in using WebAuthn
    .build()

// Sign in the user
val result = Amplify.Auth.signIn(
    username = username,
    password = null,
    options = options
)

// result.nextStep.signInStep should be "DONE" if use granted access to the passkey
// NOTE: `signIn` will throw a UserCancelledException if user dismissed the passkey UI
```

</Block>

```java
// Use options to specify the preferred first factor
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .callingActivity(callingActivity)
    .preferredFirstFactor(AuthFactorType.WEB_AUTHN) // Sign in using WebAuthn
    .build();

// Sign in the user
RxAmplify.Auth.signIn(
    username,
    null, // no password
    options
).subscribe(
    result -> Log.i("AuthQuickStart", "Next sign in step: " + result.getNextStep()),
    error -> Log.e("AuthQuickstart", error.toString())
)
```

</Block>
</BlockSwitcher>

Using WebAuthn sign in may result in a number of possible exception types.

- `UserCancelledException` - If the user declines to authorize access to the passkey in the system UI. You can retry the WebAuthn flow by invoking `confirmSignIn` again, or restart the `signIn` process to select a different `AuthFactorType`.
- `WebAuthnNotEnabledException` - This indicates WebAuthn is not enabled in your user pool.
- `WebAuthnNotSupportedException` - This indicates WebAuthn is not supported on the user's device.
- `WebAuthnRpMismatchException` - This indicates there is a problem with the `assetlinks.json` file deployed to your relying party.
- `WebAuthnFailedException` - This exception is used for other errors that may occur with WebAuthn. Inspect the `cause` to determine the best course of action.

</InlineFilter>

</InlineFilter>

Pass `webAuthn` as the `preferredFirstFactor` in order to initiate the passwordless authentication flow using a WebAuthn credential.

```swift
// sign in with `webAuthn` as preferred factor
func signIn(username: String) async  else 

        let signInResult = try await Amplify.Auth.signIn(
            username: username,
            options: .init(pluginOptions: AWSAuthSignInOptions(
                authFlowType: .userAuth(
                    preferredFirstFactor: authFactorType))))
        print("Sign in succeeded. Next step: \(signInResult.nextStep)")
    } catch let error as AuthError  catch 
}

```

</Block>

```swift
// sign in with `webAuthn` as preferred factor
func signIn(username: String) async  else 

        try await Amplify.Auth.signIn(
            username: username,
            options: .init(pluginOptions: AWSAuthSignInOptions(
                authFlowType: .userAuth(
                    preferredFirstFactor: authFactorType))))
    }.sink 
    }
    receiveValue: 
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

### Password

Pass either `PASSWORD` or `PASSWORD_SRP` as the `preferredChallenge` in order to initiate a traditional password based authentication flow.

```ts
const  = await signIn(,
});

if (confirmSignInNextStep.signInStep === 'DONE') 
```
</InlineFilter>

Pass either `PASSWORD` or `PASSWORD_SRP` as the `preferredFirstFactor` in order to initiate a traditional password based authentication flow.

```java
// Use options to specify the preferred first factor
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.PASSWORD) // Sign in using Password
    .build();

// Sign in the user
Amplify.Auth.signIn(
    username,
    password, // supply the password if preferredFirstFactor is PASSWORD or PASSWORD_SRP
    options,
    result -> Log.i("AuthQuickStart", "Next sign in step: " + result.getNextStep()),
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
// Use options to specify the preferred first factor
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.PASSWORD) // Sign in using Password
    .build()

// Sign in the user
Amplify.Auth.signIn(
    username,
    password, // supply the password if preferredFirstFactor is PASSWORD or PASSWORD_SRP
    options,
    ") },
    
)
```

</Block>

```kotlin
// Use options to specify the preferred first factor
val options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.PASSWORD) // Sign in using Password
    .build()

// Sign in the user
val result = Amplify.Auth.signIn(
    username = username,
    password = password, // supply the password if preferredFirstFactor is PASSWORD or PASSWORD_SRP
    options = options
)

// result.nextStep.signInStep should be "DONE"
```

</Block>

```java
// Use options to specify the preferred first factor
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .preferredFirstFactor(AuthFactorType.Password) // Sign in using Password
    .build();

// Sign in the user
RxAmplify.Auth.signIn(
    username,
    password, // supply the password if preferredFirstFactor is PASSWORD or PASSWORD_SRP
    options
).subscribe(
    result -> Log.i("AuthQuickStart", "Next sign in step: " + result.getNextStep()),
    error -> Log.e("AuthQuickstart", error.toString())
)
```

</Block>
</BlockSwitcher>

</InlineFilter>

Pass either `password` or `passwordSRP` as the `preferredFirstFactor` in order to initiate a traditional password based authentication flow.

```swift
// sign in with `password` as preferred factor
func signIn(username: String) async  catch let error as AuthError  catch 
}

```

</Block>

```swift
// sign in with `password` as preferred factor
func signIn(username: String) async .sink 
    }
    receiveValue: 
}
```
</Block>
</BlockSwitcher>

</InlineFilter>

### First Factor Selection

Omit the `preferredChallenge` parameter to discover which first factors are available for a given user. This is useful to allow
users to choose how they would like to sign in.

The `confirmSignIn` API can then be used to select a challenge and initiate the associated authentication flow.

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
</InlineFilter>

Omit the `preferredFirstFactor` option to discover which first factors are available for a given user. This is useful to allow
users to choose how they would like to sign in.

The `confirmSignIn` API can then be used to select a challenge and initiate the associated authentication flow.

```java
// Omit preferredFirstFactor. If the user has more than one factor available then
// the next step will be CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION.
AuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
                                .authFlowType(AuthFlowType.USER_AUTH)
                                .build();

// Step 1: Sign in the user
Amplify.Auth.signIn(
    "hello@example.com",
    null,
    options,
    result -> 
    },
    error -> Log.e("AuthQuickstart", error.toString())
);

// Step 2: Select SMS OTP for sign in
Amplify.Auth.confirmSignIn(
    AuthFactorType.SMS_OTP.getChallengeResponse(),
    result -> 
    },
    error -> Log.e("AuthQuickstart", error.toString())
);

// Step 3: Then pass that OTP into the confirmSignIn API
Amplify.Auth.confirmSignIn(
    "123456",
    result -> ,
    error -> Log.e("AuthQuickstart", error.toString())
);
```

</Block>

```kotlin
// Omit preferredFirstFactor. If the user has more than one factor available then
// the next step will be CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION.
val options: AuthSignInOptions = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .build()

// Step 1: Sign in the user
Amplify.Auth.signIn(
    "hello@example.com",
    null,
    options,
    "
            )
        }
    },
    
)

// Step 2: Select SMS OTP for sign in
Amplify.Auth.confirmSignIn(
    AuthFactorType.SMS_OTP.getChallengeResponse(),
    "
            )
            // Show UI to collect OTP
        }
    },
    
)

// Step 3: Then pass that OTP into the confirmSignIn API
Amplify.Auth.confirmSignIn(
    "123456",
    ,
    
)
```

</Block>

```kotlin
// Omit preferredFirstFactor. If the user has more than one factor available then
// the next step will be CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION.
val options: AuthSignInOptions = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .build()

// Step 1: Sign in the user
val result = Amplify.Auth.signIn(
    username = "hello@example.com",
    password = null,
    options = options
)

if (result.nextStep.signInStep == AuthSignInStep.CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION) "
    )
}

// Step 2: Select SMS OTP for sign in
val selectFactorResult = Amplify.Auth.confirmSignIn(challengeResponse = AuthFactorType.SMS_OTP.challengeResponse)

if (result.nextStep.signInStep == AuthSignInStep.CONFIRM_SIGN_IN_WITH_OTP) "
    )
    // Show UI to collect OTP
}

// Step 3: Then pass that OTP into the confirmSignIn API
val confirmResult = Amplify.Auth.confirmSignIn(challengeResponse = "123456")

// confirmResult.nextStep.signInStep should be "DONE" now
```

</Block>

```java
// Omit preferredFirstFactor. If the user has more than one factor available then
// the next step will be CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION.
AWSCognitoAuthSignInOptions options = AWSCognitoAuthSignInOptions.builder()
    .authFlowType(AuthFlowType.USER_AUTH)
    .build();

// Step 1: Sign in the user
RxAmplify.Auth.signIn(
    username,
    null, // no password
    options
).subscribe(
    result -> 
    },
    error -> Log.e("AuthQuickstart", error.toString())
)

// Step 2: Select SMS OTP for sign in
RxAmplify.Auth.confirmSignIn(AuthFactorType.SMS_OTP.getChallengeResponse())
    .subscribe(
        result -> 
        },
        error -> Log.e("AuthQuickstart", error.toString())
    );

// Step 3: Then pass that OTP into the confirmSignIn API
RxAmplify.Auth.confirmSignIn("123456")
    .subscribe(
        result -> ,
        error -> Log.e("AuthQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

Omit the `preferredFirstFactor` parameter to discover which first factors are available for a given user. This is useful to allow
users to choose how they would like to sign in.

The `confirmSignIn` API can then be used to select a challenge and initiate the associated authentication flow.

```swift
// Step 1: Initiate UserAuth Sign-In
let pluginOptions = AWSAuthSignInOptions(authFlowType: .userAuth)
let signInResult = try await Amplify.Auth.signIn(
    username: "user@example.com",
    options: .init(pluginOptions: pluginOptions)
)

switch signInResult.nextStep 

// Step 2: Select Authentication Factor
let confirmSignInResult = try await Amplify.Auth.confirmSignIn(
    challengeResponse: AuthFactorType.emailOTP.challengeResponse
)

switch confirmSignInResult.nextStep 

// Step 3: Complete Sign-In with OTP Code
let finalSignInResult = try await Amplify.Auth.confirmSignIn(
    challengeResponse: "<code>"
)

if case .done = finalSignInResult.nextStep 
```

</Block>

```swift
func signInWithUserAuth(username: String, getOTP: @escaping () async -> String) -> AnyCancellable  else 
        } else 
    }
    .sink(
        receiveCompletion: 
        },
        receiveValue:  else 
        }
    )
}
```

</Block>
</BlockSwitcher>

</InlineFilter>
