---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/ios/real-time/observe-query-snippet.mdx
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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/ios/real-time/observe-query-snippet.mdx`