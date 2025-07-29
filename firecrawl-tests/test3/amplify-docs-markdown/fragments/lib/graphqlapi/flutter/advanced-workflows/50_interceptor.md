---
title: Documentation
source: fragments/lib/graphqlapi/flutter/advanced-workflows/50_interceptor.mdx
---

# Documentation

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
  AmplifyAPI(
    options: APIPluginOptions(
      baseHttpClient: MyHttpRequestInterceptor(),
    ),
  ),
]);
```
