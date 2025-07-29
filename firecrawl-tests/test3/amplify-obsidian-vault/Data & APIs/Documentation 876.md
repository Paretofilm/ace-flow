---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/js/data-access/update-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

```ts
async function updatePost(id, newTitle) )
    );
  }
}
```

</Block>

```js
async function updatePost(id, newTitle) )
  );
}
```

</Block>
</BlockSwitcher>

> **Note**: 

Models in DataStore are *immutable*. To update a record you must use the `copyOf` function to apply updates to the item's fields rather than mutating the instance directly.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/js/data-access/update-snippet.mdx`