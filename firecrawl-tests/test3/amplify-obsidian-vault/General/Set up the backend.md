---
title: Set up the backend
topics: ['General']
primary_topic: General
source: fragments/lib-v1/predictions/js/translate.mdx
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

If you haven't already done so, run `amplify init` inside your project and then `amplify add auth` (we recommend selecting the *default configuration*).

Run `amplify add predictions` and select **Convert**. Then use the following answers:

```console
? What would you like to convert? (Use arrow keys)
❯ Convert text into a different language 
  Generate speech audio from text 
  Transcribe text from audio 

? Who should have access? Auth and Guest users
```

Now run `amplify push` which will generate your `aws-exports.js` and create resources in the cloud. You can now either add this to your backend or skip and add more features to your app.

## Working with the API

Translate text from one source language to a destination language.

```javascript
Predictions.convert(,
    // targetLanguage: "en"
  }
})
.then(result => console.log())
.catch(err => console.log());
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/predictions/js/translate.mdx`