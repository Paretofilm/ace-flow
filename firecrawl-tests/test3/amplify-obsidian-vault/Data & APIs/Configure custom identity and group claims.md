---
title: Configure custom identity and group claims
topics: ['Data & APIs', 'Authentication', 'AI & Machine Learning']
primary_topic: Data & APIs
source: pages/build-a-backend/data/customize-authz/configure-custom-identity-and-group-claim/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, authentication, ai-&-machine-learning]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Authentication/]] • [[AI & Machine Learning/]]
**Primary**: [[Data & APIs/]]

---


# Configure custom identity and group claims

Amplify Data supports using custom identity and group claims if you do not wish to use the default Amazon Cognito-provided `cognito:groups` or the double-colon-delimited claims, `sub::username`, from your JWT token. This can be helpful if you are using tokens from a 3rd party OIDC system or if you wish to populate a claim with a list of groups from an external system, such as when using a [Pre Token Generation Lambda Trigger](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-token-generation.html) which reads from a database.

To use custom claims specify `identityClaim` or `groupClaim` as appropriate. In the example below, the `identityClaim` is specified and the record owner will check against this `user_id` claim. Similarly, if the `user_groups` claim contains a "Moderator" string then access will be granted.

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .authorization(allow => [
      allow.owner().identityClaim('user_id'),
      allow.groups(['Moderator']).withClaimIn('user_groups'),
    ]),
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


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Authentication/]]
- [[AI & Machine Learning/]]

## 📖 Source
Original: `pages/build-a-backend/data/customize-authz/configure-custom-identity-and-group-claim/index.mdx`