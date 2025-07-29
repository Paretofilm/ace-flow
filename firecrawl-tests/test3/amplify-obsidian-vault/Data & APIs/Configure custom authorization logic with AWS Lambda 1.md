---
title: Configure custom authorization logic with AWS Lambda
topics: ['Data & APIs', 'Authentication']
primary_topic: Data & APIs
source: fragments/lib/datastore/js/setup-auth-rules/20_function-auth-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, authentication]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Authentication/]]
**Primary**: [[Data & APIs/]]

---


# Configure custom authorization logic with AWS Lambda

## Configure custom authorization logic with AWS Lambda

You can implement your own custom API authorization logic using an AWS Lambda function. To add a Lambda function as an authorization mode for your AppSync API, go to the **Settings** section of the **AppSync console**.

You will need to manage the details of token refreshes in your application code yourself.

Here's how you can specify a function for handling token refresh when using Lambda as an authorization mode with DataStore:

```js

DataStore.configure(;
    }
  }
});
```


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/datastore/js/setup-auth-rules/20_function-auth-snippet.mdx`