---
title: Use AWS SDK
source: pages/build-a-backend/add-aws-services/analytics/sdk/index.mdx
---

# Use AWS SDK

For advanced use cases where Amplify does not provide the functionality, you can retrieve an escape hatch to access the underlying Amazon Pinpoint client.

Add the following import:

```swift
import AWSPinpointAnalyticsPlugin
```

Then retrieve the escape hatch with this code:

```swift
do 

    // Retrieve the reference to PinpointClientProtocol
    let pinpointClient = analyticsPlugin.getEscapeHatch()

    // Make requests using pinpointClient...
    // ...
} catch 
```
</InlineFilter>

For advanced use cases where Amplify does not provide the functionality, you can retrieve an escape hatch to access the underlying Amazon Pinpoint client.

> **Note**: 

Learn more about consuming Kotlin clients from Java using either a blocking interface or an equivalent async interface based on futures [here](https://github.com/awslabs/smithy-kotlin/blob/main/docs/design/kotlin-smithy-sdk.md#java-interop).

```java
AWSPinpointAnalyticsPlugin plugin = (AWSPinpointAnalyticsPlugin)
    Amplify.Analytics.getPlugin("awsPinpointAnalyticsPlugin");
PinpointClient pinpointClient = plugin.getEscapeHatch();
```

</Block>

```kotlin
val plugin = Amplify.Analytics.getPlugin("awsPinpointAnalyticsPlugin")
val pinpointClient = (plugin as AWSPinpointAnalyticsPlugin).escapeHatch
```

</Block>

```java
AWSPinpointAnalyticsPlugin plugin = (AWSPinpointAnalyticsPlugin)
    RxAmplify.Analytics.getPlugin("awsPinpointAnalyticsPlugin");
PinpointClient pinpointClient = plugin.getEscapeHatch();
```

</Block>
</BlockSwitcher>
</InlineFilter>
