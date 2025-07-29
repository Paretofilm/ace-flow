---
title: Identity Pool Federation
source: pages/build-a-backend/auth/advanced-workflows/index.mdx
---

# Identity Pool Federation

## Identity Pool Federation

With identity federation, you don't need to create custom sign-in code or manage your own user identities. Instead, users of your app can sign in using a well-known external identity 
provider (IdP), such as Login with Amazon, Facebook, Google, or any other OpenID Connect (OIDC)-compatible IdP. They can receive an authentication token, and then exchange that token for 
temporary security credentials in AWS that map to an IAM role with permissions to use the resources in your AWS account. Using an IdP helps you keep your AWS account secure because you 
don't have to embed and distribute long-term security credentials with your application.

Imagine that you are creating a mobile app that accesses AWS resources, such as a game that runs on a mobile device and stores player and score information using Amazon S3 and DynamoDB.

When you write such an app, you make requests to AWS services that must be signed with an AWS access key. However, we strongly recommend that you do not embed or distribute long-term 
AWS credentials with apps that a user downloads to a device, even in an encrypted store. Instead, build your app so that it requests temporary AWS security credentials dynamically when 
needed using identity federation. The supplied temporary credentials map to an AWS role that has only the permissions needed to perform the tasks required by the mobile app.

You can use `federateToIdentityPool` to get AWS credentials directly from Cognito Federated Identities and not use User Pool federation. If you logged in with `Auth.signIn` you **cannot** 
call `federateToIdentityPool` as Amplify will perform this federation automatically for you in the background. In general, you should only call `Auth.federatedSignIn()` when using OAuth flows.

You can use the escape hatch API `federateToIdentityPool` with a valid token from other social providers.

```dart
final cognitoPlugin =
    Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
const googleIdToken = 'idToken';
final session = await cognitoPlugin.federateToIdentityPool(
  token: googleIdToken,
  provider: AuthProvider.google,
);
```

> **Note**: 

Note that when federated, APIs such as `Auth.getCurrentUser` will throw an error as the user is not authenticated with User Pools.

### Retrieve Session

After federated login, you can retrieve the session using the `Auth.fetchAuthSession` API.

### Token Refresh

> **Note**: 

Automatic authentication token refresh is NOT supported when federated.

By default, Amplify will **NOT** automatically refresh the tokens from the federated providers. You will need to handle the token refresh logic and provide the new token to the `federateToIdentityPool` API.

### Clear Session

You can clear the federated session using the `clearFederationToIdentityPool` API.

```dart
final cognitoPlugin =
    Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
await cognitoPlugin.clearFederationToIdentityPool();
```

> **Note**: 

`clearFederationToIdentityPool` will only clear the session from the local cache; the developer needs to handle signing out from the federated identity provider.

### Provide Custom Identity ID

You can provide a custom identity ID to the `federateToIdentityPool` API. This is useful when you want to use the same identity ID across multiple sessions.

```dart
final cognitoPlugin =
    Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
const googleIdToken = 'idToken';
const identityId = 'us-west-2:b4cd4809-7ab1-42e1-b044-07dab9eaa768';
final session = await cognitoPlugin.federateToIdentityPool(
  token: googleIdToken,
  provider: AuthProvider.google,
  options: FederateToIdentityPoolOptions(
    developerProvidedIdentityId: identityId,
  ),
);
```
</InlineFilter>

## Subscribing Events

You can take specific actions when users sign-in or sign-out by subscribing to authentication events in your app. Please see our [Hub Module Developer Guide](/[platform]/build-a-backend/auth/connect-your-frontend/listen-to-auth-events/) for more information.

## Identity Pool Federation

Imagine that you are creating a mobile app that accesses AWS resources, such as a game that runs on a mobile device and stores player and score information using Amazon S3 and DynamoDB.

When you write such an app, you make requests to AWS services that must be signed with an AWS access key. However, we strongly recommend that you do not embed or distribute long-term AWS credentials with apps that a user downloads to a device, even in an encrypted store. Instead, build your app so that it requests temporary AWS security credentials dynamically when needed using web identity federation. The supplied temporary credentials map to an AWS role that has only the permissions needed to perform the tasks required by the mobile app.

With web identity federation, you don't need to create custom sign-in code or manage your own user identities. Instead, users of your app can sign in using a well-known external identity provider (IdP), such as Login with Amazon, Facebook, Google, or any other OpenID Connect (OIDC)-compatible IdP. They can receive an authentication token, and then exchange that token for temporary security credentials in AWS that map to an IAM role with permissions to use the resources in your AWS account. Using an IdP helps you keep your AWS account secure because you don't have to embed and distribute long-term security credentials with your application.

