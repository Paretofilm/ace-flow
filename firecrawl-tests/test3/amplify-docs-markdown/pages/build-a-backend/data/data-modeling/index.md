---
title: Data modeling capabilities
source: pages/build-a-backend/data/data-modeling/index.mdx
---

# Data modeling capabilities

## Data modeling capabilities

Every data model is defined as part of a data schema (`a.schema()`). You can enhance your data model with various fields, customize their identifiers, apply authorization rules, or model relationships. Every data model (`a.model()`) automatically provides create, read, update, and delete API operations as well as real-time subscription events. Below is a quick tour of the many functionalities you can add to your data model:

```ts

const schema = a
  .schema(),
        // fields can be enums
        engagementStage: a.enum(["PROSPECT", "INTERESTED", "PURCHASED"]),
        collectionId: a.id(),
        collection: a.belongsTo("Collection", "collectionId")
        // Use custom identifiers. By default, it uses an `id: a.id()` field
      })
      .identifier(["customerId"]),
    Collection: a
      .model()
      .secondaryIndexes((index) => [index("representativeId")]),
  })
  .authorization((allow) => [allow.publicApiKey()]);

## Gen 1 schema support 

If you are coming from Gen 1, you can continue to use the GraphQL Schema Definition Language (SDL) for defining your schema. However, we strongly recommend you use the TypeScript-first schema builder experience in your project as it provides type safety and is the recommended way of working with Amplify going forward.

> **Note**: 

**Note:** Some features available in Gen 1 GraphQL SDL are not available in Gen 2. See the [feature matrix](/[platform]/start/migrate-to-gen2/#gen-1-vs-gen-2-feature-matrix) for features supported in Gen 2.

```ts title="amplify/data/resource.ts"

const schema = /* GraphQL */`
  type Todo @model @auth(rules: []) 
`;
