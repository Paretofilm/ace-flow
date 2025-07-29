---
title: Working with the API
source: pages/build-a-backend/add-aws-services/predictions/translate/index.mdx
---

# Working with the API

> **Note**: 

**Note:** Make sure to complete the [getting started](../set-up-predictions) section first, where you will set up the IAM roles with the right policy actions

## Working with the API

Translate text from one source language to a destination language.

```ts

const result = await Predictions.convert(,
    targetLanguage: "en"
  }
})
```

To view the complete list of supported languages refer to [Supported languages and language codes](https://docs.aws.amazon.com/translate/latest/dg/what-is-languages.html).
