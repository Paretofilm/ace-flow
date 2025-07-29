---
title: List and get your data
source: pages/build-a-backend/data/query-data/index.mdx
---

# List and get your data

}

You can read application data using the Amplify Data client. In this guide, we will review the difference between reading data and getting data, how to filter query results to get just the data you need, and how to paginate results to make your data more manageable. We will also show you how to cancel these requests when needed.

Before you begin, you will need:

- An [application connected to the API](/[platform]/build-a-backend/data/connect-to-API/)
- Data already created to view

## List and get your data

Queries are used to read data through the API and include the `list` and `get` operations. Amplify Data automatically creates `list` and `get` queries for any `a.model()` type in your schema. The `list` query retrieves multiple items, such as Todo items, without needing to specific an identifier for a particular record. This is best suited for getting an overview or summary of items, or for enhancing the `list` operation to filter the items by specific criteria. When you want to query a single entry by an identifier, you would use `get` to retrieve a specific Todo item.

> **Note**: 

**Note:** The cost structure of your underlying data source can impact the cost to run some queries. For example, the `list` operation uses Amazon DynamoDB "scan operations," which can use more read request units than the `get` operation. You will want to review the associated costs for these operations for your data source. In our example, we are using DynamoDB. You can learn more about how DynamoDB costs are calculated by visiting [Amazon DynamoDB pricing](https://aws.amazon.com/dynamodb/pricing/).

You can list items by first generating the Data client with your backend Data schema. Then you can list items of your desired model:

```ts

const client = generateClient();

// list items
const  = await client.models.Todo.list();

// get a specific item
const  = await client.models.Todo.get();
```

Each API request uses an authorization mode. If you get unauthorized errors, you may need to update your authorization mode. To override the default authorization mode defined in your **amplify/data/resource.ts** file, pass an `authMode` property to the request or the client. The following examples show how you can mutate data with a custom authorization mode:

```ts

const client = generateClient();

const  = await client.models.Todo.list();
```

</Accordion>

## Filter list queries

As your data grows, you will need to paginate your list queries. Fortunately, this is already built in to Amplify Data.

```ts

const client = generateClient();

const  = await client.models.Todo.list(
  }
});
```

### Compound filters

You can combine filters with `and`, `or`, and `not` Boolean logic. Observe that `filter` is recursive in respect to those fields. So if, for example, you wanted to filter for `priority` values of 1 _or_ 2, you would do this:

```ts

const client = generateClient();

const  = await client.models.Todo.list(
      },
      
      }
    ]
  }
});
```

Note that querying for `priority` of 1 and 2 would return no results, because this is Boolean logic instead of natural language.

## Paginate list queries

To paginate your list query results, make a subsequent list query request with the `nextToken` and `limit` input variable set. The `limit` variable limits how many results are returned. The response will include a `nextToken` you can use to request the next page of data. A `nextToken` is a very long string that represents the cursor to the starting item of the next query made with these filters.

```ts

const client = generateClient();

const  = await client.models.Todo.list();
```

If you're building a React application, you can use the `usePagination` hook in Amplify UI to help with managing the pagination user experience.

```js

  const handleNextPage = async () =>  = await client.models.Todo.list();

      if (!nextToken) 

      setPageTokens([...pageTokens, nextToken]);
    }

    setCurrentPageIndex(currentPageIndex + 1);
  };

  return (
     setCurrentPageIndex(currentPageIndex - 1)}
      onChange=
    />
  );
};
```

</InlineFilter>

> **Note**: 

**Limitations:**

- There is no API to get a total page count at this time. Note that scanning all items is a [potentially expensive operation](https://github.com/aws-amplify/amplify-js/issues/2901).
- You [cannot query by `page` number](https://github.com/aws-amplify/amplify-cli/issues/5086); you have to query by `nextToken`.

## Fetch only the data you need with custom selection set

A business domain model may contain many models with numerous fields. However, apps typically only need subsets of the data or fields to meet the requirements of different components or screens. It is necessary to have a mechanism to retrieve subsets of models and their relationships. This mechanism would help optimize data usage for screens and components by only transferring needed data. Having this capability would improve the app's data efficiency, latency, and the end user's perceived performance.

A **custom selection set** allows consumers to specify, on a per-call basis, the fields the consumer wants to retrieve; this is possible for all operations that return data (CRUDL + `observeQuery`). The desired fields are specified in a strongly typed way (discoverable through IntelliSense) with a "dot notation".

```ts
// same way for all CRUDL: .create, .get, .update, .delete, .list, .observeQuery
const  = await client.models.Blog.get(
  ,
  
);
```

## TypeScript type helpers for Amplify Data

When using TypeScript, you frequently need to specify data model types for type generics. 

For instance, with React's `useState`, you provide a type in TypeScript to ensure type-safety in your component code using the state. Use the `Schema["MODEL_NAME"]["type"]` pattern to get TypeScript types for the shapes of data models returned from the backend API.

```ts

type Post = Schema['Post']['type'];

const [posts, setPosts] = useState([]);
```

</InlineFilter>

```ts

type Post = Schema['Post']['type'];
```

</InlineFilter>

You can combine the `Schema["MODEL_NAME"]["type"]` type with the `SelectionSet` helper type to describe the return type of API requests using the `selectionSet` parameter:

```ts

const selectionSet = ['content', 'blog.author.*', 'comments.*'] as const;
type PostWithComments = SelectionSet;

// ...
const [posts, setPosts] = useState([]);

const fetchPosts = async () =>  = await client.models.Post.list();
  setPosts(postsWithComments);
}
```

</InlineFilter>

```ts
<script setup lang="ts">

const client = generateClient();

const selectionSet = ['content', 'blog.author.*', 'comments.*'] as const;

type PostWithComments = SelectionSet<
  Schema['Post']['type'], 
  typeof selectionSet
>;

const posts = ref([]);

const fetchPosts = async (): Promise<void> =>  = await client.models.Post.list();
  posts.value = postsWithComments;
};

onMounted(() => );
</script>

<template v-for="post in posts" :key="post.id">
  <li>}</li>
</template>
```
</InlineFilter>

```ts

const client = generateClient();

const selectionSet = ['content', 'blog.author.*', 'comments.*'] as const;

type PostWithComments = SelectionSet<
  Schema['Post']['type'],
  typeof selectionSet
>;

@Component()

  constructor() 

  ngOnInit(): void 

  async fetchPosts(): Promise<void>  = await client.models.Post.list();
    this.posts = postsWithComments;
  }
}
```
</InlineFilter>

## Cancel read requests

You can cancel any query API request by calling `.cancel` on the query request promise that's returned by `.list(...)` or `.get(...)`.

```javascript
const promise = client.models.Todo.list();
//  ^ Note: we're not awaiting the request, we're returning the promise

try  catch (error) 
}
...

// To cancel the above request
client.cancel(promise, "my message for cancellation");
```

You need to ensure that the promise returned from `.list()` or `.get()` has not been modified. Typically, async functions wrap the promise being returned into another promise. For example, the following will **not** work:

```javascript
async function makeAPICall() 
const promise = makeAPICall();

// The following will NOT cancel the request.
client.cancel(promise, 'my error message');
```

## Conclusion

Congratulations! You have finished the **Read application data** guide. In this guide, you learned how to read your data through `get` and `list` queries.

### Next steps

Our recommended next steps include subscribing to real-time events to look for mutations in your data and continuing to build out and customize your information architecture for your data. Some resources that will help with this work include:

- [Subscribe to real-time events](/[platform]/build-a-backend/data/subscribe-data/)
- [Customize your auth rules](/[platform]/build-a-backend/data/customize-authz/)
- [Customize your data model](/[platform]/build-a-backend/data/data-modeling/)
- [Add custom business logic](/[platform]/build-a-backend/data/custom-business-logic/)

</InlineFilter>

## Query by Id

Now that you were able to make a mutation, take the `Id` that was printed out and use it in your query to retrieve data.

```swift
func getTodo() async 
            print("Successfully retrieved todo: \(todo)")
        case .failure(let error):
            print("Got failed result with \(error.errorDescription)")
        }
    } catch let error as APIError  catch 
}
```

</Block>

```swift
func getTodo() -> AnyCancellable 
    .sink 
    }
    receiveValue: 
            print("Successfully retrieved todo: \(todo)")
        case .failure(let error):
            print("Got failed result with \(error.errorDescription)")
        }
    }
    return sink
}
```

</Block>

</BlockSwitcher>

## List Query

You can get the list of items using `.list` with optional parameters `limit` and `where` to specify the page size and condition. By default, the page size is 1000.

```swift
func listTodos() async 
    } catch let error as APIError  catch 
}
```

</Block>

```swift
func listTodos() -> AnyCancellable 
    .sink 
    }
    receiveValue: 
    }
    return sink
}
```

</Block>

</BlockSwitcher>

### List subsequent pages of items

If you are using SwiftUI and have SwiftUI imported in the same code file, you will need to import the class `Amplify.List` to resolve name collision with `SwiftUI.List`:

```swift
import SwiftUI
import Amplify
import class Amplify.List
```

For large data sets, you'll need to paginate through the results. After receiving the first page of results, you can check if there is a subsequent page and obtain the next page.

```swift
var todos: [Todo] = []
var currentPage: List?

func listFirstPage() async 
    } catch let error as APIError  catch 
}

func listNextPage() async  catch 
    }
}
```

## List all pages

If you want to get all pages, retrieve the subsequent page when you have successfully retrieved the first or next page.

1. Update the above method `listFirstPage()` to `listAllPages()`
2. Call `listNextPageRecursively()` in the success block of the query in `listAllPages()`
2. Update the `listNextPage()` to `listNextPageRecursively()`
3. Call `listNextPageRecursively()` in the success block of the query in `listNextPageRecursively()`

The completed changes should look like this:

```swift
var todos: [Todo] = []
var currentPage: List?

func listAllPages() async 
    } catch let error as APIError  catch 
}

func listNextPageRecursively() async  catch 
    }
}
```

</InlineFilter>

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
    ));
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

</InlineFilter>

## Query item

Now that you were able to make a mutation, take the `id` from the created `Todo` instance and use it to retrieve data.

```dart
Future queryItem(Todo queriedTodo) async ');
    }
    return todo;
  } on ApiException catch (e) 
}
```

## List items

You can get the list of items in `Amplify.API.query`:

```dart
Future> queryListItems() async ');
      return const [];
    }
    return todos;
  } on ApiException catch (e) 
}
```

### List subsequent pages of items

For large data sets, you'll need to paginate through the results. After receiving the first page of results, you can check if there is a subsequent page and obtain the next page.

```dart
const limit = 100;

Future> queryPaginatedListItems() async  else 
}
```

## Query Predicates

Models also support the use of query predicates for comparison. These are accessible from the Model's attributes, for example `Blog["attribute"]["operator"]`.

Supported operators:
- `eq` - equal
- `ne` - not equal
- `gt` - greater than
- `ge` - greater than or equal
- `lt` - less than
- `le` - less than or equal
- `beginsWith` - Matches models where the given field begins with the provided value.
- `between` - Matches models where the given field is between the provided start and end values.
- `contains` - Matches models where the given field contains the provided value.

### Basic Equality Operator

Query for equality on a model's attribute.

```dart
const blogTitle = 'Test Blog 1';
final queryPredicate = Blog.NAME.eq(blogTitle);

final request = ModelQueries.list(
  Blog.classType,
  where: queryPredicate,
);
final response = await Amplify.API.query(request: request).response;
final blogFromResponse = response.data?.items.first;
```

### Fetch by Parent ID

Get all Posts by parent ID

```dart
final blogId = blog.id;

final request = ModelQueries.list(
  Post.classType,
  where: Post.BLOG.eq(blogId),
);
final response = await Amplify.API.query(request: request).response;
final data = response.data?.items ?? [];
```

### Less than

Return Posts with a rating less than 5.

```dart
const rating = 5;

final request = ModelQueries.list(
  Post.classType,
  where: Post.RATING.lt(rating),
);
final response = await Amplify.API.query(request: request).response;

final data = response.data?.items ?? [];
```

</InlineFilter>
