---
title: Subscribe
topics: ['General']
primary_topic: General
source: fragments/lib-v1/pubsub/js/subunsub.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Subscribe

## Subscribe

### Subscribe to a topic

In order to start receiving messages from your provider, you need to subscribe to a topic as follows;

```javascript
PubSub.subscribe('myTopic').subscribe();
```

If multiple providers are defined in your app you can include the specific provider you would like to subscribe to:

```javascript
PubSub.subscribe('myTopic', ).subscribe();

PubSub.subscribe('myTopic', ).subscribe();
```

> **Note**: 

**Note:** If you do not include a specific provider it will subscribe to all of the configured PubSub providers in your app.

Following events will be triggered with `subscribe()`

| Event | Description |
| :-: | --- |
| `next` | Triggered every time a message is successfully received for the topic |
| `error` | Triggered when subscription attempt fails |
| `complete` | Triggered when you unsubscribe from the topic |

### Subscribe to multiple topics

To subscribe for multiple topics, just pass a String array including the topic names:

```javascript
PubSub.subscribe(['myTopic1', 'myTopic1']).subscribe();
```

## Unsubscribe

To stop receiving messages from a topic, you can use `unsubscribe()` method:

```javascript
const sub1 = PubSub.subscribe('myTopicA').subscribe();

sub1.unsubscribe();
// You will no longer get messages for 'myTopicA'
```

## Subscription connection status updates

Now that your application is setup and using pubsub subscriptions, you may want to know when the subscription is finally established, or reflect to your users when the subscription isn't healthy. You can monitor the connection state for changes via Hub.

```typescript

Hub.listen('pubsub', (data: any) =>  = data;
  if (payload.event === CONNECTION_STATE_CHANGE) 
});
```

### Connection issues and automated reconnection

```typescript
const fetchRecentData = () => 

let priorConnectionState: ConnectionState;

Hub.listen("pubsub", (data: any) =>  = data;
  if (
    payload.event === CONNECTION_STATE_CHANGE
  ) 
    priorConnectionState = payload.data.connectionState;
  }
});

PubSub.subscribe('myTopic').subscribe()
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/pubsub/js/subunsub.mdx`