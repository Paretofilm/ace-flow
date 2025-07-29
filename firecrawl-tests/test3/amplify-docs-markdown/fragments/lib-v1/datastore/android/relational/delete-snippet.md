---
title: Documentation
source: fragments/lib-v1/datastore/android/relational/delete-snippet.mdx
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
