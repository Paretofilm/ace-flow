---
title: Triggers
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/customize-auth-lifecycle/triggers/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Triggers

Amplify Auth's behavior can be customized through the use of triggers. A trigger is defined as a Function, and is a mechanism to slot some logic to execute during the authentication flow. For example, you can use triggers to [validate whether emails include an allowlisted domain](/[platform]/build-a-backend/functions/examples/email-domain-filtering), [add a user to a group upon confirmation](/[platform]/build-a-backend/functions/examples/add-user-to-group), or [create a "UserProfile" model upon account confirmation](/[platform]/build-a-backend/functions/examples/create-user-profile-record).

Triggers translate to [Cognito user pool Lambda triggers](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html).

> When you have a Lambda trigger assigned to your user pool, Amazon Cognito interrupts its default flow to request information from your function. Amazon Cognito generates a JSON event and passes it to your function. The event contains information about your user's request to create a user account, sign in, reset a password, or update an attribute. Your function then has an opportunity to take action, or to send the event back unmodified.

To get started, define a function and specify the `triggers` property on your auth resource:

```ts title="amplify/auth/resource.ts"

To learn more about use cases for triggers, visit the [Functions examples](/[platform]/build-a-backend/functions/examples/).


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/customize-auth-lifecycle/triggers/index.mdx`