---
title: Query item
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/graphqlapi/flutter/query-data.mdx
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
- `between` - Matches models where the given field is between the provided start and end values.
- `beginsWith` - Matches models where the given field begins with the provided value.
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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/flutter/query-data.mdx`