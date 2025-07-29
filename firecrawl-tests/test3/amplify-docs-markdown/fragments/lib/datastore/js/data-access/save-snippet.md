---
title: My First Post
source: fragments/lib/datastore/js/data-access/save-snippet.mdx
---

# My First Post

```js
await DataStore.save(
  new Post()
);
```

> **Note**: 

Omitted or `undefined` optional fields are converted to `null` upon instantiation.
