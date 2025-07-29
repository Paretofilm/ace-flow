---
title: Documentation
source: fragments/lib-v1/graphqlapi/android/authz/30_multi.mdx
---

# Documentation

When you have configured multiple APIs, you can specify the name of the API as a parameter as the target for an operation:

```java
Amplify.API.mutate(
    "[FRIENDLY-NAME-API-WITH-API-KEY]",
    request,
    response -> Log.i("MyAmplifyApp", "Mutation successful"),
    error -> Log.e("MyAmplifyApp", "Failed to mutate model.", error)
);
```

</Block>

```kotlin
Amplify.API.mutate(
    "[FRIENDLY-NAME-API-WITH-API-KEY]",
    request,
    ,
    
)
```

</Block>

```kotlin
try  catch (error: ApiException) 
```

</Block>
</BlockSwitcher>
