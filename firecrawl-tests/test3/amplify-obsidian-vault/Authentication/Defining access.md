---
title: Defining access
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/concepts/user-groups/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Defining access

Amplify Auth provides a mechanism that allows you to group users. Assigning users to groups enable you to customize access for a collection of users, or leverage for auditing purposes. For example, only "ADMINS" users are permitted to delete posts from a bulletin, or only "EDITORS" are permitted to modify posts in a "draft" state. To get started with groups, configure the `groups` property:

```ts title="amplify/auth/resource.ts"

> **Note**: 

**Note:** There are a few [limitations with groups](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-user-groups.html#user-pool-user-groups-limitations), including a limit of 10,000 groups per user pool.

## Defining access

Amplify resources enable you to define access for groups using common language. For example, you can use `allow.groups` in data:

```ts title="amplify/data/resource.ts"

const schema = a.schema().authorization(allow => [
    allow.groups(["EDITORS"]).to(["read", "update"])
  ])
})

// ...
```

Or in storage:

```ts title="amplify/storage/articles/resource.ts"

By defining access with groups, Amplify configures authorization rules to read from the current user's groups. User pool groups are available as a claim in the user's ID token and access token as `cognito:groups`. Requests can be made to secure resources using the access token and validated against this claim to permit action on the resource.

## Group roles

Each Cognito user pool group is assigned an [IAM role](https://aws.amazon.com/iam/features/manage-roles/). IAM roles can be modified to extend access to other AWS resources. Roles can be accessed from your backend on the `role` property of your group:

```ts title="amplify/backend.ts"

/**
 * @see https://docs.amplify.aws/react/build-a-backend/ to add storage, functions, and more
 */
const backend = defineBackend();

// highlight-start
const  = backend.auth.resources

// https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_iam.IRole.html
groups["ADMINS"].role
// highlight-end
```

## Next steps

- [Learn how to automatically add a user to a group upon account confirmation](/[platform]/build-a-backend/functions/examples/add-user-to-group/)
- [Learn how to secure access to data models using groups](/[platform]/build-a-backend/data/customize-authz/user-group-based-data-access)
- [Learn how to secure access to storage objects using groups](/[platform]/build-a-backend/storage/set-up-storage/)


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/concepts/user-groups/index.mdx`