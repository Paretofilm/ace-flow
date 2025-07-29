---
title: Add public authorization rule using API key-based authentication
source: pages/build-a-backend/data/customize-authz/public-data-access/index.mdx
---

# Add public authorization rule using API key-based authentication

The public authorization strategy grants everyone access to the API, which is protected behind the scenes with an API key. You can also override the authorization provider to use an unauthenticated IAM role from Cognito instead of an API key for public access.

## Add public authorization rule using API key-based authentication

To grant everyone access, use the `.public()` authorization strategy. Behind the scenes, the API will be protected with an API key.

```ts title="amplify/data/resource.ts"
const schema = a.schema()
    .authorization(allow => [allow.publicApiKey()]),
});
```

In your application, you can perform CRUD operations against the model using `client.models.<model-name>` by specifying the `apiKey` auth mode.

```ts

const client = generateClient();

const  = await client.models.Todo.create(
  ,
  // highlight-start
  
  // highlight-end
);
```

</InlineFilter>

In your application, you can perform CRUD operations against the model by specifying the `apiKey` auth mode.
</InlineFilter>

```dart
try ');
    return;
  }
  safePrint('Mutation result: $');

} on APIException catch (e) 
```

</InlineFilter>

```swift
do  catch 
```

</InlineFilter>

### Extend API Key Expiration

If the API key has not expired, you can extend the expiration date by deploying your app again. The API key expiration date will be set to `expiresInDays` days from the date when the app is deployed. In the example below, the API key will expire 7 days from the latest deployment.

```ts title="amplify/data/resource.ts"

### Rotate an API Key

You can rotate an API key if it was expired, compromised, or deleted. To rotate an API key, you can override the logical ID of the API key resource in the `amplify/backend.ts` file. This will create a new API key with a new logical ID.

```ts title="amplify/backend.ts"
const backend = defineBackend();

backend.data.resources.cfnResources.cfnApiKey?.overrideLogicalId(
  `recoverApiKey$`
);
```

Deploy your app. After the deploy has finished, remove the override to the logical ID and deploy your app again to use the default logical ID.

```ts title="amplify/backend.ts"
const backend = defineBackend();

// backend.data.resources.cfnResources.cfnApiKey?.overrideLogicalId(
//   `recoverApiKey$`
// );
```

A new API key will be created for your app.

## Add public authorization rule using Amazon Cognito identity pool's unauthenticated role

You can also override the authorization provider. In the example below, `identityPool` is specified as the provider which allows you to use an "Unauthenticated Role" from the Cognito identity pool for public access instead of an API key. Your Auth resources defined in `amplify/auth/resource.ts` generates scoped down IAM policies for the "Unauthenticated role" in the Cognito identity pool automatically.

```ts title="amplify/data/resource.ts"
const schema = a.schema()
    .authorization(allow => [allow.guest()]),
});
```

In your application, you can perform CRUD operations against the model using `client.models.<model-name>` with the `identityPool` auth mode.

> **Note**: 
If you're not using the auto-generated **amplify_outputs.json** file, then you must set the Amplify Library resource configuration's `allowGuestAccess` flag to `true`. This lets the Amplify Library use the unauthenticated role from your Cognito identity pool when your user isn't logged in.

```ts title="src/App.tsx"

Amplify.configure(
  ,
    },
  }
);
```
</Accordion>

```ts title="src/App.tsx"

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

```swift
do  catch 
```

</InlineFilter>
