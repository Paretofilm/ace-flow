---
title: Documentation
topics: ['Analytics']
primary_topic: Analytics
source: fragments/lib-v1/analytics/js/create-custom-plugin.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics]
---


## 🧭 Navigation
**Topics**: [[Analytics/]]
**Primary**: [[Analytics/]]

---


# Documentation

You can create your custom pluggable for Analytics. This may be helpful if you want to integrate your app with a custom analytics backend.

To create a plugin implement the `AnalyticsProvider` interface:

```typescript

  // you need to implement these four methods
  // configure your provider
  configure(config: object): object;

  // record events and returns true if succeeds
  record(params: object): Promise<boolean>;

  // return 'Analytics';
  getCategory(): string;

  // return the name of you provider
  getProviderName(): string;
}
```

You can now register your pluggable:

```javascript
// add the plugin
Analytics.addPluggable(new MyAnalyticsProvider());

// get the plugin
Analytics.getPluggable(MyAnalyticsProvider.providerName);

// remove the plugin
Analytics.removePluggable(MyAnalyticsProvider.providerName);

// send configuration into Amplify
Analytics.configure(
});
```

The default provider (Amazon Pinpoint) is in use when you call `Analytics.record()` unless you specify a different provider: `Analytics.record(,'MyAnalytics')`.


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `fragments/lib-v1/analytics/js/create-custom-plugin.mdx`