---
title: Auth Modes
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/graphqlapi/native_common/authz/common.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Auth Modes

For client authorization AppSync supports API Keys, Amazon IAM credentials, Amazon Cognito User Pools, and 3rd party OIDC providers. This is inferred from the `amplifyconfiguration.json`/`.dart` file when you call `Amplify.configure()`. You can configure auth modes for an API using the Amplify CLI or manual configuration.

## Auth Modes

### API key

API Key is the easiest way to setup and prototype your application with AWS AppSync. This means it is also prone to abuse since anyone can easily discover the API Key and make requests to your public service. To have authorization checks, use the other auth modes such as Cognito user pool or AWS IAM. API Key will expiry according to the expiry time set when provisioning AWS AppSync and will require extending it or creating a new one if needed. Default API Key expiry time is 7 days.

### Amazon Cognito User Pools

Amazon Cognito User Pools is most commonly used with AWS AppSync when adding authorization check on your API calls. If your application needs to interact with other AWS services besides AWS AppSync, such as Amazon S3, you will need to use AWS IAM credentials with Amazon Cognito Identity Pools. Amplify CLI can automatically configure this for you and will also automatically use the authenticated user from User Pools to federate with the Identity Pools to provide the AWS IAM credentials in the application. [See this for more information about the differences](https://aws.amazon.com/premiumsupport/knowledge-center/cognito-user-pools-identity-pools/). This allows you to have both User Pools' credentials for AWS AppSync and AWS IAM credentials for other AWS resources. You can learn more about Amplify Auth outlined in the [Accessing credentials section](/gen1/[platform]/prev/build-a-backend/auth/accessing-credentials/).

### IAM

Amazon Cognito Identity Pools allows you to use credentials from AWS IAM in your app. AWS IAM helps you securely control access to AWS resources. You use IAM to control who is authenticated (signed in) and authorized (has permissions) to use AWS resources. [Learn more about IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html?icmpid=docs_iam_console) . The Amplify CLI can automatically configure this for you.

### OpenID Connect (OIDC)

If you are using a 3rd party OIDC provider you will need to configure it and manage the details of token refreshes yourself.

### AWS Lambda

You can implement your own custom API authorization logic using an AWS Lambda function. To add a Lambda function as an authorization mode for your AppSync API, go to the **Settings** section of the **AppSync console**.

You will need to manage the details of token refreshes in your application code yourself.

## Use Amplify CLI to configure authorization modes

Amplify CLI can automatically configure the auth modes for you when running `amplify add api` or `amplify update api` if you want to change the auth mode.

If you already have auth configured, then you need to run `amplify update api` to use this pre-configured auth mode and CLI will not ask for auth settings again.

```bash
amplify update api
```

```console
? Please select from one of the below mentioned services:
    > `GraphQL`
? Select a setting to edit:
    > `Authorization modes`
? Choose the default authorization type for the API
  API key
  Amazon Cognito User Pool
❯ IAM
  OpenID Connect
```

## Manual Configuration

### API Key

Add the following snippet to your `amplifyconfiguration.json`/`.dart` file, under the `awsAPIPlugin`:

```json

    }
}
```

### Amazon Cognito User Pools

Add the following snippet to your `amplifyconfiguration.json`/`.dart` file, under the `awsCognitoAuthPlugin`:

```json

        }
    }
}
```

and under the `awsAPIPlugin`

```json

    }
}

```

### IAM

Add the following snippet to your `amplifyconfiguration.json`/`.dart` file:

```json

            }
        }
    }
}
```

and under the `awsAPIPlugin`

```json

    }
}
```

### OIDC

Update the `amplifyconfiguration.json`/`.dart` file and code snippet as follows:

```json

    }
}
```

If you are using Cognito's user pool as the authorization type, this will by default retrieve and use the Access Token for your requests. If you would like to override this behavior and use the ID Token instead, you can treat Cognito user pool as your OIDC provider and use `Amplify.Auth` to retrieve the ID Token for your requests.

### AWS Lambda

Amplify CLI does not currently allow you to configure Lambda as an authorization mode for your GraphQL API. To add a Lambda function as an authorization mode for your AppSync API, go to the **Settings** section of the **AppSync console**. Then, update the `authorizationType` value in the `amplifyconfiguration.json`/`.dart` file and code snippet as follows:

```json

    }
}
```

### NONE

You can also set authorization mode to `NONE` so that the library will not provide any request interception logic. You can use this when your API does not require any authorization or when you want to manipulate the request yourself, such as adding header values or authorization data.

```json

    }
}
```

You can register your own request interceptor to intercept the request and perform an action or inject something into your request before it is performed.

## Configure multiple authorization modes

> **Note**: 

There is currently [a known issue](https://github.com/aws-amplify/amplify-flutter/issues/1867) where enabling multi-auth modes for the API plugin may break DataStore functionality if the DataStore plugin is also used in the same App.

If you are planning to enable multi-auth for _only_ the DataStore plugin, please refer to the [configure multiple authorization types](/gen1/[platform]/prev/build-a-backend/more-features/datastore/authz-rules-setup/#configure-multiple-authorization-types) section in DataStore documentation.

If you are planning to enable multi-auth for both the API and DataStore plugins, please monitor the aforementioned issue for the latest progress and updates.

This section talks about the capability of AWS AppSync to configure multiple authorization modes for a single AWS AppSync endpoint and region. Follow the [AWS AppSync Multi-Auth](https://docs.aws.amazon.com/appsync/latest/devguide/security.html#using-additional-authorization-modes) to configure multiple authorization modes for your AWS AppSync endpoint.

You can now configure a single GraphQL API to deliver private and public data. Private data requires authenticated access using authorization mechanisms such as IAM, Cognito User Pools, and OIDC. Public data does not require authenticated access and is delivered through authorization mechanisms such as API Keys. You can also configure a single GraphQL API to deliver private data using more than one authorization type. For example, you can configure your GraphQL API to authorize some schema fields using OIDC, while other schema fields through Cognito User Pools and/or IAM.

As discussed in the above linked documentation, certain fields may be protected by different authorization types. This can lead the same query, mutation, or subscription to have different responses based on the authorization sent with the request; Therefore, it is recommended to use the different `friendly_name_` as the `apiName` parameter in the `Amplify.API` call to reference each authorization type.

The following snippets highlight the new values in the `amplifyconfiguration.json`/`.dart` and the client code configurations.

The `friendly_name` illustrated here is created from Amplify CLI prompt. There are 4 clients in this configuration that connect to the same API except that they use different `AuthMode`.

```json
,
        "[FRIENDLY-NAME-API-WITH-IAM]": ,
        "[FRIENDLY-NAME-API-WITH-USER-POOLS]": ,
        "[FRIENDLY-NAME-API-WITH-OPENID-CONNECT]": 
      }
    }
  }
}
```

The `GRAPHQL-ENDPOINT` from AWS AppSync will look similar to `https://xyz.appsync-api.us-west-2.amazonaws.com/graphql`.


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/graphqlapi/native_common/authz/common.mdx`