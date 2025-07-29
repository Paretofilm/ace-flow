---
title: Documentation
source: fragments/lib-v1/analytics/android/escapehatch.mdx
---

# Documentation

For advanced use cases where Amplify does not provide the functionality, you can retrieve the escape hatch to access the underlying Amazon Pinpoint client.

```java
AWSPinpointAnalyticsPlugin plugin = (AWSPinpointAnalyticsPlugin)
    Amplify.Analytics.getPlugin("awsPinpointAnalyticsPlugin");
AnalyticsClient analyticsClient = plugin.getEscapeHatch();
```

</Block>

```kotlin
val plugin = Amplify.Analytics.getPlugin("awsPinpointAnalyticsPlugin")
val analyticsClient = (plugin as AWSPinpointAnalyticsPlugin).escapeHatch
```

</Block>

```java
AWSPinpointAnalyticsPlugin plugin = (AWSPinpointAnalyticsPlugin)
    RxAmplify.Analytics.getPlugin("awsPinpointAnalyticsPlugin");
AnalyticsClient analyticsClient = plugin.getEscapeHatch();
```

</Block>
</BlockSwitcher>
