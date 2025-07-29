---
title: Re-use existing AppSync GraphQL API
source: fragments/lib-v1/graphqlapi/js/existing-resources.mdx
---

# Re-use existing AppSync GraphQL API

## Re-use existing AppSync GraphQL API

As an alternative to automatic configuration, you can manually enter AWS AppSync configuration parameters in your app. Authentication type options are `API_KEY`, `AWS_IAM`, `AMAZON_COGNITO_USER_POOLS` and `OPENID_CONNECT`.

### Using API_KEY

```javascript
const myAppConfig = ;

Amplify.configure(myAppConfig);
```

### Using AWS_IAM

```javascript
const myAppConfig = ;

Amplify.configure(myAppConfig);
```

### Using AMAZON_COGNITO_USER_POOLS

```javascript
const myAppConfig = ;

Amplify.configure(myAppConfig);
```

### Using OPENID_CONNECT

```javascript
const myAppConfig = ;

Amplify.configure(myAppConfig);
```

### Using with an AppSync custom domain name

[Custom domain names](https://docs.aws.amazon.com/appsync/latest/devguide/custom-domain-name.html) can have any format, but must end with `/graphql` (see https://graphql.org/learn/serving-over-http/#uris-routes).

```javascript
const myAppConfig = ;

Amplify.configure(myAppConfig);
```

## Using a non-AppSync GraphQL Server

To access a non-AppSync GraphQL API with your app, you need to configure the endpoint URL in your app’s configuration. Add the following line to your setup:

```js

// Considering you have an existing aws-exports.js configuration file
Amplify.configure(awsconfig);

// Configure a custom GraphQL endpoint
Amplify.configure(
});
```

### Set Custom Request Headers for non-AppSync GraphQL APIs

When working with a non-AppSync GraphQL endpoint, you may need to set request headers for authorization purposes. This is done by passing a `graphql_headers` function into the configuration:

```js
Amplify.configure()
  }
});
```

### Signing Request with IAM

AWS Amplify provides the ability to sign requests automatically with AWS Identity Access Management (IAM) for GraphQL requests that are processed through AWS API Gateway. Add the `graphql_endpoint_iam_region` parameter to your GraphQL configuration statement to enable signing:

```js
Amplify.configure(
});
```
