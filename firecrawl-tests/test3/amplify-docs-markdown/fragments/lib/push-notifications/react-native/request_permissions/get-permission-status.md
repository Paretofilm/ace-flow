---
title: Documentation
source: fragments/lib/push-notifications/react-native/request_permissions/get-permission-status.mdx
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
