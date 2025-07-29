---
title: Custom message
topics: ['Functions']
primary_topic: Functions
source: pages/build-a-backend/functions/examples/custom-message/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, functions]
---


## 🧭 Navigation
**Topics**: [[Functions/]]
**Primary**: [[Functions/]]

---


# Custom message

You can use `defineAuth` and `defineFunction` to create an [Amazon Cognito custom message AWS Lambda trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-custom-message.html) thats sends an custom email or phone verification message, or a multi-factor authentication (MFA) code.

To get started, install `@types/aws-lambda` package that will be used to define the type of the handler:

```bash title="Terminal" showLineNumbers=
npm add --save-dev @types/aws-lambda
```

Next, create a new directory and a resource file, `amplify/auth/custom-message/resource.ts`. Then, define the function with `defineFunction`:

```ts title="amplify/auth/custom-message/resource.ts"

Next, create the corresponding handler file, `amplify/auth/custom-message/handler.ts`, file with the following contents:

> **Note**: 
The input event for the `CustomMessage_AdminCreateUser` trigger source includes both a username and verification code. Admin-created users must receive both their username and code in order to sign in and thus you must include both the `usernameParameter` and `codeParameter` in your message template.

```ts title="amplify/auth/custom-message/handler.ts" 

  if (event.triggerSource === "CustomMessage_AdminCreateUser")  and your temporary password is $`;
    event.response.emailSubject = 'Welcome to Example App';
  }

  return event;
};
```

Lastly, set the newly created function resource on your auth resource:

```ts title="amplify/auth/resource.ts"

After deploying the changes, whenever a user with user attribute `locale` set to `es` attempts to reset a password they will receive an email with a one-time code in Spanish.


---

## 📚 Related Topics
- [[Functions/]]

## 📖 Source
Original: `pages/build-a-backend/functions/examples/custom-message/index.mdx`