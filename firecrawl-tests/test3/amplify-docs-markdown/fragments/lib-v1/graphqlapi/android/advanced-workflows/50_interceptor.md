---
title: Documentation
source: fragments/lib-v1/graphqlapi/android/advanced-workflows/50_interceptor.mdx
---

# Documentation

To specify your own headers, use the `configureClient()` configuration option on the `AWSApiPlugin`'s builder. Specify the name of one of the configured APIs in your **amplifyconfiguration.json**. Apply customizations to the underlying OkHttp instance by providing a lambda expression as below.

```java
AWSApiPlugin plugin = AWSApiPlugin.builder()
    .configureClient("yourApiName", okHttpBuilder -> );
    })
    .build();
Amplify.addPlugin(plugin);
```

</Block>

```kotlin
val plugin = AWSApiPlugin.builder()
    .configureClient("yourApiName") 
    }
    .build()
Amplify.addPlugin(plugin)
```

</Block>

```kotlin
val plugin = AWSApiPlugin.builder()
    .configureClient("yourApiName") 
    }
    .build()
Amplify.addPlugin(plugin)
```

</Block>

```java
AWSApiPlugin plugin = AWSApiPlugin.builder()
    .configureClient("yourApiName", okHttpBuilder -> );
    })
    .build();
RxAmplify.addPlugin(plugin);
```

</Block>
</BlockSwitcher>
