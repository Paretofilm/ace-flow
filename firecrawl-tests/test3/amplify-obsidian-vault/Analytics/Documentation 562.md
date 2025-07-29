---
title: Documentation
topics: ['Analytics', 'Getting Started']
primary_topic: Analytics
source: fragments/lib-v1/analytics/android/getting-started/40_record.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics, getting-started]
---


## 🧭 Navigation
**Topics**: [[Analytics/]] • [[Getting Started/]]
**Primary**: [[Analytics/]]

---


# Documentation

To record an event, create an `AnalyticsEvent` and call `Amplify.Analytics.recordEvent()` to send it:

```java
AnalyticsEvent event = AnalyticsEvent.builder()
    .name("PasswordReset")
    .addProperty("Channel", "SMS")
    .addProperty("Successful", true)
    .addProperty("ProcessDuration", 792)
    .addProperty("UserAge", 120.3)
    .build();

Amplify.Analytics.recordEvent(event);
```

</Block>

```kotlin
val event = AnalyticsEvent.builder()
    .name("PasswordReset")
    .addProperty("Channel", "SMS")
    .addProperty("Successful", true)
    .addProperty("ProcessDuration", 792)
    .addProperty("UserAge", 120.3)
    .build()

Amplify.Analytics.recordEvent(event)
```

</Block>

```java
AnalyticsEvent event = AnalyticsEvent.builder()
    .name("PasswordReset")
    .addProperty("Channel", "SMS")
    .addProperty("Successful", true)
    .addProperty("ProcessDuration", 792)
    .addProperty("UserAge", 120.3)
    .build();

RxAmplify.Analytics.recordEvent(event);
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Analytics/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/analytics/android/getting-started/40_record.mdx`