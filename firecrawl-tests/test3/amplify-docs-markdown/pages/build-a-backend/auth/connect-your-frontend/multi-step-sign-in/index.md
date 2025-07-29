---
title: Confirm sign-in with SMS MFA
source: pages/build-a-backend/auth/connect-your-frontend/multi-step-sign-in/index.mdx
---

# Confirm sign-in with SMS MFA

After a user has finished signup, they can proceed to sign in. Amplify Auth signin flows can be multi-step processes. The required steps are determined by the configuration provided when you define your auth resources. See the [multi-factor authentication](/[platform]/build-a-backend/auth/concepts/multi-factor-authentication/) page for more information.

Depending on the configuration, you may need to call various APIs to finish authenticating a user's signin attempt. To identify the next step in a signin flow, inspect the `nextStep` parameter of the signin result.

```typescript
import  from 'aws-amplify/auth';

const  = await signIn();

if (
	nextStep.signInStep === 'CONFIRM_SIGN_IN_WITH_SMS_CODE' ||
	nextStep.signInStep === 'CONFIRM_SIGN_IN_WITH_EMAIL_CODE' ||
	nextStep.signInStep === 'CONFIRM_SIGN_IN_WITH_TOTP_CODE'
) );
}

if (nextStep.signInStep === 'CONTINUE_SIGN_IN_WITH_MFA_SELECTION') );
}

if (nextStep.signInStep === 'CONTINUE_SIGN_IN_WITH_MFA_SETUP_SELECTION') );
}

if (nextStep.signInStep === 'CONTINUE_SIGN_IN_WITH_EMAIL_SETUP') );
}

if (nextStep.signInStep === 'CONTINUE_SIGN_IN_WITH_TOTP_SETUP') );
}

if (nextStep.signInStep === 'CONFIRM_SIGN_IN_WITH_PASSWORD') );
}

if (nextStep.signInStep === 'CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION') );
}

if (nextStep.signInStep === 'CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE') );
}

if (nextStep.signInStep === 'CONFIRM_SIGN_IN_WITH_NEW_PASSWORD_REQUIRED') );
}

if (nextStep.signInStep === 'RESET_PASSWORD') );
}

if (nextStep.signInStep === 'CONFIRM_SIGN_UP') );
}

if (nextStep.signInStep === 'DONE') 
```

## Confirm sign-in with SMS MFA

If the next step is `CONFIRM_SIGN_IN_WITH_SMS_CODE`, Amplify Auth has sent the user a random code over SMS and is waiting for the user to verify that code. To handle this step, your app's UI must prompt the user to enter the code. After the user enters the code, pass the value to the `confirmSignIn` API.

> **Note**: 

The result includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery, such as the partial phone number of the SMS recipient, which can be used to prompt the user on where to look for the code.

```ts

async function handleSignInResult(result: SignInOutput)  = result.nextStep;
			// OTP has been delivered to user via SMS
			// Inspect codeDeliveryDetails for additional delivery information
			console.log(
				`A confirmation code has been sent to $`,
			);
			console.log(
				`Please check your $ for the code.`,
			);
			break;
		}
	}
}

async function confirmMfaCode(mfaCode: string) );

	return handleSignInResult(result);
}

```

## Confirm sign-in with TOTP MFA

If the next step is `CONFIRM_SIGN_IN_WITH_TOTP_CODE`, you should prompt the user to enter the TOTP code from their associated authenticator app during set up. The code is a six-digit number that changes every 30 seconds. The user must enter the code before the 30-second window expires.

After the user enters the code, your implementation must pass the value to Amplify Auth `confirmSignIn` API.

```ts

async function handleSignInResult(result: SignInOutput) 
	}
}
// Then, pass the TOTP code to `confirmSignIn`
async function confirmTotpCode(totpCode: string) );

	return handleSignInResult(result);
}

```

## Confirm sign-in with Email MFA

If the next step is `CONFIRM_SIGN_IN_WITH_EMAIL_CODE`, Amplify Auth has sent the user a random code to their email address and is waiting for the user to verify that code. To handle this step, your app's UI must prompt the user to enter the code. After the user enters the code, pass the value to the `confirmSignIn` API.

> **Note**: 

The result includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery, such as the partial email address of the recipient, which can be used to prompt the user on where to look for the code.

```ts

async function handleSignInResult(result: SignInOutput)  = result.nextStep;
			// OTP has been delivered to user via Email
			// Inspect codeDeliveryDetails for additional delivery information
			console.log(
				`A confirmation code has been sent to $`,
			);
			console.log(
				`Please check your $ for the code.`,
			);
			break;
		}
	}
}

async function confirmMfaCode(mfaCode: string) );

	return handleSignInResult(result);
}

```

## Continue sign-in with MFA Selection

If the next step is `CONTINUE_SIGN_IN_WITH_MFA_SELECTION`, the user must select the MFA method to use. Amplify Auth currently supports SMS, TOTP, and EMAIL as MFA methods. After the user selects an MFA method, your implementation must pass the selected MFA method to Amplify Auth using `confirmSignIn` API.

The MFA types which are currently supported by Amplify Auth are:

- `SMS`
- `TOTP`
- `EMAIL`

Once Amplify receives the users selection, you can expect to handle a follow up `nextStep` corresponding with the selected MFA type for setup:
- If `SMS` is selected, `CONFIRM_SIGN_IN_WITH_SMS_CODE` will be the next step.
- If `TOTP` is selected, `CONFIRM_SIGN_IN_WITH_TOTP_CODE` will be the next step.
- If `EMAIL` is selected, `CONFIRM_SIGN_IN_WITH_EMAIL_CODE` will be the next step.

