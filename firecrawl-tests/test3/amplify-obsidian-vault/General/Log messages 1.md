---
title: Log messages
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/logging/send-logs/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Log messages

With the Amplify Logger, you can send logs to Amazon CloudWatch from errors that are caught by the Amplify library or by adding your own custom log messages. You can also customize which levels of log messages to send to CloudWatch.

## Log messages

> **Note**: 

You should follow best security practices when logging messages. This includes validating log messages and ensuring log messages don't contain personally identifiable information and/or sensitive data.

You can log messages using the Amplify logger to a specific namespace to help you group logs that are similar when they are sent to CloudWatch. To accomplish this, get an instance of the `Logger` and specify a `category name` and/or `namespace`. Use the `Logger` instance to log messages at the desired log level. The `category name` and `namespace` values are used to tag your log messages that will appear in CloudWatch. They are also used to identify and fetch the logger again without creating a new `Logger` instance.

You can also log JSON formatted log messages to leverage [AWS CloudWatch](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AnalyzingLogData.html) query and filter supports.

```java
Logger logger = Amplify.Logging.logger(AmplifyCategory.Auth, "<namespace>")
try  catch(Exception: exception) 

```

</Block>

```kotlin
val logger = Amplify.Logging.logger(AmplifyCategory.Auth, "<namespace>")
try  catch (exception: Exception) 
```

</Block>

```java
Logger logger = Amplify.Logging.logger(AmplifyCategory.Auth, "<namespace>")
try  catch(Exception: exception) 
```
</Block>
</BlockSwitcher>

The following are existing Amplify category names that are used by default by Amplify when automatically logging errors from the library.
* `ANALYTICS`
* `API`
* `AUTH`
* `DATASTORE`
* `HUB`
* `LOGGING`
* `NOTIFICATIONS`
* `PREDICTIONS`
* `STORAGE`
* `GEO`

</InlineFilter>

```swift
let logger = Amplify.Logging.logger(forCategory: "Authentication", forNamespace: "<your-code-namespace>")
do  catch 
```

The following are existing Amplify category names that are used by default by Amplify when automatically logging errors from the library.
* `Analytics`
* `API`
* `Authentication`
* `DataStore`
* `Geo`
* `Hub`
* `Logging`
* `Predictions`
* `PushNotifications`
* `Storage`

</InlineFilter>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/logging/send-logs/index.mdx`