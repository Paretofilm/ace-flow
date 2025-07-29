---
title: Set up a real-time list query
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/subscribe-data/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Set up a real-time list query

}

In this guide, we will outline the benefits of enabling real-time data integrations and how to set up and filter these subscriptions. We will also cover how to unsubscribe from subscriptions.

Before you begin, you will need:

- An [application connected to the API](/[platform]/build-a-backend/data/connect-to-API/)
- Data already created to modify

## Set up a real-time list query

The recommended way to fetch a list of data is to use `observeQuery` to get a real-time list of your app data at all times. You can integrate `observeQuery` with React's `useState` and `useEffect` hooks in the following way:

```ts

type Todo = Schema['Todo']['type'];

const client = generateClient();

  useEffect(() => ) => ,
    });
    return () => sub.unsubscribe();
  }, []);

  return (
    <ul>
      ></li>
      ))}
    </ul>
  );
}
```

`observeQuery` fetches and paginates through all of your available data in the cloud. While data is syncing from the cloud, snapshots will contain all of the items synced so far and an `isSynced` status of `false`. When the sync process is complete, a snapshot will be emitted with all the records in the local store and an `isSynced` status of `true`.

If you don't see all of the real-time events and model fields you expect to see, here are a few things to look for.

#### Authorization

The model's [authorization rules](/[platform]/build-a-backend/data/customize-authz/) must grant the appropriate rights to the user.

| Operation | Authorization |
| -- | -- |
| `onCreate` | `read` OR `listen` |
| `onUpdate` | `read` OR `listen` |
| `onDelete` | `read` OR `listen` |
| `observeQuery` | `read` OR (`listen` AND `list`) |

If the authorization rules are correct, also ensure the session is authenticated as expected.

#### Selection Set Parity

All of the fields you expect to see in a real-time update must be present in the selection set of the **mutation** that triggers it. A mutation essentially "provides" the fields via its selection set that the corresponding subscription can then select from.

One way to address this is to use a common selection set variable for both operations. For example:

```ts
// Defining your selection set `as const` ensures the types
// propagate through to the response objects.
const selectionSet = ['title', 'author', 'posts.*'] as const;

const sub = client.models.Blog.observeQuery(
  filter:  },
  selectionSet: [...selectionSet]
).subscribe(
});

// The update uses the same selection set, ensuring all the
// required fields are provided to the subscriber.
const  = await client.models.Blog.update(, );
```

This works well if all subscriptions to `Blog` require the same subset of fields. If multiple subscriptions are involved with various selection sets, you must ensure that all `Blog` mutations contain the superset of fields from all subscriptions.

Alternatively, you can skip the custom selection sets entirely. The internally generated selection set for any given model is identical across operations by default. The trade-off is that the default selection sets exclude related models. So, when related models are required, you would need to either lazy load them or construct a query to fetch them separately.

#### Related Model Mutations

Mutations do not trigger real-time updates for *related* models. This is true even when the subscription includes a related model in the selection set. For example, if we're subscribed to a particular `Blog` and wish to see updates when a `Post` is added or changed, it's tempting to create  a subscribe on `Blog` and assume it "just works":

```ts
// Notice how we're fetching a few `Blog` details, but mostly using
// the selection set to grab all the related posts.
const selectionSet = ['title', 'author', 'posts.*'] as const;

const sub = client.models.Blog.observeQuery(
  filter:  },
  selectionSet: [...selectionSet]
).subscribe(
});
```

But, mutations on `Post` records won't trigger an real-time event for the related `Blog`. If you need `Blog` updates when a `Post` is added, you must manually "touch" the relevant `Blog` record.

```ts
async function addPostToBlog(
  post: Schema['Post']['createType'],
  blog: Schema['Blog']['type']
) );

  // "Touch" the blog, notifying subscribers to re-render.
  await client.models.Blog.update(, );
}
```

</Accordion>

## Set up a real-time event subscription

Subscriptions is a feature that allows the server to send data to its clients when a specific event happens. For example, you can subscribe to an event when a new record is created, updated, or deleted through the API. Subscriptions are automatically available for any `a.model()` in your Amplify Data schema.

```ts

const client = generateClient();

// Subscribe to creation of Todo
const createSub = client.models.Todo.onCreate().subscribe();

// Subscribe to update of Todo
const updateSub = client.models.Todo.onUpdate().subscribe();

// Subscribe to deletion of Todo
const deleteSub = client.models.Todo.onDelete().subscribe();

// Stop receiving data updates from the subscription
createSub.unsubscribe();
updateSub.unsubscribe();
deleteSub.unsubscribe();
```

