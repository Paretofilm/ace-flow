---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib/restapi/android/getting-started/40_postTodo.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

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


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/restapi/android/getting-started/40_postTodo.mdx`