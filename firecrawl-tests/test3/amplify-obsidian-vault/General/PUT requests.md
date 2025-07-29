---
title: PUT requests
topics: ['General']
primary_topic: General
source: fragments/lib-v1/restapi/flutter/update.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

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


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/restapi/flutter/update.mdx`