```ts

async function handleSignInResult(result: SignInOutput)  = result.nextStep;
			// Present available MFA options to user
			// Prompt for selection
			console.log(`There are multiple MFA options available for sign in.`);
			console.log(`Select an MFA type from the allowedMfaTypes list.`);
			break;
		}
	}
}

type MfaType = 'SMS' | 'TOTP' | 'EMAIL';

async function handleMfaSelection(mfaType: MfaType) );

	return handleSignInResult(result);
}

```

## Continue sign-in with Email Setup

If the next step is `CONTINUE_SIGN_IN_WITH_EMAIL_SETUP`, then the user must provide an email address to complete the sign in process. Once this value has been collected from the user, call the `confirmSignIn` API to continue.

```ts

async function handleSignInResult(result: SignInOutput) 
	}
}

// Then, pass the email address to `confirmSignIn`
async function confirmEmail(email: string) );

	return handleSignInResult(result);
}

```

## Continue sign-in with TOTP Setup

The `CONTINUE_SIGN_IN_WITH_TOTP_SETUP` step signifies that the user must set up TOTP before they can sign in. The step returns an associated value of type TOTPSetupDetails which must be used to configure an authenticator app like Microsoft Authenticator or Google Authenticator. TOTPSetupDetails provides a helper method called getSetupURI which generates a URI that can be used, for example, in a button to open the user's installed authenticator app. For more advanced use cases, TOTPSetupDetails also contains a sharedSecret which can be used to either generate a QR code or be manually entered into an authenticator app.

Once the authenticator app is set up, the user can generate a TOTP code and provide it to the library to complete the sign in process.

```ts

async function handleSignInResult(result: SignInOutput)  = result.nextStep;
			const appName = 'my_app_name';
			const setupUri = totpSetupDetails.getSetupUri(appName);
			// Open setupUri with an authenticator app
			// Prompt user to enter OTP code to complete setup
			break;
		}
	}
}

// Then, pass the collected OTP code to `confirmSignIn`
async function confirmTotpCode(totpCode: string) );

	return handleSignInResult(result);
}

```

## Continue sign-in with MFA Setup Selection

If the next step is `CONTINUE_SIGN_IN_WITH_MFA_SETUP_SELECTION`, then the user must indicate which of the available MFA methods they would like to setup. After the user selects an MFA method to setup, your implementation must pass the selected MFA method to the `confirmSignIn` API.

The MFA types which are currently supported by Amplify Auth for setup are:

- `TOTP`
- `EMAIL`

Once Amplify receives the users selection, you can expect to handle a follow up `nextStep` corresponding with the selected MFA type for setup:
- If `EMAIL` is selected, `CONTINUE_SIGN_IN_WITH_EMAIL_SETUP` will be the next step.
- If `TOTP` is selected, `CONTINUE_SIGN_IN_WITH_TOTP_SETUP` will be the next step.

```ts

async function handleSignInResult(result: SignInOutput)  = result.nextStep;
			// Present available MFA options to user
			// Prompt for selection
			console.log(`There are multiple MFA options available for setup.`);
			console.log(`Select an MFA type from the allowedMFATypes list.`);
			break;
		}
	}
}

type MfaType = 'SMS' | 'TOTP' | 'EMAIL';

async function handleMfaSelection(mfaType: MfaType) );

	return handleSignInResult(result);
}

```

## Confirm sign-in with Password

If the next step is `CONFIRM_SIGN_IN_WITH_PASSWORD`, the user must provide their password as the first factor authentication method. To handle this step, your implementation should prompt the user to enter their password. After the user enters the password, pass the value to the `confirmSignIn` API.

```ts

async function handleSignInResult(result: SignInOutput) 
    }
}

async function confirmWithPassword(password: string) );

    return handleSignInResult(result);
}
```

## Continue sign-in with First Factor Selection

If the next step is `CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION`, the user must select a first factor method for authentication. After the user selects an option, your implementation should pass the selected method to the `confirmSignIn` API.

The first factor types which are currently supported by Amplify Auth are:
- `SMS_OTP`
- `EMAIL_OTP`
- `WEB_AUTHN`
- `PASSWORD`
- `PASSWORD_SRP`

Depending on your configuration and what factors the user has previously setup, not all options may be available. Only the available options will be presented in `availableChallenges` for selection.

Once Amplify receives the user's selection via the `confirmSignIn` API, you can expect to handle a follow up `nextStep` corresponding with the first factor type selected:
- If `SMS_OTP` is selected, `CONFIRM_SIGN_IN_WITH_SMS_CODE` will be the next step.
- If `EMAIL_OTP` is selected, `CONFIRM_SIGN_IN_WITH_EMAIL_CODE` will be the next step.
- If `PASSWORD` or `PASSWORD_SRP` is selected, `CONFIRM_SIGN_IN_WITH_PASSWORD` will be the next step.
- If `WEB_AUTHN` is selected, Amplify Auth will initiate the authentication ceremony on the user's device. If successful, the next step will be `DONE`.

```ts

async function handleSignInResult(result: SignInOutput)  = result.nextStep;
			// Present available first factor options to user
			// Prompt for selection
			console.log(
				`There are multiple first factor options available for sign in.`,
			);
			console.log(
				`Select a first factor type from the availableChallenges list.`,
			);
			break;
		}
	}
}

async function handleFirstFactorSelection(firstFactorType: string) );

	return handleSignInResult(result);
}

```

## Confirm sign-in with custom challenge

If the next step is `CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE`, Amplify Auth is awaiting completion of a custom authentication challenge. The challenge is based on the AWS Lambda trigger you configured as part of a custom sign in flow.

For example, your custom challenge Lambda may pass a prompt to the frontend which requires the user to enter a secret code.

```ts

async function handleSignInResult(result: SignInOutput) 
	}
}

```

To complete this step, you should prompt the user for the custom challenge answer, and pass the answer to the `confirmSignIn` API.

```ts
async function confirmCustomChallenge(answer: string) );

	return handleSignInResult(result);
}
```

> **Note**: 

**Special Handling on `confirmSignIn`**

