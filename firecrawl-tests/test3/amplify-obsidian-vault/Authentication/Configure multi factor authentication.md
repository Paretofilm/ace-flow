---
title: Configure multi-factor authentication
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/concepts/multi-factor-authentication/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Configure multi-factor authentication

Amplify Auth supports multi-factor authentication (MFA) for user sign-in flows. MFA is an extra layer of security used to make sure that users trying to gain access to an account are who they say they are. It requires users to provide additional information to verify their identity. Amplify Auth supports MFA with time-based one-time passwords (TOTP), text messages (SMS), and email. 

In this guide we will review how you can set up MFA with each of these methods and the discuss tradeoffs between them to help you choose the right setup for your application. We will also review how to set up MFA to remember a device and reduce sign-in friction for your users.

## Configure multi-factor authentication

Use `defineAuth` to enable MFA for your app. The example below is setting up MFA with TOTP but not SMS as you can see that the phone number is not a required attribute. 
- If you plan to use SMS for MFA, then the `phoneNumber` attribute must be marked as required in your `userAttributes`. Note that if you have `loginWith.phone` as `true` this attribute will automatically be marked as required.
- If you plan to use email for MFA, then the `email` attribute must also be `true` must be marked as required in your `userAttributes`. Note that if you have `loginWith.email` as `true` this attribute will automatically be marked as required.

```ts title="amplify/auth/resource.ts"

> **Note**: 
**Note:** Email-based MFA is currently not supported with `defineAuth`. We are working towards supporting this feature. For more information, visit the [feature request in GitHub](https://github.com/aws-amplify/amplify-backend/issues/2159).

To take advantage of this feature with an Amplify generated backend, the underlying CDK construct can be extended manually. See [overriding Cognito User Pool multi-factor authentication options](/[platform]/build-a-backend/auth/modify-resources-with-cdk/#override-cognito-userpool-multi-factor-authentication-options) for more information.

When MFA is `REQUIRED` with SMS in your backend auth resource, you will need to pass the phone number during sign-up API call. If you are using the `email` or `username` as the primary sign-in mechanism, you will need to pass the `phone_number` attribute as a user attribute. 

Similarly, when MFA is `REQUIRED` with email as your delivery mechanism, you will need to pass an email address during the sign-up API call. If you are using `phoneNumber` or `username` as the primary sign-in mechanism, you will need to pass the `email` attribute as a user attribute. 

This configuration may change depending on the combination of MFA methods enabled in your user pool.

### Understand your MFA options

When enabling MFA you will have two key decisions to make:

- **MFA enforcement:** As part of this setup you will determine how MFA is enforced. If you require MFA by setting MFA mode to `REQUIRED`, all your users will need to complete MFA to sign in. If you keep it `OPTIONAL`, your users will have the choice whether to enable MFA or not for their account.
- **MFA methods:** You will also specify which MFA method you are using: TOTP (Time-based One-time Password), SMS (text message), email, or any combination thereof. We recommend that you use TOTP-based MFA as it is more secure and you can reserve SMS or email for account recovery.

|  | Time-based One-time Password (TOTP) | Short Message Service (SMS) | Email |
| --- | --- | --- | --- |
| **Description** | Generates a short-lived numeric code for user authentication that includes a shared secret key and current time using an authenticator app. | Generates a one-time code shared via text message that is entered with other credentials for user authentication. | Generates a one-time code sent to the user's registered email address. The user must access the email and enter the code to complete the authentication process. |
| **Benefits** | More secure than SMS since the code is generated locally and not transmitted over a network. TOTP also works without cell service as long as the TOTP app is installed. | Easy to set up with a user-provided phone number and is familiar to users as a common authentication method. | Email is a widely used and familiar communication channel that requires no additional hardware or software requirements on the user's end. |
| **Constraints** | Requires an app to generate codes and adds to the initial setup of an account. Codes also expire quickly and must be used promptly after it is generated. | SMS requires cell service and can include an additional cost for the user. Although rare, SMS messages can also be intercepted. | Depends on the availability and reliability of email services. Although rare, emails can be intercepted or accounts can become compromised. |

</Accordion>

If multiple MFA methods are enabled for the user, and none are set as preferred, the `signIn` API will return `CONTINUE_SIGN_IN_WITH_MFA_SELECTION` as the next step in the auth flow. During this scenario, the user should be prompted to select the MFA method they want to use to sign in and their preference should be passed to `confirmSignIn`.

</InlineFilter>

```ts

