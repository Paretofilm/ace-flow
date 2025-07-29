---
title: Documentation
topics: ['Data & APIs', 'Getting Started']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/getting-started/60_initDataStore.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, getting-started]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Getting Started/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

To initialize the Amplify DataStore, use the `Amplify.addPlugin()` method to add the AWS DataStore Plugin. Next, finish configuring Amplify by calling `Amplify.configure()`.

Add the following code to your `onCreate()` method in your application class:

```java
import android.util.Log;
import com.amplifyframework.AmplifyException;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.datastore.AWSDataStorePlugin;
```

```java
Amplify.addPlugin(new AWSDataStorePlugin());
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
import com.amplifyframework.core.Amplify
import com.amplifyframework.datastore.AWSDataStorePlugin
```

```kotlin
Amplify.addPlugin(AWSDataStorePlugin())
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
import com.amplifyframework.datastore.AWSDataStorePlugin;
import com.amplifyframework.rx.RxAmplify;
```

```java
RxAmplify.addPlugin(new AWSDataStorePlugin());
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
- [[Data & APIs/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/datastore/android/getting-started/60_initDataStore.mdx`