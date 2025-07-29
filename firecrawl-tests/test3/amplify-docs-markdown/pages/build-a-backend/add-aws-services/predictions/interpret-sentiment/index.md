---
title: Working with the API
source: pages/build-a-backend/add-aws-services/predictions/interpret-sentiment/index.mdx
---

# Working with the API

> **Note**: 

**Note:** Make sure to complete the [getting started](../set-up-predictions) section first, where you will set up the IAM roles with the right policy actions

## Working with the API

Analyze text to find key phrases, sentiment (positive, negative, neutral), or the syntax (pronouns, verbs, etc.). You can also find entities in the text such as names or places, or perform language detection.

```ts

const result = await Predictions.interpret(,
    type: 'ALL'
  }
})
```