You can use `federateToIdentityPool` to get AWS credentials directly from Cognito Federated Identities and not use User Pool federation. If you logged in with `Auth.signIn` you **cannot** call `federateToIdentityPool` as Amplify will perform this federation automatically for you in the background. In general, you should only call `Auth.federatedSignIn()` when using OAuth flows.

You can use the escape hatch API `federateToIdentityPool` with a valid token from other social providers.

```java
if (Amplify.Auth.getPlugin("awsCognitoAuthPlugin") instanceof AWSCognitoAuthPlugin) ,
        e -> 
    );
}
```

</Block>

```kotlin
(Amplify.Auth.getPlugin("awsCognitoAuthPlugin") as? AWSCognitoAuthPlugin)?.let ,
        
    )
}
```

</Block>
</BlockSwitcher>

> **Note**: 
Note that when federated, APIs such as Auth.getCurrentUser will throw an error as the user is not authenticated with User Pools.

### Retrieve Session

After federated login, you can retrieve the session using the `Auth.fetchAuthSession` API.

### Token Refresh

> **Note**: 
Automatic authentication token refresh is NOT supported when federated.

By default, Amplify will **NOT** automatically refresh the tokens from the federated providers. You will need to handle the token refresh logic and provide the new token to the `federateToIdentityPool` API.

### Clear Session

You can clear the federated session using the `clearFederationToIdentityPool` API.

```java
if (Amplify.Auth.getPlugin("awsCognitoAuthPlugin") instanceof AWSCognitoAuthPlugin) 
```

</Block>

```kotlin
(Amplify.Auth.getPlugin("awsCognitoAuthPlugin") as? AWSCognitoAuthPlugin)?.let ,
        
    )
}
```

</Block>
</BlockSwitcher>

> **Note**: 
`clearFederationToIdentityPool` will only clear the session from the local cache, the developer needs to handle signing out from the federated provider.

### Provide Custom Identity Id

You can provide a custom identity id to the `federateToIdentityPool` API. This is useful when you want to use the same identity id across multiple devices.

```java
FederateToIdentityPoolOptions options = FederateToIdentityPoolOptions.builder()
    .developerProvidedIdentityId("YOUR_CUSTOM_IDENTITY_ID")
    .build();

if (Amplify.Auth.getPlugin("awsCognitoAuthPlugin") instanceof AWSCognitoAuthPlugin) ,
        e -> 
    );
}
```

</Block>

```kotlin
val options = FederateToIdentityPoolOptions.builder()
    .developerProvidedIdentityId("YOUR_CUSTOM_IDENTITY_ID")
    .build()

(Amplify.Auth.getPlugin("awsCognitoAuthPlugin") as? AWSCognitoAuthPlugin)?.let ,
        
    )
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

## Subscribing Events

You can take specific actions when users sign-in or sign-out by subscribing authentication events in your app. Please see our [Hub Module Developer Guide](/[platform]/build-a-backend/auth/connect-your-frontend/listen-to-auth-events/) for more information.

## Identity Pool Federation

Imagine that you are creating a mobile app that accesses AWS resources, such as a game that runs on a mobile device and stores player and score information using Amazon S3 and DynamoDB.

When you write such an app, you make requests to AWS services that must be signed with an AWS access key. However, we strongly recommend that you do not embed or distribute long-term AWS credentials with apps that a user downloads to a device, even in an encrypted store. Instead, build your app so that it requests temporary AWS security credentials dynamically when needed using web identity federation. The supplied temporary credentials map to an AWS role that has only the permissions needed to perform the tasks required by the mobile app.

With web identity federation, you don't need to create custom sign-in code or manage your own user identities. Instead, users of your app can sign in using a well-known external identity provider (IdP), such as Login with Amazon, Facebook, Google, or any other OpenID Connect (OIDC)-compatible IdP. They can receive an authentication token, and then exchange that token for temporary security credentials in AWS that map to an IAM role with permissions to use the resources in your AWS account. Using an IdP helps you keep your AWS account secure, because you don't have to embed and distribute long-term security credentials with your application.

You can use `federateToIdentityPool` to get AWS credentials directly from Cognito Federated Identities and not use User Pool federation. If you have logged in with `Auth.signIn` you **can not** call `federateToIdentityPool` as Amplify will perform this federation automatically for you in the background. In general, you should only call `Auth.federateToIdentityPool` when using OAuth flows. 

You can use the escape hatch API `federateToIdentityPool` with a valid token from other social providers.

```swift
func federateToIdentityPools() async throws 
    do  catch 
}
```

> **Note**: 
Note that when federated, API's such as Auth.getCurrentUser() will throw an error as the user is not authenticated with User Pools.

### Retrieve Session

After federated login, you can retrieve session using the `Auth.fetchAuthSession` API.

### Token Refresh

> **Note**: 
NOTE: Automatic authentication token refresh is NOT supported when federated.

By default, Amplify will **NOT** automatically refresh the tokens from the federated providers. You will need to handle the token refresh logic and provide the new token to the `federateToIdentityPool` API.

### Clear Session

You can clear the federated session using the `clearFederationToIdentityPool` API.

```swift
func clearFederationToIdentityPools() async throws 
    do  catch 
}
```

> **Note**: 
clearFederationToIdentityPool will only clear the session from local cache, developer need to handle signing out from the federated provider.

### Provide Custom Identity Id

You can provide a custom identity id to the `federateToIdentityPool` API. This is useful when you want to use the same identity id across multiple devices.

```swift
func federateToIdentityPoolsUsingCustomIdentityId() async throws 
    do  catch 
}
```

## Keychain Sharing

### Migrating to a Shared Keychain

To use a shared keychain:

1. In Xcode, go to Project Settings → Your Target → Signing & Capabilities
2. Select +Capability
3. Add Keychain Sharing capability
4. Add a keychain group
5. Repeat for all apps for which you want to share auth state, adding the same keychain group for all of them

To move to the shared keychain using this new keychain access group, specify the `accessGroup` parameter when instantiating the `AWSCognitoAuthPlugin`. If a user is currently signed in, they will be signed out when first using the access group:

```swift
let accessGroup = AccessGroup(name: "\(teamID)com.example.sharedItems")
let secureStoragePreferences = AWSCognitoSecureStoragePreferences(
  accessGroup: accessGroup)
