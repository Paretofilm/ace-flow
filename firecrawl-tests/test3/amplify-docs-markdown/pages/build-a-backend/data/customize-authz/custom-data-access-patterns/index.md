---
title: Custom data access using Lambda functions
source: pages/build-a-backend/data/customize-authz/custom-data-access-patterns/index.mdx
---

# Custom data access using Lambda functions

You can define your own custom authorization rule with a Lambda function.

```ts title="amplify/data/resource.ts"
import  from '@aws-amplify/backend';

const schema = a.schema()
    // STEP 1
    // Indicate which models / fields should use a custom authorization rule
    .authorization(allow => [allow.custom()]),
});

In your application, you can perform CRUD operations against the model using `client.models.<model-name>` with the `lambda` auth mode.

```ts

const client = generateClient();

const  = await client.models.Todo.create(
  ,
  // highlight-start
  
  // highlight-end
);
```

</InlineFilter>

In your application, you can perform CRUD operations against the model with the `function` auth mode.

```dart
try ');
    return;
  }
  safePrint('Mutation result: $');

} on APIException catch (e) 
```

</InlineFilter>

The Lambda function of choice will receive an authorization token from the client and execute the desired authorization logic. The AppSync GraphQL API will receive a payload from Lambda after invocation to allow or deny the API call accordingly.

To configure a Lambda function as the authorization mode, create a new file `amplify/data/custom-authorizer.ts`. You can use this Lambda function code template as a starting point for your authorization handler code:

```ts
// amplify/data/custom-authorizer.ts

// This is sample code. Update this to suite your needs

type ResolverContext = ;

You can use the template above as a starting point for your custom authorization rule. The authorization Lambda function receives the following event:

```json
\n\nquery MyQuery \n", # GraphQL query
        "operationName": "MyQuery", # GraphQL operation name
        "variables":  # any additional variables supplied to the operation
    }
}
```

Your Lambda authorization function needs to return the following JSON:

```json
, // JSON object visible as $ctx.identity.resolverContext in VTL resolver templates

  // optional
  "deniedFields": ["TypeName.FieldName"], // Forces the fields to "null" when returned to the client
  "ttlOverride": 10 // The number of seconds that the response should be cached for. Overrides default specified in "amplify update api"
}
```

Review the Amplify documentation to set the custom authorization token for the [Data client](/[platform]/build-a-backend/data/connect-to-API).
