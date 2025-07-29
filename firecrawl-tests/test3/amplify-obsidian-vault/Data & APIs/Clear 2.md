---
title: Clear
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/js/other-methods.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Clear

## Clear

To clear local data from DataStore, use the `clear` method:

```js

await DataStore.clear();
```

> **Note**: 

If your app has authentication implemented, it is recommended to call `DataStore.clear()` on sign-in/sign-out to remove any user-specific data. This method is often important to use for shared device scenarios or where you need to purge the local on-device storage of records for security/privacy concerns.

## Start

To manually start the sync process, use the `start` method:

```js

await DataStore.start();
```

Synchronization starts automatically whenever you run any of the following methods: `DataStore.query()`, `DataStore.save()`, `DataStore.delete()`, or `DataStore.observe()`.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/js/other-methods.mdx`