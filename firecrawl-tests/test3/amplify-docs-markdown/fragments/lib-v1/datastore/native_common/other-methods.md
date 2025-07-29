---
title: Clear
source: fragments/lib-v1/datastore/native_common/other-methods.mdx
---

# Clear

## Clear

To stop DataStore sync process and to clear local data from DataStore, use the `clear` method:

## Start

## Stop

To stop the DataStore sync process, you can use `DataStore.stop()`. This will close the real time subscription connection when your app is no longer interested in updates. You will typically call `DataStore.stop()` just before your application is closed. You can also force your [DataStore sync expressions](/gen1/[platform]/prev/build-a-backend/more-features/datastore/sync-to-cloud/) to be re-evaluated at runtime by calling `stop()` followed by `start()`.
