---
title: Documentation
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/ios/record_notifications/10_notification_received.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

You can record receipt of a push notification with Amazon Pinpoint by calling `Amplify.Notifications.Push.recordNotificationReceived(_)` from the `application(_:didReceiveRemoteNotification:)` delegate method of your Application Delegate.

```swift
// Called when a notification is received
//
// Requires background processing->remote notifications entitlement
// and "content-available" : 1 in the notification
//
func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable: Any]
) async -> UIBackgroundFetchResult  catch 
    
    return .newData
}
```

</Block>

```swift
// Called when a notification is received
//
// Requires background processing->remote notifications entitlement
// and "content-available" : 1 in the notification
//
func application(
    _ application: NSApplication,
    didReceiveRemoteNotification userInfo: [String : Any]
)  catch 
    }
}
```

</Block>

```swift
// Called when a notification is received
//
// Requires background processing->remote notifications entitlement
// and "content-available" : 1 in the notification
//
func didReceiveRemoteNotification(_ userInfo: [AnyHashable : Any]) async -> WKBackgroundFetchResult  catch 
    
    return .newData
}
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Push Notifications/]]

## 📖 Source
Original: `fragments/lib/push-notifications/ios/record_notifications/10_notification_received.mdx`