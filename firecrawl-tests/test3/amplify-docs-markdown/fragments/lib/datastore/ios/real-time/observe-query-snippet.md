---
title: Documentation
source: fragments/lib/datastore/ios/real-time/observe-query-snippet.mdx
---

# Documentation

```swift
// You must hold a reference to your subscription.
var postsSubscription: AmplifyAsyncThrowingSequence>?

// Subscribe
func subscribeToPosts() async 
    } catch 
}

// When you're finished observing, cancel the subscription
func unsubscribeFromPosts() 
```

</Block>

```swift
// In your type declaration, declare a cancellable to hold onto the subscription
var postsSubscription: AnyCancellable?

func subscribeToPosts() 
    } receiveValue: 
}

// Then, when you're finished observing, cancel the subscription
func unsubscribeFromPosts() 
```

</Block>

</BlockSwitcher>