If `failAuthentication=true` is returned by the Lambda, Cognito will invalidate the session of the request. This is represented by a `NotAuthorizedException` and requires restarting the sign-in flow by calling `signIn` again.

## Confirm sign-in with new password

If the next step is `CONFIRM_SIGN_IN_WITH_NEW_PASSWORD_REQUIRED`, Amplify Auth requires the user choose a new password they proceeding with the sign in. 

Prompt the user for a new password and pass it to the `confirmSignIn` API.

See the [sign-in](/[platform]/build-a-backend/auth/connect-your-frontend/sign-in/) and [manage-password](/[platform]/build-a-backend/auth/manage-users/manage-passwords/) docs for more information.

```ts

async function handleSignInResult(result: SignInOutput) 
	}
}

async function confirmNewPassword(newPassword: string) );

	return handleSignInResult(result);
}

```

## Reset password

If the next step is `RESET_PASSWORD`, Amplify Auth requires that the user reset their password before proceeding.
Use the `resetPassword` API to guide the user through resetting their password, then call `signIn` to restart the sign-in flow.

See the [reset password](/[platform]/build-a-backend/auth/manage-users/manage-passwords/) docs for more information.

```ts
import  from '@aws-amplify/auth';

async function handleSignInResult(result: SignInOutput) );
			// initiate reset password flow
			await handleResetPasswordResult(resetPasswordResult);
			break;
		}
	}
}

async function handleResetPasswordResult(
	resetPasswordResult: ResetPasswordOutput,
)  = resetPasswordResult.nextStep;
			console.log(
				`A confirmation code has been sent to $.`,
			);
			console.log(
				`Please check your $ for the code.`,
			);
			break;
		}
		case 'DONE': 
	}
}

```

## Confirm Signup

If the next step is `CONFIRM_SIGN_UP`, Amplify Auth requires that the user confirm their email or phone number before proceeding.
Use the `resendSignUpCode` API to send a new sign up code to the registered email or phone number, followed by `confirmSignUp` to complete the sign up.

See the [sign up](/[platform]/build-a-backend/auth/connect-your-frontend/sign-up/) docs for more information.

> **Note**: 

The result includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery, such as the partial phone number of the SMS recipient, which can be used to prompt the user on where to look for the code.

```ts
import  from '@aws-amplify/auth';

async function handleSignInResult(result: SignInOutput)  = await resendSignUpCode();
			console.log(`A confirmation code has been sent to $.`);
			console.log(`Please check your $ for the code.`);
			break;
		}
	}
}

async function handleConfirmSignUp(username: string, confirmationCode: string) );
}

```

Once the sign up is confirmed, call `signIn` again to restart the sign-in flow.

## Done

The sign-in flow is complete when the next step is `DONE`, which means the user is successfully authenticated. 
As a convenience, the `SignInResult` also provides the `isSignedIn` property, which will be true if the next step is `DONE`.

```ts

async function handleSignInResult(result: SignInOutput) 
	}
}

```
</InlineFilter>

After a user has finished signup, they can proceed to sign in. Amplify Auth signin flows can be multi step processes. The required steps are determined by the configuration you provided when you define your auth resources like described on [Manage MFA Settings](/[platform]/build-a-backend/auth/concepts/multi-factor-authentication/) page.

Depending on the configuration, you may need to call various APIs to finish authenticating a user's signin attempt. To identify the next step in a signin flow, inspect the `nextStep` parameter in the signin result.

> **Note**: 
*New enumeration values*

When Amplify adds a new enumeration value (e.g., a new enum class entry or sealed class subtype in Kotlin, or a new enum value in Swift/Dart/Kotlin), it will publish a new minor version of the Amplify Library. Plugins that switch over enumeration values should include default handlers (an else branch in Kotlin or a default statement in Swift/Dart/Kotlin) to ensure that they are not impacted by new enumeration values.

The `Amplify.Auth.signIn` API returns a `SignInResult` object which indicates whether the sign-in flow is
complete or whether additional steps are required before the user is signed in.

To see if additional signin steps are required, inspect the sign in result's `nextStep.signInStep` property.
- If the sign-in step is `done`, the flow is complete and the user is signed in.
- If the sign-in step is not `done`, one or more additional steps are required. These are explained in detail below.

> **Note**: 

The `signInStep` property is an enum of type `AuthSignInStep`. Depending on its value, your code should take one of the actions mentioned on this page.

```dart
Future signInWithCognito(
  String username,
  String password,
) async 

Future<void> _handleSignInResult(SignInResult result) async 
}
```
## Confirm sign-in with SMS MFA

If the next step is `confirmSignInWithSmsMfaCode`, Amplify Auth has sent the user a random code over SMS and is waiting for the user to verify that code. To handle this step, your app's UI must prompt the user to enter the code. After the user enters the code, pass the value to the `confirmSignIn` API.

> **Note**: 

The result includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery, such as the partial phone number of 
the SMS recipient, which can be used to prompt the user on where to look for the code.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) . '
    'Please check your $ for the code.',
  );
}
```

```dart
Future<void> confirmMfaUser(String mfaCode) async  on AuthException catch (e) ');
  }
}
```

## Confirm sign-in with TOTP MFA

If the next step is `confirmSignInWithTOTPCode`, you should prompt the user to enter the TOTP code from their associated authenticator app during set up. The code is a six-digit number that changes every 30 seconds. The user must enter the code before the 30-second window expires.

After the user enters the code, your implementation must pass the value to Amplify Auth `confirmSignIn` API.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

// Then, pass the TOTP code to `confirmSignIn`

Future<void> confirmTotpUser(String totpCode) async  on AuthException catch (e) ');
  }
}
```

## Confirm sign-in with Email MFA

If the next step is `confirmSignInWithOtpCode`, Amplify Auth has sent the user a random code to their email address and is waiting for the user to verify that code. To handle this step, your app's UI must prompt the user to enter the code. After the user enters the code, pass the value to the `confirmSignIn` API.

