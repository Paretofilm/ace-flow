---
title: Use OpenID Connect as an authorization provider
topics: ['Data & APIs', 'Authentication']
primary_topic: Data & APIs
source: pages/build-a-backend/data/customize-authz/using-oidc-authorization-provider/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, authentication]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Authentication/]]
**Primary**: [[Data & APIs/]]

---


# Use OpenID Connect as an authorization provider

Private, owner, and group authorization can be configured with an OpenID Connect (OIDC) authorization mode. Add `"oidc"` to the authorization rule as the provider. Use the `oidcAuthorizationMode` property to configure the *OpenID Connect provider name*, *OpenID Connect provider domain*, *Client ID*, *Issued at TTL*, and *Auth Time TTL*.

The example below highlights the supported authorization strategies with a `oidc` authorization provider. For owner and group-based authorization, you also will need to [specify a custom identity and group claim](/[platform]/build-a-backend/data/customize-authz/configure-custom-identity-and-group-claim).

```ts title="amplify/data/resource.ts"
// amplify/data/resource.ts

const schema = a.schema()
    .authorization(allow => [
      allow.owner('oidc').identityClaim('user_id'),
      allow.authenticated('oidc'),
      allow
        .groups(['testGroupName'], 'oidc')
        .withClaimIn('user_groups'),
    ]),
});

In your application, you can perform CRUD operations against the model using `client.models.<model-name>` by specifying the `oidc` auth mode.

```ts

const client = generateClient();

const  = await client.models.Todo.list();
```

</InlineFilter>

In your application, you can perform CRUD operations against the model with the `oidc` auth mode.

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

## 📖 Source
Original: `pages/build-a-backend/data/customize-authz/using-oidc-authorization-provider/index.mdx`