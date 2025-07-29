---
title: Documentation
source: fragments/lib/geo/android/getting_started/40_init_geo.mdx
---

# Documentation

To initialize Amplify Geo, use the `Amplify.addPlugin()` method to add the AWS Location Geo plugin. Next, finish configuring Amplify by calling `Amplify.configure()`.

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

```java
RxAmplify.addPlugin(new AWSCognitoAuthPlugin());
RxAmplify.addPlugin(new AWSLocationGeoPlugin());
RxAmplify.configure(getApplicationContext());
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
