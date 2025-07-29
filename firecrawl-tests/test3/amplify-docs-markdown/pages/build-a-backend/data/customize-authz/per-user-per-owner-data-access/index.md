---
title: Add per-user/per-owner authorization rule
source: pages/build-a-backend/data/customize-authz/per-user-per-owner-data-access/index.mdx
---

# Add per-user/per-owner authorization rule

The `owner` authorization strategy restricts operations on a record to only the record's owner. When configured, the `owner` field will automatically be added and populated with the identity of the created user. The API will authorize against the `owner` field to allow or deny operations.

## Add per-user/per-owner authorization rule

You can use the `owner` authorization strategy to restrict a record's access to a specific user. When `owner` authorization is configured, only the record's `owner` is allowed the specified operations.

```ts title="amplify/data/resource.ts"
// The "owner" of a Todo is allowed to create, read, update, and delete their own todos
const schema = a.schema()
    .authorization(allow => [allow.owner()]),
});
```

```ts title="amplify/data/resource.ts"
// The "owner" of a Todo record is only allowed to create, read, and update it.
// The "owner" of a Todo record is denied to delete it.
const schema = a.schema()
    .authorization(allow => [allow.owner().to(['create', 'read', 'update'])]),
});
```

In your application, you can perform CRUD operations against the model using `client.models.<model-name>` with the `userPool` auth mode.

```ts

const client = generateClient();

const  = await client.models.Todo.create(
  ,
  // highlight-start
  
  // highlight-end
);
```
</InlineFilter>

In your application, you can perform CRUD operations against the model with the `userPools` auth mode.
  
```dart
try ');
    return;
  }
  safePrint('Mutation result: $');

} on APIException catch (e) 
```
</InlineFilter>

In your application, you can perform CRUD operations against the model with the `amazonCognitoUserPools` auth mode.

```swift
do  catch 
```
</InlineFilter>

Behind the scenes, Amplify will automatically add a `owner: a.string()` field to each record which contains the record owner's identity information upon record creation.

By default, the Cognito user pool's user information is populated into the `owner` field. The value saved includes `sub` and `username` in the format `<sub>::<username>`. The API will authorize against the full value of `<sub>::<username>` or `sub` / `username` separately and return `username`. You can alternatively configure [OpenID Connect as an authorization provider](/[platform]/build-a-backend/data/customize-authz/using-oidc-authorization-provider).

> **Note**: 

**By default, owners can reassign the owner of their existing record to another user.**

To prevent an owner from reassigning their record to another user, protect the owner field (by default `owner: String`) with a [field-level authorization rule](/[platform]/build-a-backend/data/customize-authz/#field-level-authorization-rules). For example, in a social media app, you would want to prevent Alice from being able to reassign Alice's Post to Bob.

```ts
const schema = a.schema()
    .authorization(allow => [allow.owner()]),
});
```

## Customize the owner field

You can override the `owner` field to your own preferred field, by specifying a custom `ownerField` in the authorization rule.

```ts
const schema = a.schema()
    .authorization(allow => [allow.ownerDefinedIn('author')]),
});
```
