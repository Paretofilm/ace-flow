---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib-v1/restapi/android/getting-started/30_initapi.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Documentation

To initialize the Amplify Auth and API categories you call `Amplify.addPlugin()` method for each category. To complete initialization call `Amplify.configure()`.

Add the following code to your `onCreate()` method in your application class:

```java
Amplify.addPlugin(new AWSApiPlugin());
Amplify.addPlugin(new AWSCognitoAuthPlugin());
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
Amplify.addPlugin(AWSCognitoAuthPlugin())
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
RxAmplify.addPlugin(new AWSCognitoAuthPlugin());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/restapi/android/getting-started/30_initapi.mdx`