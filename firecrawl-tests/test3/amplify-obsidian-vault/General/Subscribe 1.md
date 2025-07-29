---
title: Subscribe
topics: ['General']
primary_topic: General
source: fragments/lib/pubsub/js/subunsub.mdx
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
pubsub.subscribe().subscribe();
```

Following events will be triggered with `subscribe()`

| Event | Description |
| :-: | --- |
| `next` | Triggered every time a message is successfully received for the topic |
| `error` | Triggered when subscription attempt fails |
| `complete` | Triggered when you unsubscribe from the topic |

### Subscribe to multiple topics

To subscribe for multiple topics, just pass a String array including the topic names:

```javascript
pubsub.subscribe().subscribe();
```

## Unsubscribe

To stop receiving messages from a topic, you can use `unsubscribe()` method:

```javascript
const sub1 = pubsub.subscribe().subscribe();

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

pubsub.subscribe('myTopic').subscribe()
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/pubsub/js/subunsub.mdx`