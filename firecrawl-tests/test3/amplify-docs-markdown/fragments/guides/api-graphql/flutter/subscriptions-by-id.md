---
title: Documentation
source: fragments/guides/api-graphql/flutter/subscriptions-by-id.mdx
---

# Documentation

```dart
Future<void> subscribeByPostId(String postId) async 
      }
    ''';
  final Stream> operation = Amplify.API.subscribe(
    GraphQLRequest(
      document: graphQLDocument, 
      variables: ,
    ),
    onEstablished: () => print('Subscription established'),
  );

  try ');
    }
  } on Exception catch (e) 
}
```

</Block>

Take for example the following GraphQL schema:

```graphql
type Post @model @auth(rules: [])

type Comment @model @auth(rules: [])
```

You can subscribe to comments from a specific post with the following:

```dart
Future<void> subscribeByPostId(String postId) async ');
    }
  } on Exception catch (e) 
}
```

</Block>

</BlockSwitcher>
