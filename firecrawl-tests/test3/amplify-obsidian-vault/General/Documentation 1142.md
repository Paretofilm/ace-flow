---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/logging/ios/setup_logging/30_initialize_without_config.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

To use the Amplify Logger and Amplify Auth categories in your app, you need to create and configure their corresponding plugins by calling the `Amplify.add(plugin:)` and `Amplify.configure()` methods.

Add the following imports to the top of your main `App` file:

```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSCloudWatchLoggingPlugin
```

Add the following code to its initializer. If there is none, you can create a default `init`.  The `<log-group-name>` and `<region>` are values you specified in the CDK construct as part of provisioning your backend resources.  These values can also be found at the end of the output logs when deploying the sample CDK construct. 
The example below configures the logging plugin to automatically send all logs at log level `ERROR` at 60 seconds interval and store logs locally up to 1MB.

```swift
init()  catch 
}
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/logging/ios/setup_logging/30_initialize_without_config.mdx`