---
title: Documentation
source: fragments/lib/auth/android/escapehatch/escapehatch.mdx
---

# Documentation

For advanced use cases where Amplify does not provide the functionality you're looking for,
you can retrieve the escape hatch to access the underlying SDK.

The escape hatch provides access to the underlying `CognitoIdentityProviderClient` and `CognitoIdentityClient` instance. Then retrieve the escape hatch with this code:

**Gradle Imports**

```groovy
implementation "aws.sdk.kotlin:cognitoidentityprovider:KOTLIN_SDK_VERSION"
implementation "aws.sdk.kotlin:cognitoidentity:KOTLIN_SDK_VERSION"
```

```java
// Get the instance of AWSCognitoAuthPlugin
AWSCognitoAuthPlugin cognitoAuthPlugin = (AWSCognitoAuthPlugin) Amplify.Auth.getPlugin("awsCognitoAuthPlugin");

// Get the instance of CognitoIdentityProviderClient
CognitoIdentityProviderClient client = cognitoAuthPlugin.getEscapeHatch().getCognitoIdentityProviderClient();
ResendConfirmationCodeRequest request = ResendConfirmationCodeRequest.Companion.invoke(dslBuilder -> );

assert client != null;
client.resendConfirmationCode(request, new Continuation() 

    @Override
    public void resumeWith(@NonNull Object resultOrException) 
});
```

</Block>

```kotlin
suspend fun resendCodeUsingEscapeHatch() 
    val response = cognitoIdentityProviderClient?.resendConfirmationCode(request)
}
```

</Block>

</BlockSwitcher>
