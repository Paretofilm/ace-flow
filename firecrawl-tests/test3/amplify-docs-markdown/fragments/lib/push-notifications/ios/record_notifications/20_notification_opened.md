---
title: Documentation
source: fragments/lib/push-notifications/ios/record_notifications/20_notification_opened.mdx
---

# Documentation

> **Note**: 

**Note:** This functionality is not available in **tvOS**.

You can record that a user opened a push notification with Amazon Pinpoint by calling `Amplify.Notifications.Push.recordNotificationOpened(_)` from the `userNotificationCenter(_:didReceive:)` delegate method of your UNUserNotificationCenter Delegate.

First, set the UNUserNotificationCenter delegate to your Application Delegate by adding or updating the following method.

```swift
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
) -> Bool 
```

</Block>

```swift
func applicationDidFinishLaunching(_ notification: Notification) 
```

</Block>

```swift
func applicationDidFinishLaunching() 
```

</Block>
</BlockSwitcher>

Then, extend your Application Delegate to conform to `UNUserNotificationCenterDelegate` and add the following method.

```swift
extension AppDelegate: UNUserNotificationCenterDelegate  catch 
    }
}
```
