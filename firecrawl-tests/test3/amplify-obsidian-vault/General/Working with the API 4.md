---
title: Working with the API
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/predictions/transcribe-audio/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Working with the API

> **Note**: 

**Note:** Make sure to complete the [getting started](../set-up-predictions) section first, where you will set up the IAM roles with the right policy actions

## Working with the API

You can transcribe a PCM Audio byte buffer to Text, such as a recording from microphone.

```ts

const  = await Predictions.convert(
  }
})
```

To view the complete list of all the supported languages and language specific features refer to [the supported languages list](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html). The language data input type has to support streaming for it to work with Amplify Predictions.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/predictions/transcribe-audio/index.mdx`