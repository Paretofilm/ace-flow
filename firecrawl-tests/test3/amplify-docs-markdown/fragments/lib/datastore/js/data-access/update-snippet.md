---
title: Documentation
source: fragments/lib/datastore/js/data-access/update-snippet.mdx
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
