---
title: Documentation
source: fragments/lib-v1/datastore/js/relational/delete-snippet.mdx
---

# Documentation

```ts
const toDelete = await DataStore.query(Post, "123");
if (toDelete) 
```

</Block>

```js
const toDelete = await DataStore.query(Post, "123");
DataStore.delete(toDelete);
```

</Block>
</BlockSwitcher>
