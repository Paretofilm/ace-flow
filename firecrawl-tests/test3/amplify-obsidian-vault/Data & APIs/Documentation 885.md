---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/ios/relational/updated-schema.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

For the examples below with DataStore let's add a new model to the [sample schema](/gen1/[platform]/build-a-backend/more-features/datastore/set-up-datastore/#sample-schema):

```graphql
enum PostStatus 

type Post @model @auth(rules: []) 

# new model
type Comment @model 
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/ios/relational/updated-schema.mdx`