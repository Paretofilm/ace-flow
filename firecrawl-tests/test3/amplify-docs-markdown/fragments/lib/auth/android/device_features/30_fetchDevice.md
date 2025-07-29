---
title: Documentation
source: fragments/lib/auth/android/device_features/30_fetchDevice.mdx
---

# Documentation

```java
Amplify.Auth.fetchDevices(
    devices -> 
    },
    error -> Log.e("AuthQuickStart", "Fetch devices failed with error: " + error.toString()));
```

</Block>

```kotlin
Amplify.Auth.fetchDevices(
    
    },
    
)
```

</Block>

```kotlin
try 
} catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.fetchDevices()
    .subscribe(
        device -> Log.i("AuthQuickStart", "Device: " + device);
        error -> Log.e("AuthQuickStart", "Fetch devices failed with error: " + error.toString())
    );
```

</Block>
</BlockSwitcher>
