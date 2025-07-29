---
title: Custom Authentication in Amplify
source: fragments/sdk/auth/ios/custom-auth-flow.mdx
---

# Custom Authentication in Amplify

Amazon Cognito User Pools supports customizing the authentication flow to enable custom challenge types. These challenge types may include CAPTCHAs or dynamic challenge questions. To define your challenges you need to implement three Lambda triggers.

> For more information about working with Lambda Triggers for custom authentication challenges visit [Amazon Cognito Developer Documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).

## Custom Authentication in Amplify

To enable a custom authentication flow update your `awsconfiguration.json` file and set `authenticationFlowType` to `CUSTOM_AUTH`.

```json

  },
  "Auth": 
  }
}
```

In your app code call `signIn` with a dummy password. Custom challenges need to be answered using the `confirmSignIn` method:

```swift
AWSMobileClient.default().signIn(
  username: username,
  password: "dummyPassword"
) 
    }
}
```

Get the challenge details from the user and then call `confirmSignIn`

```swift
AWSMobileClient.default().confirmSignIn(
  challengeResponse: "",
  completionHandler:  else if let signInResult = signInResult 
    }
  }
)
```

### Lambda Trigger Setup

The Amplify CLI can be used to generate triggers required by a custom authentication flow. See the [CLI Documentation](/gen1/[platform]/tools/cli/usage/lambda-triggers/) for details. The CLI will create a custom auth flow skeleton that you can manually edit.

> More information on available triggers can be found in the [Cognito documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).

`AWSMobileClient` assumes the custom auth flow starts with username and password. If you want a passwordless authentication flow, modify your **Define Auth Challenge** Lambda trigger to bypass the initial username/password verification and proceed to the custom challenge:

```javascript
exports.handler = (event, context) =>  else if (
    event.request.session.length === 2 &&
    event.request.session[1].challengeName === 'CUSTOM_CHALLENGE' &&
    event.request.session[1].challengeResult === true
  )  else 
  context.done(null, event);
};
```
