---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/graphqlapi/android/subscribe-data.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/android/subscribe-data.mdx`