---
title: Generate Typed Objects
topics: ['AI & Machine Learning']
primary_topic: AI & Machine Learning
source: pages/ai/generation/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, ai-&-machine-learning]
---


## 🧭 Navigation
**Topics**: [[AI & Machine Learning/]]
**Primary**: [[AI & Machine Learning/]]

---


# Generate Typed Objects

AI generation routes are a request-response API used to generate structured output from AI models. Examples of generation routes include:
- generated structured data from unstructured input
- summarization

> **Note**: 
See [Supported Providers and Models](/[platform]/ai/concepts/models/#supported-providers-and-models) for a list of supported AI models.

Under the hood, a generation route is an AWS AppSync query that ensures the AI model responds with the response type defined for the route.

## Generate Typed Objects

```ts title="Schema Definition"
const schema = a.schema()
    .arguments()
    .returns(
      a.customType()
    )
    .authorization((allow) => allow.authenticated())
});
```

```ts title="Data Client Request"
const description = 'I would like to bake a birthday cake for my friend. She has celiac disease and loves chocolate.'
const  = await client.generations
  .generateRecipe()

/**
Example response:

*/
```

</InlineFilter>

```tsx

const client = generateClient();
const  = createAIHooks(client);

  const generateSummary = async () => );
  };
}
```

</InlineFilter>

## Generate Scalar Types

```ts title="Schema Definition"
const schema = ()
  .arguments()
  .returns(a.string())
  .authorization((allow) => allow.guest()),
});
```

```ts title="Data Client Request"
const  = await client.generations
  .summarize()
```

## Setting Inference Parameters

You can influence response generation by setting inference parameters for the AI model.
This ability to control the randomness and diversity of responses is useful for generating responses that are tailored to your needs.

[More information about inference parameters](/[platform]/ai/concepts/inference-configuration).

```ts title="Inference Parameters"
const schema = a.schema(
    // highlight-end
  }),
});
```

## Limitations

### 1. Generation routes do not support referencing models

For example, the following schema defines a `Recipe` model, but this model cannot be used as the return type of a generation route.

```ts title="Invalid Model Reference"
const schema = a.schema(),
  generateRecipe: a.generation()
    .arguments()
    .returns(a.ref('Recipe')) // ❌ Invalid
    .authorization((allow) => allow.authenticated()),
});
```

You can, however, reference custom types. Here's an example of a custom type that can be used as the return type of a generation route.

```ts title="Valid Custom Type Reference"
const schema = a.schema(),
  generateRecipe: a.generation()
    .arguments()
    .returns(a.ref('Recipe')) // ✅ Valid
    .authorization((allow) => allow.authenticated()),
});
```

### 2. Generation routes do not support some required types.

The following AppSync scalar types are not supported as **required** fields in response types:
- `AWSEmail`
- `AWSDate`
- `AWSTime`
- `AWSDateTime`
- `AWSTimestamp`
- `AWSPhone`
- `AWSURL`
- `AWSIPAddress`

```ts title="Unsupported Required Type"
const schema = a.schema()
    .arguments()
    .returns(
      a.customType()
    )
    .authorization((allow) => allow.authenticated()),
});


---

## 📚 Related Topics
- [[AI & Machine Learning/]]

## 📖 Source
Original: `pages/ai/generation/index.mdx`