function handleSignInNextSteps(output: SignInOutput)  = output;
	switch (nextStep.signInStep) 
}

type MfaType = 'SMS' | 'TOTP' | 'EMAIL';

function promptUserForMFAType(allowedMFATypes?: MfaType[]): MfaType 

async function handleMFASelection(mfaType: MfaType) );
		handleSignInNextSteps(output);
	} catch (error) 
}
```
</InlineFilter>

```kotlin
fun signIn(username: String, password: String)  catch (e: AuthException) 
    handleNextSignInStep(username, result.nextStep)
}

fun handleNextSignInStep(
    username: String,
    nextStep: AuthNextSignInStep
) 
        else -> 
    }
}

fun promptUserForMfaType(mfaTypes: Set?) 
```
</InlineFilter>

If multiple MFA methods are enabled for the user, and none are set as preferred, the `signIn` API will return `continueSignInWithMFASelection` as the next step in the auth flow. During this scenario, the user should be prompted to select the MFA method they want to use to sign in and their preference should be passed to `confirmSignIn`.
</InlineFilter>

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

Future _promptUserPreference(Set allowedTypes) async 

Future<void> _handleMfaSelection(MfaType selection) async  on AuthException catch (e) ');
  }
}
```
</InlineFilter>

```swift
func signIn(username: String, password: String) async 
    } catch let error as AuthError catch 
}

func confirmSignInWithTOTPAsMFASelection() async 

    } catch 
}
```
</InlineFilter>

## Multi-factor authentication with SMS

> **Note**: 

