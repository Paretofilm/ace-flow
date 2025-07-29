---
title: Working with the API
source: pages/build-a-backend/add-aws-services/predictions/text-to-speech/index.mdx
---

# Working with the API

> **Note**: 

**Note:** Make sure to complete the [getting started](../set-up-predictions) section first, where you will set up the IAM roles with the right policy actions

## Working with the API

Generate an audio buffer for playback from a text input.

```ts

const result = await Predictions.convert(,
    voiceId: "Amy" 
  }
})
```

To view the complete list of voiceId options refer to [Voices in Amazon Polly](https://docs.aws.amazon.com/polly/latest/dg/voicelist.html).
