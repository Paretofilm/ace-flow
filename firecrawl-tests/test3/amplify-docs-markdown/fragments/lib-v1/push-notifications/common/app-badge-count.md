---
title: Get the current badge count
source: fragments/lib-v1/push-notifications/common/app-badge-count.mdx
---

# Get the current badge count

The app badge count, when set, can be seen on your app's icon on a user's device. Amplify provides you with simple helpers to manipulate this number.

> **Note**: 
  App badge count helpers are safe to call (but will be ignored) even when your
  app is running on platforms where badges are not supported.

## Get the current badge count

Use `getBadgeCount` to get the current app badge count. You might need to do this to calculate the value when setting the badge count.

## Update the badge count

Use `setBadgeCount` to set the current app badge count. Setting the badge count to `0` (zero) will remove the badge from your app's icon.