If you are using the [Authenticator component](https://ui.docs.amplify.aws/react/connected-components/authenticator) with Amplify, this feature works without any additional code. The guide below is for writing your own implementation.

</InlineFilter>

> **Note**: 

If you are using the [Authenticator component](https://ui.docs.amplify.aws/swift/connected-components/authenticator) with Amplify, this feature works without any additional code. The guide below is for writing your own implementation.

</InlineFilter>

> **Note**: 

If you are using the [Authenticator component](https://ui.docs.amplify.aws/flutter/connected-components/authenticator) with Amplify, this feature works without any additional code. The guide below is for writing your own implementation.

</InlineFilter>

> **Note**: 

If you are using the [Authenticator component](https://ui.docs.amplify.aws/android/connected-components/authenticator) with Amplify, this feature works without any additional code. The guide below is for writing your own implementation.

</InlineFilter>

Once you have setup SMS as your second layer of authentication with MFA as shown above, your users will get an authentication code via a text message to complete sign-in after they sign in with their username and password.

> **Note**: 

**Warning:** In order to send SMS authentication codes, you must [request an origination number](https://docs.aws.amazon.com/pinpoint/latest/userguide/settings-request-number.html). [Learn more about configuring your auth resource for production workloads](/[platform]/build-a-backend/auth/moving-to-production/).

### Enable SMS MFA during sign-up

You will need to pass `phone_number` as a user attribute to enable SMS MFA for your users during sign-up. However, if the primary sign-in mechanism for your Cognito resource is `phone_number` (without enabling `username`), then you do not need to pass it as an attribute.

```ts

await signUp(,
  },
});
```
</InlineFilter>

```dart
Future<void> signUpWithPhoneVerification(
  String username,
  String password,
) async ,
    ),
  );
}
```
</InlineFilter>

```swift
func signUp(username: String, password: String, email: String, phonenumber: String) async  else 
    } catch let error as AuthError  catch 
}
```
</InlineFilter>

By default, you have to verify a user account after they sign up using the `confirmSignUp` API, which will send a one-time password to the user's phone number or email, depending on your Amazon Cognito configuration.

```ts

await confirmSignUp()
```
</InlineFilter>

```dart
Future<void> confirmSignUpPhoneVerification(
  String username,
  String otpCode,
) async 
```
</InlineFilter>

```swift
func confirmSignUp(for username: String, with confirmationCode: String) async  catch let error as AuthError  catch 
}
```
</InlineFilter>

### Manage SMS MFA during sign-in

After a user signs in, if they have MFA enabled for their account, a challenge will be returned that you would need to call the `confirmSignIn` API where the user provides their confirmation code sent to their phone number.

If MFA is **ON** or enabled for the user, you must call `confirmSignIn` with the OTP sent to their phone.

```ts

await confirmSignIn();
```
</InlineFilter>

```dart
Future<void> confirmSignInPhoneVerification(String otpCode) async 
```
</InlineFilter>

```swift
func confirmSignIn() async  catch let error as AuthError  catch 
}
```
</InlineFilter>

After a user has been signed in, call `updateMFAPreference` to record the MFA type as enabled for the user and optionally set it as preferred so that subsequent logins default to using this MFA type.

```ts

await updateMFAPreference();
```
</InlineFilter>

```dart
Future<void> updateMfaPreferences() async 
```
</InlineFilter>

```swift
func updateMFAPreferences() async throws 
```
</InlineFilter>

## Multi-factor authentication with TOTP

> **Note**: 

If you are using the [Authenticator component](https://ui.docs.amplify.aws/react/connected-components/authenticator) with Amplify, this feature works without any additional code. The guide below is for writing your own implementation.

</InlineFilter>

> **Note**: 

If you are using the [Authenticator component](https://ui.docs.amplify.aws/swift/connected-components/authenticator) with Amplify, this feature works without any additional code. The guide below is for writing your own implementation.

</InlineFilter>

> **Note**: 

If you are using the [Authenticator component](https://ui.docs.amplify.aws/flutter/connected-components/authenticator) with Amplify, this feature works without any additional code. The guide below is for writing your own implementation.

</InlineFilter>

> **Note**: 

If you are using the [Authenticator component](https://ui.docs.amplify.aws/android/connected-components/authenticator) with Amplify, this feature works without any additional code. The guide below is for writing your own implementation.

</InlineFilter>

You can use Time-based One-Time Password (TOTP) for multi-factor authentication (MFA) in your web or mobile applications. The Amplify Auth category includes support for TOTP setup and verification using authenticator apps, offering an integrated solution and enhanced security for your users. These apps, such as Google Authenticator, Microsoft Authenticator, have the TOTP algorithm built-in and work by using a shared secret key and the current time to generate short-lived, six digit passwords.

### Set up TOTP for a user

After you initiate a user sign in with the `signIn` API where a user is required to set up TOTP as an MFA method, the API call will return `CONTINUE_SIGN_IN_WITH_TOTP_SETUP` as a challenge and next step to handle in your app. You will get that challenge if the following conditions are met:

- MFA is marked as **Required** in your user pool.
- TOTP is enabled in your user pool.
- User does not have TOTP MFA set up already.

The `CONTINUE_SIGN_IN_WITH_TOTP_SETUP` step signifies that the user must set up TOTP before they can sign in. The step returns an associated value of type `TOTPSetupDetails` which must be used to configure an authenticator app like Microsoft Authenticator or Google Authenticator. `TOTPSetupDetails` provides a helper method called `getSetupURI` which generates a URI that can be used, for example, in a button to open the user's installed authenticator app. For more advanced use cases, `TOTPSetupDetails` also contains a `sharedSecret` which can be used to either generate a QR code or be manually entered into an authenticator app.

Once the authenticator app is set up, the user can generate a TOTP code and provide it to the library to complete the sign in process.

```ts

const output = await signIn();

const  = output;
switch (nextStep.signInStep) 
```
</InlineFilter>

After you initiate a user sign in with the `signIn` API where a user is required to set up TOTP as an MFA method, the API call will return `continueSignInWithTOTPSetup` as a challenge and next step to handle in your app. You will get that challenge if the following conditions are met:

- MFA is marked as **Required** in your user pool.
- TOTP is enabled in your user pool.
- User does not have TOTP MFA set up already.

The `continueSignInWithTOTPSetup` step signifies that the user must set up TOTP before they can sign in. The step returns an associated value of type `TOTPSetupDetails` which must be used to configure an authenticator app like Microsoft Authenticator or Google Authenticator. `TOTPSetupDetails` provides a helper method called `getSetupURI` which generates a URI that can be used, for example, in a button to open the user's installed authenticator app. For more advanced use cases, `TOTPSetupDetails` also contains a `sharedSecret` which can be used to either generate a QR code or be manually entered into an authenticator app.

Once the authenticator app is set up, the user can generate a TOTP code and provide it to the library to complete the sign in process.
</InlineFilter>

```dart
Future<void> signInUser(String username, String password) async  on AuthException catch (e) ');
  }
}

Future<void> _handleSignInResult(SignInResult result) async 
}
```
</InlineFilter>

```swift
func signIn(username: String, password: String) async 
    } catch let error as AuthError  catch 
}
```
</InlineFilter>

The TOTP code can be obtained from the user via a text field or any other means. Once the user provides the TOTP code, call `confirmSignIn` with the TOTP code as the `challengeResponse` parameter.

```ts

await confirmSignIn();
```
</InlineFilter>

```dart
Future<void> confirmTotpUser(String totpCode) async  on AuthException catch (e) ');
  }
}
```
</InlineFilter>

```swift
func confirmSignIn() async  catch let error as AuthError  catch 
}
```
</InlineFilter>

After a user has been signed in, call `updateMFAPreference` to record the MFA type as enabled for the user and optionally set it as preferred so that subsequent logins default to using this MFA type.

```ts

await updateMFAPreference();
```
</InlineFilter>

```dart
Future<void> updateMfaPreferences() async 
```
</InlineFilter>

```swift
func updateMFAPreferences() async throws 
```
</InlineFilter>

### Enable TOTP after a user is signed in

TOTP MFA can be set up after a user has signed in. This can be done when the following conditions are met:

- MFA is marked as **Optional** or **Required** in your user pool.
- TOTP is marked as an enabled MFA method in your user pool.

TOTP can be set up by calling the `setUpTOTP` and `verifyTOTPSetup` APIs in the `Auth` category.

Invoke the `setUpTOTP` API to generate a `TOTPSetupDetails` object which should be used to configure an Authenticator app like Microsoft Authenticator or Google Authenticator. `TOTPSetupDetails` provides a helper method called `getSetupURI` which generates a URI that can be used, for example, in a button to open the user's installed Authenticator app. For more advanced use cases, `TOTPSetupDetails` also contains a `sharedSecret` which can be used to either generate a QR code or be manually entered into an Authenticator app.

that contains the `sharedSecret` which will be used to either to generate a QR code or can be manually entered into an Authenticator app.

```ts

const totpSetupDetails = await setUpTOTP();
const appName = 'my_app_name';
const setupUri = totpSetupDetails.getSetupUri(appName);
// Open setupUri with an authenticator APP to retrieve an OTP code
```
</InlineFilter>

```dart
Future<void> setUpTotp() async  on AuthException catch (e) 
}
```
</InlineFilter>

```swift
func setUpTOTP() async  catch 
}
```
</InlineFilter>

Once the Authenticator app is set up, the user must generate a TOTP code and provide it to the library. Pass the code to `verifyTOTPSetup` to complete the TOTP setup process.

```ts

await verifyTOTPSetup();
```
</InlineFilter>

```dart
Future<void> verifyTotpSetup(String totpCode) async  on AuthException catch (e) 
}
```
</InlineFilter>

```swift
func verifyTOTPSetup(totpCodeFromAuthenticatorApp: String) async  catch 
}
```
</InlineFilter>

After TOTP setup is complete, call `updateMFAPreference` to record the MFA type as enabled for the user and optionally set it as preferred so that subsequent logins default to using this MFA type.

```ts

await updateMFAPreference();
```
</InlineFilter>

```dart
Future<void> updateMfaPreferences() async 
```
</InlineFilter>

```swift
func updateMFAPreferences() async throws 
```
</InlineFilter>

### Recover from a lost TOTP device

> **Note**: 

If a user loses access to their TOTP device, they will need to contact an administrator to get help accessing their account. Based on the Cognito user pool configuration, the administrator can use the [AdminSetUserMFAPreference](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminSetUserMFAPreference.html) to either change the MFA preference to a different MFA method or to disable MFA for the user.

In a scenario where MFA is marked as "Required" in the Cognito User Pool and another MFA method is not set up, the administrator would need to first initiate an [`AdminUpdateUserAttributes`](https://docs.aws.amazon.com/cognito-user-identity-pools/latest/APIReference/API_AdminUpdateUserAttributes.html) call and update the user's phone number attribute. Once this is complete, the administrator can continue changing the MFA preference to SMS as suggested above.

## Multi-factor authentication with EMAIL

> **Note**: 
**Note:** Email-based MFA is currently not supported in the [Authenticator component](https://ui.docs.amplify.aws/react/connected-components/authenticator). We are working towards supporting this feature. For more information, visit the [feature request in GitHub](https://github.com/aws-amplify/amplify-ui/issues/5983).

</InlineFilter>

> **Note**: 

If you are using the [Authenticator component](https://ui.docs.amplify.aws/swift/connected-components/authenticator) with Amplify, this feature works without any additional code. The guide below is for writing your own implementation.

</InlineFilter>

> **Note**: 

If you are using the [Authenticator component](https://ui.docs.amplify.aws/flutter/connected-components/authenticator) with Amplify, this feature works without any additional code. The guide below is for writing your own implementation.

</InlineFilter>

> **Note**: 

If you are using the [Authenticator component](https://ui.docs.amplify.aws/android/connected-components/authenticator) with Amplify, this feature works without any additional code. The guide below is for writing your own implementation.

</InlineFilter>

Once you have setup email as your second layer of authentication with MFA as shown above, your users will get an authentication code via email to complete sign-in after they sign in with their username and password.

> **Note**: 

In order to send email authentication codes, the following prerequisites must be met:
- Cognito must be configured to send emails using [Amazon Simple Email Service (Amazon SES)](/[platform]/build-a-backend/auth/moving-to-production/#email).
- [Advanced Security Features (ASF)](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-advanced-security.html) must be enabled in your user pool.
- If account recovery is enabled in Cognito, the delivery method for recovery messages cannot be set to `Email only`

> **Note**: 
Additional pricing applies for ASF. [Learn more about Amazon Cognito pricing](https://aws.amazon.com/cognito/pricing/)

### Enable EMAIL MFA during sign-up

You will need to pass `email` as a user attribute to enable email MFA for your users during sign-up. However, if the primary sign-in mechanism for your Cognito resource is already `email` (without enabling `username`), then you do not need to pass it as an attribute.

```ts

await signUp(,
  },
});
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

```dart
Future<void> signUpWithEmailVerification(
  String username,
  String password,
) async ,
    ),
  );
}
```
</InlineFilter>

```swift
func signUp(username: String, password: String, email: String, phonenumber: String) async  else 
    } catch let error as AuthError  catch 
}
```
</InlineFilter>

By default, you have to verify a user account after they sign up using the `confirmSignUp` API. Following the initial `signUp` request, a one-time passcode will be sent to the user's phone number or email, depending on your Amazon Cognito configuration.

```ts

await confirmSignUp()
```
</InlineFilter>

```java
 try  catch (Exception error) 
```
</Block>

```kotlin
 try ")
          }
      ) 
} catch (error: Exception) 
```
</Block>

```kotlin
try ")
} catch (error: Exception) 
```
</Block>

```java
RxAmplify.Auth.confirmSignUp(
        "username",
        "confirmation code").subscribe(
        result -> Log.i("AuthQuickstart", "Confirm signUp result completed: " + result.isSignUpComplete()),
        error -> Log.e("AuthQuickstart", "An error occurred while confirming sign up: " + error)
);
```
</Block>

</BlockSwitcher>
</InlineFilter>

```dart
Future<void> confirmSignUpEmailVerification(
  String username,
  String otpCode,
) async 
```
</InlineFilter>

```swift
func confirmSignUp(for username: String, with confirmationCode: String) async  catch let error as AuthError  catch 
}
```
</InlineFilter>

### Manage EMAIL MFA during sign-in

After a user signs in, if they have MFA enabled for their account, a challenge will be issued that requires calling the `confirmSignIn` API with the user provided confirmation code sent to their email address.

If MFA is **ON** or enabled for the user, you must call `confirmSignIn` with the OTP sent to their email address.

```ts

await confirmSignIn();
```
</InlineFilter>

```java
try  else 
            },
            error -> Log.e("AuthQuickstart", "Confirm sign in failed: " + error)
    );
} catch (Exception error) 
```
</Block>

```kotlin
try  else ")
                  // Switch on the next step to take appropriate actions.
                  // If `result.isSignedIn` is true, the next step
                  // is 'done', and the user is now signed in.
              }
          }
    ) 
} catch (error: Exception) 
```
</Block>

```kotlin
try  else "
        )
        // Switch on the next step to take appropriate actions.
        // If `result.isSignedIn` is true, the next step
        // is 'done', and the user is now signed in.
    }
} catch (error: Exception) 
```
</Block>

```java

