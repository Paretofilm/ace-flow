---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/flutter/relational/updated-schema.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

For the examples below with DataStore, let's add a new model to the `schema.graphql` file located by default at `amplify/backend//`:

```graphql
enum PostStatus 

type Post @model 

# New model
type Comment @model 
```

After that, regenerate the models with the following console command:

```bash
amplify codegen models
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/flutter/relational/updated-schema.mdx`