---
title: Documentation
source: fragments/lib/push-notifications/react-native/request_permissions/request-permissions.mdx
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
