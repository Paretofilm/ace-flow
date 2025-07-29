---
title: Add signed-in user authorization rule
source: pages/build-a-backend/data/customize-authz/signed-in-user-data-access/index.mdx
---

# Add signed-in user authorization rule

The `authenticated` authorization strategy restricts record access to only signed-in users authenticated through IAM, Cognito, or OpenID Connect, applying the authorization rule to all users. It provides a simple way to make data private to all authenticated users.

## Add signed-in user authorization rule

You can use the `authenticated` authorization strategy to restrict a record's access to every signed-in user.

> **Note**: 
**Note:** If you want to restrict a record's access to a specific user, see [Per-user/per-owner data access](/[platform]/build-a-backend/data/customize-authz/per-user-per-owner-data-access/). The `authenticated` authorization strategy detailed on this page applies the authorization rule for data access to **every** signed-in user.

In the example below, anyone with a valid JWT token from the Cognito user pool is allowed access to all Todos.

```ts title="amplify/data/resource.ts"
const schema = a.schema()
    .authorization(allow => [allow.authenticated()]),
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

## Use identity pool for signed-in user authentication

You can also override the authorization provider. In the example below, `identityPool` is specified as the provider which allows you to use an "Unauthenticated Role" from the Cognito identity pool for public access instead of an API key. Your Auth resources defined in `amplify/auth/resource.ts` generates scoped down IAM policies for the "Unauthenticated role" in the Cognito identity pool automatically.

```ts title="amplify/data/resource.ts"
const schema = a.schema()
    .authorization(allow => [allow.authenticated('identityPool')]),
});
```

In your application, you can perform CRUD operations against the model using `client.models.<model-name>` with the `iam` auth mode.

> **Note**: 
 The user must be logged in for the Amplify Library to use the authenticated role from your Cognito identity pool.

```ts

const client = generateClient();

const  = await client.models.Todo.create(
  ,
  // highlight-start
  
  // highlight-end
);
```
</InlineFilter>

In your application, you can perform CRUD operations against the model with the `iam` auth mode.

```dart
try ');
    return;
  }
  safePrint('Mutation result: $');

} on APIException catch (e) 
```

</InlineFilter>

In your application, you can perform CRUD operations against the model with the `awsIAM` auth mode.

> **Note**: 
 The user must be logged in for the Amplify Library to use the authenticated role from your Cognito identity pool.

```swift
do  catch 
```
</InlineFilter>

In addition, you can also use OpenID Connect with `authenticated` authorization. See [OpenID Connect as an authorization provider](/[platform]/build-a-backend/data/customize-authz/using-oidc-authorization-provider/).
