---
title: Create
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/js/relational/query-many-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Create

### Create

In order to save a many-to-many relationship, create both model instance first and then save them to a new join model instance.

```js
const post = await DataStore.save(
  new Post()
);

const user = await DataStore.save(
  new User()
);

const postEditor = await DataStore.save(
  new PostEditor()
);
```

Here we've first created a new `Post` instance and a new `User` instance. Then, saved those instances to a new instance of our join model `PostEditor`.

### Query

To query many-to-many relationships, use a nested predicate to filter the target model by the source model's id:

```js
const editors = await DataStore.query(User, (u) => u.posts.post.id.eq(post.id));
```

### Delete

Deleting the join model instance will not delete any source model instances.

```js
await DataStore.delete(toBeDeletedPostEditor);
```

Both the `Post` and the `User` instances will not be deleted. Only the join model instances containing the link between a `Post` and a `User`.

Deleting a source model instance will also delete the join model instances containing the source model instance.

```js
await DataStore.delete(toBeDeletedUser);
```

The `toBeDeletedUser` User instance and all `PostEditor` instances where `user` is linked to `toBeDeletedUser` will be deleted.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/js/relational/query-many-snippet.mdx`