---
title: Override ID token claims
topics: ['Functions']
primary_topic: Functions
source: pages/build-a-backend/functions/examples/override-token/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, functions]
---


## 🧭 Navigation
**Topics**: [[Functions/]]
**Primary**: [[Functions/]]

---


# Override ID token claims

You can use `defineAuth` and `defineFunction` to create an [Amazon Cognito Pre token generation AWS Lambda trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-token-generation.html) to override the token by adding a new claim or modifying the user's group membership.

To get started, install the `aws-lambda` package, which is used to define the handler type.

```bash title="Terminal" showLineNumbers=
npm add --save-dev @types/aws-lambda
```

Create a new directory and a resource file, `amplify/auth/pre-token-generation/resource.ts`. Then, define the function with `defineFunction`:

```ts title="amplify/auth/pre-token-generation/resource.ts"

Then, create the corresponding handler file, `amplify/auth/post-confirmation/pre-token-generation/handler.ts`, file with the following contents:

```ts title="amplify/auth/pre-token-generation/handler.ts"

```

Lastly, set the newly created function resource on your auth resource:

```ts title="amplify/auth/resource.ts"

After deploying the changes, The idToken of the user will be modified as per the trigger above.

```json showLineNumbers=

```


---

## 📚 Related Topics
- [[Functions/]]

## 📖 Source
Original: `pages/build-a-backend/functions/examples/override-token/index.mdx`