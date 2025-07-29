---
title: Set up existing analytics backend
topics: ['Analytics']
primary_topic: Analytics
source: fragments/lib/analytics/js/existing-resources.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics]
---


## 🧭 Navigation
**Topics**: [[Analytics/]]
**Primary**: [[Analytics/]]

---


# Set up existing analytics backend

## Set up existing analytics backend

The manual setup enables you to use your existing Amazon Pinpoint resource in your app.

```javascript

const resourceConfig = parseAmplifyConfig(amplifyconfig);

Amplify.configure(
  }
});
```

## Update your IAM Policy

Amazon Pinpoint service requires an IAM policy in order to use the `record` and `identifyUser` APIs:
```json
:apps/$*"]
    }
  ]
}
```


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `fragments/lib/analytics/js/existing-resources.mdx`