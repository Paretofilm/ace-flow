---
title: Documentation
source: fragments/lib/analytics/native_common/getting-started/30_initAnalytics.mdx
---

# Documentation

```javascript

Amplify.configure(amplifyconfig);
```

> **Note**: 

Make sure you call `Amplify.configure` as early as possible in your application’s life-cycle. A missing configuration or `NoCredentials` error is thrown if `Amplify.configure` has not been called before other Amplify JavaScript APIs. Review the [Library Not Configured Troubleshooting guide](/gen1/[platform]/build-a-backend/troubleshooting/library-not-configured/) for possible causes of this issue.

User session data is automatically collected unless you disabled analytics. To see the results visit the [Amazon Pinpoint console](https://console.aws.amazon.com/pinpoint/home/).
