---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/js/relational/delete-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/js/relational/delete-snippet.mdx`