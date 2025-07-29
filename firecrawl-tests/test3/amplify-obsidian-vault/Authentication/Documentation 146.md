---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/android/hub_events/10_listen_events.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

```java
Amplify.Hub.subscribe(HubChannel.AUTH,
      hubEvent ->  else if (hubEvent.getName().equals(InitializationStatus.FAILED.toString())) else 
          }
      }
);
```

</Block>

```kotlin
Amplify.Hub.subscribe(HubChannel.AUTH) ")
        }
    }
}
```

</Block>

```kotlin
Amplify.Hub.subscribe(HubChannel.AUTH).collect 
    }
}
```

</Block>

```java
RxAmplify.Hub.on(HubChannel.AUTH)
    .map(HubEvent::getName)
    .subscribe(name ->  else if (name.equals(InitializationStatus.FAILED.toString())) 
        switch (AuthChannelEventName.valueOf(name)) 
    });
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/android/hub_events/10_listen_events.mdx`