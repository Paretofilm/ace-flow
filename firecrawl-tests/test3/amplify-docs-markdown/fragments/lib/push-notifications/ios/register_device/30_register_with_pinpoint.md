---
title: Documentation
source: fragments/lib/push-notifications/ios/register_device/30_register_with_pinpoint.mdx
---

# Documentation

Once the user has granted permission to receive notifications and the device has been registered with APNs, the `application(_:didRegisterForRemoteNotificationsWithDeviceToken:)` delegate method of your Application Delegate will be called with the APNs token. You can use the `Amplify.Notifications.Push.registerDevice(apnsToken:)` method to register the device with Pinpoint.

```swift
// Note: In order for this to work on the simulator, you must be running
// on Apple Silicon, with macOS 13+, Xcode 14+, and iOS simulator 16+.
//
// If your development environment does not meet all of these requirements,
// then you must run on a real device to get an APNs token.
//
func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
)  catch 
    }
}
```

</Block>

```swift
func application(
    _ application: NSApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
)  catch 
    }
}
```

</Block>

```swift
func didRegisterForRemoteNotifications(withDeviceToken deviceToken: Data)  catch 
    }
}
```

</Block>
</BlockSwitcher>
