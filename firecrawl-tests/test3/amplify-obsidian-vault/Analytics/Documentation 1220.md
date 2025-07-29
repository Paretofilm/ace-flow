---
title: Documentation
topics: ['Analytics', 'Getting Started']
primary_topic: Analytics
source: fragments/lib/analytics/native_common/getting-started/30_initAnalytics.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics, getting-started]
---


## 🧭 Navigation
**Topics**: [[Analytics/]] • [[Getting Started/]]
**Primary**: [[Analytics/]]

---


# Documentation

```javascript

Amplify.configure(amplifyconfig);
```

> **Note**: 

Make sure you call `Amplify.configure` as early as possible in your application’s life-cycle. A missing configuration or `NoCredentials` error is thrown if `Amplify.configure` has not been called before other Amplify JavaScript APIs. Review the [Library Not Configured Troubleshooting guide](/gen1/[platform]/build-a-backend/troubleshooting/library-not-configured/) for possible causes of this issue.

User session data is automatically collected unless you disabled analytics. To see the results visit the [Amazon Pinpoint console](https://console.aws.amazon.com/pinpoint/home/).


---

## 📚 Related Topics
- [[Analytics/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/analytics/native_common/getting-started/30_initAnalytics.mdx`