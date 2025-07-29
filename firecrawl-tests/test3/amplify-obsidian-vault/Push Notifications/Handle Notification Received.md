---
title: Handle Notification Received
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/android/record_notifications/10_handle_notification_received.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]]
**Primary**: [[Push Notifications/]]

---


# Handle Notification Received

> **Note**: 

You do not need to add these APIs to your app if you want to use Amplify with Amazon Pinpoint. You should use these APIs if you are interested in supporting multiple push providers.

## Handle Notification Received

You can display the notification in the system tray if the app is in a background or killed state by calling `Amplify.Notifications.Push.handleNotificationReceived()` from the Messaging Service class. It also calls `recordNotificationReceived` irrespective of the app state  when the device receives a notifications from Pinpoint.

```java
class MyAppService extends FirebaseMessagingService() 
    }
}
```

</Block>

```kotlin
class MyAppService : FirebaseMessagingService() ,
                
            )
        }
    }
}
```

</Block>

```kotlin
class MyAppService : FirebaseMessagingService()  catch (error: PushNotificationsException) 
        }
    }
}
```

</Block>

```java
class MyAppService extends FirebaseMessagingService() 
    }
}
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Push Notifications/]]

## 📖 Source
Original: `fragments/lib/push-notifications/android/record_notifications/10_handle_notification_received.mdx`