RxAmplify.Auth.confirmSignIn(
                "confirmation code").subscribe(
                result ->  else 
                },
                error -> Log.e("AuthQuickstart", "Confirm sign in failed: " + error)
        );
```
</Block>

</BlockSwitcher>
</InlineFilter>

```dart
Future<void> confirmSignInEmailVerification(String otpCode) async 
```
</InlineFilter>

```swift
func confirmSignIn() async  catch let error as AuthError  catch 
}
```
</InlineFilter>

After a user has been signed in, call `updateMFAPreference` to record the MFA type as enabled for the user and optionally set it as preferred so that subsequent logins default to using this MFA type.

```ts

await updateMFAPreference();
```
</InlineFilter>

```java
if (Amplify.Auth.getPlugin("awsCognitoAuthPlugin") instanceof AWSCognitoAuthPlugin) 
```

</Block>

```kotlin
if (Amplify.Auth.getPlugin("awsCognitoAuthPlugin") is AWSCognitoAuthPlugin) ,
        
    )
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

```dart
Future<void> updateMfaPreferences() async 
```
</InlineFilter>

```swift
func updateMFAPreferences() async throws 
```
</InlineFilter>

## Set up a user's preferred MFA method

Depending on your user pool configuration, it's possible that multiple MFA options may be available to a given user. In order to avoid requiring your users to select an MFA method each time they sign-in to your application, Amplify provides two utility APIs to manage an individual user's MFA preferences.

