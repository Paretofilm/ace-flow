---
title: Documentation
source: fragments/lib-v1/auth/android/getting_started/30_initAuth.mdx
---

# Documentation

Add the Auth plugin before calling `Amplify.configure`. Update [the code you added](/gen1/[platform]/prev/start/project-setup/create-application/#n4-initialize-amplify-in-the-application) in **Prerequisites**: 

```java
// Add this line, to include the Auth plugin.
Amplify.addPlugin(new AWSCognitoAuthPlugin());
Amplify.configure(getApplicationContext());
```

</Block>

```kotlin
// Add this line, to include the Auth plugin.
Amplify.addPlugin(AWSCognitoAuthPlugin())
Amplify.configure(applicationContext)
```

</Block>

```kotlin
// Add this line, to include the Auth plugin.
Amplify.addPlugin(AWSCognitoAuthPlugin())
Amplify.configure(applicationContext)
```

</Block>

```java
// Add this line, to include the Auth plugin.
RxAmplify.addPlugin(new AWSCognitoAuthPlugin());
RxAmplify.configure(getApplicationContext());
```

</Block>
</BlockSwitcher>
