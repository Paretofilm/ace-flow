---
title: API key
source: fragments/lib/graphqlapi/flutter/authz.mdx
---

# API key

AppSync supports authorization by means of API Keys, Amazon IAM credentials, Amazon Cognito User Pools, and 3rd party OIDC providers. The type of authorization being used is determined from the `amplifyconfiguration.dart` file that gets read when you call `Amplify.configure()`.

#### API key

API Key is the simplest way to setup and prototype your application with AWS AppSync. While simple, the mechanism is easy to abuse since anyone who discovers your API Key can make requests to your public service. Production applications should authorized requests via Cognito user pool or AWS IAM. Your API Key will expire according to the expiry time that you set when provisioning AWS AppSync. You will need to extend its lifespan, or creating a new API key, if needed. 

#### Amazon Cognito User Pools

Amazon Cognito's user pool is most commonly used with AWS AppSync when adding authorization check on your API calls. If your application needs to interact with other AWS services besides AWS AppSync, such as Amazon S3, you will need to use AWS IAM credentials with Amazon Cognito's identity pools. Amplify CLI can automatically configure this for you when running `amplify add auth` and will also automatically use the authenticated user from user pools to federate with the identity pools to provide the AWS IAM credentials in the application. [See this for more information about the differences](https://aws.amazon.com/premiumsupport/knowledge-center/cognito-user-pools-identity-pools/). This allows you to have both user pool credentials for AWS AppSync and AWS IAM credentials for other AWS resources. You can learn more about Amplify Auth outlined in the [Accessing credentials section](/gen1/[platform]/build-a-backend/auth/accessing-credentials/). For manual configuration, add the following snippet to your `amplifyconfiguration.dart` file, under the `awsCognitoAuthPlugin`:

```json

        }
    }
}
```
and under the `awsAPIPlugin`
```json

            }
        } 
    }
}
```
and under the `awsAPIPlugin`
```json
,
                "[FRIENDLY-NAME-API-WITH-IAM": ,
                "[FRIENDLY-NAME-API-WITH-USER-POOLS]": ,
                "[FRIENDLY-NAME-API-WITH-OPENID-CONNECT]": 
            }
        }
    }
}
```

The `GRAPHQL-ENDPOINT` from AWS AppSync will look similar to `https://xyz.appsync-api.us-west-2.amazonaws.com/graphql`.
