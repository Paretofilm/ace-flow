---
title: Using Amplify GraphQL client
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/graphqlapi/js/authz.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Using Amplify GraphQL client

## Using Amplify GraphQL client

Each AppSync API is set with a __default__ authorization mode.

AWS AppSync also supports [multiple authorization modes on a single API](https://docs.aws.amazon.com/appsync/latest/devguide/security.html#using-additional-authorization-modes) enabling you to add additional authorization modes.

In order to use this feature with the Amplify GraphQL Client the `API.graphql()` function accepts an optional parameter called `authMode`, its value will be one of the supported auth modes:

- `API_KEY`
- `AWS_IAM`
- `OPENID_CONNECT`
- `AMAZON_COGNITO_USER_POOLS`
- `AWS_LAMBDA`

<br />

This is an example of using `AWS_IAM` as an authorization mode:

```ts

// Creating a post is restricted to IAM 
const createdTodo = await API.graphql>(,
  authMode: GRAPHQL_AUTH_MODE.AWS_IAM
});
```

</Block>

```js

// Creating a post is restricted to IAM 
const createdTodo = await API.graphql(,
  authMode: GRAPHQL_AUTH_MODE.AWS_IAM
});
```

</Block>
</BlockSwitcher>

Previous examples uses `graphqlOperation` function. That function only creates an object with two attributes `query` and `variables`. In order to use `authMode` you need to pass this object as is mentioned on the previous example.

> **Note**: 

When using __AWS_IAM__ for public API access, unauthenticated logins must be enabled. To enable unauthenticated logins, run `amplify update auth` from the command line and choose __Walkthrough all the auth configurations__.

### AWS Lambda

You can implement your own custom API authorization logic using an AWS Lambda function. To add a Lambda as an authorization mode for your AppSync API, go to the **Settings** section of the **AppSync console**.

If you are using a Lambda function as an authorization mode with your AppSync API, you will need to pass an authentication token with each API request and will need to manage token refresh in your application.

The following example assumes `AWS_LAMBDA` is configured as the default authentication type for your API:

```ts
// ...

const getAuthToken = () => 'myAuthToken';
const lambdaAuthToken = getAuthToken();

const createdTodo = await API.graphql>(,
  authToken: lambdaAuthToken
});
```

</Block>

```js
// ...

const getAuthToken = () => 'myAuthToken';
const lambdaAuthToken = getAuthToken();

const createdTodo = await API.graphql(,
  authToken: lambdaAuthToken
});
```

</Block>
</BlockSwitcher>

If you have a different default authentication type and would like to use `AWS_LAMBDA` with a request:

```ts
// ...

const getAuthToken = () => 'myAuthToken';
const lambdaAuthToken = getAuthToken();

const createdTodo = await API.graphql>(,
  authMode: GRAPHQL_AUTH_MODE.AWS_LAMBDA,
  authToken: lambdaAuthToken
});
```

</Block>

```js
// ...

const getAuthToken = () => 'myAuthToken';
const lambdaAuthToken = getAuthToken();

const createdTodo = await API.graphql(,
  authMode: GRAPHQL_AUTH_MODE.AWS_LAMBDA,
  authToken: lambdaAuthToken
});
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/js/authz.mdx`