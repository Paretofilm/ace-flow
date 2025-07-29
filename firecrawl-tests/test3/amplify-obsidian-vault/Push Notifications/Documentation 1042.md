---
title: Documentation
topics: ['Push Notifications', 'Getting Started']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/ios/getting_started/50_existing_resources.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, getting-started]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[Getting Started/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

Amplify reads configuration information at runtime from a file called `amplifyconfiguration.json`. If you used the Amplify CLI to create backend resources, this file was created for you. If it does not already exist, create the file and add it to your Xcode project.

Existing Amazon Pinpoint resources can be used with the Amplify Libraries by referencing your **Application ID** and **Region** in your `amplifyconfiguration.json` file.

```json
"notifications": 
    }
}
```

- **appId**: Amazon Pinpoint application ID
- **region**: AWS Region where the resources are provisioned (e.g. `us-east-1`)


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/push-notifications/ios/getting_started/50_existing_resources.mdx`