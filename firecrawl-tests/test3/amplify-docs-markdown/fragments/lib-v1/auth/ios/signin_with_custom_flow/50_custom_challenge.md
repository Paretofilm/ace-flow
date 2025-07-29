---
title: Lambda Trigger Setup
source: fragments/lib-v1/auth/ios/signin_with_custom_flow/50_custom_challenge.mdx
---

# Lambda Trigger Setup

```swift
func customChallenge(response: String) 
    }
}
```

</Block>

```swift
func customChallenge(response: String) -> AnyCancellable 
        }
        receiveValue: 
}
```

</Block>

</BlockSwitcher>

### Lambda Trigger Setup

The Amplify CLI can be used to generate triggers required by a custom authentication flow. See the [CLI Documentation](/gen1/[platform]/tools/cli/usage/lambda-triggers/) for details. The CLI will create a custom auth flow skeleton that you can manually edit. 

> More information on available triggers can be found in the [Cognito documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).

`AWSCognitoAuthPlugin` assumes the custom auth flow starts with username and password (SRP_A). If you want a passwordless authentication flow, modify your **Define Auth Challenge** Lambda trigger to bypass the initial username/password verification and proceed to the custom challenge:

```javascript
exports.handler = (event, context) =>  else if (
    event.request.session.length === 2 &&
    event.request.session[1].challengeName === 'CUSTOM_CHALLENGE' &&
    event.request.session[1].challengeResult === true
  )  else 
  context.done(null, event);
};
```
You also need to pass a dummy password during the signup process as shown above.

You will know the sign in flow is complete if you see the following in your console window:

```console
Sign in succeeded
```
