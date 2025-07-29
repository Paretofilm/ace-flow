---
title: Documentation
topics: ['Analytics', 'Getting Started']
primary_topic: Analytics
source: fragments/lib/analytics/android/getting-started/40_record.mdx
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
import com.amplifyframework.analytics.AnalyticsEvent;
import com.amplifyframework.core.Amplify;
```

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
import com.amplifyframework.analytics.AnalyticsEvent
import com.amplifyframework.core.Amplify
```

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
import com.amplifyframework.analytics.AnalyticsEvent;
import com.amplifyframework.rx.RxAmplify;
```

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

> **Note**: 

The AWS Pinpoint event count updates in minutes after recording your event.

However, it can take upwards of 30 minutes for the event to display in the Filter section, and for its custom attributes to appear in Pinpoint.


---

## 📚 Related Topics
- [[Analytics/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/analytics/android/getting-started/40_record.mdx`