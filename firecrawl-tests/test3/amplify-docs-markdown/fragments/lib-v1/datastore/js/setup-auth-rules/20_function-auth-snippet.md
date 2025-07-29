---
title: Configure custom authorization logic with AWS Lambda
source: fragments/lib-v1/datastore/js/setup-auth-rules/20_function-auth-snippet.mdx
---

# Configure custom authorization logic with AWS Lambda

## Configure custom authorization logic with AWS Lambda

You can implement your own custom API authorization logic using an AWS Lambda function. To add a Lambda function as an authorization mode for your AppSync API, go to the **Settings** section of the **AppSync console**.

You will need to manage the details of token refreshes in your application code yourself. 

Here's how you can specify a function for handling token refresh when using Lambda as an authorization mode with DataStore:

```js

DataStore.configure(
    },
  }
});
```