### Fetch the current user's MFA preferences

Invoke the following API to get the current MFA preference and enabled MFA types, if any, for the current user.

```ts

const  = await fetchMFAPreference();
```
</InlineFilter>

```java
if (Amplify.Auth.getPlugin("awsCognitoAuthPlugin") instanceof AWSCognitoAuthPlugin) 
```

</Block>

```kotlin
val cognitoAuthPlugin = Amplify.Auth.getPlugin("awsCognitoAuthPlugin") as? AWSCognitoAuthPlugin
cognitoAuthPlugin?.fetchMFAPreference(
    , preferred: $") },
    
)
```

</Block>
</BlockSwitcher>
</InlineFilter>

```dart
Future<void> getCurrentMfaPreference() async ');
  safePrint('Preferred MFA type for user: $');
}
```
</InlineFilter>

```swift
func getMFAPreferences() async throws 
```
</InlineFilter>

### Update the current user's MFA preferences

Invoke the following API to update the MFA preference for the current user.

> **Note**: 

Only one MFA method can be marked as preferred at a time. If the user has multiple MFA methods enabled and tries to mark more than one MFA method as preferred, the API will throw an error.

```ts

await updateMFAPreference();
```
</InlineFilter>

```java
if (Amplify.Auth.getPlugin("awsCognitoAuthPlugin") instanceof AWSCognitoAuthPlugin) 
```

