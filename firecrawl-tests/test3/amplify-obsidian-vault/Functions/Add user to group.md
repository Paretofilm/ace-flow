---
title: Add user to group
topics: ['Functions']
primary_topic: Functions
source: pages/build-a-backend/functions/examples/add-user-to-group/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, functions]
---


## 🧭 Navigation
**Topics**: [[Functions/]]
**Primary**: [[Functions/]]

---


# Add user to group

You can use `defineAuth` and `defineFunction` to create a [Cognito post confirmation Lambda trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-post-confirmation.html) that extends the behavior to perform some action when a user is confirmed.

> **Note**: 

A user is "confirmed" when they verify their account. Typically this happens when the user confirms their email via the verification email. The post confirmation handler will _not_ be triggered for federated sign-ins (i.e. social sign-in).

To get started, install the AWS SDK v3 package, which will be used to perform actions against your auth resource, and the `@types/aws-lambda` package, which is used to define the handler type:

```bash title="Terminal"
npm add --save-dev @aws-sdk/client-cognito-identity-provider @types/aws-lambda
```

Next, create a new directory and a resource file, `amplify/auth/post-confirmation/resource.ts`. Then, define the Function with `defineFunction`:

```ts title="amplify/auth/post-confirmation/resource.ts"

After creating the Function definition you will need to:

1. create the `EVERYONE` group
2. grant access to your auth resource to ensure it can perform the `addUserToGroup` action
3. set the Function as the post confirmation trigger

```ts title="amplify/auth/resource.ts"

Then create the Function's corresponding handler file, `amplify/auth/post-confirmation/handler.ts`, file with the following contents:

```ts title="amplify/auth/post-confirmation/handler.ts"
import  from '@aws-sdk/client-cognito-identity-provider';

const client = new CognitoIdentityProviderClient();

// add user to group

After deploying the changes, whenever a user signs up and verifies their account they are automatically added to the group named "EVERYONE".


---

## 📚 Related Topics
- [[Functions/]]

## 📖 Source
Original: `pages/build-a-backend/functions/examples/add-user-to-group/index.mdx`