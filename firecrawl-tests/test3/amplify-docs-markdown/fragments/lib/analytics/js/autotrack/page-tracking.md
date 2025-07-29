---
title: Page View Tracking
source: fragments/lib/analytics/js/autotrack/page-tracking.mdx
---

# Page View Tracking

## Page View Tracking

Use this feature to track the most frequently viewed page/url in your webapp. It automatically sends events containing url information when a page is visited.

This behavior can be enabled by calling `configureAutoTrack`:
```javascript

configureAutoTrack(,

    // OPTIONAL, the event name. By default, this is 'pageView'
    eventName: 'pageView',

    // OPTIONAL, the type of app under tracking. By default, this is 'multiPageApp'.
    // You will need to change it to 'singlePage' if your app is a single-page app like React
    appType: 'multiPageApp',

    // OPTIONAL, provide the URL for the event.
    urlProvider:  () => 
  }
});
```

This behavior can be disabled by calling `configureAutoTrack`:
```javascript

configureAutoTrack();
```

## Page Event Tracking

Use this type of tracking to track user interactions with specific elements on a page. Just attach the specified selectors to your DOM element and turn on the auto tracking.

This behavior can be enabled by calling `configureAutoTrack`:
```javascript

configureAutoTrack(,
    // OPTIONAL, events you want to track. By default, this is 'click'
    events: ['click'],

    // OPTIONAL, the prefix of the selectors. By default, this is 'data-amplify-analytics-'
    // Per https://www.w3schools.com/tags/att_global_data.asp, always start
    // the prefix with 'data' to avoid collisions with the user agent
    selectorPrefix: 'data-amplify-analytics-'
  }
});
```

For example:

```html
<!-- you want to track this button and send an event when it is clicked -->
<button
  data-amplify-analytics-on="click"
  data-amplify-analytics-name="click"
  data-amplify-analytics-attrs="attr1:attr1_value,attr2:attr2_value"
/>
```

When the button above is clicked, an event will be sent automatically. This is equivalent to doing:

```html
<script>
  import  from 'aws-amplify/analytics';
  var sendEvent = function() 
    });
  };
</script>
<button onclick="sendEvent()" />
```

This behavior can be disabled by calling `configureAutoTrack`:
```javascript

configureAutoTrack();
```
