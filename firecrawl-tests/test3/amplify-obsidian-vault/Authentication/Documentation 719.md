---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/android/device_features/30_fetchDevice.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

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


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/android/device_features/30_fetchDevice.mdx`