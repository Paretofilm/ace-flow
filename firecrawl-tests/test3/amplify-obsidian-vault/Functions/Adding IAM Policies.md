---
title: Adding IAM Policies
topics: ['Functions']
primary_topic: Functions
source: pages/build-a-backend/functions/modify-resources-with-cdk/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, functions]
---


## 🧭 Navigation
**Topics**: [[Functions/]]
**Primary**: [[Functions/]]

---


# Adding IAM Policies

Amplify Functions utilize the [`NodejsFunction`](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_lambda_nodejs.NodejsFunction.html) construct from the [AWS Cloud Development Kit (CDK)](https://aws.amazon.com/cdk/). The underlying resources can be modified, overridden, or extended using CDK after setting the resource on your backend.

```ts title="amplify/backend.ts"

const backend = defineBackend()

// CDK constructs can be accessed via
backend.myFunction.resources

// where the Lambda function can be found on
backend.myFunction.resources.lambda
```

The Lambda resource available is a representation of [`IFunction`](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_lambda.IFunction.html). 

## Adding IAM Policies

To learn how to add IAM policies to a Function's execution role, visit the [documentation for granting access to other resources](/[platform]/build-a-backend/functions/grant-access-to-other-resources#using-cdk).


---

## 📚 Related Topics
- [[Functions/]]

## 📖 Source
Original: `pages/build-a-backend/functions/modify-resources-with-cdk/index.mdx`