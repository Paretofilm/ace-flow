---
title: Custom Authentication in Amplify
source: fragments/sdk/auth/android/custom-auth-flow.mdx
---

# Custom Authentication in Amplify

Amazon Cognito User Pools supports customizing the authentication flow to enable custom challenge types, in addition to a password in order to verify the identity of users. These challenge types may include CAPTCHAs or dynamic challenge questions.

To define your challenges for custom authentication flow, you need to implement three Lambda triggers for Amazon Cognito.

For more information about working with Lambda Triggers for custom authentication challenges, please visit [Amazon Cognito Developer Documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).

## Custom Authentication in Amplify

To initiate a custom authentication flow in your app, specify `authenticationFlowType` as `CUSTOM_AUTH` in the awsconfiguration.json file. Note that is not currently supported by the CLI and developers must manually update the awsconfiguration.json to specify `authenticationFlowType` as follows : 

```json

  },
  "Auth": 
  }
}
```

Next, in the app code  call `signIn` with a dummy password. Any custom challenges needs to be answered using the `confirmSignIn` method as follows:

```java
public void signIn() 
                }
            });
        }

        @Override
        public void onError(Exception e) 
    });
}

public void confirmSignIn() 
                }
            });
        }

        @Override
        public void onError(Exception e) 
    });
}
```

### Lambda trigger setup

Amplify CLI can be used generate lambda triggers required by a custom authentication flow. See [documentation](/gen1/[platform]/tools/cli/usage/lambda-triggers/) for details. Amplify CLI creates a custom auth flow skeleton that you can manually edit. More information on each of the triggers can be found in [Cognito documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html).

`AWSMobileClient` assumes that custom auth flows start with username and password. If you want a passwordless custom authentication flow, modify your `Define Auth Challenge` Lambda trigger to bypass the initial username/password verification and proceed to the custom challenge, as in the code below.

```javascript
exports.handler = (event, context) =>  else if (
    event.request.session.length === 2 &&
    event.request.session[1].challengeName === 'CUSTOM_CHALLENGE' &&
    event.request.session[1].challengeResult === true
  )  else 
  context.done(null, event);
};
```
