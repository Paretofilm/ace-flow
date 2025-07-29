---
title: Documentation
source: fragments/lib-v1/storage/ios/getting-started/20_installLib.mdx
---

# Documentation

3. Lastly, choose **AWSS3StoragePlugin**, **AWSCognitoAuthPlugin**, and **Amplify**. Then click **Add Package**.

</Block>

To install the Amplify Storage and Authentication to your application, **add both `AmplifyPlugins/AWSS3StoragePlugin` and `AmplifyPlugins/AWSCognitoAuthPlugin` to your `Podfile`**. Your `Podfile` should look similar to:

```ruby
target 'MyAmplifyApp' do
  use_frameworks!
  pod 'Amplify'
  pod 'AmplifyPlugins/AWSS3StoragePlugin'
  pod 'AmplifyPlugins/AWSCognitoAuthPlugin'
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
