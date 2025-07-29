---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/data-access/delete-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

Below, you query for an instance with an `id` of `"123"`, and then delete it, if found:

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

To conditionally delete an instance, pass an instance and a predicate into `Amplify.DataStore.delete()`.
In the example below, posts are deleted only if their `rating` is greater than `4`:

```java
Amplify.DataStore.query(Post.class,
        matches -> 
        },
        failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class.java,
    ,
                
            )
        }
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore.query(Post::class)
    .catch 
    .onEach 
    .catch 
    .collect 
```

</Block>

```java
RxAmplify.DataStore.query(
    Post.class,
    Where.matches(Post.RATING.gt(4)))
    .subscribe(
            post -> RxAmplify.DataStore.delete(post, Where.matches(Post.RATING.gt(4)).getQueryPredicate())
                    .subscribe(
                            () -> Log.i("MyAmplifyApp", "Deleted a post."),
                            failure -> Log.e("MyAmplifyApp", "Delete failed.", failure)
                    ),
            failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/android/data-access/delete-snippet.mdx`