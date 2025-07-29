---
title: S3 Upload confirmation
source: pages/build-a-backend/functions/examples/s3-upload-confirmation/index.mdx
---

# S3 Upload confirmation

You can use `defineStorage` and `defineFunction` to create a function trigger to confirm uploading a file.

To get started, install the `@types/aws-lambda` [package](https://www.npmjs.com/package/@types/aws-lambda), which contains types for different kinds of Lambda handlers, events, and responses.

```bash title="Terminal" showLineNumbers=
npm add --save @types/aws-lambda
```

Update your storage definition to define the onUpload trigger as below:

```ts title="amplify/storage/resource.ts"

Next, create a file named `amplify/storage/on-upload-handler.ts` and use the following code to log the object keys whenever an object is uploaded to the bucket. You can add your custom logic to this function as needed.

```ts title="amplify/storage/on-upload-handler.ts"

Now, when you deploy your backend, this function will be invoked whenever an object is uploaded to the bucket.
