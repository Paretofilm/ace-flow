---
title: Documentation
source: fragments/lib-v1/auth/android/escapehatch/10_awsmobileclient_escape.mdx
---

# Documentation

For advanced use cases where Amplify does not provide the functionality you're looking for,
you can retrieve the escape hatch to access the underlying SDK.

The escape hatch provides access to the underlying `AWSMobileClient` instance.

```java
AWSMobileClient mobileClient = (AWSMobileClient) Amplify.Auth.getPlugin("awsCognitoAuthPlugin").getEscapeHatch();
```

</Block>

```kotlin
val cognitoAuthPlugin = Amplify.Auth.getPlugin("awsCognitoAuthPlugin")
val mobileClient = cognitoAuthPlugin.escapeHatch as AWSMobileClient
```

</Block>

```kotlin
val cognitoAuthPlugin = Amplify.Auth.getPlugin("awsCognitoAuthPlugin")
val mobileClient = cognitoAuthPlugin.escapeHatch as AWSMobileClient
```

</Block>

```java
AWSMobileClient mobileClient =
    (AWSMobileClient) RxAmplify.Auth.getPlugin("awsCognitoAuthPlugin").getEscapeHatch();
```

</Block>
</BlockSwitcher>

You can use the escape hatch to `federatedSignIn` with a valid token from other social providers. Find more details [here](/gen1/[platform]/sdk/auth/federated-identities/)

```java
mobileClient.federatedSignIn(IdentityProvider.FACEBOOK.toString(), "", new Callback() 

    @Override
    public void onError(Exception e) 
});
```
