---
title: Documentation
source: fragments/lib/datastore/native_common/callout/datastore-clear-with-auth.mdx
---

# Documentation

> **Note**: 

If your app uses authentication, it is recommended to call `DataStore.clear()` on sign-in or sign-out to remove any user-specific data. In scenarios where a mobile device can be shared by several users, calling `DataStore.clear()` will ensure that data does not leak from one user to another.
