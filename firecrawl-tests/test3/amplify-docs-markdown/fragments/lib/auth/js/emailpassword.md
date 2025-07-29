---
title: Sign-up
source: fragments/lib/auth/js/emailpassword.mdx
---

# Sign-up

## Sign-up

Create a new user in the Amazon Cognito UserPool by passing the new user's email address, password, and other attributes to `Auth.signUp`.

```ts

type SignUpParameters = ;

```javascript

async function signUp()  = await Auth.signUp(,
      autoSignIn: 
    });
    console.log(user);
  } catch (error) 
}
```
</Block>
</BlockSwitcher>

The `Auth.signUp` promise returns a data object of type [`ISignUpResult`](https://github.com/aws-amplify/amplify-js/blob/4644b4322ee260165dd756ca9faeb235445000e3/packages/amazon-cognito-identity-js/index.d.ts#L136-L139) with a [`CognitoUser`](https://github.com/aws-amplify/amplify-js/blob/4644b4322ee260165dd756ca9faeb235445000e3/packages/amazon-cognito-identity-js/index.d.ts#L48). `CognitoUser` contains a `userSub` which is a unique identifier of the authenticated user; the `userSub` is not the same as the `username`.

```js

```

### Re-send sign up confirmation code

If user didn't get a confirmation code, you can use `resendSignUp` function to send a new one.

```ts

type ResendConfCodeParameters = ;

```js

async function resendConfirmationCode()  catch (err) 
}
```
</Block>
</BlockSwitcher>

### Confirm sign up

If you enabled multi-factor auth, confirm the sign-up after retrieving a confirmation code from the user.

```ts

type ConfirmSignUpParameters = ;

```js

async function confirmSignUp()  catch (error) 
}
```
</Block>
</BlockSwitcher>

As part of the options parameter, you can specify the `forceAliasCreation` boolean. By default
set to `True`. If set to `False` and the email or phone number used for sign up confirmation
already exists as an alias for a different user, the API will throw an `AliasExistsException`
error. If set to `True`, the API call will migrate the alias from the previous user to 
a newly created user.

```ts

type ConfirmSignUpParameters = ;

```js

async function confirmSignUp() );
  } catch (error) 
}
```
</Block>
</BlockSwitcher>

### Auto sign in after sign up

If you enabled `autoSignIn`, the `sign up` function will dispatch `autoSignIn` hub event after successful confirmation.
If authentication was successful, the event will contain `CognitoUser` in data object. If auto sign in failed, it will dispatch `autoSignIn_failure` event.

```js

function listenToAutoSignInEvent() ) =>  = payload;
    if (event === 'autoSignIn')  else if (event === 'autoSignIn_failure') 
  })
}

```

### Custom Attributes

To create a custom attribute during your sign-up process, add it to the attributes field of the signUp method prepended with `custom:`.

```js
Auth.signUp(
})
```

> Amazon Cognito does not dynamically create custom attributes on sign up. In order to use a custom attribute, the attribute must be first [created in the user pool](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html). To open the User Pool to create custom attributes using the Amplify ClI, run `amplify console auth`. If you are not using the Amplify CLI, you can view the user pool by visiting the AWS console and opening the Amazon Cognito dashboard.

## Sign-in

After a user has finished signing up, they can proceed to sign in.  When signing in with user name and password, you will pass in the username and the password to the `signIn()` method of the Auth class. 

```ts

type SignInParameters = ;

```js

async function signIn()  catch (error) 
}
```
</Block>
</BlockSwitcher>

The sign in flows can be as simple as just a user name and password as shown above, or multi-step process based on how Auth was configured. Amazon Cognito will return a user object when `Auth.signIn` is called that contains `challengeName` and `challengeParam`. Depending on what is enabled for each user, they may need to pass additional challenges such as multi-factor authentication (MFA), time-based one time password (TOTP), or a custom challenge such as CAPTCHA. 

Based on the two parameters returned in the user object, you can then call the corresponding functions below:

### Confirm sign in with SMS MFA

If the user has SMS Multi-Factor Authentication (MFA) enabled, Cognito responds with a challenge that requires the user to provide an SMS verification code. This is where you can trigger `Auth.confirmSignIn()` and pass in the code provided by the user.  Amplify will then verify with Cognito that the SMS code is valid and complete the sign in process via Cognito returning access, ID, and refresh tokens that are all handled by Amplify internally.

```ts

