---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/ios/real-time/observe-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

```swift
// You must hold a reference to your subscription.
var postsSubscription:  AmplifyAsyncThrowingSequence?

// Then in the body of your code, subscribe to the subscription
func subscribeToPosts() async 
    } catch 
}

// Then, when you're finished observing, cancel the subscription
func unsubscribeFromPosts() 
```

</Block>

```swift
// In your type declaration, declare a cancellable to hold onto the subscription
var postsSubscription: AnyCancellable?

// Then in the body of your code, subscribe to the publisher
func subscribeToPosts() 
    }
    receiveValue: 
}

// Then, when you're finished observing, cancel the subscription
func unsubscribeFromPosts() 
```

</Block>

</BlockSwitcher>

> **Note**: 

`DataStore.clear()` and `DataStore.stop()` will stop the DataStore sync engine and keep any subscriptions connected. There will not be any additional subscription events received by the subscriber until DataStore is started (`DataStore.start()`) or the sync engine is re-initiated upon performing a DataStore operation (query/save/delete).

> **Note**: 

This API is built on top of the [Combine framework](https://developer.apple.com/documentation/combine); therefore, it is only available on iOS 13 or higher.

The `Amplify.Publisher.create` API returns a standard [AnyPublisher](https://developer.apple.com/documentation/combine/anypublisher).


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/ios/real-time/observe-snippet.mdx`