---
title: DELETE requests
source: fragments/lib-v1/restapi/android/delete.mdx
---

# DELETE requests

## DELETE requests

```java
RestOptions options = RestOptions.builder()
    .addPath("/todo/1")
    .build();

Amplify.API.delete(options,
    response -> Log.i("MyAmplifyApp", "DELETE succeeded: " + response),
    error -> Log.e("MyAmplifyApp", "DELETE failed.", error)
);
```

</Block>

```kotlin
val options = RestOptions.builder()
    .addPath("/todo/1")
    .build()

Amplify.API.delete(options,
    ,
    
)
```

</Block>

```kotlin
val request = RestOptions.builder()
    .addPath("/todo/1")
    .build()
try  catch (error: ApiException) 
```

</Block>

```java
RestOptions options = RestOptions.builder()
    .addPath("/todo/1")
    .build();

RxAmplify.API.delete(options)
    .subscribe(
        response -> Log.i("MyAmplifyApp", "DELETE succeeded: " + response),
        error -> Log.e("MyAmplifyApp", "DELETE failed.", error)
    );
```

</Block>
</BlockSwitcher>
