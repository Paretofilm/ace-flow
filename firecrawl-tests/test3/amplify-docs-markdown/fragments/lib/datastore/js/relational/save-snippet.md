---
title: My Post with comments
source: fragments/lib/datastore/js/relational/save-snippet.mdx
---

# My Post with comments

```js
const post = await DataStore.save(
  new Post()
);

await DataStore.save(
  new Comment()
);
```
