---
title: Record event
topics: ['Analytics']
primary_topic: Analytics
source: fragments/lib/analytics/flutter/record.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics]
---


## 🧭 Navigation
**Topics**: [[Analytics/]]
**Primary**: [[Analytics/]]

---


# Record event

## Record event

The Amplify analytics plugin also makes it easy to record custom events within the app. The plugin handles retry logic in the event the device looses network connectivity and automatically batches requests to reduce network bandwidth.

```dart
Future<void> recordCustomEvent() async 
```

> **Note**: 

The AWS Pinpoint event count updates in minutes after recording your event.

However, it can take upwards of 30 minutes for the event to display in the Filter section, and for its custom attributes to appear in Pinpoint. 

> **Note**: 

Security Notice: Amplify Analytics temporarily stores event data locally in an unencrypted format before sending it to Pinpoint. 

To protect your sensitive information, please do not include any passwords, API keys, or other confidential information in your analytic events.

## Flush events

Events have default configuration to flush out to the network every 30 seconds. To modify the default value, assign the `autoFlushEventsInterval` property to your desired duration. The example below configures the plugin to flush events every 10 seconds.

```json
,
        "pinpointTargeting": ,
        "autoFlushEventsInterval": 10
      }
    }
  }
}
```

> **Note**
>
> Setting `autoFlushEventsInterval` to 0 will **disable** the automatic flush of events and you will be responsible for submitting them.

To manually flush events, call:

```dart
await Amplify.Analytics.flushEvents();
```

## Global Properties

You can register global properties which will be sent along with all invocations of `Amplify.Analytics.recordEvent`.

```dart
Future<void> registerGlobalProperties() async 
```

To unregister a global property, call `Amplify.Analytics.unregisterGlobalProperties()`:

```dart
Future<void> unregisterGlobalProperties() async 
```

Furthermore, you can remove all global properties by calling `unregisterGlobalProperties` without `propertyNames`:

```dart
Future<void> unregisterAllGlobalProperties() async 
```


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `fragments/lib/analytics/flutter/record.mdx`