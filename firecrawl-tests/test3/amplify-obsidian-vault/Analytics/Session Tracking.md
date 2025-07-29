---
title: Session Tracking
topics: ['Analytics']
primary_topic: Analytics
source: fragments/lib-v1/analytics/js/autotrack/autotrack.mdx
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

## Session Tracking

You can track the session both in a web app or a React Native app by using Analytics. A web session can be defined in different ways. To keep it simple we define a web session as being active when the page is not hidden and inactive when the page is hidden. A session in a React Native app is active when the app is in the foreground and inactive when the app is in the background.

For example:

```javascript
Analytics.autoTrack('session', ,
  // when using function
  // attributes: () => 
  // },
  // OPTIONAL, the service provider, by default is the Amazon Pinpoint
  provider: 'AWSPinpoint'
});
```

When the page is loaded, the Analytics module will send an event to the Amazon Pinpoint Service.

```javascript

}
```

To keep backward compatibility, the auto tracking of the session is enabled by default. You can turn it off by:

```javascript
Analytics.configure();
```

or

```javascript
Analytics.autoTrack('session', );

// Note: this must be called before Amplify.configure() or Analytics.configure() to cancel the session_start event
```

> **Note**: 

Note: Amplify doesn't capture the location automatically. Instead, you can add the location information in the default config when you [configure Analytics](/gen1/[platform]/prev/build-a-backend/more-features/analytics/set-up-analytics/#set-up-existing-analytics-backend) or while [updating the end point](/gen1/[platform]/prev/build-a-backend/more-features/analytics/set-up-analytics/#update-endpoint).


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `fragments/lib-v1/analytics/js/autotrack/autotrack.mdx`