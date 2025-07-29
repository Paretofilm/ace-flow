---
title: Documentation
topics: ['Push Notifications', 'Getting Started']
primary_topic: Push Notifications
source: fragments/lib/push-notifications/android/getting_started/50_init_push_notifications.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, getting-started]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[Getting Started/]]
**Primary**: [[Push Notifications/]]

---


# Documentation

To initialize the Amplify Push Notifications, you will use the `Amplify.addPlugin()` method to add the **AWSCognitoAuthPlugin** and the **AWSPinpointPushNotificationsPlugin** and then call `Amplify.configure()` to finish configuring Amplify.
Displaying push notifications from FCM requires registering mobile devices with the FCM service. The AWSPinpointPushNotificationsPlugin takes care of registering the device with FCM during configuration, and automatically records analytics in Amazon Pinpoint.

Add the following code to your `onCreate()` method in your application class:

```java
import android.util.Log;
import com.amplifyframework.AmplifyException;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.pushnotifications.pinpoint.AWSPinpointPushNotificationsPlugin;
```

```java
Amplify.addPlugin(new AWSCognitoAuthPlugin());
Amplify.addPlugin(new AWSPinpointPushNotificationsPlugin());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>

```kotlin
import android.util.Log
import com.amplifyframework.AmplifyException
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.core.Amplify
import com.amplifyframework.pushnotifications.pinpoint.AWSPinpointPushNotificationsPlugin
```

```kotlin
Amplify.addPlugin(AWSCognitoAuthPlugin())
Amplify.addPlugin(AWSPinpointPushNotificationsPlugin())
```

Your class will look like this:

```kotlin
class MyAmplifyApp : Application()  catch (error: AmplifyException) 
    }
}
```

</Block>

```java
import android.util.Log;
import com.amplifyframework.AmplifyException;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.pushnotifications.pinpoint.AWSPinpointPushNotificationsPlugin;
import com.amplifyframework.rx.RxAmplify;
```

```java
RxAmplify.addPlugin(AWSCognitoAuthPlugin());
RxAmplify.addPlugin(AWSPinpointPushNotificationsPlugin());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>
</BlockSwitcher>

Upon building and running this application you should see the following in your console window:

```console
Initialized Amplify
```


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/push-notifications/android/getting_started/50_init_push_notifications.mdx`