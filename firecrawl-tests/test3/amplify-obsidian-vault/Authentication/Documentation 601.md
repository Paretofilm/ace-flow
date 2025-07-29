---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/js/delete_user.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

Invoke the `deleteUser` API to delete a user from the Auth category. This action will also sign your user out.

If your application uses a Cognito User Pool, which is the default configuration for the Amazon Cognito plugin, this action will delete the user from the Cognito User Pool. It will have no effect if you are federating with a Cognito Identity Pool alone.

> **Note**: 
  Depending on your application, data associated with your user may be stored in
  other resources such as Amazon DynamoDB or AWS S3. It is recommended that you
  carefully evaluate this data and implement code to remove or otherwise
  sanitize it, if necessary, prior to giving users the ability to delete their
  own user record.

> **Note**: 

Before invoking the “delete user” API, you can first delete associated user data from the GraphQL API. For example, if you are using Amplify CLI's [GraphQL transformer](/gen1/[platform]/build-a-backend/graphqlapi/) to persist user data via [owner based access control](/gen1/[platform]/build-a-backend/graphqlapi/customize-authorization-rules/#per-user--owner-based-data-access), you could follow [these instructions](https://gist.github.com/aws-amplify-ops/27954c421bd72930874d48c15c284807) to delete associated user data.

This allows you to address any guidelines that require your app to delete data associated with a user who deletes their account.

```ts

</Block>

```js

async function deleteUser()  catch (error) 
}
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/js/delete_user.mdx`