> **Note**: 

The result includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery, such as the partial email address of 
the recipient, which can be used to prompt the user on where to look for the code.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) . '
    'Please check your $ for the code.',
  );
}
```

```dart
Future<void> confirmMfaUser(String mfaCode) async  on AuthException catch (e) ');
  }
}
```

## Continue sign-in with MFA Selection

If the next step is `continueSignInWithMFASelection`, the user must select the MFA method to use. Amplify Auth currently supports SMS, TOTP, and email as MFA methods. After the user selects an MFA method, your implementation must pass the selected MFA method to Amplify Auth using `confirmSignIn` API.

The MFA types which are currently supported by Amplify Auth are:

- `MfaType.sms`
- `MfaType.totp`
- `MfaType.email`

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

Future _promptUserPreference(Set allowedTypes) async 

Future<void> _handleMfaSelection(MfaType selection) async  on AuthException catch (e) ');
  }
}
```

## Continue sign-in with Email Setup

If the next step is `continueSignInWithEmailMfaSetup`, then the user must provide an email address to complete the sign in process. Once this value has been collected from the user, call the `confirmSignIn` API to continue.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

// Then, pass the email address to `confirmSignIn`

Future<void> confirmEmailUser(String emailAddress) async  on AuthException catch (e) ');
  }
}
```

## Continue sign-in with TOTP Setup

If the next step is `continueSignInWithTOTPSetup`, then the user must provide a TOTP code to complete the sign in process. The step returns an associated value of type `TOTPSetupDetails` which would be used for generating TOTP. `TOTPSetupDetails` provides a helper method called `getSetupURI` that can be used to generate a URI, which can be used by native password managers for TOTP association. For example. if the URI is used on Apple platforms, it will trigger the platform's native password manager to associate TOTP with the account. For more advanced use cases, `TOTPSetupDetails` also contains the `sharedSecret` that will be used to either generate a QR code or can be manually entered into an authenticator app.

Once the authenticator app is set up, the user can generate a TOTP code and provide it to the library to complete the sign in process.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

// Then, pass the TOTP code to `confirmSignIn`

Future<void> confirmTotpUser(String totpCode) async  on AuthException catch (e) ');
  }
}
```

## Continue sign-in with MFA Setup Selection
If the next step is `continueSignInWithMfaSetupSelection`, then the user must indicate which of the available MFA methods they would like to setup. After the user selects an MFA method to setup, your implementation must pass the selected MFA method to the `confirmSignIn` API.

The MFA types which are currently supported by Amplify Auth are:

- `MfaType.sms`
- `MfaType.totp`
- `MfaType.email`

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

Future _promptUserPreference(Set allowedTypes) async 

Future<void> _handleMfaSelection(MfaType selection) async  on AuthException catch (e) ');
  }
}
```

## Confirm sign-in with custom challenge

If the next step is `confirmSignInWithCustomChallenge`, Amplify Auth is awaiting completion of a custom authentication challenge. The challenge is based on the AWS Lambda trigger you configured as part of a [custom sign in flow](/[platform]/build-a-backend/auth/customize-auth-lifecycle/custom-auth-flows/#sign-in-a-user).

For example, your custom challenge Lambda may pass a prompt to the frontend which requires the user to enter a secret code.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}
```

To complete this step, you should prompt the user for the custom challenge answer, and pass the answer to the `confirmSignIn` API.

```dart
Future<void> confirmCustomChallenge(String answer) async  on AuthException catch (e) ');
  }
}
```

> **Note**: 

**Special Handling on `confirmSignIn`**

If `failAuthentication=true` is returned by the Lambda, Cognito will invalidate the session of the request. This is represented by a `NotAuthorizedException` and requires restarting the sign-in flow by calling `Amplify.Auth.signIn` again.

## Confirm sign-in with new password
If the next step is `confirmSignInWithNewPassword`, Amplify Auth requires the user choose a new password they proceeding with the sign in. 

Prompt the user for a new password and pass it to the `confirmSignIn` API.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}
```

```dart
Future<void> confirmNewPassword(String newPassword) async  on AuthException catch (e) ');
  }
}
```

## Reset password
If the next step is `resetPassword`, Amplify Auth requires that the user reset their password before proceeding.
Use the `resetPassword` API to guide the user through resetting their password, then call `Amplify.Auth.signIn`
when that's complete to restart the sign-in flow.

See the [reset password](/[platform]/build-a-backend/auth/manage-users/manage-passwords/) docs for more information.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

Future<void> _handleResetPasswordResult(ResetPasswordResult result) async 
}

void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) . '
    'Please check your $ for the code.',
  );
}
```
## Confirm Signup
If the next step is `resetPassword`, Amplify Auth requires that the user confirm their email or phone number before proceeding.
Use the `resendSignUpCode` API to send a new sign up code to the registered email or phone number, followed by `confirmSignUp` 
to complete the sign up.

See the [confirm sign up](/[platform]/build-a-backend/auth/connect-your-frontend/sign-up/#confirm-sign-up) docs for more information.

> **Note**: 

The result includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery, such as the partial phone number of 
the SMS recipient, which can be used to prompt the user on where to look for the code.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}

