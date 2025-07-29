---
title: Documentation
source: fragments/lib-v1/restapi/android/getting-started/40_postTodo.mdx
---

# Documentation

```java
RestOptions options = RestOptions.builder()
    .addPath("/todo")
    .addBody("".getBytes())
    .build();

Amplify.API.post(options,
    response -> Log.i("MyAmplifyApp", "POST succeeded: " + response),
    error -> Log.e("MyAmplifyApp", "POST failed.", error)
);
```

</Block>

```kotlin
val options = RestOptions.builder()
    .addPath("/todo")
    .addBody("".toByteArray())
    .build()

Amplify.API.post(options,
    ,
    
)
```

</Block>

```kotlin
val request = RestOptions.builder()
    .addPath("/todo")
    .addBody("".toByteArray())
    .build()
try  catch (error: ApiException) 
```

</Block>

```java
RestOptions options = RestOptions.builder()
    .addPath("/todo")
    .addBody("".getBytes())
    .build();

RxAmplify.API.post(options)
    .subscribe(
        response -> Log.i("MyAmplifyApp", "POST succeeded: " + response),
        error -> Log.e("MyAmplifyApp", "POST failed.", error)
    );
```

</Block>
</BlockSwitcher>
