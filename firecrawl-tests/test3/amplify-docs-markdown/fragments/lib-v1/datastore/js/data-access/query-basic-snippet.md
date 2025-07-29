---
title: Querying for all items
source: fragments/lib-v1/datastore/js/data-access/query-basic-snippet.mdx
---

# Querying for all items

### Querying for all items

To query for all items, pass in the model name as the argument.

```js
const posts = await DataStore.query(Post);
```
