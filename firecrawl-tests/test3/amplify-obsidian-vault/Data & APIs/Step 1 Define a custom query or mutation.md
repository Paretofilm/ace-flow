---
title: Step 1 - Define a custom query or mutation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/data/custom-business-logic/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Step 1 - Define a custom query or mutation

The `a.model()` data model provides a solid foundation for querying, mutating, and fetching data. However, you may need additional customizations to meet specific requirements around custom API requests, response formatting, and/or fetching from external data sources.

In the following sections, we walk through the three steps to create a custom query or mutation:

1. Define a custom query or mutation
2. Configure custom business logic handler code
3. Invoke the custom query or mutation

## Step 1 - Define a custom query or mutation

| Type | When to choose |
| --- | --- |
| Query | When the request only needs to read data and will not modify any backend data |
| Mutation | When the request will modify backend data |

For every custom query or mutation, you need to set a return type and, optionally, arguments. Use `a.query()` or `a.mutation()` to define your custom query or mutation in your **amplify/data/resource.ts** file:

```ts

const schema = a.schema(),

  // 2. Define your query with the return type and, optionally, arguments
  echo: a
    .query()
    // arguments that this query accepts
    .arguments()
    // return type of the query
    .returns(a.ref('EchoResponse'))
    // only allow signed-in users to call this API
    .authorization(allow => [allow.authenticated()])
});

</Block>

```ts

const schema = a.schema(),

  // 2. Define your mutation with the return type and, optionally, arguments
  likePost: a
    .mutation()
    // arguments that this query accepts
    .arguments()
    // return type of the query
    .returns(a.ref('Post'))
    // only allow signed-in users to call this API
    .authorization(allow => [allow.authenticated()])
});

</Block>

</BlockSwitcher>

## Step 2 - Configure custom business logic handler code

After your query or mutation is defined, you need to author your custom business logic. You can either define it in a [function](/[platform]/build-a-backend/functions/) or using a [custom resolver powered by AppSync JavaScript resolver](https://docs.aws.amazon.com/appsync/latest/devguide/tutorials-js.html).

In your `amplify/data/echo-handler/` folder, create a `handler.ts` file. You can import a utility type for your function handler via the `Schema` type from your backend resource. This gives you type-safe handler parameters and return values.

```ts title="amplify/data/echo-handler/handler.ts"

In your `amplify/data/resource.ts` file, define the function using `defineFunction` and then reference the function with your query or mutation using `a.handler.function()` as a handler.

```ts title="amplify/data/resource.ts"
import  from '@aws-amplify/backend';

// 2. define a function
const echoHandler = defineFunction()

const schema = a.schema(),

  echo: a
    .query()
    .arguments()
    .returns(a.ref('EchoResponse'))
    .authorization(allow => [allow.publicApiKey()])
    // 3. set the function has the handler
    .handler(a.handler.function(echoHandler))
});

If you want to use an existing Lambda function, you can reference it by its name: `a.handler.function('name-of-existing-lambda-fn')`. Note that Amplify will not update this external Lambda function or its dependencies.

</Block>

Custom resolvers work on a "request/response" basis. You choose a data source, map your request to the data source's input parameters, and then map the data source's response back to the query/mutation's return type. Custom resolvers provide the benefit of no cold starts, less infrastructure to manage, and no additional charge for Lambda function invocations. Review [Choosing between custom resolver and function](https://docs.aws.amazon.com/appsync/latest/devguide/resolver-reference-overview-js.html#choosing-data-source).

In your `amplify/data/resource.ts` file, define a custom handler using `a.handler.custom`.

```ts title="amplify/data/resource.ts"
import  from '@aws-amplify/backend';

const schema = a.schema().authorization(allow => [
    allow.owner(),
    allow.authenticated().to(['read'])
  ]),

  likePost: a
    .mutation()
    .arguments()
    .returns(a.ref('Post'))
    .authorization(allow => [allow.authenticated()])
    .handler(a.handler.custom())
});

```ts title="amplify/data/increment-like.js"

By default, you'll be able to access any existing database tables (powered by Amazon DynamoDB) using `a.ref('MODEL_NAME')`. But you can also reference any other external data source from within your AWS account, by adding them to your backend definition.

The supported data sources are:
- Amazon DynamoDB
- AWS Lambda
- Amazon RDS databases with Data API
- Amazon EventBridge
- OpenSearch
- HTTP endpoints

You can add these additional data sources via our `amplify/backend.ts` file:

