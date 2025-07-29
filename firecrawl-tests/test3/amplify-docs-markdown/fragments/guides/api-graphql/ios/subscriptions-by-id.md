---
title: Documentation
source: fragments/guides/api-graphql/ios/subscriptions-by-id.mdx
---

# Documentation

```swift
extension GraphQLRequest 
        }
        """
        return GraphQLRequest(document: document,
                                    variables: ["id": id],
                                    responseType: Comment.self,
                                    decodePath: operationName)
    }
}
```

Because the lifetime of the subscription will last longer than the lifetime of a single function, you can create an instance variable at the top of your class:

```swift
var subscription: AmplifyAsyncThrowingSequence>!
```

</Block>

```swift
var cancellable: AnyCancellable?
```

</Block>

</BlockSwitcher>

To listen to creation updates with the specific post using the post id, you can use the following code sample:

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
            },
            receiveValue: 
                }
            }
        )
}
```

</Block>

</BlockSwitcher>
