---
title: Documentation
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/android/record_notifications/20_record_notification_received.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

You can record receipt of a push notification with Amazon Pinpoint by calling `Amplify.Notifications.Push.recordNotificationReceived()` from the Messaging Service class.

> **Note**: 

You should call either `handleNotificationReceived` or `recordNotificationReceived`, but not both since `handleNotificationReceived` internally calls `recordNotificationReceived`.

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
Original: `fragments/lib/push-notifications/android/record_notifications/20_record_notification_received.mdx`