void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) . '
    'Please check your $ for the code.',
  );
}
```

```dart
Future<void> confirmSignUp() async  on AuthException catch (e) ');
  }
}
```

Once the sign up is confirmed, call `Amplify.Auth.signIn` again to restart the sign-in flow.

## Done

The sign-in flow is complete when the next step is `done`, which means the user is successfully authenticated. 
As a convenience, the `SignInResult` also provides the `isSignedIn` property, which will be true if the next step is `done`.

```dart
Future<void> _handleSignInResult(SignInResult result) async 
}
```
</InlineFilter>

After a user has finished signup, they can proceed to sign in. Amplify Auth signin flows can be multi step processes. The required steps are determined by the configuration you provided when you define your auth resources like described on [Manage MFA Settings](/[platform]/build-a-backend/auth/concepts/multi-factor-authentication/) page. 

Depending on the configuration, you may need to call various APIs to finish authenticating a user's signin attempt. To identify the next step in a signin flow, inspect the `nextStep` parameter in the signin result.

> **Note**: 
*New enumeration values*

When Amplify adds a new enumeration value (e.g., a new enum class entry or sealed class subtype in Kotlin, or a new enum value in Swift/Dart/Kotlin), it will publish a new minor version of the Amplify Library. Plugins that switch over enumeration values should include default handlers (an else branch in Kotlin or a default statement in Swift/Dart/Kotlin) to ensure that they are not impacted by new enumeration values.

When called successfully, the signin APIs will return an `AuthSignInResult`. Inspect the `nextStep` property in the result to see if additional signin steps are required.
The `nextStep` property is of enum type `AuthSignInStep`. Depending on its value, your code should take one of the following actions:

```java
try 
                case CONTINUE_SIGN_IN_WITH_MFA_SETUP_SELECTION: 
                case CONTINUE_SIGN_IN_WITH_EMAIL_MFA_SETUP: 
                case CONTINUE_SIGN_IN_WITH_TOTP_SETUP: 
                case CONTINUE_SIGN_IN_WITH_MFA_SELECTION: 
                case CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION: 
                case CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE: 
                case CONFIRM_SIGN_IN_WITH_OTP: 
              	case CONFIRM_SIGN_IN_WITH_PASSWORD: 
                case CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE: 
                case CONFIRM_SIGN_IN_WITH_NEW_PASSWORD: 
                case DONE: 
            }
        },
        error ->  else if (error instanceof PasswordResetRequiredException)  else 
        }
    );
} catch (Exception error) 
```

</Block>

```kotlin
try 
                AuthSignInStep.CONTINUE_SIGN_IN_WITH_MFA_SETUP_SELECTION -> ")
                    // Prompt the user to select the MFA type they want to setup
                    // Then invoke `confirmSignIn` api with the MFA type
                }
                AuthSignInStep.CONTINUE_SIGN_IN_WITH_EMAIL_MFA_SETUP -> 
                AuthSignInStep.CONTINUE_SIGN_IN_WITH_TOTP_SETUP -> ")
                    // Prompt the user to enter the TOTP code generated in their authenticator app
                    // Then invoke `confirmSignIn` api with the code
                }
                AuthSignInStep.CONTINUE_SIGN_IN_WITH_MFA_SELECTION -> ")
                    // Prompt the user to select the MFA type they want to use
                    // Then invoke `confirmSignIn` api with the MFA type
                }
                AuthSignInStep.CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION -> ")
                    // Prompt the user to select which authentication factor they want to use to sign-in
                    // Then invoke `confirmSignIn` api with that selection
                }
                AuthSignInStep.CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE -> ")
                    Log.i("AuthQuickstart", "Additional Info $")
                    // Prompt the user to enter the SMS MFA code they received
                    // Then invoke `confirmSignIn` api with the code
                }
                AuthSignInStep.CONFIRM_SIGN_IN_WITH_OTP -> ")
                    Log.i("AuthQuickstart", "Additional Info $")
                    // Prompt the user to enter the OTP MFA code they received
                    // Then invoke `confirmSignIn` api with the code
                }
                AuthSignInStep.CONFIRM_SIGN_IN_WITH_PASSWORD -> 
                AuthSignInStep.CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE -> ")
                    // Prompt the user to enter custom challenge answer
                    // Then invoke `confirmSignIn` api with the answer
                }
                AuthSignInStep.CONFIRM_SIGN_IN_WITH_NEW_PASSWORD -> ")
                    // Prompt the user to enter a new password
                    // Then invoke `confirmSignIn` api with new password
                }
                AuthSignInStep.DONE -> 
            }

        }
    ) 
            is PasswordResetRequiredException -> 
            else -> 
        }
    }
} catch (error: Exception) 
```

</Block>

```kotlin
try 
        AuthSignInStep.CONTINUE_SIGN_IN_WITH_MFA_SETUP_SELECTION -> ")
            // Prompt the user to select the MFA type they want to setup
            // Then invoke `confirmSignIn` api with the MFA type
        }
        AuthSignInStep.CONTINUE_SIGN_IN_WITH_EMAIL_MFA_SETUP -> 
        AuthSignInStep.CONTINUE_SIGN_IN_WITH_TOTP_SETUP -> ")
            // Prompt the user to enter the TOTP code generated in their authenticator app
            // Then invoke `confirmSignIn` api with the code
        }
        AuthSignInStep.CONTINUE_SIGN_IN_WITH_MFA_SELECTION -> ")
            // Prompt the user to select the MFA type they want to use
            // Then invoke `confirmSignIn` api with the MFA type
        }
        AuthSignInStep.CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION -> ")
            // Prompt the user to select which authentication factor they want to use to sign-in
            // Then invoke `confirmSignIn` api with that selection
        }
        AuthSignInStep.CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE -> ")
            Log.i("AuthQuickstart", "Additional Info $")
            // Prompt the user to enter the SMS MFA code they received
            // Then invoke `confirmSignIn` api with the code
        }
        AuthSignInStep.CONFIRM_SIGN_IN_WITH_OTP -> ")
            Log.i("AuthQuickstart", "Additional Info $")
            // Prompt the user to enter the OTP MFA code they received
            // Then invoke `confirmSignIn` api with the code
        }
        AuthSignInStep.CONFIRM_SIGN_IN_WITH_PASSWORD -> 
        AuthSignInStep.CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE -> ")
            // Prompt the user to enter custom challenge answer
            // Then invoke `confirmSignIn` api with the answer
        }
        AuthSignInStep.CONFIRM_SIGN_IN_WITH_NEW_PASSWORD -> ")
            // Prompt the user to enter a new password
            // Then invoke `confirmSignIn` api with new password
        }
        AuthSignInStep.DONE -> 
    }
} catch (error: Exception) 
        is PasswordResetRequiredException -> 
        else -> 
    }
}
```

</Block>

```java
RxAmplify.Auth.signIn("hello@example.com", "password").subscribe(
    result ->
    
            case CONTINUE_SIGN_IN_WITH_MFA_SETUP_SELECTION: 
            case CONTINUE_SIGN_IN_WITH_EMAIL_MFA_SETUP: 
            case CONTINUE_SIGN_IN_WITH_TOTP_SETUP: 
            case CONTINUE_SIGN_IN_WITH_MFA_SELECTION: 
            case CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION: 
            case CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE: 
            case CONFIRM_SIGN_IN_WITH_OTP: 
            case CONFIRM_SIGN_IN_WITH_PASSWORD: 
            case CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE: 
            case CONFIRM_SIGN_IN_WITH_NEW_PASSWORD: 
            case DONE: 
        }
    },
    error ->  else if (error instanceof PasswordResetRequiredException)  else 
    }
);
```

</Block>

</BlockSwitcher>

## Confirm sign-in with SMS MFA

If the next step is `CONFIRM_SIGN_IN_WITH_SMS_MFA_CODE`, Amplify Auth has sent the user a random code over SMS, and is waiting to find out if the user successfully received it. To handle this step, your app's UI must prompt the user to enter the code. After the user enters the code, your implementation must pass the value to Amplify Auth `confirmSignIn` API.

> **Note**: 

**Note:** The result also includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery such as the partial phone number of the SMS recipient.

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
                  // If `signInResult.isSignedIn` is true, the next step
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
        // If `signInResult.isSignedIn` is true, the next step
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

## Confirm sign-in with TOTP MFA

If the next step is `CONFIRM_SIGN_IN_WITH_TOTP_CODE`, you should prompt the user to enter the TOTP code from their associated authenticator app during set up. The code is a six-digit number that changes every 30 seconds. The user must enter the code before the 30-second window expires.

After the user enters the code, your implementation must pass the value to Amplify Auth `confirmSignIn` API.

## Confirm sign-in with Email MFA

If the next step is `CONFIRM_SIGN_IN_WITH_EMAIL_MFA_CODE`, Amplify Auth has sent the user a random code to their email address and is waiting to find out if the user successfully received it. To handle this step, your app's UI must prompt the user to enter the code. After the user enters the code, your implementation must pass the value to Amplify Auth `confirmSignIn` API.

> **Note**: 

**Note:** The result also includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery such as the partial email address of the recipient.

## Confirm sign-in with OTP

If the next step is `CONFIRM_SIGN_IN_WITH_OTP`, Amplify Auth has sent the user a random code to the medium of the user's choosing (e.g. SMS or email) and is waiting for the user to verify that code. To handle this step, your app's UI must prompt the user to enter the code. After the user enters the code, pass the value to the `confirmSignIn` API.

> **Note**: 

**Note:** The result includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery, such as the partial email address of the recipient, which can be used to prompt the user on where to look for the code.

## Continue sign-in with MFA Selection

If the next step is `CONTINUE_SIGN_IN_WITH_MFA_SELECTION`, the user must select the MFA method to use. Amplify Auth currently supports SMS, TOTP, and email as MFA methods. After the user selects an MFA method, your implementation must pass the selected MFA method to Amplify Auth using `confirmSignIn` API.

## Continue sign-in with Email Setup

If the next step is `CONTINUE_SIGN_IN_WITH_EMAIL_MFA_SETUP`, then the user must provide an email address to complete the sign in process. Once this value has been collected from the user, call the `confirmSignIn` API to continue.

## Continue sign-in with TOTP Setup

If the next step is `CONTINUE_SIGN_IN_WITH_TOTP_SETUP`, then the user must provide a TOTP code to complete the sign in process. The step returns an associated value of type `TOTPSetupDetails` which would be used for generating TOTP. `TOTPSetupDetails` provides a helper method called `getSetupURI` that can be used to generate a URI, which can be used by native password managers for TOTP association. For example. if the URI is used on Apple platforms, it will trigger the platform's native password manager to associate TOTP with the account. For more advanced use cases, `TOTPSetupDetails` also contains the `sharedSecret` that will be used to either generate a QR code or can be manually entered into an authenticator app.

Once the authenticator app is set up, the user can generate a TOTP code and provide it to the library to complete the sign in process.

## Continue sign-in with MFA Setup Selection

If the next step is `CONTINUE_SIGN_IN_WITH_MFA_SETUP_SELECTION`, the user must select the MFA method to setup. Amplify Auth currently supports SMS, TOTP, and email as MFA methods. After the user selects an MFA method, your implementation must pass the selected MFA method to Amplify Auth using `confirmSignIn` API.

## Continue sign-in with First Factor Selection

If the next step is `CONTINUE_SIGN_IN_WITH_FIRST_FACTOR_SELECTION`, the user must select an authentication factor to use either because they did not specify one or because the one they chose is not supported (e.g. selecting SMS when they don't have a phone number registered to their account). Amplify Auth currently supports SMS, email, password, and webauthn as authentication factors. After the user selects an authentication method, your implementation must pass the selected authentication method to Amplify Auth using `confirmSignIn` API.

Visit the [sign-in documentation](/[platform]/build-a-backend/auth/connect-your-frontend/sign-in/#sign-in-with-passwordless-methods) to see examples on how to call the `confirmSignIn` API.

## Confirm sign-in with custom challenge

If the next step is `CONFIRM_SIGN_IN_WITH_CUSTOM_CHALLENGE`, Amplify Auth is awaiting completion of a custom authentication challenge. The challenge is based on the Lambda trigger you setup when you configured a [custom sign in flow](/[platform]/build-a-backend/auth/customize-auth-lifecycle/custom-auth-flows/#sign-in-a-user). To complete this step, you should prompt the user for the custom challenge answer, and pass the answer to the `confirmSignIn` API.

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
                  // If `signInResult.isSignedIn` is true, the next step
                  // is 'done', and the user is now signed in.
              }
        }
    ) 
} catch (error: Exception) 
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
    "challenge answer").subscribe(
    result ->  else 
    },
    error -> Log.e("AuthQuickstart", "Confirm sign in failed: " + error)
);
```

