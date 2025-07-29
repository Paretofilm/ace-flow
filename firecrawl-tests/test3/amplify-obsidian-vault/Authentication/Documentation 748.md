---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/escapehatch/escapehatch.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

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


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/escapehatch/escapehatch.mdx`