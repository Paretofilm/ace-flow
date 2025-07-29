---
title: Page View Tracking
source: fragments/lib-v1/analytics/js/autotrack/page-tracking.mdx
---

# Page View Tracking

## Page View Tracking

If you want to track which page/url in your webapp is the most frequently viewed one, you can use this feature. It will automatically send events containing url information when the page is visited.

To turn it on:

```javascript
Analytics.autoTrack('pageView', ,
  // when using function
  // attributes: () => 
  // },
  // OPTIONAL, by default is 'multiPageApp'
  // you need to change it to 'SPA' if your app is a single-page app like React
  type: 'multiPageApp',
  // OPTIONAL, the service provider, by default is the Amazon Pinpoint
  provider: 'AWSPinpoint',
  // OPTIONAL, to get the current page url
  getUrl: () => 
});
```

## Page Event Tracking

If you want to track user interactions with elements on the page, you can use this feature. All you need to do is attach the specified selectors to your dom element and turn on the auto tracking.

To turn it on:

```javascript
Analytics.autoTrack('event', 
  // when using function
  // attributes: () => 
  // }
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
  var sendEvent = function() 
    });
  };
</script>
<button onclick="sendEvent()" />
```
