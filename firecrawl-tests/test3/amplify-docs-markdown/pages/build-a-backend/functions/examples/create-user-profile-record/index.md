---
title: Create a user profile record
source: pages/build-a-backend/functions/examples/create-user-profile-record/index.mdx
---

# Create a user profile record

You can use `defineAuth` and `defineFunction` to create a [Cognito post confirmation Lambda trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-post-confirmation.html) to create a profile record when a user is confirmed.

> **Note**: 

A user is "confirmed" when they verify their account. Typically this happens when the user confirms their email via the verification email. The post confirmation handler will _not_ be triggered for federated sign-ins (i.e. social sign-in).

To get started, install the `aws-lambda` package, which is used to define the handler type.

```bash title="Terminal" showLineNumbers=
npm add --save-dev @types/aws-lambda
```

Update the `amplify/data/resource.ts` file to define a data model for the user's profile:

> **Note**: 

Make sure to configure the authorization rule to allow the `postConfirmation` resource as highlighted below. Granting access to resources creates environment variables for your Function such as the GraphQL API endpoint. To learn more visit the [environment variables and secrets documentation for Functions](/[platform]/build-a-backend/functions/environment-variables-and-secrets/).

```ts title="amplify/data/resource.ts"

const schema = a
  .schema()
      .authorization((allow) => [
        allow.ownerDefinedIn("profileOwner"),
      ]),
  })
  .authorization((allow) => [allow.resource(postConfirmation)]);

```

Create a new directory and a resource file, `amplify/auth/post-confirmation/resource.ts`. Then, define the Function with `defineFunction`:

```ts title="amplify/auth/post-confirmation/resource.ts"

Then, create the corresponding handler file, `amplify/auth/post-confirmation/handler.ts`, file with the following contents:

```ts title="amplify/auth/post-confirmation/handler.ts"

const  = await getAmplifyDataClientConfig(
  env
);

Amplify.configure(resourceConfig, libraryOptions);

const client = generateClient();

  return event;
};

```

> **Note**: 
When configuring Amplify with `getAmplifyDataClientConfig`, your function consumes schema information from an S3 bucket created during backend deployment with grants for the access your function need to use it. Any changes to this bucket outside of backend deployment may break your function.

Lastly, set the newly created Function resource on your auth resource:

```ts title="amplify/auth/resource.ts"

After deploying the changes, whenever a user signs up and verifies their account a profile record is automatically created.
