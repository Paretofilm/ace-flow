---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/android/hub_events/hub_events.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

```java
Amplify.Hub.subscribe(HubChannel.LOGGING,
            hubEvent ->  else if (hubEvent.getName().equals(LoggingEventName.FLUSH_LOG_FAILURE.toString()))
            }
        );
```

</Block>

```kotlin
Amplify.Hub.subscribe(
    HubChannel.LOGGING
)  else if (hubEvent.name == LoggingEventName.FLUSH_LOG_FAILURE.toString()) 
}
```

</Block>

```java
RxAmplify.Hub.on(HubChannel.LOGGING)
.map(HubEvent::getName)
.subscribe(name ->  else if (name.equals(LoggingEventName.FLUSH_LOG_FAILURE.toString())) 
});
```
</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/logging/android/hub_events/hub_events.mdx`