---
title: Documentation
source: fragments/lib-v1/datastore/ios/real-time/observe-query-snippet.mdx
---

# Documentation

```swift
// In your type declaration, declare a cancellable to hold onto the subscription
var postsSubscription: AnyCancellable?

func subscribeToPosts() 
        } receiveValue: 
}

// Then, when you're finished observing, cancel the subscription
func unsubscribeFromPosts() 
```