</Block>

```kotlin
val cognitoAuthPlugin = Amplify.Auth.getPlugin("awsCognitoAuthPlugin") as? AWSCognitoAuthPlugin
cognitoAuthPlugin?.updateMFAPreference(
    MFAPreference.DISABLED, // SMS Preference
    MFAPreference.PREFERRED, // TOTP Preference
    null, // Email Preference
    ,
    
)
```

</Block>

</BlockSwitcher>
</InlineFilter>

```dart
Future<void> updateMfaPreferences() async 
```
</InlineFilter>

```swift
func updateMFAPreferences() async throws 
```
</InlineFilter>

## Remember a device

Remembering a device is useful in conjunction with MFA because it allows the second factor requirement to be automatically met when your user signs in on that device and reduces friction in their sign-in experience. By default, this feature is turned off.

> **Note**: 

**Note:** The [device tracking and remembering](https://aws.amazon.com/blogs/mobile/tracking-and-remembering-devices-using-amazon-cognito-your-user-pools/) features are not available if any of the following conditions are met:

- the federated OAuth flow with Cognito User Pools or Hosted UI is used, or
- when the `signIn` API uses the `USER_PASSWORD_AUTH` as the `authFlowType`.

### Configure device tracking

You can configure device tracking with `deviceTracking` construct.

```ts title="amplify/backend.ts"

const backend = defineBackend();

const  = backend.auth.resources.cfnResources;

cfnUserPool.addPropertyOverride('DeviceConfiguration', );
```

There are differences to keep in mind when working with remembered, forgotten, and tracked devices.

- **Tracked:** Every time the user signs in with a new device, the client is given the device key at the end of a successful authentication event. We use this device key to generate a salt and password verifier which is used to call the `ConfirmDevice` API. At this point, the device is considered to be "tracked". Once the device is in a tracked state, you can use the Amazon Cognito console to see the time it started to be tracked, last authentication time, and other information about that device.
- **Remembered:** Remembered devices are also tracked. During user authentication, the device key and secret pair assigned to a remembered device is used to authenticate the device to verify that it is the same device that the user previously used to sign in.
- **Not Remembered:** A not-remembered device is a tracked device where Cognito has been configured to require users to "Opt-in" to remember a device but the user has chosen not to remember the device. This use case is for users signing into their application from a device that they don't own.
- **Forgotten:** In the event that you no longer want to remember or track devices, you can use the `forgetDevice()` API to remove devices from being both remembered and tracked.

</Accordion>

## Next steps

- [Learn how to sign-up with MFA enabled](/[platform]/build-a-backend/auth/connect-your-frontend/sign-in/#with-multi-factor-auth-enabled)
- [Learn how to manage user devices](/[platform]/build-a-backend/auth/manage-users/manage-devices/)


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/concepts/multi-factor-authentication/index.mdx`