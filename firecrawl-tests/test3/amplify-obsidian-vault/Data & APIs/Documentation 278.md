---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/js/data-access/query-predicate-multiple-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

When using multiple conditions, you can wrap the predicates with the `and` operator. For example with multiple conditions:

```js
const posts = await DataStore.query(Post, (c) => c.and(c => [
  c.rating.gt(4),
  c.status.eq(PostStatus.ACTIVE)
]));
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/js/data-access/query-predicate-multiple-snippet.mdx`