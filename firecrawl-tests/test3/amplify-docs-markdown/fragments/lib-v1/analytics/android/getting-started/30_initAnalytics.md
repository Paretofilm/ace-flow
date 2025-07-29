---
title: Documentation
source: fragments/lib-v1/analytics/android/getting-started/30_initAnalytics.mdx
---

# Documentation

To initialize the Amplify Auth and Analytics categories you call `Amplify.addPlugin()` method for each category. To complete initialization call `Amplify.configure()`.

Add the following code to your `onCreate()` method in your application class:

```java
Amplify.addPlugin(new AWSCognitoAuthPlugin());
Amplify.addPlugin(new AWSPinpointAnalyticsPlugin(this));
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>

```kotlin
Amplify.addPlugin(AWSCognitoAuthPlugin())
Amplify.addPlugin(AWSPinpointAnalyticsPlugin(this))
```

Your class will look like this:

```kotlin
class MyAmplifyApp : Application()  catch (error: AmplifyException) 
    }
}
```

</Block>

```java
RxAmplify.addPlugin(new AWSCognitoAuthPlugin());
RxAmplify.addPlugin(new AWSPinpointAnalyticsPlugin(this));
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>
</BlockSwitcher>