</Block>
</BlockSwitcher>

> **Note**: 

**Special Handling on `confirmSignIn`**

During a confirmSignIn call if `failAuthentication=true` is returned by the Lambda the session of the request gets invalidated by cognito, a NotAuthorizedException is returned and a new signIn call is expected via Amplify.Auth.signIn

```java
NotAuthorizedException
```

## Confirm sign-in with new password
If you receive a `UserNotConfirmedException` while signing in, Amplify Auth requires a new password for the user before they can proceed. Prompt the user for a new password and pass it to the `confirmSignIn` API.

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
              }
          }
      ) 
} catch (error: Exception) 
}
```

</Block>

```kotlin
try  else ")
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

## Reset password
If you receive `PasswordResetRequiredException`, authentication flow could not proceed without resetting the password. The next step is to invoke `resetPassword` api and follow the reset password flow.

```java
try  catch (Exception error) 
```
</Block>

```kotlin
try 
      ) 
} catch (error: Exception) 
```
</Block>

```kotlin
try  catch (error: Exception) 
```
</Block>

```java
RxAmplify.Auth.resetPassword(
        "username").subscribe(
        result -> Log.i("AuthQuickstart", "Reset password succeeded"),
        error -> Log.e("AuthQuickstart", "Reset password failed : " + error)
);
```
</Block>

