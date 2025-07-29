---
title: Deleting records with custom primary keys
source: fragments/lib/datastore/js/advanced-workflows/custom-primary-key/delete-snippet.mdx
---

# Deleting records with custom primary keys

### Deleting records with custom primary keys

In addition to deleting by the model type (or `Predicates.ALL`), a record with a custom primary key can be deleted the following ways:

With the value of the primary key:
```js
const book = await DataStore.delete(Book, '12345');
```

With a predicate:

```js
const book = await DataStore.delete(Book, b =>
    b.isbn.eq('12345')
);
```

</Block>

```js
const book = await DataStore.delete(Book, b => b.and([
    b.isbn.eq('12345'),
    b.title.eq('My Book')
]));
```

</Block>
</BlockSwitcher>

With an object literal:

```js
const book = await DataStore.delete(Book, );
```

</Block>

```js
const book = await DataStore.delete(Book, );
```

</Block>
</BlockSwitcher>
