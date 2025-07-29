---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/js/real-time/observe-query-snippet.mdx
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
const subscription = DataStore.observeQuery(
  Post,
  p => p.and(p => [
    p.title.beginsWith("post"),
    p.rating.gt(10)
  ]), 
).subscribe(snapshot =>  = snapshot;
  console.log(`[Snapshot] item count: $, isSynced: $`);
});
```

> **Note**: 

The default configuration for `observeQuery` has a default `syncPageSize` of 1,000 and a default `maxRecordsToSync` of 10,000. These values can be customized by configuring their values manually in `DataStore.configure`.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/js/real-time/observe-query-snippet.mdx`