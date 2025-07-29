---
title: Use auth resources without an Amplify backend
source: pages/build-a-backend/auth/use-existing-cognito-resources/index.mdx
---

# Use auth resources without an Amplify backend

Amplify Auth can be configured to use an existing Amazon Cognito user pool and identity pool. If you are in a team setting or part of a company that has previously created auth resources, you can [configure the client library directly](#use-auth-resources-without-an-amplify-backend), or maintain references with [AWS Cloud Development Kit (AWS CDK)](https://aws.amazon.com/cdk/) in your Amplify backend.

> **Note**: 

**Note:** when using existing auth resources, it may be necessary to add additional policies or permissions for your authenticated and unauthenticated IAM roles. These changes must be performed manually.

## Use auth resources without an Amplify backend

You can use existing resources without an Amplify backend by configuring the client library directly.

```ts title="src/main.ts"

Amplify.configure(,
      signUpVerificationMethod: "code",
      userAttributes: ,
      },
      allowGuestAccess: true,
      passwordFormat: ,
    },
  },
})
```

</InlineFilter>

Configuring the mobile client libraries directly is not supported, however you can manually create `amplify_outputs.json` with the following schema:

> **Note**: 

**Note:** it is strongly recommended to use backend outputs to generate this file for each sandbox or branch deployment

```json title="amplify_outputs.json"

  }
}
```

</InlineFilter>

## Use auth resources with an Amplify backend

> **Note**: 

Amplify cannot modify the configuration of your referenced resources and only captures the resource configuration at the time of reference, any subsequent changes made to the referenced resources will not be automatically reflected in your Amplify backend.

If you have created Amazon Cognito resources outside of the context of your Amplify app such as creating resources through the AWS Console or consuming resources created by a separate team, you can use `referenceAuth` to reference the existing resources. It requires a user pool, a user pool client, identity pool, and an authenticated & unauthenticated IAM role configured on your identity pool.

```ts title="amplify/auth/resource.ts"

> **Note**: 

IAM policies specific to your Amplify application will be appended to your authenticated and unauthenticated roles, and applications using the referenced resource will be able to create users in the Cognito user pool and identities in the Cognito identity pool.

You can also use the [`access` property](/[platform]/build-a-backend/auth/grant-access-to-auth-resources/) to grant permissions to your auth resource from other Amplify backend resources. For example, if you have a function that needs to retrieve details about a user:

```ts title="amplify/auth/resource.ts"

Additionally, you can also use the `groups` property to reference groups in your user pool. This is useful if you want to work with groups in your application and provide access to resources such as storage based on group membership.

```ts title="amplify/auth/resource.ts"

In a team setting you may want to reference a different set of auth resources depending on the deployment context. For instance if you have a `staging` branch that should reuse resources from a separate "staging" environment compared to a `production` branch that should reuse resources from the separate "production" environment. In this case we recommend using environment variables.

```ts title="amplify/auth/resource.ts"

Environment variables must be configured separately on your machine for sandbox deployments and Amplify console for branch deployments.

## Next steps

- [Learn how to connect your frontend](/[platform]/build-a-backend/auth/connect-your-frontend/)
