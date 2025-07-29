---
title: Retrieve userIDs with Amplify Auth.
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/logging/configure-user/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Retrieve userIDs with Amplify Auth.

Each Amplify authenticated user can be configured to have their own unique logging configuration. This is helpful in enabling you debug issues more granularly for your users.

## Retrieve userIDs with Amplify Auth.

You can use the Amplify Auth category to retrieve the userId for a specific user if needed. You can also retrieve the userId by visiting the Amazon Cognito console and inspecting the `User ID` in User pools.

```java
Amplify.Auth.getCurrentUser(
   user.userId,
   error -> // failed to fetch user
);
```
</Block>

```kotlin
Amplify.Auth.getCurrentUser()
```

</Block>

```java
RxAmplify.Auth.getCurrentUser().subscribe(
        result -> result.userId,
        error -> // failed to get user
 );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
Amplify.Auth.getCurrentUser().userId
```

</InlineFilter>

## Configure user allow list

Below is an example of setting different default and category log level for an authenticated user.

    Add a `userLogLevel` section and for each user identifier add a `defaultLogLevel` and `categoryLogLevel`.

```json

                }
            }
        }
    }
}
```

  </Block>

Provide a map of `UserLogLevel` at initialization and configuration of the `AWSCloudWatchLoggingPlugin`.

```java
Map categoryOverrides = new HashMap<>();
categoryOverrides.put(CategoryType.AUTH, LogLevel.VERBOSE);
categoryOverrides.put(CategoryType.STORAGE, LogLevel.DEBUG);

UserLogLevel userLogLevel = new UserLogLevel(LogLevel.WARN, categoryOverrides);

Map userOverrides = new HashMap<>();
userOverrides.put("USER_ID", userLogLevel);

LoggingConstraints loggingConstraints = new LoggingConstraints(LogLevel.WARN, categoryOverrides, userOverrides);

AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>, <region>, loggingConstraints);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>

```kotlin
val categoryOverrides = mapOf(CategoryType.AUTH to LogLevel.VERBOSE, CategoryType.STORAGE to LogLevel.DEBUG)
val userOverrides = mapOf("USER_ID" to UserLogLevel(LogLevel.WARN, categoryOverrides))

val loggingConstraints = LoggingConstraints(defaultLogLevel = LogLevel.WARN, userLogLevel = userOverrides)

val config = AWSCloudWatchLoggingPluginConfiguration(logGroupName = <log-group-name>, region = <region>, loggingConstraints = loggingConstraints)
Amplify.addPlugin(AWSCloudWatchLoggingPlugin(config))
```
</Block>

```java
Map categoryOverrides = new HashMap<>();
categoryOverrides.put(CategoryType.AUTH, LogLevel.VERBOSE);
categoryOverrides.put(CategoryType.STORAGE, LogLevel.DEBUG);

UserLogLevel userLogLevel = new UserLogLevel(LogLevel.WARN, categoryOverrides);

Map userOverrides = new HashMap<>();
userOverrides.put("USER_ID", userLogLevel);

LoggingConstraints loggingConstraints = new LoggingConstraints(LogLevel.WARN, categoryOverrides, userOverrides);

AWSCloudWatchLoggingPluginConfiguration config = new AWSCloudWatchLoggingPluginConfiguration (<log-group-name>, <region>, loggingConstraints);
Amplify.addPlugin(new AWSCloudWatchLoggingPlugin(config));
```

</Block>
</BlockSwitcher>

</InlineFilter>

Provide a dictionary of `UserLogLevel` at initialization and configuration of the `AWSCloudWatchLoggingPlugin`.

```swift
do  catch 
```
</InlineFilter>

  </Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/logging/configure-user/index.mdx`