---
title: Setup subscription with callbacks
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/graphqlapi/flutter/subscribe-data.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Setup subscription with callbacks

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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/flutter/subscribe-data.mdx`