---
title: Unsubscribing from updates
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/graphqlapi/ios/subscribe-data.mdx
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
var subscription: AmplifyAsyncThrowingSequence>
```

</Block>

```swift
var subscription: AnyCancellable?
```

</Block>

</BlockSwitcher>

To listen to creation updates, you can use the following code sample:

```swift
func createSubscription() 
                }
            }
        } catch 
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
}
```

</Block>

</BlockSwitcher>

## Unsubscribing from updates

### Async/Await

To unsubscribe from updates, you can call `cancel()` on the subscription.

```swift
func cancelSubscription() 
```

### Combine

Calling `cancel()` on the sequence will disconnect the subscription from the backend. Any downstream subscribers will also be cancelled.

```swift
let sequence = Amplify.API.subscribe(...)
let subscription = Amplify.Publisher.create(sequence)
let allUpdates = subscription.sink(...)
let filteredUpdates = subscription.filter.sink(...)
sequence.cancel()   // sequence is now disconnected
                    // allUpdates and filteredUpdates will no longer receive data
```

Similarly, calling `cancel()` on the Combine subscriber (e.g., the `AnyCancellable` returned from `sink()`) will cause the underlying sequence to cancel. This will cause all attached subscribers to stop receiving updates.

```swift
allUpdates.cancel() // sequence is disconnected
                    // filteredUpdates will no longer receive data
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/ios/subscribe-data.mdx`