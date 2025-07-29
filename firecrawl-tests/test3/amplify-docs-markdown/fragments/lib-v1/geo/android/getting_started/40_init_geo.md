---
title: Documentation
source: fragments/lib-v1/geo/android/getting_started/40_init_geo.mdx
---

# Documentation

To initialize Amplify Geo, use the `Amplify.addPlugin()` method to add the AWS Location Geo plugin. Next, finish configuring Amplify by calling `Amplify.configure()`.

Add the following import statements at the top of your application class that you created during the project setup:

```java
import android.util.Log;
import com.amplifyframework.AmplifyException;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.geo.location.AWSLocationGeoPlugin;
```

</Block>

```kotlin
import android.util.Log
import com.amplifyframework.AmplifyException
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.core.Amplify
import com.amplifyframework.geo.location.AWSLocationGeoPlugin
```

</Block>
</BlockSwitcher>

Add the following code to your `onCreate()` method in your application class:

```java
Amplify.addPlugin(new AWSCognitoAuthPlugin());
Amplify.addPlugin(new AWSLocationGeoPlugin());
Amplify.configure(getApplicationContext());
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
Amplify.addPlugin(AWSLocationGeoPlugin())
Amplify.configure(applicationContext)
```

Your class will look like this:

```kotlin
class MyAmplifyApp : Application()  catch (error: AmplifyException) 
    }
}
```

</Block>
</BlockSwitcher>

Upon building and running this application you should see the following in your console window:

```console
Initialized Amplify
```
