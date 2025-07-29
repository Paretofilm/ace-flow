---
title: Next steps
source: pages/build-a-backend/functions/set-up-function/index.mdx
---

# Next steps

Amplify Functions are powered by [AWS Lambda](https://aws.amazon.com/lambda/), and allow you to perform a wide variety of customization through self-contained _functions_. Functions can respond to events from other resources, execute some logic in-between events like an authentication flow, or act as standalone jobs. They are used in a variety of settings and use cases:

- Authentication flow customizations (e.g. attribute validations, allowlisting email domains)
- Resolvers for GraphQL APIs
- Handlers for individual REST API routes, or to host an entire API
- Scheduled jobs

To get started, create a new directory and a resource file, `amplify/functions/say-hello/resource.ts`. Then, define the Function with `defineFunction`:

```ts title="amplify/functions/say-hello/resource.ts"

Next, create the corresponding handler file at `amplify/functions/say-hello/handler.ts`. This is where your function code will go.

```ts title="amplify/functions/say-hello/handler.ts"

The handler file _must_ export a function named "handler". This is the entry point to your function. For more information on writing functions, refer to the [AWS documentation for Lambda function handlers using Node.js](https://docs.aws.amazon.com/lambda/latest/dg/nodejs-handler.html).

Lastly, this function needs to be added to your backend.

```ts title="amplify/backend.ts"
// highlight-next-line

defineBackend();
```

Now when you run `npx ampx sandbox` or deploy your app on Amplify, it will include your Function.

To invoke your Function, we recommend adding your [Function as a handler for a custom query with your Amplify Data resource](/[platform]/build-a-backend/data/custom-business-logic/). This will enable you to strongly type Function arguments and the return statement, and use this to author your Function's business logic. To get started, open your `amplify/data/resource.ts` file and specify a new query in your schema:

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .returns(a.string())
    .authorization(allow => [allow.guest()])
    .handler(a.handler.function(sayHello)),
  // highlight-end
})

Now you can use this query from the `Schema` export to strongly type your Function handler:

```ts title="amplify/functions/say-hello/handler.ts"

Finally, use the data client to invoke your Function by calling its associated query.

```ts title="src/main.ts"

Amplify.configure(outputs)

const client = generateClient()

// highlight-start
client.queries.sayHello()
// highlight-end
```

</InlineFilter>

```kt
data class SayHelloDetails(
    val name: String,
)

data class SayHelloResponse(
    val sayHello: SayHelloDetails
)

val document = """
    query SayHelloQuery($name: String!) name) 
    }
""".trimIndent()
val sayHelloQuery = SimpleGraphQLRequest(
    document,
    mapOf("name" to "Amplify"),
    String::class.java,
    GsonVariablesSerializer())

Amplify.API.query(
    sayHelloQuery,
    ")
    },
    
)
```

</InlineFilter>

First define a class that matches your response shape:

```dart
class SayHelloResponse );

  factory SayHelloResponse.fromJson(Map json) 
}

class SayHello );

  factory SayHello.fromJson(Map json) 
}
```

Next, make the request and map the response to the classes defined above:

```dart
// highlight-next-line
import 'dart:convert';

// highlight-start
const graphQLDocument = '''
  query SayHello(\$name: String!) 
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
SayHelloResponse SayHelloResponse = SayHelloResponse.fromJson(jsonMap);
safePrint(SayHelloResponse.sayHello.name);
// highlight-end
```

</InlineFilter>

```swift
struct SayHelloResponse: Codable 
}

let document = """
    query EchoQuery($name: String!) 
    }
    """

let result = try await Amplify.API.query(request: GraphQLRequest(
    document: document,
    variables: [
        "name": "Amplify"
    ],
    responseType: SayHelloResponse.self
))
switch result 
```

</InlineFilter>

## Next steps

Now that you have completed setting up your first Function, you may also want to add some additional features or modify a few settings. We recommend you learn more about:

- [Environment variables and secrets](/[platform]/build-a-backend/functions/environment-variables-and-secrets/)
- [Grant access to other resources](/[platform]/build-a-backend/functions/grant-access-to-other-resources/)
- [Explore example use cases](/[platform]/build-a-backend/functions/examples/)
- [Modifying underlying resources with CDK](/[platform]/build-a-backend/functions/modify-resources-with-cdk/)
