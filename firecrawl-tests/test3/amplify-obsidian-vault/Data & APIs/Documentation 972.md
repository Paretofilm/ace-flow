---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/data-access/update-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

```java
QueryOptions queryOptions = null;
try  catch (AmplifyException e) 

if (queryOptions != null) 
        },
        failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
    );
}
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class.java, Where.identifier(Post::class.java, "123"),
    ,
                
            )
        }
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class, Where.identifier(Post::class.java, "123"))
    .catch 
    .map 
    .onEach 
    .catch 
    .collect 
```

</Block>

```java
QueryOptions queryOptions = null;
try  catch (AmplifyException e) 

if (queryOptions != null) 
```

</Block>
</BlockSwitcher>

> **Note**: 

Models in DataStore are *immutable*. Instead of directly modifying the fields on a Model, you must use the `.copyOfBuilder()` method to create a new representation of the model.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/android/data-access/update-snippet.mdx`