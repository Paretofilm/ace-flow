---
title: Lambda Trigger Setup
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/ios/signin_with_custom_flow/50_custom_challenge.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Lambda Trigger Setup

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

```swift
let options = AWSAuthSignInOptions(
    authFlowType: .customWithSRP)
let signInResult = try await Amplify.Auth.signIn(
    username: username,
    password: password,
    options: .init(pluginOptions: options))
```

### CAPTCHA-based authentication

Here is the sample for creating a CAPTCHA challenge with a Lambda Trigger.

The `Create Auth Challenge Lambda Trigger` creates a CAPTCHA as a challenge to the user. The URL for the CAPTCHA image and  the expected answer is added to the private challenge parameters:

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


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/ios/signin_with_custom_flow/50_custom_challenge.mdx`