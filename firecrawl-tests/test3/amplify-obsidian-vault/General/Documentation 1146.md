---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/ios/hub_events/hub_events.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

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


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/logging/ios/hub_events/hub_events.mdx`