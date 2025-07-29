---
title: Installation and Configuration
source: pages/build-a-backend/add-aws-services/analytics/personalize-recommendations/index.mdx
---

# Installation and Configuration

Amazon Personalize can create recommendations by using event data, historical data, or a combination of both. The event data can then be used to create recommendations.

To record event data, you need the following:

* [A dataset group](https://docs.aws.amazon.com/personalize/latest/dg/data-prep-ds-group.html)
* [An event tracker](https://docs.aws.amazon.com/personalize/latest/dg/event-get-tracker.html).

For more information, see [Record Events](https://docs.aws.amazon.com/personalize/latest/dg/recording-events.html).

## Installation and Configuration

After creating the Amazon Personalize dataset group, you need to add the `personalize:PutEvents` permission to your AWS Identity and Access Management (IAM) user roles.

An example IAM policy:
```json
]
}
```

You need the tracking ID of your event tracker. For more information, see [Get a Tracking ID](https://docs.aws.amazon.com/personalize/latest/dg/action-interaction-tracker-id.html).

Configure Amazon Personalize:

```javascript title="src/index.js"

const amplifyConfig = parseAmplifyConfig(outputs);

Amplify.configure(
  }
});
```
## Working with the API

You can use the `Identify` event type to track a user identity. This lets you connect a user to their actions and record traits about them. To identify a user, specify a unique identifier for the userId property.
 Consider the following user interactions when choosing when and how often to call record with the Identify eventType:

* After a user registers.
* After a user logs in.
* When a user updates their information (For example, changing or adding a new address).
* Upon loading any pages that are accessible by a logged-in user (optional).

```javascript

record(
});
```
You can send events to Amazon Personalize by calling the `record` operation. If you already use `Identify` to track end-user data, you can skip the userId, the SDK will fetch the userId based on current browser session.
For information about the properties field, see [Put Events](https://docs.aws.amazon.com/personalize/latest/dg/API_UBS_PutEvents.html).

```javascript

record(
});
```
You can track iframe and HTML5 media types by using the MediaAutoTrack event type. MediaAutoTrack tracks all media events of the media DOM element that you bind to. `MediaAutoTracker` will automatically track *Play*, *Pause*, *Ended*, *TimeWatched*, and *Resume* in `eventType`. The duration of the event compared to the total length of the media is stored as a percentage value in `eventValue`.

```javascript

record(
});
```

## Flush events
The recorded events are saved in a buffer and sent to the remote server periodically *(You can tune it with the `flushInterval` option)*. If needed, you have the option to manually clear all the events from the buffer by using the 'flushEvents' API.

```javascript

flushEvents();
```
