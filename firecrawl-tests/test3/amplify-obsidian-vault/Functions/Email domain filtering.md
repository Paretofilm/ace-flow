---
title: Email domain filtering
topics: ['Functions', 'AI & Machine Learning']
primary_topic: Functions
source: pages/build-a-backend/functions/examples/email-domain-filtering/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, functions, ai-&-machine-learning]
---


## 🧭 Navigation
**Topics**: [[Functions/]] • [[AI & Machine Learning/]]
**Primary**: [[Functions/]]

---


# Email domain filtering

You can use `defineAuth` and `defineFunction` to create a [Cognito pre sign-up Lambda trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-sign-up.html) that performs filtering based on the user's email address. This can allow or deny user signups based on their email address.

To get started, install the `aws-lambda` package, which is used to define the handler type.

```bash title="Terminal" showLineNumbers=
npm add --save-dev @types/aws-lambda
```

Next, create a new directory and a resource file, `amplify/auth/pre-sign-up/resource.ts`. Then, define the Function with `defineFunction`:

```ts title="amplify/auth/pre-sign-up/resource.ts"

Next, create the corresponding handler file, `amplify/auth/pre-sign-up/handler.ts`, file with the following contents:

```ts title="amplify/auth/pre-sign-up/handler.ts"

  if (!email.endsWith(env.ALLOW_DOMAIN)) 

  return event;
};
```

Lastly, set the newly created Function resource on your auth resource:

```ts title="amplify/auth/resource.ts"

After deploying the changes, whenever a user attempts to sign up without an `amazon.com` email address they will receive an error.


---

## 📚 Related Topics
- [[Functions/]]
- [[AI & Machine Learning/]]

## 📖 Source
Original: `pages/build-a-backend/functions/examples/email-domain-filtering/index.mdx`