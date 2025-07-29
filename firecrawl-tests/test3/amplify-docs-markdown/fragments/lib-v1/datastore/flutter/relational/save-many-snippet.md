---
title: My First Post
source: fragments/lib-v1/datastore/flutter/relational/save-many-snippet.mdx
---

# My First Post

Add the model above to the `schema.graphql` file located by default at `amplify/backend//` and regenerate the models again with the following command:

```console
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
