---
title: Querying for a single item
source: fragments/lib-v1/datastore/js/data-access/query-single-item-snippet.mdx
---

# Querying for a single item

### Querying for a single item

To query for a single item, pass in the ID of the item as the second argument to the query.

```js
const post = await DataStore.query(Post, "1234567");
```
