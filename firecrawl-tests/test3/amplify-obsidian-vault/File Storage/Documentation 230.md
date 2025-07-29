---
title: Documentation
topics: ['File Storage', 'Getting Started']
primary_topic: File Storage
source: fragments/lib-v1/storage/android/getting-started/30_initStorage.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage, getting-started]
---


## 🧭 Navigation
**Topics**: [[File Storage/]] • [[Getting Started/]]
**Primary**: [[File Storage/]]

---


# Documentation

To initialize the Amplify Auth and Storage categories you call `Amplify.addPlugin()` method for each category. To complete initialization call `Amplify.configure()`.

Add the following code to your `onCreate()` method in your application class:

```java
Amplify.addPlugin(new AWSCognitoAuthPlugin());
Amplify.addPlugin(new AWSS3StoragePlugin());
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
Amplify.addPlugin(AWSS3StoragePlugin())
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
RxAmplify.addPlugin(new AWSS3StoragePlugin());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>
</BlockSwitcher>

Note that because the storage category requires auth, you will need to either configure [guest access](/gen1/[platform]/prev/build-a-backend/auth/enable-guest-access/) or [sign in a user](/gen1/[platform]/prev/build-a-backend/auth/enable-sign-in/) before using features in the storage category.


---

## 📚 Related Topics
- [[File Storage/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/storage/android/getting-started/30_initStorage.mdx`