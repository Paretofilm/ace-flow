---
title: Documentation
topics: ['Analytics', 'Getting Started']
primary_topic: Analytics
source: fragments/lib-v1/analytics/ios/getting-started/20_installLib.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics, getting-started]
---


## 🧭 Navigation
**Topics**: [[Analytics/]] • [[Getting Started/]]
**Primary**: [[Analytics/]]

---


# Documentation

3. Lastly, choose **AWSPinpointAnalyticsPlugin**, **AWSCognitoAuthPlugin**, and **Amplify**. Then click **Add Package**.

</Block>

To install the Amplify Analytics and Authentication to your application, **add both "AmplifyPlugins/AWSPinpointAnalyticsPlugin" and "AmplifyPlugins/AWSCognitoAuthPlugin" to your `Podfile`** (Because IAM credential is required to access AWS Pinpoint Service, `"AWSCognitoAuthPlugin"` also needs to be installed). Your `Podfile` should look similar to:

```bash
target 'MyAmplifyApp' do
  use_frameworks!
  pod 'Amplify'
  pod 'AmplifyPlugins/AWSPinpointAnalyticsPlugin'
  pod 'AmplifyPlugins/AWSCognitoAuthPlugin'
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
- [[Analytics/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/analytics/ios/getting-started/20_installLib.mdx`