---
title: Subscribing Events
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/advanced/advanced.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Subscribing Events

## Subscribing Events

You can take specific actions when users sign-in or sign-out by subscribing to authentication events in your app. Please see our [Hub Module Developer Guide](/gen1/[platform]/build-a-backend/utilities/hub/) for more information.

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


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/advanced/advanced.mdx`