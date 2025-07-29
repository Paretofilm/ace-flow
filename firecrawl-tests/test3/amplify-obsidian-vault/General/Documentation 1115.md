---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/graphqlapi/android/advanced-workflows/30_nested.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

```java
private GraphQLRequest getPostWithCommentsRequest(String id)  "
            + "} "
        + "} "
    + "}";
    return new SimpleGraphQLRequest<>(
            document,
            Collections.singletonMap("id", id),
            Post.class,
            new GsonVariablesSerializer());
}
```

</Block>

```kotlin
private fun getPostWithCommentsRequest(id: String): GraphQLRequest  "
            + "} "
        + "} "
    + "}")
    return SimpleGraphQLRequest(
            document,
            mapOf("id" to id),
            Post::class.java,
            GsonVariablesSerializer())
}
```

</Block>
</BlockSwitcher>

Then query for the Post:

```java
Amplify.API.query(getPostWithCommentsRequest("[POST_ID]"),
    response -> Log.d("MyAmplifyApp", "response" + response),
    error -> Log.e("MyAmplifyApp", "error" + error)
);
```

</Block>

```kotlin
Amplify.API.query(getPostWithCommentsRequest("[POST_ID]"),
    ,
    
)
```

</Block>

```kotlin
try  catch (error: ApiException) 
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/android/advanced-workflows/30_nested.mdx`