---
title: Example
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/js/conflict.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Example

DataStore has a few optional configurations, such as the ability to specify a custom handler for error messages that take place in any part of the system. You can also specify a custom conflict handler that runs if a mutation is rejected by AWS AppSync during one of the conflict resolution strategies.

Finally you can configure the number of records to sync as an upper bound on items (per-Model) which will be stored locally on the device, as well as a custom interval in minutes which is an override of the default 24 hour "base query" which runs as part of the Delta Sync process.

### Example

The code below illustrates a conflict resolution handler for the `Post` model that retries a mutation with the same title, but the most recent remote data for all other fields. The conflict resolution handler discards conflicts for all other models (by returning the `DISCARD` symbol imported from `aws-amplify/datastore`).

```ts
import  from "aws-amplify/datastore";

DataStore.configure();
  },
  conflictHandler: async (data) => );
      
      return newModel;
    }

    return DISCARD;
  },
  maxRecordsToSync: 30000,
  fullSyncInterval: 60, // minutes
});
```

</Block>

```js

DataStore.configure();
  },
  conflictHandler: async (data) => );
      return newModel;
    }

    return DISCARD;
  },
  maxRecordsToSync: 30000,
  fullSyncInterval: 60, // minutes
});
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/js/conflict.mdx`