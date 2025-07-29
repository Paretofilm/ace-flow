---
title: Expose hub events triggered in response to auth actions
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/connect-your-frontend/listen-to-auth-events/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Expose hub events triggered in response to auth actions

Amplify Auth emits events during authentication flows, which enables you to react to user flows in real time and trigger custom business logic. For example, you may want to capture data, synchronize your app's state, and personalize the user's experience. You can listen to and respond to events across the Auth lifecycle such as sign-in and sign-out.

## Expose hub events triggered in response to auth actions

You can use Amplify Hub with its built in Amplify Auth events to subscribe a listener using a publish-subscribe pattern and capture events between different parts of your application. The Amplify Auth category publishes in the `auth` channel when auth events such as `signedIn` or `signedOut` happen independent from your app code.

You can review the Amplify Hub guide to [learn more](/gen1/react/build-a-backend/utilities/hub/).

> **Note**: 

Channels are logical group names that help you organize dispatching and listening. However, some channels are protected and cannot be used to publish custom events, and `auth` is one of these channels. Sending unexpected payloads to protected channels can have undesirable side effects such as impacting authentication flows. See the [Amplify Hub](/gen1/react/build-a-backend/utilities/hub/) guide for more protected channels.

Here is a basic example of setting up a listener that logs an event emitted through the `auth` channel:

```js

Hub.listen('auth', (data) => );
```

Once your app is set up to subscribe and listen to specific event types from the `auth` channel, the listeners will be notified asynchronously when an event occurs. This pattern allows for a one-to-many relationship where one auth event can be shared with many different listeners that have been subscribed. This lets your app react based on the event rather than proactively poll for information.

Additionally, you can set up your listener to extract data from the event payload and execute a callback that you define. For example, you might update UI elements in your app to reflect your user's authenticated state after the `signedIn` or `signedOut` events.

### Listen to and log auth events

One of the most common workflows will be to log events. In this example you can see how you can listen and target specific `auth` events using a `switch` to log your own messages.

```js

Hub.listen('auth', () => 
});
```

### Stop listening to events

You can also stop listening for messages by calling the result of the `Hub.listen()` function. This may be useful if you no longer need to receive messages in your application flow. This can also help you avoid any memory leaks on low powered devices when you are sending large amounts of data through Amplify Hub on multiple channels.

To stop listening to a certain event, you need to wrap the listener function with a variable and call it once you no longer need it:

```js
/* start listening for messages */
const hubListenerCancelToken = Hub.listen('auth', (data) => );

/* later */
hubListenerCancelToken(); // stop listening for messages
```

You now have a few use cases and examples for listening to and responding to auth events.

</InlineFilter>

AWS Cognito Auth Plugin sends important events through Amplify Hub. You can listen to these events like the following:

```dart
final subscription = Amplify.Hub.listen(HubChannel.Auth, (AuthHubEvent event) 
});
```
</InlineFilter>

AWS Cognito Auth Plugin sends important events through Amplify Hub. You can listen to these events like the following:

```java
Amplify.Hub.subscribe(HubChannel.AUTH,
    hubEvent ->  else if (hubEvent.getName().equals(InitializationStatus.FAILED.name())) else 
            else if (eventName.equals(SIGNED_OUT.name())) 
            else if (eventName.equals(SESSION_EXPIRED.name())) 
            else if (eventName.equals(USER_DELETED.name())) 
            else 
        }
    }
);

```

</Block>

```kotlin
Amplify.Hub.subscribe(HubChannel.AUTH) ")
        }
    }
}
```

</Block>

```kotlin
Amplify.Hub.subscribe(HubChannel.AUTH).collect ")
        }
    }
}
```

</Block>

```java
RxAmplify.Hub.on(HubChannel.AUTH)
    .map(HubEvent::getName)
    .subscribe(name ->  else if (name.equals(InitializationStatus.FAILED.name()))  else 
            else if (name.equals(SIGNED_OUT.name())) 
            else if (name.equals(SESSION_EXPIRED.name())) 
            else if (name.equals(USER_DELETED.name())) 
            else 
        }
    });
```

</Block>
</BlockSwitcher>

</InlineFilter>

AWS Cognito Auth Plugin sends important events through Amplify Hub. You can listen to these events like the following:

```swift
override func viewDidLoad() 
    }
}
```

</Block>

```swift
override func viewDidLoad() 
        }
}
```

</Block>
</BlockSwitcher>
</InlineFilter>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/connect-your-frontend/listen-to-auth-events/index.mdx`