```ts title="amplify/backend.ts"

const externalDataSourcesStack = backend.createStack("MyExternalDataSources")

const externalTable = dynamoDb.Table.fromTableName(externalDataSourcesStack, "MyTable", "MyExternalTable")

backend.data.addDynamoDbDataSource(
  // highlight-next-line
  "ExternalTableDataSource",
  externalTable)
```

In your schema you can then reference these additional data sources based on their name:

```ts title="amplify/data/resource.ts"
import  from '@aws-amplify/backend';

const schema = a.schema().authorization(allow => [
    allow.owner(),
    allow.authenticated().to(['read'])
  ]),

  likePost: a
    .mutation()
    .arguments()
    .returns(a.ref('Post'))
    .authorization(allow => [allow.authenticated()])
    .handler(a.handler.custom())
});

</Block>
</BlockSwitcher>

> **Note**: 

All handlers must be of the same type. For example, you can't mix and match `a.handler.function` with `a.handler.custom` within a single `.handler()` modifier.

## Step 3 - Invoke the custom query or mutation

From your generated Data client, you can find all your custom queries and mutations under the `client.queries.` and `client.mutations.` APIs respectively.

```ts
const  = await client.queries.echo();
```

</Block>

```ts
const  = await client.mutations.likePost();
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
struct EchoResponse: Codable 
}

let document = """
    query EchoQuery($content: String!) 
    }
    """

let result = try await Amplify.API.query(request: GraphQLRequest(
    document: document,
    variables: [
        "content": "hello world!!!"
    ],
    responseType: EchoResponse.self
))
switch result 
```

</InlineFilter>

```kt
data class EchoDetails(
    val content: String,
    val executionDuration: Float
)

data class EchoResponse(
    val echo: EchoDetails
)

val document = """
    query EchoQuery($content: String!) content) 
    }
""".trimIndent()
val echoQuery = SimpleGraphQLRequest(
    document,
    mapOf("content" to "hello world!!!"),
    String::class.java,
    GsonVariablesSerializer())

Amplify.API.query(
    echoQuery,
    ")
    },
    
)
```

</InlineFilter>

First define a class that matches your response shape:

```dart
class EchoResponse );

  factory EchoResponse.fromJson(Map json) 
}

class Echo );

  factory Echo.fromJson(Map json) 
}
```

Next, make the request and map the response to the classes defined above:

```dart
// highlight-next-line
import 'dart:convert';

// highlight-start
const graphQLDocument = '''
  query Echo(\$content: String!) 
  }
''';

final echoRequest = GraphQLRequest(
  document: graphQLDocument,
  variables: ,
);

final response =
    await Amplify.API.query(request: echoRequest).response;
safePrint(response);

Map jsonMap = json.decode(response.data!);
EchoResponse echoResponse = EchoResponse.fromJson(jsonMap);
safePrint(echoResponse.echo.content);
// highlight-end
```

</InlineFilter>
## Supported Argument Types in Custom Operations

Custom operations can accept different types of arguments. Understanding these options helps define flexible and well-structured APIs.

### Defining Arguments in Custom Operations

When defining a custom operation, you can specify arguments using different types:

- **Scalar Fields**: Basic types such as `string`, `integer`, `float`, etc
- **Custom Types**: Define inline `customType`
- **Reference Types**: Use `a.ref()` to reference enums and custom types

```ts title="amplify/data/resource.ts"
const schema = a.schema(),
    })
    .returns(a.string())
    .authorization(allow => [allow.authenticated()])
});
```

## Async function handlers

Async function handlers allow you to execute long-running operations asynchronously, improving the responsiveness of your API. This is particularly useful for tasks that don't require an immediate response, such as batch processing, putting messages in a queue, and initiating a generative AI model inference.

### Usage

To define an async function handler, use the `.async()` method when defining your handler:

```ts title="amplify/data/resource.ts"
const signUpForNewsletter = defineFunction();

const schema = a.schema()
    .handler(a.handler.function(signUpForNewsletter).async())
    .authorization((allow) => allow.guest()),
})
```

### Key Characteristics

1. **Single Return Type**: Async handlers return a static type `EventInvocationResponse` and don't support specifying a return type. The `.returns()` method is not available for operations using async handlers.

2. **Fire and Forget**: The client is informed whether the invocation was successfully queued, but doesn't receive data from the Lambda function execution.

3. **Pipeline Support**: Async handlers can be used in function pipelines. If the final handler is an async function, the return type of the query or mutation is `EventInvocationResponse`.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/data/custom-business-logic/index.mdx`