---
title: Documentation
source: fragments/lib/push-notifications/react-native/interact_with_notifications/on-notification-opened.mdx
---

# Documentation

```ts
import  from 'aws-amplify/push-notifications';

const myNotificationOpenedHandler: OnNotificationOpenedInput = (
  notification
) => ;

const listener: OnNotificationOpenedOutput = onNotificationOpened(
  myNotificationOpenedHandler
);

listener.remove(); // Remember to remove the listener when it is no longer needed
```

</Block>

```js

const myNotificationOpenedHandler = (notification) => ;

const listener = onNotificationOpened(myNotificationOpenedHandler);

listener.remove(); // Remember to remove the listener when it is no longer needed
```

</Block>
</BlockSwitcher>
