---
title: Recording Custom Events
topics: ['Analytics']
primary_topic: Analytics
source: fragments/lib-v1/analytics/js/record.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics]
---


## 🧭 Navigation
**Topics**: [[Analytics/]]
**Primary**: [[Analytics/]]

---


# Recording Custom Events

## Recording Custom Events

To record custom events call the `record` method:

```javascript
Analytics.record();
```

## Record a Custom Event with Attributes

The `record` method lets you add additional attributes to an event. For example, to record _artist_ information with an _albumVisit_ event:

```javascript
Analytics.record(
});
```

## Record Engagement Metrics

Data can also be added to an event:

```javascript
Analytics.record(,
  metrics: 
});
```

Metric values must be a `Number` type such as a float or integer.

## Record Events Immediately

The Amazon Pinpoint & Kinesis providers send events in batches to optimize network bandwidth. However, events can be sent immediately using the `immediate` flag.

```javascript
Analytics.record();
```

> **Note**: 

The AWS Pinpoint event count updates in minutes after recording your event.

However, it can take upwards of 30 minutes for the event to display in the Filter section, and for its custom attributes to appear in Pinpoint.


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `fragments/lib-v1/analytics/js/record.mdx`