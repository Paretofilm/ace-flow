---
title: Documentation
source: fragments/lib-v1/graphqlapi/android/getting-started/30_initapi.mdx
---

# Documentation

Call `Amplify.addPlugin()` to initialize the Amplify API category followed by `Amplify.configure()`.

Add the following code to your `onCreate()` method in your application class:

```java
Amplify.addPlugin(new AWSApiPlugin());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>

```kotlin
Amplify.addPlugin(AWSApiPlugin())
```

Your class will look like this:

```kotlin
class MyAmplifyApp : Application()  catch (error: AmplifyException) 
    }
}
```

</Block>

```java
RxAmplify.addPlugin(new AWSApiPlugin());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>
</BlockSwitcher>
