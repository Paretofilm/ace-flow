---
title: Query item
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/graphqlapi/android/query-data.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Query item

## Query item

Now that you were able to make a mutation, take the `Id` that was printed out and use it in your query to retrieve data.

```java
private void getTodo(String id) 
```

</Block>

```kotlin
private fun getTodo(id: String) ") },
        
    );
}
```

</Block>

```kotlin
suspend fun getTodo(id: String)  catch (error: ApiException) 
}
```

</Block>

```java
private void getTodo(String id) 
```

</Block>
</BlockSwitcher>

## List items

You can get the list of items that match a condition that you specify in `Amplify.API.query`:

```java
Amplify.API.query(
    ModelQuery.list(Todo.class, Todo.NAME.contains("first")),
    response -> 
    },
    error -> Log.e("MyAmplifyApp", "Query failure", error)
);
```

</Block>

```kotlin
Amplify.API.query(
    ModelQuery.list(Todo::class.java, Todo.NAME.contains("first")),
    
    },
    
)
```

</Block>

```kotlin
try 
} catch (error: ApiException) 
```

</Block>

```java 
RxAmplify.API.query(ModelQuery.list(Todo.class, Todo.NAME.contains("first"))
    .subscribe(
        response -> 
        },
        error -> Log.e("MyAmplifyApp", "Query failure", error)
    );
```

</Block>
</BlockSwitcher>

> **Note**: This approach will only return up to the first 1,000 items.  To change this limit or make requests for additional results beyond this limit, use *pagination* as discussed below.

## List subsequent pages of items

A list query only returns the first 1,000 items by default, so for large data sets, you'll need to paginate through the results.  After receiving a page of results, you can obtain a `GraphQLRequest` for requesting the next page, if there are more results available.  The page size is configurable as well, as in the example below.

```java
public void queryFirstPage() 

private static void query(GraphQLRequest> request) 
                if (response.getData().hasNextResult()) 
            }
        },
        failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
    );
}
```

</Block>

```kotlin
fun queryFirstPage() 

fun query(request: GraphQLRequest>) 
                if (response.data.hasNextResult()) 
            }
        },
        
    )
}
```

</Block>

```kotlin
suspend fun queryFirstPage() 

suspend fun query(request: GraphQLRequest>) 
        if (response.data.hasNextResult()) 
    } catch (error: ApiException) 
}
```

</Block>

```java
BehaviorSubject>> subject =
        BehaviorSubject.createDefault(ModelQuery.list(Todo.class, ModelPagination.limit(1_000)));
subject.concatMap(request -> RxAmplify.API.query(request).toObservable())
    .doOnNext(response ->  else if (!response.hasData())  else if(response.getData().hasNextResult())  else 
    })
    .concatMapIterable(GraphQLResponse::getData)
    .subscribe(
        todo -> Log.d(TAG, "Todo: " + todo),
        error -> Log.e(TAG, "Error: " + error)
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/android/query-data.mdx`