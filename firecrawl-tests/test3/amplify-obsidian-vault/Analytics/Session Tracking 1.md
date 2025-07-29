---
title: Session Tracking
topics: ['Analytics']
primary_topic: Analytics
source: fragments/lib/analytics/js/autotrack/autotrack.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics]
---


## 🧭 Navigation
**Topics**: [[Analytics/]]
**Primary**: [[Analytics/]]

---


# Session Tracking

Analytics Auto Tracking helps you to automatically track user behaviors like sessions start/stop, page view change and web events like clicking or mouseover.

> **Note**: 
  The Auto Tracking feature is only supported when you have Amazon Pinpoint
  configured for Amplify Analytics.

## Session Tracking

You can track the session both in a web app or a React Native app by using Analytics. A web session can be defined in different ways. To keep it simple we define a web session as being active when the page is not hidden and inactive when the page is hidden. A session in a React Native app is active when the app is in the foreground and inactive when the app is in the background.

For example:

```javascript

configureAutoTrack(
  }
});
```

By default, when the page/app transitions to the foreground, the Analytics module will send an event to the Amazon Pinpoint Service.

```json

}
```

This behavior can be disabled by calling `configureAutoTrack`:

```javascript

configureAutoTrack();
```

> **Note**: 

Note: Amplify doesn't capture the location automatically. Instead, you can add the location information in the default config when you [configure Analytics](/gen1/[platform]/build-a-backend/more-features/analytics/set-up-analytics/#set-up-existing-analytics-backend) or while [updating the end point](/gen1/[platform]/build-a-backend/more-features/analytics/set-up-analytics/#update-endpoint).


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `fragments/lib/analytics/js/autotrack/autotrack.mdx`