---
title: Configure the Amplify Library
source: pages/build-a-backend/data/connect-to-API/index.mdx
---

# Configure the Amplify Library

}

In this guide, you will connect your application code to the backend API using the Amplify Libraries. Before you begin, you will need:

- Your cloud sandbox with an Amplify Data resource up and running (`npx ampx sandbox`)
- A frontend application set up with the Amplify library installed
- [npm installed](https://docs.npmjs.com/getting-started)

## Configure the Amplify Library

When you deploy you're iterating on your backend (`npx ampx sandbox`), an **amplify_outputs.json** file is generated for you. This file contains your API's endpoint information and auth configurations. Add the following code to your app's entrypoint to initialize and configure the Amplify client library:

```ts

Amplify.configure(outputs);
```

## Generate the Amplify Data client

Once the Amplify library is configured, you can generate a "Data client" for your frontend code to make fully-typed API requests to your backend.

> **Note**: 
**If you're using Amplify with a JavaScript-only frontend (i.e. not TypeScript), then you can still get a fully-typed data fetching experience by annotating the generated client with a JSDoc comment**. Select the **JavaScript** in the code block below to see how.

To generate a new Data client, use the following code:

```ts

const client = generateClient();

// Now you should be able to make CRUDL operations with the
// Data client
const fetchTodos = async () =>  = await client.models.Todo.list();
};
```
</Block>

```js

/**
 * @type 
 */
const client = generateClient();

// Now you should be able to make CRUDL operations with the
// Data client
const fetchTodos = async () =>  = await client.models.Todo.list();
};
```
</Block>

</BlockSwitcher>

</InlineFilter>

## Configure authorization mode

The **Authorization Mode** determines how a request should be authorized with the backend. By default, Amplify Data uses the "userPool" authorization which uses the signed-in user credentials to sign an API request. If you use a `allow.publicApiKey()` authorization rules for your data models, you need to use "apiKey" as an authorization mode. Review [Customize your auth rules](/[platform]/build-a-backend/data/customize-authz) to learn more about which authorization modes to choose for which type of request. A **Default Authorization Mode** is provided as part of the **amplify_outputs.json** that is generated upon a successful deployment.

You can generate different Data clients with different authorization modes or pass in the authorization mode at the request time.

### Set authorization mode on a per-client basis

To apply the same authorization mode on all requests from a Data client, specify the `authMode` parameter on the `generateClient` function.

Use "API Key" as your authorization mode when if defined the `allow.publicApiKey()` authorization rule.

```ts

const client = generateClient();
```

</Block>

Use "userPool" as your authorization mode when using Amazon Cognito user pool-based authorization rules, such as `allow.authenticated()`, `allow.owner()`, `allow.ownerDefinedIn()`, `allow.groupsDefinedIn()`, or `allow.groups()`.

```ts

const client = generateClient();
```

</Block>

Use "identityPool" as your authorization mode when using Amazon Cognito identity pool-based authorization rules, such as `allow.guest()` or `allow.authenticated('identityPool')`.

```ts

const client = generateClient();
```

</Block>

Use "oidc" as your authorization mode when connecting applications to a trusted identity provider. Private, owner, and group authorization can be configured with an OIDC authorization mode. Review the [OIDC authorization docs](/[platform]/build-a-backend/data/customize-authz/using-oidc-authorization-provider) to learn more.

```ts

const client = generateClient();
```

</Block>

Use "Lambda Authorizer" when using your own custom authorization logic via `allow.custom()`. Review [Customize your auth rules](/[platform]/build-a-backend/data/customize-authz) to learn more about how to implement your authorization protocol.

```ts

const getAuthToken = () => 'myAuthToken';
const lambdaAuthToken = getAuthToken();

const client = generateClient();
```

</Block>
</BlockSwitcher>

</InlineFilter>

### Set authorization mode on the request-level

You can also specify the authorization mode on each individual API request. This is useful if your application typically only uses one authorization mode with a small number of exceptions.

```ts
const  = await client.models.Todo.list();
```

</InlineFilter>

```kt
val query = ModelQuery.list(Todo::class.java) as AppSyncGraphQLRequest>
val apiKeyQuery = query
    .newBuilder()
    .authorizationType(AuthorizationType.API_KEY)
    .build>()
Amplify.API.query(apiKeyQuery,
    ")},
    )
```

</InlineFilter>

```swift
let result = try await Amplify.API.query(
    request: .list(
        Todo.self,
        authMode: .apiKey))
```

</InlineFilter>

```dart
final apiKeyRequest = ModelQueries.list(Todo.classType, authorizationMode: APIAuthorizationType.apiKey);
final apiKeyResponse = await Amplify.API.query(request: apiKeyRequest).response;
```

</InlineFilter>

</Block>

```ts
const  = await client.models.Todo.list();
```

</InlineFilter>

```kt
val query = ModelQuery.list(Todo::class.java) as AppSyncGraphQLRequest>
val userPoolQuery = query
  .newBuilder()
  .authorizationType(AuthorizationType.AMAZON_COGNITO_USER_POOLS)
  .build>()
Amplify.API.query(userPoolQuery,
  ")},
  )
```

</InlineFilter>

```swift
let result = try await Amplify.API.query(
    request: .list(
        Todo.self,
        authMode: .amazonCognitoUserPools))
```

</InlineFilter>

```dart
final userPoolRequest = ModelQueries.list(Todo.classType, authorizationMode: APIAuthorizationType.userPools);
final userPoolResponse = await Amplify.API.query(request: userPoolRequest).response;
```

</InlineFilter>

</Block>

```ts
const  = await client.models.Todo.list();
```

</InlineFilter>

```kt
val query = ModelQuery.list(Todo::class.java) as AppSyncGraphQLRequest>
val iamQuery = query
    .newBuilder()
    .authorizationType(AuthorizationType.AWS_IAM)
    .build>()
Amplify.API.query(iamQuery,
    ")},
    )
```

</InlineFilter>

```swift
let result = try await Amplify.API.query(
    request: .list(
        Todo.self,
        authMode: .awsIAM))
```

</InlineFilter>

```dart
final iamRequest = ModelQueries.list(Todo.classType, authorizationMode: APIAuthorizationType.iam);
final iamResponse = await Amplify.API.query(request: iamRequest).response;
```

</InlineFilter>

</Block>

```ts
const  = await client.models.Todo.list();
```

</InlineFilter>

```kt
val query = ModelQuery.list(Todo::class.java) as AppSyncGraphQLRequest>
val oidcQuery = query
    .newBuilder()
    .authorizationType(AuthorizationType.OPENID_CONNECT)
    .build>()
Amplify.API.query(oidcQuery,
    ")},
    )
```

</InlineFilter>

```swift
let result = try await Amplify.API.query(
    request: .list(
        Todo.self,
        authMode: .openIDConnect))
```

</InlineFilter>

```dart
final oidcRequest = ModelQueries.list(Todo.classType, authorizationMode: APIAuthorizationType.oidc);
final oidcResponse = await Amplify.API.query(request: oidcRequest).response;
```

</InlineFilter>

</Block>

You can implement your own custom API authorization logic using a AWS Lambda function. Review [Customize your auth rules](/[platform]/build-a-backend/data/customize-authz) to learn more about how to implement your authorization protocol with AWS Lambda.

```ts
const getAuthToken = () => 'myAuthToken';
const lambdaAuthToken = getAuthToken();

const  = await client.models.Todo.list();
```

</InlineFilter>

```kt
val query = ModelQuery.list(Todo::class.java) as AppSyncGraphQLRequest>
val lambdaQuery = query
    .newBuilder()
    .authorizationType(AuthorizationType.AWS_LAMBDA)
    .build>()
Amplify.API.query(lambdaQuery,
    ")},
    )
```

</InlineFilter>

```swift
let result = try await Amplify.API.query(
    request: .list(
        Todo.self,
        authMode: .function))
```

</InlineFilter>

```dart
final lambdaRequest = ModelQueries.list(Todo.classType, authorizationMode: APIAuthorizationType.function);
final lambdaResponse = await Amplify.API.query(request: lambdaRequest).response;
```

</InlineFilter>

</Block>
</BlockSwitcher>

## Set custom request headers

When working with the Amplify Data endpoint, you may need to set request headers for authorization purposes or to pass additional metadata from your frontend to the backend API.

This is done by specifying a `headers` parameter into the configuration. You can define headers either on a per Data client-level or on a per-request level:

```ts

const client = generateClient(,
});
```

</Block>

```ts
// same way for all CRUDL: .create, .get, .update, .delete, .list, .observeQuery
const  = await client.models.Blog.get(
  ,
  ,
  }
);
```

</Block>

</BlockSwitcher>

The examples above show you how to set static headers but you can also programmatically set headers by specifying an async function for `headers`:

```ts

const client = generateClient(,
      uri: '/',
      queryString: ""
    }
    */
    return ;
  },
});
```

</Block>

```ts
// same way for all CRUDL: .create, .get, .update, .delete, .list, .observeQuery
const res = await client.models.Blog.get(
  ,
  ,
        uri: '/',
        queryString: ""
      }
      */
      return ;
    },
  }
);
```

</Block>

</BlockSwitcher>

</InlineFilter>

To specify your own headers, use the `configureClient()` configuration option on the `AWSApiPlugin`'s builder. Specify the name of one of the configured APIs in your **amplify_outputs.json**. Apply customizations to the underlying OkHttp instance by providing a lambda expression as below.

```java
AWSApiPlugin plugin = AWSApiPlugin.builder()
    .configureClient(AWSApiPlugin.DEFAULT_GRAPHQL_API, okHttpBuilder -> );
    })
    .build();
Amplify.addPlugin(plugin);
```

</Block>

```kotlin
val plugin = AWSApiPlugin.builder()
    .configureClient(AWSApiPlugin.DEFAULT_GRAPHQL_API) 
    }
    .build()
Amplify.addPlugin(plugin)
```

</Block>

```kotlin
val plugin = AWSApiPlugin.builder()
    .configureClient(AWSApiPlugin.DEFAULT_GRAPHQL_API) 
    }
    .build()
Amplify.addPlugin(plugin)
```

</Block>

```java
AWSApiPlugin plugin = AWSApiPlugin.builder()
    .configureClient(AWSApiPlugin.DEFAULT_GRAPHQL_API, okHttpBuilder -> );
    })
    .build();
RxAmplify.addPlugin(plugin);
```

</Block>
</BlockSwitcher>

</InlineFilter>

To include custom headers in your outgoing requests, add an `URLRequestInterceptor` to the `AWSAPIPlugin`.

```swift
import Amplify
import AWSAPIPlugin

struct CustomInterceptor: URLRequestInterceptor 
}
let apiPlugin = AWSAPIPlugin(modelRegistration: AmplifyModels())
try apiPlugin.add(interceptor: CustomInterceptor(), for: AWSAPIPlugin.defaultGraphQLAPI)
try Amplify.add(plugin: apiPlugin)
try Amplify.configure(with: .amplifyOutputs)

```

</InlineFilter>

The simplest option for GraphQL requests is to use the `headers` property of a `GraphQLRequest`.

```dart
Future<void> queryWithCustomHeaders() async ,
    ),
  );
  final response = await operation.response;
  final data = response.data;
  safePrint('data: $data');
}
```

Another option is to use the `baseHttpClient` property of the API plugin which can customize headers or otherwise alter HTTP functionality for all HTTP calls.

```dart
// First create a custom HTTP client implementation to extend HTTP functionality.
class MyHttpRequestInterceptor extends AWSBaseHttpClient 
}

// Then you can pass an instance of this client to `baseHttpClient` when you configure Amplify.
await Amplify.addPlugins([
  AmplifyAPI(baseHttpClient: MyHttpRequestInterceptor()),
]);
```

</InlineFilter>

## Use an additional Data endpoint

If you have an additional Data endpoint that you're managing with a different Amplify project or through other means, this section will show you how to utilize that endpoint in your frontend code.

This is done by specifying the `endpoint` parameter on the `generateClient` function.

```ts

const client = generateClient();
```

If this Data endpoint shares its authorization configuration (for example, both endpoints share the same user pool and/or identity pool as the one in your `amplify_outputs.json` file), you can specify the `authMode` parameter on `generateClient`.

```ts
const client = generateClient();
```

If the endpoint uses API Key authorization, you can pass in the `apiKey` parameter on `generateClient`.

```ts
const client = generateClient();
``` 

If the endpoint uses a different authorization configuration, you can manually pass in the authorization header using the instructions in the [Set custom request headers](#set-custom-request-headers) section.

</InlineFilter>
