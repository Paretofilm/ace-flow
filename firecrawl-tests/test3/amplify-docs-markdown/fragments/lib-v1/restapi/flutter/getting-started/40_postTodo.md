---
title: Documentation
source: fragments/lib-v1/restapi/flutter/getting-started/40_postTodo.mdx
---

# Documentation

```dart
Future<void> postTodo() async ),
    );
    final response = await restOperation.response;
    print('POST call succeeded');
    print(response.decodeBody());
  } on ApiException catch (e) 
}
```
