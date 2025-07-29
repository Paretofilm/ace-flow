---
title: Query
topics: ['General']
primary_topic: General
source: fragments/lib-v1/graphqlapi/graphql-from-node.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Query

You can call an AppSync GraphQL API from a Node.js app or a Lambda function. Take a basic `Todo` app as an example:

```graphql
type Todo @model @auth(rules: []) 
```

This API will have operations available for `Query`, `Mutation`, and `Subscription`. Let's take a look at how to perform both a **query** as well as a **mutation** from a Lambda function using Node.js.

First, create a Lambda function with `amplify add function` and make sure to give access to your GraphQL API when prompted by the CLI to grant access to other resources in the project.

```console
amplify add function
? Select which capability you want to add: Lambda function (serverless function)
? Provide an AWS Lambda function name: myfunction
? Choose the runtime that you want to use: NodeJS
? Choose the function template that you want to use: Hello World

Available advanced settings:
- Resource access permissions
- Scheduled recurring invocation
- Lambda layers configuration
- Environment variables configuration
- Secret values configuration

? Do you want to configure advanced settings? Yes
? Do you want to access other resources in this project from your Lambda function? Yes
? Select the categories you want this function to have access to. api
? Select the operations you want to permit on  Query, Mutation, Subscription

You can access the following resource attributes as environment variables from your Lambda function
	API__GRAPHQLAPIENDPOINTOUTPUT
	API__GRAPHQLAPIIDOUTPUT
	API__GRAPHQLAPIKEYOUTPUT
	ENV
	REGION
```

The examples on this page use [`node-fetch`](https://www.npmjs.com/package/node-fetch) to make a HTTP request to your GraphQL API. When the Node.js v18 runtime is released for Lambda this dependency can be removed in favor of [native `fetch`](https://nodejs.org/dist/latest-v18.x/docs/api/globals.html#fetch) To get started, add the `node-fetch` module as a dependency:

```diff
,
  "devDependencies": 
}
```

## Query

Using an API Key for authenticating your requests, you can query the GraphQL API to get a list of all `Todo`s.

```js

const GRAPHQL_ENDPOINT = process.env.API__GRAPHQLAPIENDPOINTOUTPUT;
const GRAPHQL_API_KEY = process.env.API__GRAPHQLAPIKEYOUTPUT;

const query = /* GraphQL */ `
  query LIST_TODOS 
    }
  }
`;

/**
 * @type 
 */

  /** @type  */
  const options = ,
    body: JSON.stringify()
  };

  const request = new Request(GRAPHQL_ENDPOINT, options);

  let statusCode = 200;
  let body;
  let response;

  try  catch (error) 
      ]
    };
  }

  return ;
};
```

## Mutation

In this example you create a mutation showing how to pass in variables as arguments to create a `Todo` record.

```js

const GRAPHQL_ENDPOINT = process.env.API__GRAPHQLAPIENDPOINTOUTPUT;
const GRAPHQL_API_KEY = process.env.API__GRAPHQLAPIKEYOUTPUT;

const query = /* GraphQL */ `
  mutation CREATE_TODO($input: CreateTodoInput!) 
  }
`;

/**
 * @type 
 */

  const variables = 
  };

  /** @type  */
  const options = ,
    body: JSON.stringify()
  };

  const request = new Request(GRAPHQL_ENDPOINT, options);

  let statusCode = 200;
  let body;
  let response;

  try  catch (error) 
      ]
    };
  }

  return ;
};
```

## IAM Authorization

Let's take a look at another example schema that uses `iam` authorization.

```graphql
type Todo @model @auth(rules: []) 
```

The CLI will automatically configure the Lambda execution IAM role to call the GraphQL API. Before writing your Lambda function you will first need to install the appropriate AWS SDK v3 dependencies:

```diff
,
  "devDependencies": 
}
```

Then, the following example will sign the request to call the GraphQL API using IAM authorization.

```js

const  = crypto;
const GRAPHQL_ENDPOINT = process.env.API__GRAPHQLAPIENDPOINTOUTPUT;
const AWS_REGION = process.env.AWS_REGION || 'us-east-1';

const query = /* GraphQL */ `
  query LIST_TODOS 
    }
  }
`;

/**
 * @type 
 */

  const endpoint = new URL(GRAPHQL_ENDPOINT);

  const signer = new SignatureV4();

  const requestToBeSigned = new HttpRequest(,
    hostname: endpoint.host,
    body: JSON.stringify(),
    path: endpoint.pathname
  });

  const signed = await signer.sign(requestToBeSigned);
  const request = new Request(endpoint, signed);

  let statusCode = 200;
  let body;
  let response;

  try  catch (error) 
      ]
    };
  }

  return ;
};
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/graphql-from-node.mdx`