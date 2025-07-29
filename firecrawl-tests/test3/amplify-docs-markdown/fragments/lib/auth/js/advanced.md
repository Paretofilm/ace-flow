---
title: Subscribing to Events
source: fragments/lib/auth/js/advanced.mdx
---

# Subscribing to Events

## Subscribing to Events

You can take specific actions when users sign-in or sign-out by subscribing to authentication events in your app. Please see our [Hub Module Developer Guide](/gen1/[platform]/build-a-backend/utilities/hub/) for more information.

## Identity Pool Federation

You can alternatively create your own custom credentials provider to get AWS credentials directly from Cognito Federated Identities and not use User Pool federation. You must supply the custom credentials provider to Amplify via the `Amplify.configure` method call. Below, you can see sample code of how such a custom provider can be built to achieve the use case.

```js
import  from 'aws-amplify/auth';

// Note: This example requires installing `@aws-sdk/client-cognito-identity` to obtain Cognito credentials
// npm i @aws-sdk/client-cognito-identity

// You can make use of the sdk to get identityId and credentials
const cognitoidentity = new CognitoIdentity();

// Note: The custom provider class must implement CredentialsAndIdentityIdProvider
class CustomCredentialsProvider implements CredentialsAndIdentityIdProvider ;

  // Custom method to load the federated login information
  loadFederatedLogin(login?: typeof this.federatedLogin) 

  async getCredentialsAndIdentityId(
    getCredentialsOptions: GetCredentialsOptions
  ): Promise ,
      });

      const cognitoCredentialsResult = await cognitoidentity.getCredentialsForIdentity(,
      });

      const credentials: CredentialsAndIdentityId = ,
        identityId: getIdResult.IdentityId,
      };
      return credentials;
    } catch (e) 
  }
  // Implement this to clear any cached credentials and identityId. This can be called when signing out of the federation service.
  clearCredentialsAndIdentityId(): void 
}

// Create an instance of your custom provider
const customCredentialsProvider = new CustomCredentialsProvider();
Amplify.configure(awsconfig, ,
});

```

Now that the custom credentials provider is built and supplied to `Amplify.configure`, let's look at how you can use the custom credentials provider to finish federation into Cognito identity pool.

### Facebook Sign-in (React Native - Expo)

```javascript

const App = () =>  =
      await Expo.Facebook.logInWithReadPermissionsAsync(
        'YOUR_FACEBOOK_APP_ID',
        
      );
    if (type === 'success') );
        const fetchSessionResult = await fetchAuthSession(); // will return the credentials
        console.log('fetchSessionResult: ', fetchSessionResult);
      } catch (err) 
    }
  };

  // ...

  return (

    </View>
  );
};
```

</InlineFilter>

### Facebook sign-in (React)

```js
import  from 'aws-amplify/auth';

// To federated sign in from Facebook
const SignInWithFacebook = () => , [])

  const signIn = () =>  else 
            customCredentialsProvider.loadFederatedLogin();
            const fetchSessionResult = await fetchAuthSession(); // will return the credentials
            console.log('fetchSessionResult: ', fetchSessionResult);
          },
          
        );
      }
    });
  }

  const createScript = () => 

  const initFB = () => 

  const fbAsyncInit = () => );
  }

  return (
    <div>
      <button onClick=>Sign in with Facebook</button>
    </div>
  );
}
```

### Google sign-in (React)

```jsx
import  from 'aws-amplify/auth';

const SignInWithGoogle = () => , []);

  // Load the Google client
  const createScript = () => 

  // Initialize Google client and render Google button
  const initGsi = () => );
          const fetchSessionResult = await fetchAuthSession(); // will return the credentials
          console.log('fetchSessionResult: ', fetchSessionResult);
        },
      });
      window.google.accounts.id.renderButton(
        document.getElementById('googleSignInButton'),
        
      );
    }
  }

  return (
    <div>
      <button id='googleSignInButton'/>
    </div>
  );
}
```

### Federate with Auth0

You can use `Auth0` as one of the providers of your Cognito Identity Pool. This will allow users authenticated via Auth0 have access to your AWS resources.

Step 1. [Follow Auth0 integration instructions for Cognito Federated Identity Pools](https://auth0.com/docs/integrations/integrating-auth0-amazon-cognito-mobile-apps)

Step 2. Login with `Auth0`, then use the id token returned to get AWS credentials from `Cognito Federated Identity Pools` using custom credentials provider you created at the start:

```js

const  = getFromAuth0(); // get the user credentials and info from auth0

async function getCognitoCredentials() );
    const fetchSessionResult = await fetchAuthSession(); // will return the credentials
    console.log('fetchSessionResult: ', fetchSessionResult);
  } catch (err) 
}
```

</InlineFilter>

## Lambda Triggers

The CLI allows you to configure [Lambda Triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html) for your Cognito User Pool. These enable you to add custom functionality to your registration and authentication flows. [Read more](/gen1/[platform]/build-a-backend/functions/set-up-function/)

### Pre Authentication and Pre Sign-up Lambda triggers

If you have a Pre Authentication Lambda trigger enabled, you can pass `clientMetadata` as an option for `signIn`. This metadata can be used to implement additional validations around authentication.

```ts

async function handleSignIn(username: string, password: string)  // Optional, an object of key-value pairs which can contain any key and will be passed to your Lambda trigger as-is.
      }
    });
  } catch (err) 
}
```

### Passing metadata to other Lambda triggers

Many Cognito Lambda Triggers also accept unsanitized key/value pairs in the form of a `clientMetadata` attribute. This attribute can be specified for various Auth APIs which result in Cognito Lambda Trigger execution.

These APIs include:

- `signIn`
- `signUp`
- `confirmSignIn`
- `confirmSignUp`
- `resetPassword`
- `confirmResetPassword`
- `resendSignUpCode`
- `updateUserAttributes`

Please note that some of triggers which accept a `validationData` attribute will use `clientMetadata` as the value for `validationData`. Exercise caution with using `clientMetadata` when you are relying on `validationData`.

## Working with AWS service objects

You can use AWS _Service Interface Objects_ to work with AWS Services in authenticated State. You can call methods on any AWS Service interface object by passing your credentials from Amplify `fetchAuthSession` to the service call constructor:

```javascript

async function changeResourceRecordSets()  = await fetchAuthSession();

    const route53 = new Route53();

    // more code working with route53 object
    //route53.changeResourceRecordSets();
  } catch (err) 
}
```

> **Note**: 

Note: To work with Service Interface Objects, your Amazon Cognito users' [IAM role](https://docs.aws.amazon.com/cognito/latest/developerguide/iam-roles.html) must have the appropriate permissions to call the requested services.

## Custom Token providers

Create a custom Auth token provider for situations where you would like provide your own tokens for a service. For example, using OIDC Auth with AppSync.  You must supply the token provider to Amplify via the `Amplify.configure` method call. Below, you can see sample code of how such a custom provider can be built to achieve the use case.

```javascript

// ...

const myTokenProvider: TokenProvider =  = ) 

    const accessTokenString = '<insert JWT from provider>';
    const idTokenString = '<insert JWT from provider>';
    
    return ;
  },
};

Amplify.configure(awsconfig, 
});

```
## API reference

For the complete API documentation for Authentication module, visit our [API Reference](https://aws-amplify.github.io/amplify-js/api/modules/aws_amplify.auth.html)
