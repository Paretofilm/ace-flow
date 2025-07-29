---
title: Querying for a single item
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/js/data-access/query-single-item-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Querying for a single item

### Querying for a single item

To query for a single item, pass in the ID of the item as the second argument to the query.

```js
const post = await DataStore.query(Post, "1234567");
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/js/data-access/query-single-item-snippet.mdx`