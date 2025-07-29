---
title: My first post
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/js/relational/save-many-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# My first post

```js
// first you save the post
const post = await DataStore.save(
  new Post()
);

// secondly, you save the editor/user
const editor = await DataStore.save(
  new User()
);

// then you save the model that links a post with an editor
await DataStore.save(
  new PostEditor()
);
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/js/relational/save-many-snippet.mdx`