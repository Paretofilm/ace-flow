---
title: Documentation
topics: ['Authentication', 'Getting Started']
primary_topic: Authentication
source: fragments/lib/auth/android/getting_started/30_initAuth.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication, getting-started]
---


## 🧭 Navigation
**Topics**: [[Authentication/]] • [[Getting Started/]]
**Primary**: [[Authentication/]]

---


# Documentation

Add the Auth plugin before calling `Amplify.configure`. Update [the code you added](/gen1/[platform]/start/project-setup/create-application/#n4-initialize-amplify-in-the-application) in **Prerequisites**: 

```java
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
```

```java
// Add this line, to include the Auth plugin.
Amplify.addPlugin(new AWSCognitoAuthPlugin());
Amplify.configure(getApplicationContext());
```

</Block>

```kotlin
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.core.Amplify
```

```kotlin
// Add this line, to include the Auth plugin.
Amplify.addPlugin(AWSCognitoAuthPlugin())
Amplify.configure(applicationContext)
```

</Block>

```kotlin
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.kotlin.core.Amplify
```

```kotlin
// Add this line, to include the Auth plugin.
Amplify.addPlugin(AWSCognitoAuthPlugin())
Amplify.configure(applicationContext)
```

</Block>

```java
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.rx.RxAmplify;
```

```java
// Add this line, to include the Auth plugin.
RxAmplify.addPlugin(new AWSCognitoAuthPlugin());
RxAmplify.configure(getApplicationContext());
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/auth/android/getting_started/30_initAuth.mdx`