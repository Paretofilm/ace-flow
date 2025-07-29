---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/js/relational/query-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

You can query related models in three ways: 

- Option 1: use the `toArray()` function to lazy load related comments

```ts
const post = await DataStore.query(Post, "YOUR_POST_ID")
if (post) 
```

</Block>

```js
const post = await DataStore.query(Post, "YOUR_POST_ID");
const comments = await post.comments.toArray();
```

</Block>
</BlockSwitcher>

- Option 2: use async iterators to lazy load related comments

```ts
const post = await DataStore.query(Post, "YOUR_POST_ID");
if (post) ;
}
```

</Block>

```js
const post = await DataStore.query(Post, "YOUR_POST_ID");
for await (const comment of post.comments) ;
```

</Block>
</BlockSwitcher>

- Option 3: use nested query predicates with the `Comment` model

```js
const comments = await DataStore.query(Comment, c => c.post.id.eq('YOUR_POST_ID'));
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/js/relational/query-snippet.mdx`