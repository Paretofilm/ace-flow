---
title: Documentation
topics: ['Push Notifications', 'React']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/react-native/request_permissions/get-permission-status.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, react]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[React/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

```ts
import  from 'aws-amplify/push-notifications';

const status: GetPermissionStatusOutput = await getPermissionStatus();
// 'shouldRequest' | 'shouldExplainThenRequest' | 'granted' | 'denied'
```

</Block>

```js

const status = await getPermissionStatus();
// 'shouldRequest' | 'shouldExplainThenRequest' | 'granted' | 'denied'
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[React/]]

## 📖 Source
Original: `fragments/lib/push-notifications/react-native/request_permissions/get-permission-status.mdx`