</BlockSwitcher>

## Confirm Signup

If you receive `CONFIRM_SIGN_UP` as a next step, sign up could not proceed without confirming user information such as email or phone number. The next step is to invoke the `confirmSignUp` API and follow the confirm signup flow.

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

## Get Current User

This call fetches the current logged in user and should be used after a user has been successfully signed in.
If the user is signed in, it will return the current userId and username.

> **Note**: 
**Note:** An empty string will be assigned to userId and/or username, if the values are not present in the accessToken.

```java
 try  catch (Exception error) 
```
</Block>

```kotlin
Amplify.Auth.getCurrentUser(,)
```
</Block>

```kotlin
try  catch (error: Exception) 
```
</Block>

```java
  RxAmplify.Auth.getCurrentUser().subscribe(
        result -> Log.i("AuthQuickStart getCurrentUser: " + result.toString()),
        error -> Log.e("AuthQuickStart", error.toString())
 );
```
</Block>

</BlockSwitcher>

## Done

Sign In flow is complete when you get `done`. This means the user is successfully authenticated. As a convenience, the SignInResult also provides the `isSignedIn` property, which will be true if the next step is `done`.

</InlineFilter>

After a user has finished signup, they can proceed to sign in. Amplify Auth signin flows can be multi step processes. The required steps are determined by the configuration you provided when you define your auth resources like described on [Manage MFA Settings](/[platform]/build-a-backend/auth/concepts/multi-factor-authentication/) page. 

Depending on the configuration, you may need to call various APIs to finish authenticating a user's signin attempt. To identify the next step in a signin flow, inspect the `nextStep` parameter in the signin result.

> **Note**: 
*New enumeration values*

When Amplify adds a new enumeration value (e.g., a new enum class entry or sealed class subtype in Kotlin, or a new enum value in Swift/Dart/Kotlin), it will publish a new minor version of the Amplify Library. Plugins that switch over enumeration values should include default handlers (an else branch in Kotlin or a default statement in Swift/Dart/Kotlin) to ensure that they are not impacted by new enumeration values.

When called successfully, the signin APIs will return an `AuthSignInResult`. Inspect the `nextStep` property in the result to see if additional signin steps are required.

```swift
func signIn(username: String, password: String) async 
    } catch let error as AuthError catch 
}
```

The `nextStep` property is of enum type `AuthSignInStep`. Depending on its value, your code should take one of the following actions:

## Confirm sign-in with SMS MFA
If the next step is `confirmSignInWithSMSMFACode`, Amplify Auth has sent the user a random code over SMS, and is waiting to find out if the user successfully received it. To handle this step, your app's UI must prompt the user to enter the code. After the user enters the code, your implementation must pass the value to Amplify Auth `confirmSignIn` API.

Note: the signin result also includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery such as the partial phone number of the SMS recipient.

```swift
func confirmSignIn(confirmationCodeFromUser: String) async  else 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func confirmSignIn(confirmationCodeFromUser: String) -> AnyCancellable .sink 
        }
        receiveValue:  else 
        }
}
```

</Block>

</BlockSwitcher>

## Confirm sign-in with TOTP MFA

If the next step is `confirmSignInWithTOTPCode`, you should prompt the user to enter the TOTP code from their associated authenticator app during set up. The code is a six-digit number that changes every 30 seconds. The user must enter the code before the 30-second window expires.

After the user enters the code, your implementation must pass the value to Amplify Auth `confirmSignIn` API.

```swift
func confirmSignIn(totpCode: String) async  else 
    } catch 
}
```

</Block>

```swift
func confirmSignIn(totpCode: String) -> AnyCancellable .sink 
        }
        receiveValue:  else 
        }
}
```

</Block>

</BlockSwitcher>

## Confirm sign-in with Email MFA
If the next step is `confirmSignInWithOTP`, Amplify Auth has sent a random code to the user's email address, and is waiting to find out if the user successfully received it. To handle this step, your app's UI must prompt the user to enter the code. After the user enters the code, your implementation must pass the value to Amplify Auth `confirmSignIn` API.

