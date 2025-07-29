---
title: Integrate native modules
topics: ['Push Notifications', 'React', 'Getting Started']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/react-native/getting_started/50_integrate_native_modules.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, react, getting-started]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[React/]] • [[Getting Started/]]
**Primary**: [[Push Notifications/]]

---


# Integrate native modules

## Integrate native modules

> **Note**: 
  On Android, there should be no additional integration steps after the
  prerequisites above have been completed.

Since push notifications require interaction with the native platform, there are some additional steps required to integrate your React Native app with the Amplify Push Notifications native module.

### Link the module

You should have already installed the native module in an earlier step, now you need to link it. In your React Native app's root directory run the following command.

```bash
npx pod-install
```

### Update your Application Delegate

Depending on the React Native version you’re using, you need to use Objective-C or Swift code snippets to update your application.

= 0.77.0">

Locate and open your `AppDelegate.swift` file in your text editor. You should find it in your React Native project under `/ios/<your-project-name>`.

At the top of your `AppDelegate`, import Amplify Push Notifications:

```swift
import ReactAppDependencyProvider
import AmplifyRTNPushNotification // <- add this line

...
```

In the body of your `AppDelegate`, add the following two methods:

```swift
override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) 

override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) 
```

</Block>

Locate and open your `AppDelegate.m` or `AppDelegate.mm` file in your text editor. You should find it in your React Native project under `/ios/<your-project-name>`

At the top of your `AppDelegate`, import Amplify Push Notifications:

```objective-c
#import "AppDelegate.h"
#import "AmplifyPushNotification.h"

...
```

In the body of your `AppDelegate`, add the following two methods:

```objective-c
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken 

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler 
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[React/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/react-native/getting_started/50_integrate_native_modules.mdx`