---
title: Add Required Polyfills
topics: ['Data & APIs', 'React', 'Getting Started']
primary_topic: Data & APIs
source: fragments/lib/datastore/react-native/getting-started/polyfills.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, react, getting-started]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[React/]] • [[Getting Started/]]
**Primary**: [[Data & APIs/]]

---


# Add Required Polyfills

### Add Required Polyfills

React Native and Expo apps using `react-native` 0.70+ enable the Hermes engine by default, which does not currently support `asyncIterator` out of the box. DataStore requires adding the following to the entry point of your app to polyfill `asyncIterator` support:

```js
import '@azure/core-asynciterator-polyfill';
```


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[React/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/datastore/react-native/getting-started/polyfills.mdx`