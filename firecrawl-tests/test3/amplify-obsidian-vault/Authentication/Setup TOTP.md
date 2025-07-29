---
title: Setup TOTP
topics: ['Authentication', 'React']
primary_topic: Authentication
source: fragments/lib/auth/js/react-native-mfa.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication, react]
---


## 🧭 Navigation
**Topics**: [[Authentication/]] • [[React/]]
**Primary**: [[Authentication/]]

---


# Setup TOTP

> **Note**: 
Note: If you create or update an SMS MFA configuration for your Cognito user pool, the Cognito service will send a test SMS message to an internal number in order to verify your configuration. You will be charged for these test messages by Amazon SNS. 

For information about Amazon SNS pricing, see [Worldwide SMS Pricing](https://aws.amazon.com/sns/sms-pricing/).

MFA (Multi-factor authentication increases security for your app by adding an authentication method and not relying solely on the username (or alias) and password. AWS Amplify uses Amazon Cognito to provide MFA. Please see [Amazon Cognito Developer Guide](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-mfa.html) for more information about setting up MFA in Amazon Cognito.

Once you enable MFA on Amazon Cognito, you can configure your app to work with MFA.

## Setup TOTP

With TOTP (Time-based One-time Password), your app user is challenged to complete authentication using a time-based one-time (TOTP) password after their username and password have been verified.

You can setup TOTP for a user in your app:

```javascript

// To setup TOTP, first you need to get a `authorization code` from Amazon Cognito
// `user` is the current Authenticated user
Auth.setupTOTP(user).then((code) => );

// ...

// Then you will have your TOTP account in your TOTP-generating app (like Google Authenticator)
// Use the generated one-time password to verify the setup
Auth.verifyTotpToken(user, challengeAnswer)
  .then(() => )
  .catch((e) => );
```

## Setup MFA type

Multiple MFA types supported by Amazon Cognito. You can set the preferred method in your code:

```javascript

// You can select preferred mfa type, for example:
// Select TOTP as preferred
Auth.setPreferredMFA(user, 'TOTP')
  .then((data) => )
  .catch((e) => );

// Select SMS as preferred
Auth.setPreferredMFA(user, 'SMS');

// Select no-mfa
Auth.setPreferredMFA(user, 'NOMFA');
```

## Retrieve current preferred MFA type

You can get current preferred MFA type in your code:

```javascript

// Will retrieve the current mfa type from cache
Auth.getPreferredMFA(user, ).then((data) => );
```

## Advanced use cases

### Sign-in with custom auth challenges

When signing in with user name and password, you will either sign in directly or be asked to pass some challenges before getting authenticated.

The `user` object returned from `Auth.signIn` will contain `challengeName` and `challengeParam` if the user needs to pass those challenges. You can call corresponding functions based on those two parameters.

ChallengeName:

- `SMS_MFA`: The user needs to input the code received from SMS message. You can submit the code by `Auth.confirmSignIn`.
- `SOFTWARE_TOKEN_MFA`: The user needs to input the OTP(one time password). You can submit the code by `Auth.confirmSignIn`.
- `NEW_PASSWORD_REQUIRED`: This happens when the user account is created through the Cognito console. The user needs to input the new password and required attributes. You can submit those data by `Auth.completeNewPassword`.
- `MFA_SETUP`: This happens when the MFA method is TOTP(the one time password) which requires the user to go through some steps to generate those passwords. You can start the setup process by `Auth.setupTOTP`.
- `SELECT_MFA_TYPE`: This happens when both SMS and TOTP methods are enabled but neither is set as preferred. You can set up your front-end application to let users choose what type they want to use
in the current session and set it using `user.sendMFASelectionAnswer` function.

The following code is only for demonstration purpose:

```javascript

async function signIn()  else if (user.challengeName === 'NEW_PASSWORD_REQUIRED')  = user.challengeParam; // the array of required attributes, e.g ['email', 'phone_number']
      // You need to get the new password and required attributes from the UI inputs
      // and then trigger the following function with a button click
      // For example, the email and phone_number are required attributes
      const  = getInfoFromUserInput();
      const loggedUser = await Auth.completeNewPassword(
        user, // the Cognito User Object
        newPassword, // the new password
        // OPTIONAL, the required attributes
        
      );
    } else if (user.challengeName === 'MFA_SETUP')  else if (user.challengeName === 'SELECT_MFA_TYPE') ,
        mfaRequired: (challengeName, parameters) => ,
        totpRequired: (challengeName, parameters) => 
      });
    } else 
  } catch (err)  else if (err.code === 'PasswordResetRequiredException')  else if (err.code === 'NotAuthorizedException')  else if (err.code === 'UserNotFoundException')  else 
  }
}
```

### Sign-in with custom validation data for Lambda Trigger

You can also pass an object which has the username, password and validationData which is sent to a PreAuthentication Lambda trigger

```js
try );
  console.log('user is signed in!', user);
} catch (error) 
```

### Forcing Email Uniqueness in Cognito User Pools

When your Cognito User Pool sign-in options are set to "_Username_", and "_Also allow sign in with verified email address_", the _signUp()_ method creates a new user account every time it's called, without validating email uniqueness. In this case you will end up having multiple user pool identities and all previously created accounts will have their _email_verified_ attribute changed to _false_.

To enforce Cognito User Pool signups with a unique email, you need to change your User Pool's _Attributes_ setting in [Amazon Cognito console](https://console.aws.amazon.com/cognito) as the following:

![cup](/images/cognito_user_pool_settings.png)


---

## 📚 Related Topics
- [[Authentication/]]
- [[React/]]

## 📖 Source
Original: `fragments/lib/auth/js/react-native-mfa.mdx`