---
title: Documentation
topics: ['Authentication', 'Getting Started']
primary_topic: Authentication
source: fragments/lib-v1/auth/android/getting_started/40_fetchSession.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication, getting-started]
---


## 🧭 Navigation
**Topics**: [[Authentication/]] • [[Getting Started/]]
**Primary**: [[Authentication/]]

---


# Documentation

For testing purposes, you can run this from your MainActivity's `onCreate` method.

```java
Amplify.Auth.fetchAuthSession(
    result -> Log.i("AmplifyQuickstart", result.toString()),
    error -> Log.e("AmplifyQuickstart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.fetchAuthSession(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

 ```java
RxAmplify.Auth.fetchAuthSession()
    .subscribe(
        result -> Log.i("AmplifyQuickstart", result.toString()),
        error -> Log.e("AmplifyQuickstart", error.toString())
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/auth/android/getting_started/40_fetchSession.mdx`