> **Note**: 

**Note:** the sign-in result also includes an `AuthCodeDeliveryDetails` member. It includes additional information about the code delivery such as the partial email address of the recipient.

```swift
func confirmSignIn(confirmationCodeFromUser: String) async  else 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func confirmSignIn(confirmationCodeFromUser: String) -> AnyCancellable .sink 
        }
        receiveValue:  else 
        }
}
```

</Block>

</BlockSwitcher>

## Continue sign-in with MFA Selection

If the next step is `continueSignInWithMFASelection`, the user must select the MFA method to use. Amplify Auth currently supports SMS, TOTP, and email as MFA methods. After the user selects an MFA method, your implementation must pass the selected MFA method to Amplify Auth using `confirmSignIn` API.

```swift
func confirmSignInWithTOTPAsMFASelection() async 

    } catch 
}
```

</Block>

```swift
func confirmSignInWithTOTPAsMFASelection() -> AnyCancellable .sink 
        }
        receiveValue: 
    }
}
```

</Block>

</BlockSwitcher>

## Continue sign-in with Email Setup
If the next step is `continueSignInWithEmailMFASetup`, then the user must provide an email address to complete the sign in process. Once this value has been collected from the user, call the `confirmSignIn` API to continue.

```swift 
// Confirm sign in with Email Setup
case .continueSignInWithEmailMFASetup:
    print("Received next step as continue sign in by setting up email MFA")
        
    // Prompt the user to enter the email address they wish to use for MFA
    // Then invoke `confirmSignIn` api with the email address
```

## Continue sign-in with TOTP Setup

If the next step is `continueSignInWithTOTPSetup`, then the user must provide a TOTP code to complete the sign in process. The step returns an associated value of type `TOTPSetupDetails` which would be used for generating TOTP. `TOTPSetupDetails` provides a helper method called `getSetupURI` that can be used to generate a URI, which can be used by native password managers for TOTP association. For example. if the URI is used on Apple platforms, it will trigger the platform's native password manager to associate TOTP with the account. For more advanced use cases, `TOTPSetupDetails` also contains the `sharedSecret` that will be used to either generate a QR code or can be manually entered into an authenticator app.

Once the authenticator app is set up, the user can generate a TOTP code and provide it to the library to complete the sign in process.

```swift 
// Confirm sign in with TOTP setup
case .continueSignInWithTOTPSetup(let setUpDetails):
    
    /// appName parameter will help distinguish the account in the Authenticator app
    let setupURI = try setUpDetails.getSetupURI(appName: ">") 
    
    print("TOTP Setup URI: \(setupURI)")
```

```swift
func confirmSignInWithTOTPSetup(totpCodeFromAuthenticatorApp: String) async  else 
    } catch 
}
```

</Block>

```swift
func confirmSignInWithTOTPSetup(totpCodeFromAuthenticatorApp: String) -> AnyCancellable .sink 
        }
        receiveValue:  else 
        }
}
```

</Block>

</BlockSwitcher>

## Continue sign-in with MFA Setup Selection

If the next step is `continueSignInWithMFASetupSelection`, the user must indicate which of the available MFA methods they would like to setup. After the user selects an MFA method to setup, your implementation must pass the selected MFA method to the `confirmSignIn` API.

```swift
func continueSignInWithEmailMFASetupSelection() async 

    } catch 
}
```

</Block>

```swift
func continueSignInWithEmailMFASetupSelection() -> AnyCancellable .sink 
        }
        receiveValue: 
    }
}
```

</Block>

</BlockSwitcher>

## Confirm sign-in with custom challenge

If the next step is `confirmSignInWithCustomChallenge`, Amplify Auth is awaiting completion of a custom authentication challenge. The challenge is based on the Lambda trigger you setup when you configured a [custom sign in flow](/[platform]/build-a-backend/auth/customize-auth-lifecycle/custom-auth-flows/#sign-in-a-user). To complete this step, you should prompt the user for the custom challenge answer, and pass the answer to the `confirmSignIn` API.

```swift
func confirmSignIn(challengeAnswerFromUser: String) async  else 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func confirmSignIn(challengeAnswerFromUser: String) -> AnyCancellable .sink 
        }
        receiveValue:  else 
        }
}
```

</Block>
</BlockSwitcher>

> **Note**: 

**Special Handling on `confirmSignIn`**

During a confirmSignIn call if `failAuthentication=true` is returned by the Lambda function the session of the request gets invalidated by cognito, a NotAuthorizedException is returned and a new signIn call is expected via Amplify.Auth.signIn

```swift
Exception:  notAuthorized
```

## Confirm sign-in with new password

If the next step is `confirmSignInWithNewPassword`, Amplify Auth requires a new password for the user before they can proceed. Prompt the user for a new password and pass it to the `confirmSignIn` API.

```swift
func confirmSignIn(newPasswordFromUser: String) async  else 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func confirmSignIn(newPasswordFromUser: String) -> AnyCancellable .sink 
        }
        receiveValue:  else 
        }
}
```

</Block>

</BlockSwitcher>

## Reset password

If you receive `resetPassword`, authentication flow could not proceed without resetting the password. The next step is to invoke `resetPassword` api and follow the reset password flow.

```swift
func resetPassword(username: String) async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func resetPassword(username: String) -> AnyCancellable .sink 
        }
        receiveValue: 
}
```

</Block>

</BlockSwitcher>

## Confirm Signup

If you receive `confirmSignUp` as a next step, sign up could not proceed without confirming user information such as email or phone number. The next step is to invoke the `confirmSignUp` API and follow the confirm signup flow.

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

## Done

Signin flow is complete when you get `done`. This means the user is successfully authenticated. As a convenience, the SignInResult also provides the `isSignedIn` property, which will be true if the next step is `done`.
</InlineFilter>
