---
title: Add the API plugin
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/ios/sync/10-installPlugin.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Add the API plugin

### Add the API plugin

Although DataStore presents a distinct API, its cloud synchronization functionality relies on the underlying [API category](/gen1/[platform]/build-a-backend/graphqlapi/). Therefore, you will still be required to incorporate the API plugin when working with DataStore.

Add `AWSAPIPlugin` in your Amplify initialization code alongside with the previously added `AWSDataStorePlugin`.

```swift
try Amplify.add(plugin: AWSAPIPlugin())
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/ios/sync/10-installPlugin.mdx`