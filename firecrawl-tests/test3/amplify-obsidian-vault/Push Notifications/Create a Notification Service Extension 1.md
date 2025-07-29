---
title: Create a Notification Service Extension
topics: ['Push Notifications']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/common/enable-rich-notifications.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]]
**Primary**: [[Push Notifications/]]

---


# Create a Notification Service Extension

> **Note**: 
  On Android, Amplify Push Notifications should already be configured to handle
  rich content for you.

Amplify currently supports adding images to your notifications, but there are some additional steps required.

## Create a Notification Service Extension

1. Open `<your-app-name>.xcworkspace` located inside the `/ios` folder of your application project with Xcode.

2. In the Xcode project, select **File > New > Target...**

![The file menu is selected in the toolbar, then the new option is selected, then the target option.](/images/push-notifications/cross-platform-service-extension/01_new-target.png)

3. Select **Notification Service Extension > Next**.

![The notification service extension option is selected in the new target popup.](/images/push-notifications/cross-platform-service-extension/02_target-type.png)

4. Enter a name for your service extension (e.g. MyNotificationServiceExtension) and select **Finish**.

![Form for the new target options.](/images/push-notifications/cross-platform-service-extension/03_target-name.png)

## Provide the extension with the Amplify service class

1. Open `Podfile` located inside the `/ios` folder of your application project with a text editor.

2. Add `AmplifyUtilsNotifications` to the extension you created above.

4. Open `<your-app-name>.xcworkspace` located inside the `/ios` folder of your application project with Xcode.

5. Find your extension folder in the Project navigator pane and select the **Info** Property List.

![Extension info](/images/push-notifications/cross-platform-service-extension/04_extension-info.png)

6. Update the `NSExtensionPrincipalClass` property with the value `AmplifyUtilsNotifications.AUNotificationService`.

![Extension class](/images/push-notifications/cross-platform-service-extension/05_extension-class.png)


---

## 📚 Related Topics
- [[Push Notifications/]]

## 📖 Source
Original: `fragments/lib/push-notifications/common/enable-rich-notifications.mdx`