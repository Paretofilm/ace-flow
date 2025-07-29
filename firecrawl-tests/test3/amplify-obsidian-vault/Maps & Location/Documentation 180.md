---
title: Documentation
topics: ['Maps & Location', 'Getting Started']
primary_topic: Maps & Location
source: fragments/lib-v1/geo/ios/getting_started/30_install_lib.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location, getting-started]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]] • [[Getting Started/]]
**Primary**: [[Maps & Location/]]

---


# Documentation

The Geo plugin is dependent on Cognito Auth.

1. To install Amplify Geo and Authentication to your application, open your project in Xcode and select **File > Add Packages...**.

1. Enter the Amplify iOS GitHub repo URL (`https://github.com/aws-amplify/amplify-swift`) into the search bar and and hit **Enter** Wait for the result to load. You'll see the repository rules for which version of amplify-ios-mapLibre you want Swift Package Manager to install.

1. Choose the dependency rule **Up to Next Major Version**, as it will use the latest compatible version of the dependency, then click **Add Package**.

1. Lastly, choose **AWSLocationGeoPlugin**, **AWSCognitoAuthPlugin**, and **Amplify**. Then click Finish.

</Block>

> **Note**: 

**Troubleshooting:** If you intend on using the Amplify-MapLibre adapter to render maps, you **must** use Swift Package Manager to add Amplify. The adapter is incompatible with existing Amplify dependencies added via CocoaPods.

To install the Amplify Geo and Authentication to your application, **add both "AmplifyPlugins/AWSLocationGeoPlugin" and "AmplifyPlugins/AWSCognitoAuthPlugin" to your `Podfile`** (Because IAM credential is required to access Amazon Location Service, `"AWSCognitoAuthPlugin"` also needs to be installed). Your `Podfile` should look similar to:

```bash
target 'MyAmplifyApp' do
  use_frameworks!
  pod 'Amplify'
  pod 'AmplifyPlugins/AWSLocationGeoPlugin'
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
- [[Maps & Location/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/geo/ios/getting_started/30_install_lib.mdx`