---
title: Listen to log events
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/logging/hub-events/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Listen to log events

The Amplify Logger sends errors that occur when using it through Amplify Hub. To ensure that errors do not occur when logging, log messages should be validated and follow the best security practices. Additionally, you should ensure that log messages do not exceed the [Amazon CloudWatch log event size of 256 KB](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutLogEvents.html).

You can get logging error events by listening/subscribing to the logging events from the Amplify Hub.

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

    </InlineFilter>

```swift
import Amplify
```

```swift
// Assumes `unsubscribeToken` is declared as an instance variable in your view
unsubscribeToken = Amplify.Hub.listen(to: .logging) 
}
```

</Block>

```swift
import Amplify
```

```swift
// Assumes `sink` is declared as an instance variable in your code
sink = Amplify.Hub
    .publisher(for: .logging)
    .sink 
    }
```

</Block>

</BlockSwitcher>    
</InlineFilter>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/logging/hub-events/index.mdx`