---
title: Using Amplify V2 Auth with AWS Android SDK Plugin
source: pages/sdk/configuration/amplify-compatibility/index.mdx
---

# Using Amplify V2 Auth with AWS Android SDK Plugin

> **Note**: 
The AWS Mobile Client (com.amazonaws:aws-android-sdk-mobile-client) and Amplify Android v2 are not compatible with each other. Amplify v2 migrates the credentials from AWS Mobile Client into a different format, leaving AWS Mobile Client unable to read the credentials. If AWS Mobile Client is launched after this migration has taken place, the Amplify v2 credentials will also be cleared.

## Using Amplify V2 Auth with AWS Android SDK Plugin

We recommend using Amplify v2 with the [AWS Kotlin SDK](https://aws.amazon.com/sdk-for-kotlin/), rather than the AWS Android SDK. In order to better support existing implementations, this guide demonstrates how to continue using AWS Android SDK plugins with Amplify v2.

### Creating an AmplifyCredentialsProvider

Many of the AWS Android SDK plugins accept a custom `AWSCredentialsProvider` implementation. You can implement your own `AWSCredentialsProvider` that uses Amplify Android v2 to provide credentials. 

```java
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSCredentialsProvider;
import com.amazonaws.auth.BasicSessionCredentials;
import com.amplifyframework.auth.AWSTemporaryCredentials;
import com.amplifyframework.auth.cognito.AWSCognitoAuthSession;
import com.amplifyframework.auth.options.AuthFetchSessionOptions;
import com.amplifyframework.core.Amplify;

import java.util.concurrent.CompletableFuture;

class AmplifyCredentialsProvider implements AWSCredentialsProvider 
            }

            if (credentials != null)  else 
        }, (exception) -> sdkCredentials.completeExceptionally(
                new RuntimeException("Failed to get credentials", exception)
        ));

        return sdkCredentials.join();
    }

    @Override
    public void refresh() 
}
```

</Block>

```kotlin
import com.amazonaws.auth.AWSCredentials
import com.amazonaws.auth.AWSCredentialsProvider
import com.amazonaws.auth.BasicSessionCredentials
import com.amplifyframework.auth.AWSTemporaryCredentials
import com.amplifyframework.auth.cognito.AWSCognitoAuthSession
import com.amplifyframework.auth.options.AuthFetchSessionOptions
import com.amplifyframework.core.Amplify
import java.lang.RuntimeException
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlin.coroutines.suspendCoroutine
import kotlinx.coroutines.runBlocking

class AmplifyCredentialsProvider : AWSCredentialsProvider 

                    if (sdkCredentials != null)  else 
                },
                
            )
        }
    }

    override fun refresh() = runBlocking ,
                // We do not need to throw if refresh fails
                
            )
        }
    }
}
```

</Block>
</BlockSwitcher>

You can now use your `AmplifyCredentialsProvider` in any plugins that accept an `AWSCredentialsProvider`, instead of using `AWSMobileClient.getInstance()` as your AWSCredentialsProvider.

## Providing AWS Configuration Information

Amplify v2 uses the `amplify_outputs.json` file where AWS Android SDK uses the `awsconfiguration.json` file. If you are using both Amplify v2 and AWS Android SDK in your project, it is important to ensure the resources are in sync. The Amplify CLI still generates and updates both of these file types, but any manual customizations should be applied to both files.

For AWS Android SDK plugins that require configuration information, you can continue to use the `AWSConfiguration` class.

```java
AWSConfiguration awsConfiguration = new AWSConfiguration(context);
```

</Block>

```kotlin
val awsConfiguration = AWSConfiguration(context)
```

</Block>
</BlockSwitcher>

## Example Usage of  AWS Android SDK Plugins with Amplify v2

This is not an exhaustive list of supported plugins. Any plugins that accept an AWSCredentialsProvider and do not rely on AWS Mobile Client should work.

### S3 Storage (com.amazonaws:aws-android-sdk-s3)

```java
AWSConfiguration awsConfiguration = new AWSConfiguration(context);
TransferUtility transferUtility = TransferUtility.builder()
    .context(context)
    .awsConfiguration(awsConfig)
    .s3Client(
        new AmazonS3Client(
            new AmplifyCredentialsProvider(),
            Region.getRegion(Regions.US_EAST_1)
        )
    )
    .build();
```

</Block>

```kotlin
val awsConfiguration = AWSConfiguration(context)
val transferUtility = TransferUtility.builder()
    .context(context)
    .awsConfiguration(awsConfiguration)
    .s3Client(
        AmazonS3Client(
            AmplifyCredentialsProvider(),
            Region.getRegion(Regions.US_EAST_1)
        )
    )
    .build()
```

</Block>
</BlockSwitcher>

### IoT (com.amazonaws:aws-android-sdk-iot)

```java
AWSIotClient client = new AWSIotClient(new AmplifyCredentialsProvider());

```

</Block>

```kotlin
val client = AWSIotClient(AmplifyCredentialsProvider())
```

</Block>
</BlockSwitcher>

### Android SDK Generated by API Gateway (aws-android-sdk-apigateway-core)

```java
ApiClientFactory clientFactory = new ApiClientFactory();
clientFactory.credentialsProvider(new AmplifyCredentialsProvider());
```

</Block>

```kotlin
val clientFactory = ApiClientFactory()
clientFactory.credentialsProvider(AmplifyCredentialsProvider())
```

</Block>
</BlockSwitcher>

</InlineFilter>
