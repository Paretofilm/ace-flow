---
title: Documentation
topics: ['React']
primary_topic: React
source: fragments/common/react-native-version-deployment-target.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, react]
---


## 🧭 Navigation
**Topics**: [[React/]]
**Primary**: [[React/]]

---


# Documentation

`@aws-amplify/react-native` requires a minimum iOS deployment target of `13.0` if you are using `react-native` version less than or equal to `0.72`. Open the _Podfile_ located in the _ios_ directory and update the `target` value:

  ```diff
   - platform :ios, min_ios_version_supported
   + platform :ios, 13.0
   ```

</Accordion>


---

## 📚 Related Topics
- [[React/]]

## 📖 Source
Original: `fragments/common/react-native-version-deployment-target.mdx`