---
title: Install Amplify Libraries
topics: ['Data & APIs', 'Getting Started']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/ios/getting-started/20_installLib.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, getting-started]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Getting Started/]]
**Primary**: [[Data & APIs/]]

---


# Install Amplify Libraries

## Install Amplify Libraries

3. Lastly, choose **AWSDataStorePlugin** and **Amplify**. Then click **Add Package**.

</Block>

To install the Amplify DataStore to your application, add `AmplifyPlugins/AWSDataStorePlugin`. Your `Podfile` should look similar to:

```ruby
target 'MyAmplifyApp' do
  use_frameworks!
  pod 'Amplify'
  pod 'AmplifyPlugins/AWSDataStorePlugin'
end
```

To install, download and resolve these pods, **execute the command**:

```bash
pod install --repo-update
```

Now you can **open your project** by opening the `.xcworkspace` file using the following command:

```bash
xed .
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/ios/getting-started/20_installLib.mdx`