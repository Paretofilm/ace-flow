---
title: Documentation
source: fragments/lib/logging/ios/hub_events/hub_events.mdx
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
