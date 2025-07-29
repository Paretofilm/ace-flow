---
title: Automated Setup: Create new REST API
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib-v1/restapi/js/getting-started.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Automated Setup: Create new REST API

The API category provides a solution for making HTTP requests to REST and GraphQL endpoints. For building GraphQL APIs please visit the [GraphQL Getting Started](/gen1/[platform]/prev/build-a-backend/graphqlapi/set-up-graphql-api/) section of our documentation.

The REST API category can be used for creating signed requests against Amazon API Gateway when the API Gateway Authorization is set to `AWS_IAM`.

> Ensure you have [installed and configured the Amplify CLI and library](/gen1/[platform]/tools/cli/start/set-up-cli/).

## Automated Setup: Create new REST API

Run the following command in your project's root folder:

```bash
amplify add api
```

Select `REST` as the service type.

```console
? Please select from one of the below mentioned services
  GraphQL
❯ REST
```

The CLI will prompt several options to create your resources. With the provided options you can create:

- REST endpoints that triggers Lambda functions
- REST endpoints which enables CRUD operations on an Amazon DynamoDB table

During setup you can use existing Lambda functions and DynamoDB tables or create new ones by following the CLI prompts. After your resources have been created update your backend with the `push` command:

```bash
amplify push
```

A configuration file called `aws-exports.js` will be copied to your configured source directory, for example `./src`.

### Configure your application

```javascript

Amplify.configure(awsconfig);
```

## Manual Setup: Reference existing REST API

For manual configuration you need to provide your AWS Resource configuration and optionally configure authentication.

```javascript

Amplify.configure(,
  API: ,
      
    ]
  }
});
```

### AWS Regional Endpoints

You can utilize regional endpoints by passing in the _service_ and _region_ information to the configuration. See [AWS Regions and Endpoints](https://docs.aws.amazon.com/general/latest/gr/rande.html). The example below defines a [Lambda invocation](https://docs.aws.amazon.com/lambda/latest/dg/API_Invoke.html) in the `us-east-1` region:

```javascript
API: 
  ];
}
```

> **Note**: 

The above example **IS NOT A RECOMMENDED ARCHITECTURE** and we highly recommend you leverage AWS AppSync or API Gateway as the endpoint to invoke your Lambda functions.

 > **Note**: 

**Configuring Amazon Cognito Regional Endpoints:** To call regional service endpoints, your Amazon Cognito role needs to be configured with appropriate access for the related service. See [AWS Cognito Documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/iam-roles.html) for more details.


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/restapi/js/getting-started.mdx`