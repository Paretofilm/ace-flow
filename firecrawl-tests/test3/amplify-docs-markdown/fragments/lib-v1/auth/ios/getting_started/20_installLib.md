---
title: Documentation
source: fragments/lib-v1/auth/ios/getting_started/20_installLib.mdx
---

# Documentation

3. Lastly, choose **AWSCognitoAuthPlugin** and **Amplify**. Then click **Add Package**.

</Block>

To install Amplify Auth to your application, **add `AmplifyPlugins/AWSCognitoAuthPlugin` to your `Podfile`**. Your `Podfile` should look similar to:

```ruby
target 'MyAmplifyApp' do
  use_frameworks!
  pod 'Amplify'
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
