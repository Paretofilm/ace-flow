---
title: My Book
source: fragments/lib-v1/datastore/js/advanced-workflows/custom-primary-key/query-snippet.mdx
---

# My Book

In addition to querying by the model type (or `Predicates.ALL`), a record with a custom primary key can be queried several ways.

With the value of the primary key:
```js
const book = await DataStore.query(Book, '12345');
```

With a predicate:

```js
const books = await DataStore.query(Book, b =>
    t.isbn.eq('12345')
);
```

</Block>

```js
const books = await DataStore.query(Book, b => b.and(
    b => [
        b.isbn.eq('12345'),
        b.title.eq('My Book')
    ])
);
```

</Block>
</BlockSwitcher>

With an object literal:

```js
const book = await DataStore.query(Book, );
```

</Block>

```js
// Both keys are required for composite keys
const book = await DataStore.query(Book, );
```

</Block>
</BlockSwitcher>