type ConfirmSignInWithMFAParameters = ;

type MFAType = 'SMS_MFA' | 'SOFTWARE_TOKEN_MFA';

async function getCodeFromUserInput(): Promise<string> 
async function getMFATypeFromUserInput(): Promise 
```
</Block>

```javascript

async function signInWithMFA()  else 
  } catch (error) 
};
```
</Block>
</BlockSwitcher>

### Confirm sign in with custom challenge

If you have implemented custom challenges within your authentication flow, Cognito will respond to a sign in attempt with a `challengeName` and `challengeParam`.  Once again, Cognito will validate the the user's response and provide the necessary tokens if successful and resolves the `Auth.signIn()` promise.

```ts

type ConfirmSignInWithCustomChallenge = ;

async function getChallengeResponseFromUserInput(): Promise<string> 
```
</Block>

```javascript

async function signInWithCustomChallenge()  else 
  } catch (err) 
}
```
</Block>
</BlockSwitcher>

### Confirm sign in with new password

New users can be created from the [Cognito console](https://console.aws.amazon.com/cognito/home) for your app, which then forces the user to input a new password and any "required attributes" that may have been optionally configured to complete the sign in flow. If the user object returned by `Auth.signIn()` contains the `NEW_PASSWORD_REQUIRED` for the `challengeName`, you can submit the data using the `Auth.completeNewPassword()` method as well.

```ts

type ConfirmSignInWithNewPassword = ;

type UserInput = ;

async function getInfoFromUserInput(): Promise 
```
</Block>

```javascript

async function signInWithNewPassword()  = user.challengeParam;
      // Example if email and phone_number were required attributes
      const  = getInfoFromUserInput();

      const loggedUser = await Auth.completeNewPassword(
        user, // the Cognito User Object
        newPassword, // the new password
        // OPTIONAL, the required attributes
        
      );
      console.log(loggedUser);
    }
  } catch (error) 
}
```
</Block>
</BlockSwitcher>

For further examples of Authentication using MFA, custom challenges, or custom validation data for AWS Lambda Triggers, refer to the [advanced use cases](/gen1/[platform]/build-a-backend/auth/manage-mfa/#advanced-use-cases).  

## Sign-out

```ts

```js

async function signOut()  catch (error) 
}
```
</Block>
</BlockSwitcher>

[Amazon Cognito now supports token revocation](https://aws.amazon.com/about-aws/whats-new/2021/06/amazon-cognito-now-supports-targeted-sign-out-through-refresh-token-revocation/)  and Amplify (from version 4.1.0) will revoke Amazon Cognito tokens if the application is online. This means Cognito refresh token cannot be used anymore to generate new Access and Id Tokens.

Access and Id Tokens are short-lived (60 minutes by default but can be set from 5 minutes to 1 day). After revocation these tokens cannot be used with Cognito User Pools anymore, however they are still valid when used with other services like AppSync or API Gateway.

For limiting subsequent calls to these other services after invalidating tokens, we recommend lowering token expiration time for your app client in the Cognito User Pools console. If you are using the Amplify CLI this can be accessed by running `amplify console auth`.

Token revocation is enabled automatically on new Amazon Cognito User Pools, however existing User Pools must enable this feature, [using the Cognito Console or AWS CLI](https://docs.aws.amazon.com/cognito/latest/developerguide/token-revocation.html) 

### Global sign-out

By doing this, you sign out users from all devices. It also invalidates all refresh tokens issued to a user. The user's current access and Id tokens remain valid until their expiry. Access and Id tokens expire one hour after they are issued.

```ts

```js

async function signOut() );
  } catch (error) 
}
```
</Block>
</BlockSwitcher>
