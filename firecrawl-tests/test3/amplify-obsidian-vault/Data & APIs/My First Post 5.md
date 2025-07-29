---
title: My First Post
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/flutter/relational/save-many-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# My First Post

Add the model above to the `schema.graphql` file located by default at `amplify/backend//` and regenerate the models again with the following command:

```bash
amplify codegen models
```

Once it is regenerated, save your posts with many-to-many mode like the following:

```dart
import 'package:amplify_flutter/amplify_flutter.dart';

import 'models/ModelProvider.dart';

Future<void> savePostAndEditor() async  on DataStoreException catch (e) ');
  }
}
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/flutter/relational/save-many-snippet.mdx`