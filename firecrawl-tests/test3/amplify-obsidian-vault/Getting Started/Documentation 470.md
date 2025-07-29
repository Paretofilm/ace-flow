---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib-v1/graphqlapi/ios/getting-started/20_installLib.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Documentation

3. Lastly, choose **AWSAPIPlugin** and **Amplify** and click **Add Package**.

</Block>

To install the Amplify API to your application, **add `AmplifyPlugins/AWSAPIPlugin` to your `Podfile`**. Your `Podfile` should look similar to:

```ruby
target 'MyAmplifyApp' do
  use_frameworks!
  pod 'Amplify'
  pod 'AmplifyPlugins/AWSAPIPlugin'
end
```

To install, download and resolve these pods, **execute the command**:

```ruby
pod install --repo-update
```

Now you can **open your project** by opening the `.xcworkspace` file using the following command:

```ruby
xed .
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/ios/getting-started/20_installLib.mdx`