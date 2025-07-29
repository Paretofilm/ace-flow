---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/js/data-access/query-predicate-or-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

If you wanted this to be an `or` statement you would wrap your combined predicates with `c => c.or(...)`

```js
const posts = await DataStore.query(Post, (c) =>
  c.or(c => [
    c.rating.gt(4),
    c.status.eq(PostStatus.ACTIVE)
  ]));
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/js/data-access/query-predicate-or-snippet.mdx`