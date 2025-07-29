---
title: With admin actions
source: pages/build-a-backend/auth/manage-users/with-admin-actions/index.mdx
---

# With admin actions

Amplify Auth can be managed with the [AWS SDK's `@aws-sdk/client-cognito-identity-provider` package](https://docs.aws.amazon.com/AWSJavaScriptSDK/v3/latest/client/cognito-identity-provider/). This package is intended to use server-side, and can be used within a Function. This example focuses on the `addUserToGroup` action and will be defined as a [custom mutation](/[platform]/build-a-backend/data/custom-business-logic/#step-1---define-a-custom-query-or-mutation).

To get started, create an "ADMINS" group that will be used to authorize the mutation:

```ts title="amplify/auth/resource.ts"

Next, create the Function resource:

```ts title="amplify/data/add-user-to-group/resource.ts"

Then, in your auth resources, grant access for the function to perform the `addUserToGroup` action. [Learn more about granting access to auth resources](/[platform]/build-a-backend/auth/grant-access-to-auth-resources).

```ts title="amplify/auth/resource.ts"
// highlight-next-line

You're now ready to define the custom mutation. Here you will use the newly-created `addUserToGroup` function resource to handle the `addUserToGroup` mutation. This mutation can only be called by a user in the "ADMINS" group.

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .authorization((allow) => [allow.group("ADMINS")])
    .handler(a.handler.function(addUserToGroup))
    .returns(a.json())
})

Lastly, create the function's handler using the exported client schema to type the handler function, and the generated `env` to specify the user pool ID you'd like to interact with:

```ts title="amplify/data/add-user-to-group/handler.ts"
import  from "@aws-sdk/client-cognito-identity-provider"

type Handler = Schema["addUserToGroup"]["functionHandler"]
const client = new CognitoIdentityProviderClient()

In your frontend, use the generated client to call your mutation using the group name and the user's ID.

```ts title="src/client.ts"

const client = generateClient()

await client.mutations.addUserToGroup()
```

</InlineFilter>

</InlineFilter>

</InlineFilter>

</InlineFilter>
</InlineFilter>
