---
title: Record event
source: fragments/lib-v1/analytics/android/record.mdx
---

# Record event

## Record event

The Amplify analytics plugin also makes it easy to record custom events within the app. The plugin handles retry logic in the event the device loses network connectivity and automatically batches requests to reduce network bandwidth.

```java
AnalyticsEvent event = AnalyticsEvent.builder()
    .name("PasswordReset")
    .addProperty("Channel", "SMS")
    .addProperty("Successful", true)
    .addProperty("ProcessDuration", 792)
    .addProperty("UserAge", 120.3)
    .build();

Amplify.Analytics.recordEvent(event);
```

</Block>

```kotlin
val event = AnalyticsEvent.builder()
    .name("PasswordReset")
    .addProperty("Channel", "SMS")
    .addProperty("Successful", true)
    .addProperty("ProcessDuration", 792)
    .addProperty("UserAge", 120.3)
    .build()

Amplify.Analytics.recordEvent(event)
```

</Block>

```java
AnalyticsEvent event = AnalyticsEvent.builder()
    .name("PasswordReset")
    .addProperty("Channel", "SMS")
    .addProperty("Successful", true)
    .addProperty("ProcessDuration", 792)
    .addProperty("UserAge", 120.3)
    .build();

RxAmplify.Analytics.recordEvent(event);
```

</Block>
</BlockSwitcher>

> **Note**: 

The AWS Pinpoint event count updates in minutes after recording your event.

However, it can take upwards of 30 minutes for the event to display in the Filter section, and for its custom attributes to appear in Pinpoint. 

## Flush events

Events have default configuration to flush out to the network every 30 seconds. If you would like to change this, update `amplifyconfiguration.json` with the value in milliseconds you would like for `autoFlushEventsInterval`. This configuration will flush events every 10 seconds:

```json
,
                "pinpointTargeting": 
            }
        }
    }
}
```

To manually flush events, call:

```java
Amplify.Analytics.flushEvents();
```

</Block>

```kotlin
Amplify.Analytics.flushEvents()
```

</Block>

```java
RxAmplify.Analytics.flushEvents();
```

</Block>
</BlockSwitcher>

## Authentication events

  ```java
  /**
  * Call this method to log an authentication event to the analytics client.
  */
  public void logAuthenticationEvent() 
  ```

  </Block>

  ```kotlin

  /**
  * Call this method to log an authentication event to the analytics client.
  */
  fun logAuthenticationEvent() 
  ```
  </Block>

  ```java

  /**
  * Call this method to log an authentication event to the analytics client.
  */
  public void logAuthenticationEvent() 
  ```
  </Block>
  </BlockSwitcher>

## Global Properties

You can register global properties which will be sent along with all invocations of `Amplify.Analytics.recordEvent`.

```java
Amplify.Analytics.registerGlobalProperties(
    AnalyticsProperties.builder()
        .add("AppStyle", "DarkMode")
        .build());
```

</Block>

```kotlin
Amplify.Analytics.registerGlobalProperties(
    AnalyticsProperties.builder()
        .add("AppStyle", "DarkMode")
        .build())
```

</Block>

```java
RxAmplify.Analytics.registerGlobalProperties(
    AnalyticsProperties.builder()
        .add("AppStyle", "DarkMode")
        .build());
```

</Block>
</BlockSwitcher>

To unregister a global property, call `Amplify.Analytics.unregisterGlobalProperties()`:

```java
Amplify.Analytics.unregisterGlobalProperties("AppStyle", "OtherProperty");
```

</Block>

```kotlin
Amplify.Analytics.unregisterGlobalProperties("AppStyle", "OtherProperty")
```

</Block>

```java
RxAmplify.Analytics.unregisterGlobalProperties("AppStyle", "OtherProperty");
```

</Block>
</BlockSwitcher>

## Disable Analytics

To disable analytics, call:

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

## Enable Analytics

To re-enable, call:

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
