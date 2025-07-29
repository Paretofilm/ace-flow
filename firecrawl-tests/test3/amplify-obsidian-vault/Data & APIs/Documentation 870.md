---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/js/sync/30-savePredicateComparison.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/js/sync/30-savePredicateComparison.mdx`