---
title: User attribute validation
source: pages/build-a-backend/functions/examples/user-attribute-validation/index.mdx
---

# User attribute validation

You can use `defineAuth` and `defineFunction` to create a [Cognito pre sign-up Lambda trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-sign-up.html) that extends the behavior of sign-up to validate attribute values.

To get started, create a new directory and a resource file, `amplify/auth/pre-sign-up/resource.ts`. Then, define the function with `defineFunction`:

```ts title="amplify/auth/pre-sign-up/resource.ts"

Next, create the corresponding handler file, `amplify/auth/pre-sign-up/handler.ts`, file with the following contents:

```ts title="amplify/auth/pre-sign-up/handler.ts"

function isOlderThan(date: Date, age: number) 

  // you must be 13 years or older
  if (!isOlderThan(birthdate, 13)) 

  return event
}
```

Lastly, set the newly created function resource on your auth resource:

```ts title="amplify/auth/resource.ts"

After deploying the changes, whenever a user attempts to sign up this handler will verify the submitter's age is above 13 years.
