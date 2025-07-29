---
title: Data Extraction
topics: ['AI & Machine Learning', 'Data & APIs']
primary_topic: AI & Machine Learning
source: pages/ai/generation/data-extraction/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, ai-&-machine-learning, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[AI & Machine Learning/]] • [[Data & APIs/]]
**Primary**: [[AI & Machine Learning/]]

---


# Data Extraction

Data extraction allows you to parse unstructured text and extract structured data using AI. This is useful for converting free-form text into typed objects that can be used in your application.

The following example shows how to extract product details from an unstructured product description. The AI model will analyze the text and return a structured object containing the product name, summary, price, and category.

```typescript title="amplify/data/resource.ts"
const schema = a.schema(),

  extractProductDetails: a.generation()
    .arguments()
    .returns(a.ref('ProductDetails'))
    .authorization((allow) => allow.authenticated()),
});
```

```ts title="Data Client Request"

const productDescription = `The NBA Official Game Basketball is a premium
regulation-size basketball crafted with genuine leather and featuring
official NBA specifications. This professional-grade ball offers superior grip
and durability, with deep channels and a moisture-wicking surface that ensures
consistent performance during intense game play. Priced at $159.99, this high-end
basketball belongs in our Professional Sports Equipment category and is the same model
used in NBA games.`

const  = await client.generations
  .extractProductDetails()

/**
Example response:

*/
```
</InlineFilter>

```ts title="src/components/Example.tsx"

const client = generateClient();
const  = createAIHooks(client);

  // data is React state and will be populated when the generation is returned
  const [, extractProductDetails] =
    useAIGeneration("extractProductDetails");

  const productDetails = async () => );
  };
}
```
</InlineFilter>


---

## 📚 Related Topics
- [[AI & Machine Learning/]]
- [[Data & APIs/]]

## 📖 Source
Original: `pages/ai/generation/data-extraction/index.mdx`