---
title: Documentation
source: fragments/lib/datastore/js/data-access/query-predicate-snippet.mdx
---

# Documentation

```js
const posts = await DataStore.query(Post, (c) => c.rating.gt(4));
```
