---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/graphqlapi/android/advanced-workflows/20_custom.mdx
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
private GraphQLRequest getTodoRequest(String id) "
    + "}";
    return new SimpleGraphQLRequest<>(
            document,
            Collections.singletonMap("id", id),
            Todo.class,
            new GsonVariablesSerializer());
}
```

</Block>

```kotlin
private fun getTodoRequest(id: String): GraphQLRequest "
          + "}")
    return SimpleGraphQLRequest(
            document,
            mapOf("id" to id),
            Todo::class.java,
            GsonVariablesSerializer())
}
```

</Block>
</BlockSwitcher>

Then, query for the Todo by a todo id

```java
Amplify.API.query(getTodoRequest("[TODO_ID]"),
    response -> Log.d("MyAmplifyApp", "response" + response),
    error -> Log.e("MyAmplifyApp", "error" + error)
);
```

</Block>

```kotlin
Amplify.API.query(getTodoRequest("[TODO_ID]"),
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
Original: `fragments/lib/graphqlapi/android/advanced-workflows/20_custom.mdx`