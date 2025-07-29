---
title: Documentation
source: fragments/lib/push-notifications/react-native/interact_with_notifications/on-foreground-notification.mdx
---

# Documentation

```ts
import  from 'aws-amplify/push-notifications';

const myNotificationReceivedHandler: OnNotificationReceivedInForegroundInput = (
  notification
) => ;

const listener: OnNotificationReceivedInForegroundOutput = onNotificationReceivedInForeground(
  myNotificationReceivedHandler
);

listener.remove(); // Remember to remove the listener when it is no longer needed
```

</Block>

```js

const myNotificationReceivedHandler = (notification) => ;

const listener = onNotificationReceivedInForeground(
  myNotificationReceivedHandler
);

listener.remove(); // Remember to remove the listener when it is no longer needed
```

</Block>
</BlockSwitcher>
