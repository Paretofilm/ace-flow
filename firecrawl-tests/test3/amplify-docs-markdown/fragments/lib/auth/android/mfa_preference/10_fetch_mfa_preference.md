---
title: Documentation
source: fragments/lib/auth/android/mfa_preference/10_fetch_mfa_preference.mdx
---

# Documentation

```java
if (Amplify.Auth.getPlugin("awsCognitoAuthPlugin") instanceof AWSCognitoAuthPlugin) 
```

</Block>

```kotlin
val cognitoAuthPlugin = Amplify.Auth.getPlugin("awsCognitoAuthPlugin") as? AWSCognitoAuthPlugin
cognitoAuthPlugin?.fetchMFAPreference(
    , preferred: $") },
    
)
```

</Block>
</BlockSwitcher>
