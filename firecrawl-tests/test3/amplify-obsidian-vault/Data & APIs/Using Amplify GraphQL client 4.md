---
title: Using Amplify GraphQL client
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/graphqlapi/js/mutate-data.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Using Amplify GraphQL client

## Using Amplify GraphQL client

### Mutations

In GraphQL, mutations are used to create, update, or delete data. Here are some examples of creating, updating, and deleting items using the Amplify GraphQL client.

#### Creating an item

```ts

const client = generateClient();

const newTodo = await client.graphql(
  }
});
```

You do not have to pass in `createdAt` and `updatedAt` fields, AppSync manages this for you.

#### Updating an item

```ts

const client = generateClient();

const updatedTodo = await client.graphql(
  }
});
```

Notes:

- You do not have to pass in `createdAt` and `updatedAt` fields, AppSync manages this for you.
- If you pass in _extra_ input fields not expected by the AppSync schema, this query will fail. You can see this in the `error` field returned by the query (the query itself does not throw, per GraphQL design).

#### Deleting an item

```ts

const client = generateClient();

const deletedTodo = await client.graphql(
  }
});
```

Only the identifier fields are required for delete mutations.

> **Note**: 
  Join table records must be deleted prior to deleting the associated records.
  For example, for a many-to-many relationship between Posts and Tags, delete
  the PostTags join record prior to deleting a Post or Tag.

### Custom authorization mode

By default, each AppSync API will be set with a default authorization mode when you configure your app. If you would like to override the default authorization mode, you can do so by passing in an `authMode` property.

#### Mutation with custom authorization mode

```ts

const client = generateClient();

const todoDetails: CreateTodoInput = ;

const todo = await client.graphql(
  },
  authMode: 'iam'
});
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/graphqlapi/js/mutate-data.mdx`