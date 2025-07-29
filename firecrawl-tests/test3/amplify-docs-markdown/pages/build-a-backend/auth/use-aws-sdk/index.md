---
title: Use AWS SDK
source: pages/build-a-backend/auth/use-aws-sdk/index.mdx
---

# Use AWS SDK

For advanced use cases where Amplify does not provide the functionality, you can retrieve an escape hatch to access the underlying Amazon Cognito client.

The escape hatch provides access to the underlying `AWSCognitoIdentityProvider` instance. Import the necessary types:

```swift
import AWSCognitoAuthPlugin
import AWSCognitoIdentityProvider
```

Then retrieve the escape hatch with this code:

```swift
func getEscapeHatch()  else if case .userPool(let userPoolClient) = plugin?.getEscapeHatch()  else 
    print("Fetched escape hatch - \(String(describing: client))")
}
```
</InlineFilter>

You can access the underlying `CognitoIdentityProviderClient` and `CognitoIdentityClient` as shown below

```kotlin
implementation "aws.sdk.kotlin:cognitoidentityprovider:1.0.44"
implementation "aws.sdk.kotlin:cognitoidentity:1.0.44"
```

```kotlin
suspend fun resendCodeUsingEscapeHatch() 
    val response = cognitoIdentityProviderClient?.resendConfirmationCode(request)
}
```

</Block>

> **Note**: 

[Learn more about consuming Kotlin clients from Java using either a blocking interface or an equivalent async interface based on futures](https://github.com/awslabs/smithy-kotlin/blob/main/docs/design/kotlin-smithy-sdk.md#java-interop).

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
</BlockSwitcher>
</InlineFilter>
