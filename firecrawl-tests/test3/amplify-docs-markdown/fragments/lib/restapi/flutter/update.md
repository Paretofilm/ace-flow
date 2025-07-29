---
title: PUT requests
source: fragments/lib/restapi/flutter/update.mdx
---

# PUT requests

## PUT requests

To update an item via the API endpoint:

```dart
Future<void> updateTodo() async ),
    );
    final response = await restOperation.response;
    print('PUT call succeeded');
    print(response.decodeBody());
  } on ApiException catch (e) 
}
```
