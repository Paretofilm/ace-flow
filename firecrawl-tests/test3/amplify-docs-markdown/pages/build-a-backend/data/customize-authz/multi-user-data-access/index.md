---
title: Add multi-user authorization rule
source: pages/build-a-backend/data/customize-authz/multi-user-data-access/index.mdx
---

# Add multi-user authorization rule

The `ownersDefinedIn` rule grants a set of users access to a record by automatically creating an `owners` field to store the allowed record owners. You can override the default owners field name by specifying `inField` with the desired field name to store the owner information. You can dynamically manage which users can access a record by updating the owner field.

## Add multi-user authorization rule

If you want to grant a set of users access to a record, you use the `ownersDefinedIn` rule. This automatically creates a `owners: a.string().array()` field to store the allowed owners.

```ts title="amplify/data/resource.ts"
const schema = a.schema()
    .authorization(allow => [allow.ownersDefinedIn('owners')]),
});
```

In your application, you can perform CRUD operations against the model using `client.models.<model-name>` with the `userPool` auth mode.

```ts

const client = generateClient();

// Create a record with current user as first owner
const  = await client.models.Todo.create(
  ,
  // highlight-start
  
  // highlight-end
);
```

Add another user as an owner

```ts
await client.models.Todo.update(
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

Add another user as an owner

```dart
try ');
    return;
  }

} catch 
```
</InlineFilter>

In your application, you can perform CRUD operations against the model with the `amazonCognitoUserPools` auth mode.

```swift
do  catch 
```

Add another user as an owner

```swift
do  catch 
```

</InlineFilter>

## Override to a list of owners

You can override the `inField` to a list of owners. Use this if you want a dynamic set of users to have access to a record. In the example below, the `authors` list is populated with the creator of the record upon record creation. The creator can then update the `authors` field with additional users. Any user listed in the `authors` field can access the record.

```ts
const schema = a.schema()
    .authorization(allow => [allow.ownersDefinedIn('authors')]),
});
```
