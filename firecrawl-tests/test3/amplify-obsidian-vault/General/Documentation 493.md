---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib-v1/graphqlapi/android/advanced-workflows/40_multiple.mdx
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
private GraphQLRequest getPostAndTodo(String postId, String todoId)  "
        + "getTodo(id: $todoId)  "
    + "}";
    Map variables = new HashMap<>();
    variables.put("postId", postId);
    variables.put("todoId", todoId);
    return new SimpleGraphQLRequest<>(
            document,
            variables,
            String.class,
            new GsonVariablesSerializer());
}
```

</Block>

```kotlin
private fun getPostAndTodo(postId: String, todoId: String): GraphQLRequest  "
            + "getTodo(id: \$todoId)  "
        + "}")

    return SimpleGraphQLRequest(
            document,
            mapOf("postId" to postId, "todoId" to todoId),
            String::class.java,
            GsonVariablesSerializer())
}
```
</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/android/advanced-workflows/40_multiple.mdx`