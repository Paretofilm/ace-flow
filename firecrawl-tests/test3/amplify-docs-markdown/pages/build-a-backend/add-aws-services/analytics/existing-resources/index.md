---
title: Configuring client library directly
source: pages/build-a-backend/add-aws-services/analytics/existing-resources/index.mdx
---

# Configuring client library directly

To use existing Amazon Pinpoint resources with your Amplify backend or frontend application, use the `addOutput` method to surface backend resource outputs to the `amplify_outputs.json` file:

```ts title="amplify/backend.ts"

const backend = defineBackend()

backend.addOutput(,
  },
})
```

## Configuring client library directly

Alternatively, you can configure the client library directly using `Amplify.configure()`. This manual setup enables you to use your existing Amazon Pinpoint resource in your app.

```ts title="src/main.ts"

const amplifyConfig = parseAmplifyConfig(outputs);

Amplify.configure(
  }
});
```
</InlineFilter>

## Update your IAM Policy

Amazon Pinpoint requires an AWS Identity and Access Management (IAM) policy in order to use the `record` and `identifyUser` APIs:
```json

  ]
}
```
