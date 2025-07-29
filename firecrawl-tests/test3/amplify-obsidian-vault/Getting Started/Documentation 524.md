---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib-v1/predictions/ios/getting-started/30_installLib.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Documentation

To install the libraries required to translating text, **add both `AWSPredictionsPlugin` and `CoreMLPredictionsPlugin` to your `Podfile`**.  Your `Podfile` should look similar to:

```ruby
target 'MyAmplifyApp' do
  use_frameworks!
  pod 'Amplify'
  pod 'AmplifyPlugins/AWSCognitoAuthPlugin'
  pod 'AWSPredictionsPlugin'
  pod 'CoreMLPredictionsPlugin'
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


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/predictions/ios/getting-started/30_installLib.mdx`