---
title: Documentation
source: fragments/lib/datastore/js/sync/30-savePredicateComparison.mdx
---

# Documentation

```js
// Tests only against the local state
if (post.title.startsWith('[Amplify]')) )
  );
}

// Only applies the update if the data in the remote backend satisfies the criteria
await DataStore.save(
  Post.copyOf(post, (updated) => ),
  (p) => p.title.beginsWith('[Amplify]')
);
```