try Amplify.add(
  plugin: AWSCognitoAuthPlugin(
    secureStoragePreferences: secureStoragePreferences))
try Amplify.configure()
```

If you would prefer the user session to be migrated (which will allow the user to continue to be signed in), then specify the `migrateKeychainItemsOfUserSession` boolean in the AccessGroup to be true like so:

```swift
let accessGroup = AccessGroup(
  name: "\(teamID)com.example.sharedItems",
  migrateKeychainItemsOfUserSession: true)
let secureStoragePreferences = AWSCognitoSecureStoragePreferences(
  accessGroup: accessGroup)
try Amplify.add(
  plugin: AWSCognitoAuthPlugin(
    secureStoragePreferences: secureStoragePreferences))
try Amplify.configure()
```

Sign in a user with any sign-in method within one app that uses this access group. After reloading another app that uses this access group, the user will be signed in. Likewise, signing out of one app will sign out the other app after reloading it.

### Migrating to another Shared Keychain

To move to a different access group, update the name parameter of the AccessGroup to be the new access group. Set `migrateKeychainItemsOfUserSession` to `true` to migrate an existing user session under the previously used access group.

### Migrating from a Shared Keychain

If you'd like to stop sharing state between this app and other apps, you can set the access group to be `AccessGroup.none` or `AccessGroup.none(migrateKeychainItemsOfUserSession: true)` if you'd like the session to be migrated.

### Retrieving Team ID

First, ensure your Info.plist has the `AppIdentifierPrefix` key:

```xml title="Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>AppIdentifierPrefix</key>
    <string>$(AppIdentifierPrefix)</string>
</dict>
</plist>
```

Then, you can retrieve the team ID from your Info.plist:

```swift
guard let teamID = Bundle.main.infoDictionary?["AppIdentifierPrefix"] as? String else 
```

</InlineFilter>

## Subscribing to Events

You can take specific actions when users sign-in or sign-out by subscribing to authentication events in your app. Please see our [Hub Module Developer Guide](/[platform]/build-a-backend/auth/connect-your-frontend/listen-to-auth-events/) for more information.

## Identity Pool Federation

You can alternatively create your own custom credentials provider to get AWS credentials directly from Cognito Federated Identities and not use User Pool federation. You must supply the custom credentials provider to Amplify via the `Amplify.configure` method call. Below, you can see sample code of how such a custom provider can be built to achieve the use case.

```js
import  from 'aws-amplify/auth';

// Note: This example requires installing `@aws-sdk/client-cognito-identity` to obtain Cognito credentials
// npm add @aws-sdk/client-cognito-identity

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

With the triggers property of defineAuth and defineFunction from the new Functions implementation, you can define [Lambda Triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html) for your Cognito User Pool. These enable you to add custom functionality to your registration and authentication flows. [Check out a preSignUp hook example here.](/[platform]/build-a-backend/functions/examples/email-domain-filtering/)

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

</InlineFilter>
