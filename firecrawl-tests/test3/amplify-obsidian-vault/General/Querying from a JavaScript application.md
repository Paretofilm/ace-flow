---
title: Querying from a JavaScript application
topics: ['General']
primary_topic: General
source: fragments/guides/api-graphql/js/graphql-pagination.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Querying from a JavaScript application

## Querying from a JavaScript application

The `listTodos` query should have been created for you automatically by the CLI, but for reference purposes it should look something like this:

```js
const listTodos = `
  query listTodos($limit: Int) 
      nextToken
    }
  }
`
```

To pass in a `limit` in a query from a JavaScript application, you can use the following code by setting the limit as a variable:

```js

async function fetchTodos() 
  })
  console.log()
}
```

The data returned from the API request should look like this (with the items array containing however many items have been created):

```graphql
],
      "nextToken": "<token-id>"
    }
  }
}
```

To set the `nextToken` in a query from a JavaScript application, you can use the following code:

```js

async function fetchTodos() 
  })
  console.log()
}
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/guides/api-graphql/js/graphql-pagination.mdx`