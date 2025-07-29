---
title: Disable Analytics
source: pages/build-a-backend/add-aws-services/analytics/enable-disable/index.mdx
---

# Disable Analytics

## Disable Analytics

Analytics are enabled by default when you configure it in your app. To disable Analytics in your app use the `disable` function:

```javascript title="src/index.js"

disable();
```
</InlineFilter>

```java
Amplify.Analytics.disable();
```

</Block>

```kotlin
Amplify.Analytics.disable()
```

</Block>

```java
RxAmplify.Analytics.disable();
```

</Block>
</BlockSwitcher>
</InlineFilter>

```dart
await Amplify.Analytics.disable();
```
</InlineFilter>

```swift
Amplify.Analytics.disable()
```
</InlineFilter>

## Enable Analytics

To enable analytics you can use the `enable` function in your app:

```javascript title="src/index.js"

enable();
```
</InlineFilter>

```java
Amplify.Analytics.enable();
```

</Block>

```kotlin
Amplify.Analytics.enable()
```

</Block>

```java
RxAmplify.Analytics.enable();
```

</Block>
</BlockSwitcher>
</InlineFilter>

```dart
Amplify.Analytics.enable();
```
</InlineFilter>

```swift
Amplify.Analytics.enable()
```
</InlineFilter>
