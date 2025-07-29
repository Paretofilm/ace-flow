---
title: Documentation
topics: ['File Storage', 'Getting Started']
primary_topic: File Storage
source: fragments/lib/storage/android/getting-started/30_initStorage.mdx
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
import android.util.Log;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.storage.s3.AWSS3StoragePlugin;
```

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
import android.util.Log
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.core.Amplify
import com.amplifyframework.storage.s3.AWSS3StoragePlugin
```

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
import android.util.Log;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.rx.RxAmplify;
import com.amplifyframework.storage.s3.AWSS3StoragePlugin;
```

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

Note that because the storage category requires auth, you will need to either configure [guest access](/gen1/[platform]/build-a-backend/auth/enable-guest-access/) or [sign in a user](/gen1/[platform]/build-a-backend/auth/enable-sign-in/) before using features in the storage category.


---

## 📚 Related Topics
- [[File Storage/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/storage/android/getting-started/30_initStorage.mdx`