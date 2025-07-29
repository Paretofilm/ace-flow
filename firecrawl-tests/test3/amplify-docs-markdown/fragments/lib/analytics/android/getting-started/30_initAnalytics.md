---
title: Documentation
source: fragments/lib/analytics/android/getting-started/30_initAnalytics.mdx
---

# Documentation

To initialize the Amplify Auth and Analytics categories you call `Amplify.addPlugin()` method for each category. To complete initialization call `Amplify.configure()`.

Add the following code to your `onCreate()` method in your application class:

```java
import android.util.Log;
import com.amplifyframework.AmplifyException;
import com.amplifyframework.analytics.pinpoint.AWSPinpointAnalyticsPlugin;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
```

```java
Amplify.addPlugin(new AWSCognitoAuthPlugin());
Amplify.addPlugin(new AWSPinpointAnalyticsPlugin());
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
import com.amplifyframework.analytics.pinpoint.AWSPinpointAnalyticsPlugin
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.core.Amplify
```    

```kotlin
Amplify.addPlugin(AWSCognitoAuthPlugin())
Amplify.addPlugin(AWSPinpointAnalyticsPlugin())
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
import com.amplifyframework.analytics.pinpoint.AWSPinpointAnalyticsPlugin;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.rx.RxAmplify;
```

```java
RxAmplify.addPlugin(new AWSCognitoAuthPlugin());
RxAmplify.addPlugin(new AWSPinpointAnalyticsPlugin());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>
</BlockSwitcher>