## Set up server-side subscription filters

Subscriptions take an optional `filter` argument to define service-side subscription filters:

```ts

const client = generateClient();

const sub = client.models.Todo.onCreate(,
  },
}).subscribe();
```

If you want to get all subscription events, don't specify any `filter` parameters.

> **Note**: 

**Limitations:**

- Specifying an empty object `` as a filter is **not** recommended. Using `` as a filter might cause inconsistent behavior based on your data model's authorization rules.
- If you're using dynamic group authorization and you authorize based on a single group per record, subscriptions are only supported if the user is part of five or fewer user groups.
- Additionally, if you authorize by using an array of groups (`groups: [String]`),
  - subscriptions are only supported if the user is part of 20 or fewer groups
  - you can only authorize 20 or fewer user groups per record

### Subscription connection status updates

Now that your application is set up and using subscriptions, you may want to know when the subscription is finally established, or reflect to your users when the subscription isn't healthy. You can monitor the connection state for changes through the `Hub` local eventing system.

```ts

Hub.listen('api', (data: any) =>  = data;
  if (payload.event === CONNECTION_STATE_CHANGE) 
});
```

#### Subscription connection states

- **`Connected`** - Connected and working with no issues.
- **`ConnectedPendingDisconnect`** - The connection has no active subscriptions and is disconnecting.
- **`ConnectedPendingKeepAlive`** - The connection is open, but has missed expected keep-alive messages.
- **`ConnectedPendingNetwork`** - The connection is open, but the network connection has been disrupted. When the network recovers, the connection will continue serving traffic.
- **`Connecting`** - Attempting to connect.
- **`ConnectionDisrupted`** - The connection is disrupted and the network is available.
- **`ConnectionDisruptedPendingNetwork`** - The connection is disrupted and the network connection is unavailable.
- **`Disconnected`** - Connection has no active subscriptions and is disconnecting.

Connections between your application and backend subscriptions can be interrupted for various reasons, including network outages or the device entering sleep mode. Your subscriptions will automatically reconnect when it becomes possible to do so.

While offline, your application will miss messages and will not automatically catch up when reconnected. Depending on your use case, you may want to take action for your app to catch up when it comes back online.

```js

const client = generateClient()

const fetchRecentData = () =>  = await client.models.Todo.list();
}

let priorConnectionState: ConnectionState;

Hub.listen("api", (data: any) =>  = data;
  if (
    payload.event === CONNECTION_STATE_CHANGE
  ) 
    priorConnectionState = payload.data.connectionState;
  }
});

const createSub = client.models.Todo.onCreate().subscribe();

const updateSub = client.models.Todo.onUpdate().subscribe();

const deleteSub = client.models.Todo.onDelete().subscribe();

const cleanupSubscriptions = () => 
```

</Accordion>

## Unsubscribe from a subscription

You can also unsubscribe from events by using subscriptions by implementing the following:

```ts
// Stop receiving data updates from the subscription
sub.unsubscribe();
```

## Conclusion

Congratulations! You have finished the **Subscribe to real-time events** guide. In this guide, you set up subscriptions for real-time events and learned how to filter and cancel these subscriptions when needed.

### Next steps

Our recommended next steps include continuing to build out and customize your information architecture for your data. Some resources that will help with this work include:

- [Customize your auth rules](/[platform]/build-a-backend/data/customize-authz/)
- [Customize your data model](/[platform]/build-a-backend/data/data-modeling/)
- [Add custom business logic](/[platform]/build-a-backend/data/custom-business-logic/)

</InlineFilter>

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

</InlineFilter>

Subscribe to mutations for creating real-time clients:

```java
ApiOperation subscription = Amplify.API.subscribe(
    ModelSubscription.onCreate(Todo.class),
    onEstablished -> Log.i("ApiQuickStart", "Subscription established"),
    onCreated -> Log.i("ApiQuickStart", "Todo create subscription received: " + ((Todo) onCreated.getData()).getName()),
    onFailure -> Log.e("ApiQuickStart", "Subscription failed", onFailure),
    () -> Log.i("ApiQuickStart", "Subscription completed")
);

// Cancel the subscription listener when you're finished with it
subscription.cancel();
```

</Block>

```kotlin
val subscription = Amplify.API.subscribe(
    ModelSubscription.onCreate(Todo::class.java),
    ,
    ") },
    ,
    
)

// Cancel the subscription listener when you're finished with it
subscription.cancel();
```

