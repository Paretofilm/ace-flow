---
title: Create an Amplify DataStore app
topics: ['Data & APIs', 'Getting Started']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/getting-started/60_saveSnippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, getting-started]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Getting Started/]]
**Primary**: [[Data & APIs/]]

---


# Create an Amplify DataStore app

```swift
let post = Post(title: "Create an Amplify DataStore app",
                status: .active)

Amplify.DataStore.save(post) 
}
```

</Block>

```swift
let post = Post(title: "Create an Amplify DataStore app",
                status: .active)
let saveSink = Amplify.DataStore.save(post).sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/getting-started/60_saveSnippet.mdx`