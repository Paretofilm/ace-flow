---
title: Set up the backend
topics: ['General']
primary_topic: General
source: fragments/lib/predictions/js/transcribe.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Set up the backend

## Set up the backend

If you haven't already done so, run `amplify init` inside your project and then `amplify add auth` (we recommend selecting the _default configuration_).

Run `amplify add predictions` and select **Convert**. Then use the following answers:

```console
? What would you like to convert? (Use arrow keys)
  Translate text into a different language
  Generate speech audio from text
> Transcribe text from audio

? Who should have access? Auth and Guest users
```

Now run `amplify push` which will generate your `amplifyconfiguration.json` and create resources in the cloud. You can now either add this to your backend or skip and add more features to your app.

Services used: Amazon Transcribe

## Working with the API

You can transcribe a PCM Audio byte buffer to Text, such as a recording from microphone.

```javascript

Predictions.convert(
    // language: "en-US",
  }
})
.then(( }) => console.log())
.catch((err) => console.log());
```

To view the complete list of all the supported languages and language specific features refer to [the supported languages list](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html). The language data input type has to support streaming for it to work with Amplify Predictions.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/predictions/js/transcribe.mdx`