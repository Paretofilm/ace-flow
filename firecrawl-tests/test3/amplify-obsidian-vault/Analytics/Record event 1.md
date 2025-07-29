---
title: Record Event
topics: ['Analytics']
primary_topic: Analytics
source: fragments/lib/analytics/ios/record.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics]
---


## 🧭 Navigation
**Topics**: [[Analytics/]]
**Primary**: [[Analytics/]]

---


# Record Event

## Record Event

The Amplify Analytics plugin provides a simple interface to record custom events within your app:

> **Note**: 

The AWS Pinpoint event count updates in minutes after recording your event.

However, it can take upwards of 30 minutes for the event to display in the Filter section, and for its custom attributes to appear in Pinpoint.

> **Note**: 

Security Notice: Amplify Analytics temporarily stores event data locally in an unencrypted format before sending it to Pinpoint. 

To protect your sensitive information, please do not include any passwords, API keys, or other confidential information in your analytic events.

## Flush Events

By default, events are automatically flushed out to the network every 60 seconds.

If you would like to change this, update `amplifyconfiguration.json` and set the value you would prefer under `autoFlushEventsInterval`, expressed in seconds:

```json
,
        "autoFlushEventsInterval": 60
      }
    }
  }
}
```

> **Note**
>
> Setting `autoFlushEventsInterval` to 0 will **disable** the automatic flush of events and you will be responsible for submitting them.

To manually submit the recoded events to the backend, call:

```swift
Amplify.Analytics.flushEvents()
```

The plugin automatically batches requests in order to reduce network bandwidth and handles the retry logic if the device loses connectivity.

## Authentication events

```swift
func sendUserSignInEvent() 
```

## Global Properties

You can register properties which will be included across all `Amplify.Analytics.record(event:)` calls.

```swift
let globalProperties: AnalyticsProperties = [
    "globalPropertyKey": "value"
]
Amplify.Analytics.registerGlobalProperties(globalProperties)
```

To unregister global properties, call `Amplify.Analytics.unregisterGlobalProperties()`:

```swift
// When called with no arguments, it unregisters all global properties
Amplify.Analytics.unregisterGlobalProperties()

// Or you can specify which properties to unregister
let globalProperties = ["globalPropertyKey1", "globalPropertyKey2"]
Amplify.Analytics.unregisterGlobalProperties(globalProperties)
```


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `fragments/lib/analytics/ios/record.mdx`