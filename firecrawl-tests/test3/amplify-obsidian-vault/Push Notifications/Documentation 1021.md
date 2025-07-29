---
title: Documentation
topics: ['Push Notifications', 'React']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/react-native/request_permissions/request-permissions.mdx
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

const permissions: RequestPermissionsInput = ;

const arePermissionsGranted = await requestPermissions(permissions);
// true if granted (or already granted), false otherwise
```

</Block>

```js

const permissions = ;

const arePermissionsGranted = await requestPermissions(permissions);
// true if granted (or already granted), false otherwise
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[React/]]

## 📖 Source
Original: `fragments/lib/push-notifications/react-native/request_permissions/request-permissions.mdx`