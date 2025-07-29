---
title: Documentation
source: fragments/lib/predictions/android/getting-started/40_init.mdx
---

# Documentation

To initialize the Amplify Predictions and Authentication categories you call `Amplify.addPlugin()` method for each category. To complete initialization call `Amplify.configure()`.

Add the following code to your `onCreate()` method in your application class:

```java
import android.util.Log;
import com.amplifyframework.AmplifyException;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.predictions.aws.AWSPredictionsPlugin;
```

```java
Amplify.addPlugin(new AWSCognitoAuthPlugin());
Amplify.addPlugin(new AWSPredictionsPlugin());
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
import com.amplifyframework.predictions.aws.AWSPredictionsPlugin
```

```kotlin
Amplify.addPlugin(AWSCognitoAuthPlugin())
Amplify.addPlugin(AWSPredictionsPlugin())
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
import com.amplifyframework.predictions.aws.AWSPredictionsPlugin;
import com.amplifyframework.rx.RxAmplify;
```

```java
RxAmplify.addPlugin(new AWSCognitoAuthPlugin());
RxAmplify.addPlugin(new AWSPredictionsPlugin());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
  }
}
```

</Block>
</BlockSwitcher>

Note that because the predictions category requires auth, you will need to either configure [guest access](/gen1/[platform]/build-a-backend/auth/enable-guest-access/) or [sign in a user](/gen1/[platform]/build-a-backend/auth/enable-sign-in/) before using features in the predictions category.
