---
title: Documentation
source: fragments/lib-v1/datastore/android/relational/updated-schema.mdx
---

# Documentation

For the examples below with DataStore let's add a new model to the [sample schema](/gen1/[platform]/prev/build-a-backend/more-features/datastore/set-up-datastore/#sample-schema):

```graphql
enum PostStatus 

type Post @model 

# New model
type Comment @model 
```

Generate the models for the updated schema using the [Amplify CLI](/gen1/[platform]/prev/build-a-backend/more-features/datastore/set-up-datastore/#code-generation-amplify-cli).
