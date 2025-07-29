---
title: Documentation
source: fragments/lib/datastore/js/sync/20-savePredicate.mdx
---

# Documentation

```js
await DataStore.save(
  Post.copyOf(original, (updated) => ),
  (p) => p.title.beginsWith('[Amplify]')
);
```
