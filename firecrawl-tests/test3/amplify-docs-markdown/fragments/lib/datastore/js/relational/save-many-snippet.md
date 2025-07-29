---
title: My first post
source: fragments/lib/datastore/js/relational/save-many-snippet.mdx
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
