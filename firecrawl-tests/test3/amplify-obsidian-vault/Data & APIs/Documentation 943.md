---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/relational/delete-snippet.mdx
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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/android/relational/delete-snippet.mdx`