</Block>

```kotlin
val job = activityScope.launch 
            .collect ") }
    } catch (notEstablished: ApiException) 
}

// When done with subscription
job.cancel()
```

</Block>

```java
RxSubscriptionOperation<? extends GraphQLResponse<?>> subscription =
        RxAmplify.API.subscribe(request);

subscription
        .observeConnectionState()
        .subscribe(connectionStateEvent -> Log.i("ApiQuickStart", String.valueOf(connectionStateEvent)));

subscription
        .observeSubscriptionData()
        .subscribe(
            data -> Log.i("ApiQuickStart", data),
            exception -> Log.e("ApiQuickStart", "Subscription failed.", exception),
            () -> Log.i("ApiQuickStart", "Subscription completed.")
        );

// Cancel the subscription listener when you're finished with it
subscription.cancel();
```

</Block>
</BlockSwitcher>

</InlineFilter>

Subscribe to mutations for creating real-time clients.

## Setup subscription with callbacks

When creating subscriptions, a [`Stream`](https://api.dart.dev/dart-async/Stream-class.html) object will be returned to you. This `Stream` will continue producing events until either the subscription encounters an error or you cancel the subscription. In the case of need for limiting the amount of data that is omitted, you can take advantage of the Stream's helper functions such as `take`. The cancellation occurs when the defined amount of event has occurred:

```dart
Stream> subscribe() ,
  );
  return operation;
}
```

Alternatively, you can call [`Stream.listen`](https://api.dart.dev/dart-async/Stream/listen.html) to create a [`StreamSubscription`](https://api.dart.dev/dart-async/StreamSubscription-class.html) object which can be programmatically canceled.

```dart
// Be sure to import this
import 'dart:async';

...

StreamSubscription>? subscription;

void subscribe() ');
    },
    onError: (Object e) => safePrint('Error in subscription stream: $e'),
  );
}

void unsubscribe() 
```

In addition to an `onCreate` subscription, you can also call `.onUpdate()` or `.onDelete()`.

```dart
final onUpdateSubscriptionRequest = ModelSubscriptions.onUpdate(Todo.classType);
// or
final onDeleteSubscriptionRequest = ModelSubscriptions.onDelete(Todo.classType);
```

## Subscription connection status

Now that you set up the application and are using subscriptions, you may want to know when the subscription is closed, or reflect to your users when the subscription isn’t healthy. You can monitor the subscription status for changes via `Amplify.Hub`

```dart
Amplify.Hub.listen(
  HubChannel.Api,
  (ApiHubEvent event) 
  },
);
```

### SubscriptionStatus

- **`connected`** - Connected and working with no issues
- **`connecting`** - Attempting to connect (both initial connection and reconnection)
- **`pendingDisconnect`** - Connection has no active subscriptions and is shutting down
- **`disconnected`** - Connection has no active subscriptions and is disconnected
- **`failed`** - Connection had a failure and has been disconnected

## Automated Reconnection

Under the hood, we will attempt to maintain a healthy web socket connection through network changes. For example, if a device’s connection changes from Wi-Fi to 5g network, the plugin will attempt to reconnect using the new network.

Likewise, when disconnected from the internet unexpectedly, the subscription will attempt to reconnect using an exponential retry/back off strategy. By default, we will make 8 recovery attempts over about 50 seconds. If we cannot make a successful connection, then the web socket will be closed. You can customize this strategy when configuring the API plugin through `RetryOptions`.

```dart
Future<void> _configureAmplify() async  on AmplifyAlreadyConfiguredException 
}
```

> **Note**: 

**Important**: While offline, your application will miss messages and will not automatically catch up when reconnection happens. Depending on your use case, you may want to take action to catch up when your app comes back online. The following example solves this problem by retrieving all data on reconnection.

```dart
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import './models/ModelProvider.dart'; // <--- Update import to reflect your project
import 'dart:async';

// ...

List allTodos = [];
SubscriptionStatus prevSubscriptionStatus = SubscriptionStatus.disconnected;
StreamSubscription>? subscription;

/// ...

// Init listeners
Amplify.Hub.listen(
  HubChannel.Api,
  (ApiHubEvent event) 
      prevSubscriptionStatus = event.status;
    }
  },
);

subscribe();

/// ...

Future<void> getTodos() async ');
    }

    setState(() );
  } on ApiException catch (e) 
}

void subscribe() );
    },
    onError: (Object e) => safePrint('Error in subscription stream: $e'),
  );
}

```

</InlineFilter>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/subscribe-data/index.mdx`