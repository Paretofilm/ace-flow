---
title: Updated schema
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/native_common/relational.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Updated schema

DataStore has the capability to handle relationships between Models, such as _has one_, _has many_, _belongs to_. In GraphQL this is done with the `@hasOne`, `@hasMany` and `@index` directives as defined in the [GraphQL Transformer documentation](/gen1/[platform]/build-a-backend/graphqlapi/data-modeling/).

## Updated schema

## Saving relations

In order to save connected models, you will create an instance of the model you wish to connect and pass its ID to `DataStore.save`:

## Querying relations

## Deleting relations

When you delete a parent object in a one-to-many relationship, the children will also be removed from the DataStore and mutations for this deletion will be synced to cloud. For example, the following operation would remove the Post with id _123_ as well as any related comments:

However, in a many-to-many relationship the children are not removed and you must explicitly delete them.

## Many-to-many relationships

For many-to-many relationships, you can use the `@manyToMany` directive and specify a `relationName`. Under the hood, Amplify creates a join table and a one-to-many relationship from both models.

> **Note**: 

Join table records must be deleted prior to deleting the associated records. For example, for a many-to-many relationship between Posts and Tags, delete the PostTags join record prior to deleting a Post or Tag.

```graphql
enum PostStatus 

type Post @model 

type User @model 
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/native_common/relational.mdx`