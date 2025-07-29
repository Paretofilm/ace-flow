---
title: Setup the backend
topics: ['General']
primary_topic: General
source: fragments/lib-v1/predictions/js/interpret.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Setup the backend

## Setup the backend

This will allow you to determine key phrases, sentiment analysis from text, etc. If you haven't already done so, run `amplify init` inside your project and then `amplify add auth` (we recommend selecting the *default configuration*).

Run `amplify add predictions` and select **Interpret**. Then use the following answers:

```console
? What would you like to interpret? (Use arrow keys)
❯ Interpret Text 
  Learn More 

? What kind of interpretation would you like? 
  Language 
  Entity 
  Keyphrase 
  Sentiment 
  Syntax 
❯ All 

? Who should have access? Auth and Guest users
```

Now run `amplify push` which will generate your `aws-exports.js` and create resources in the cloud. You can now either add this to your backend or skip and add more features to your app.

Services used: Amazon Comprehend

## Working with the API

Analyze text to find key phrases, sentiment (positive, negative, neutral), or the syntax (pronouns, verbs, etc.). You can also find entities in the text such as names or places, or perform language detection.

```js
Predictions.interpret(,
    type: "ALL"
  }
})
.then(result => console.log())
.catch(err => console.log());
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/predictions/js/interpret.mdx`