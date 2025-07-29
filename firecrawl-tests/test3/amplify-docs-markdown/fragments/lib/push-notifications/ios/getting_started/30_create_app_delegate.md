---
title: Application Delegate
source: fragments/lib/push-notifications/ios/getting_started/30_create_app_delegate.mdx
---

# Application Delegate

## Application Delegate

APNs requires an application delegate to handle push notifications functionality via delegate methods. If your app does not already have an application delegate, you will need to create one:

1. Create a class that subclasses `NSObject` and implements the `UIApplicationDelegate` (iOS/tvOS), `WKApplicationDelegate` (watchOS), or `NSApplicationDelegate` (macOS) protocol.

```swift
class AppDelegate: NSObject, UIApplicationDelegate 
```

</Block>

```swift
class AppDelegate: NSObject, NSApplicationDelegate 
```

</Block>

```swift
class AppDelegate: NSObject, WKApplicationDelegate 
```

</Block>
</BlockSwitcher>

2. Add a property to your main app struct that identifies your application delegate.

```swift
@main
struct App: App 
```

</Block>

```swift
@main
struct App: App 
```

</Block>

```swift
@main
struct App: App 
```

</Block>
</BlockSwitcher>
