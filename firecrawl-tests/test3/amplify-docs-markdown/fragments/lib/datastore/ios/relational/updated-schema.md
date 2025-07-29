---
title: Documentation
source: fragments/lib/datastore/ios/relational/updated-schema.mdx
---

# Documentation

For the examples below with DataStore let's add a new model to the [sample schema](/gen1/[platform]/build-a-backend/more-features/datastore/set-up-datastore/#sample-schema):

```graphql
enum PostStatus 

type Post @model @auth(rules: []) 

# new model
type Comment @model 
```
