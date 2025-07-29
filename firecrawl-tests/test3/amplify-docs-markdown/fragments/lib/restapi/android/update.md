---
title: PUT requests
source: fragments/lib/restapi/android/update.mdx
---

# PUT requests

## PUT requests

To update an item via the API endpoint:

```java
RestOptions options = RestOptions.builder()
    .addPath("/todo/1")
    .addBody("".getBytes())
    .build();

Amplify.API.put(options,
    response -> Log.i("MyAmplifyApp", "PUT succeeded: " + response),
    error -> Log.e("MyAmplifyApp", "PUT failed.", error)
);
```

</Block>

```kotlin
val request = RestOptions.builder()
    .addPath("/todo/1")
    .addBody("".toByteArray())
    .build()

Amplify.API.put(request,
    ,
    
)
```

</Block>

```kotlin
val request = RestOptions.builder()
    .addPath("/todo/1")
    .addBody(JSONObject()
        .put("name", "Mow the lawn")
        .toString()
        .toByteArray())
    .build()
try  catch (error: ApiException) 
```

</Block>

```java
RestOptions options = RestOptions.builder()
    .addPath("/todo/1")
    .addBody("".getBytes())
    .build();

RxAmplify.API.put(options)
    .subscribe(
          response -> Log.i("MyAmplifyApp", "PUT succeeded: " + response),
          error -> Log.e("MyAmplifyApp", "PUT failed.", error)
    );
```

</Block>
</BlockSwitcher>
