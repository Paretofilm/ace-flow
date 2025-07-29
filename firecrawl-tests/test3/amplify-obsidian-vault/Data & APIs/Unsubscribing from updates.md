---
title: Unsubscribing from updates
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/graphqlapi/ios/subscribe-data.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Unsubscribing from updates

Subscribe to mutations for creating real-time clients.

Because the lifetime of the subscription will last longer than the lifetime of a single function, you can create an instance variable at the top of your class:

```swift
var subscription: GraphQLSubscriptionOperation?
```

</Block>

```swift
var subscription: GraphQLSubscriptionOperation?
var dataSink: AnyCancellable?
```

</Block>

</BlockSwitcher>

To listen to creation updates, you can use the following code sample:

```swift
func createSubscription() 
        }
    }) 
    }
}
```
</Block>

```swift
func createSubscription()  else 
    }
    receiveValue: 
    }
}
```

</Block>

</BlockSwitcher>

## Unsubscribing from updates

### Listener (iOS 11+)

To unsubscribe from updates, you can call `cancel()` on the subscription

```swift
func cancelSubscription() 
```

### Combine (iOS 13+)

With the Combine flavor of the `subscribe()` API, you have the option of canceling just the downstream Combine subscriber, or the entire GraphQL subscription.

Calling `cancel()` on the subscription will disconnect the subscription from the backend. Any downstream subscribers will also be cancelled. On the other hand, calling `cancel()` on the Combine subscriber (e.g., the `AnyCancellable` returned from `sink()` will cause that Combine subscriber to stop receiving updates, but any other attached subscribers will continue to receive subscription data. For example:

```swift
let subscription = Amplify.API.subscribe(...)
let allUpdates = subscription.subscriptionDataPublisher.sink(...)
let filteredUpdates = subscription.subscriptionDataPublisher.filter.sink(...)

allUpdates.cancel() // subscription is still connected,
                    // filteredUpdates will still receive data

subscription.cancel() // subscription is now disconnected
                      // filteredUpdates will no longer receive data
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/ios/subscribe-data.mdx`