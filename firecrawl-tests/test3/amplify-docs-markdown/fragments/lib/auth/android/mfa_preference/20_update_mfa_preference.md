---
title: Documentation
source: fragments/lib/auth/android/mfa_preference/20_update_mfa_preference.mdx
---

# Documentation

```java
if (Amplify.Auth.getPlugin("awsCognitoAuthPlugin") instanceof AWSCognitoAuthPlugin) 
```

</Block>

```kotlin
val cognitoAuthPlugin = Amplify.Auth.getPlugin("awsCognitoAuthPlugin") as? AWSCognitoAuthPlugin
cognitoAuthPlugin?.updateMFAPreference(
    MFAPreference.DISABLED, // SMS Preference
    MFAPreference.PREFERRED, // TOTP Preference
    ,
    
)
```

</Block>

</BlockSwitcher>
