---
title: Documentation
source: fragments/lib/push-notifications/flutter/enable_rich_notifications/add-notifications-pod.mdx
---

# Documentation

```ruby
target 'MyNotificationServiceExtension' do # Replace with your service extension
  use_frameworks!

  pod "AmplifyUtilsNotifications"
end
```

3. Install the new pods by running `pod install` in the `ios/` of your application project.

> **Note**: 

  Note: You will first need to [install Cocoapods](https://guides.cocoapods.org/using/getting-started.html) to enable the `pod` command.

```bash
cd ios
pod install
```
