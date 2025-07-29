---
title: Add sort keys to secondary indexes
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/data-modeling/secondary-index/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Add sort keys to secondary indexes

// cspell:ignore ACCOUNTREPRESENTATIVEID

You can optimize your list queries based on "secondary indexes". For example, if you have a **Customer** model, you can query based on the customer's **id** identifier field by default but you can add a secondary index based on the **accountRepresentativeId** to get list customers for a given account representative.

A secondary index consists of a "hash key" and, optionally, a "sort key". Use the "hash key" to perform strict equality and the "sort key" for greater than (gt), greater than or equal to (ge), less than (lt), less than or equal to (le), equals (eq), begins with, and between operations.

```ts title="amplify/data/resource.ts"

The example client query below allows you to query for "Customer" records based on their `accountRepresentativeId`:

```ts title="src/App.tsx"

const client = generateClient();

const  =
  // highlight-start
  await client.models.Customer.listCustomerByAccountRepresentativeId();
  // highlight-end
```

</InlineFilter>

The example client query below creates a custom GraphQL request that allows you to query for "Customer" records based on their `accountRepresentativeId`:

```swift
struct PaginatedList: Decodable 
let operationName = "listCustomer8ByAccountRepresentativeId"
let document = """
query ListCustomer8ByAccountRepresentativeId 
    nextToken
  }
}
"""

let request = GraphQLRequest>(
    document: document,
    responseType: PaginatedList.self,
    decodePath: operationName)

let queriedCustomers = try await Amplify.API.query(
    request: request).get()
```

</InlineFilter>

The example client query below allows you to query for "Customer" records based on their `accountRepresentativeId`:

```dart title="lib/main.dart"
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'models/ModelProvider.dart';

// highlight-start
final request = ModelQueries.list(
  Customer.classType,
  where: Customer.ACCOUNTREPRESENTATIVEID.eq(YOUR_REP_ID),
);
// highlight-end

```

</InlineFilter>

Amplify uses Amazon DynamoDB tables as the default data source for `a.model()`. For key-value databases, it is critical to model your access patterns with "secondary indexes". Use the `.secondaryIndexes()` modifier to configure a secondary index.

**Amazon DynamoDB** is a key-value and document database that delivers single-digit millisecond performance at any scale but making it work for your access patterns requires a bit of forethought. DynamoDB query operations may use at most two attributes to efficiently query data. The first query argument passed to a query (the hash key) must use strict equality and the second attribute (the sort key) may use gt, ge, lt, le, eq, beginsWith, and between. DynamoDB can effectively implement a wide variety of access patterns that are powerful enough for the majority of applications.

</Accordion>

## Add sort keys to secondary indexes

You can define "sort keys" to add a set of flexible filters to your query, such as "greater than" (gt), "greater than or equal to" (ge), "less than" (lt), "less than or equal to" (le), "equals" (eq), "begins with" (beginsWith), and "between" operations.

```ts title="amplify/data/resource.ts"

On the client side, you should find a new `listBy...` query that's named after hash key and sort keys. For example, in this case: `listByAccountRepresentativeIdAndName`. You can supply the filter as part of this new list query:

```ts title="src/App.tsx"
const  =
  // highlight-next-line
  await client.models.Customer.listCustomerByAccountRepresentativeIdAndName(,
  });
```

</InlineFilter>

On the client side, you can create a custom GraphQL request based on the new `listBy...` query that's named after hash key and sort keys. You can supply the filter as part of this new list query:

```swift
struct PaginatedList: Decodable 
let operationName = "listCustomer9ByAccountRepresentativeIdAndName"
let document = """
query ListCustomer8ByAccountRepresentativeId ) 
    nextToken
  }
}
"""
let request = GraphQLRequest>(
    document: document,
    responseType: PaginatedList.self,
    decodePath: operationName)

let queriedCustomers = try await Amplify.API.query(
    request: request).get()
```
</InlineFilter>

The example client query below allows you to query for "Customer" records based on their `name` AND their `accountRepresentativeId`:

```dart title="lib/main.dart"
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'models/ModelProvider.dart';

// highlight-start
final request = ModelQueries.list(
  Customer.classType,
  where: Customer.ACCOUNTREPRESENTATIVEID.eq(YOUR_REP_ID) & Customer.NAME.beginsWith("Rene"),
);
// highlight-end

```

</InlineFilter>

## Customize the query field for secondary indexes

You can also customize the auto-generated query name under `client.models..listBy...` by setting the `queryField()` modifier.

```ts title="amplify/data/resource.ts"
const schema = a.schema()
    .secondaryIndexes((index) => [
      index("accountRepresentativeId")
        // highlight-next-line
        .queryField("listByRep"),
    ])
    .authorization(allow => [allow.owner()]),
});
```

In your client app code, you'll see query updated under the Data client:

```ts title="src/App.tsx"
const  = await client.models.Customer.listByRep()
```

</InlineFilter>

In your client app code, you can use the updated query name.

```swift
struct PaginatedList: Decodable 
let operationName = "listByRep"
let document = """
query ListByRep 
    nextToken
  }
}
"""

let request = GraphQLRequest>(
    document: document,
    responseType: PaginatedList.self,
    decodePath: operationName)

let queriedCustomers = try await Amplify.API.query(
    request: request).get()
```
</InlineFilter>

In your client app code, you can use the updated query name.

```dart title="lib/main.dart"
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'models/ModelProvider.dart';

var accountRepresentativeId = "John";
var operationName = "listByRep";
var document = """
  query ListByRep 
      nextToken
    }
  }
  """;

final request = GraphQLRequest(
  document: document,
  variables: ,
);
```
</InlineFilter>

## Customize the name of secondary indexes

To customize the underlying DynamoDB's index name, you can optionally provide the `name()` modifier.

```ts title="amplify/data/resource.ts"
const schema = a.schema()
    .secondaryIndexes((index) => [
      index("accountRepresentativeId")
        // highlight-next-line
        .name("MyCustomIndexName"),
    ])
    .authorization(allow => [allow.owner()]),
});
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/data-modeling/secondary-index/index.mdx`