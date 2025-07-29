---
title: Override storage resource
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/js/transfer-acceleration.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Override storage resource

> **Note**: 

When you use Transfer Acceleration, additional data transfer charges might apply. For more information about pricing, see [Amazon S3 pricing](https://aws.amazon.com/s3/pricing/).

You can enable [Transfer Acceleration](https://docs.aws.amazon.com/AmazonS3/latest/userguide/transfer-acceleration.html) for fast and secure transfer of files over long distances between your end user device and the S3 bucket. You can override the storage resource for this configuration and then leverage the `useAccelerateEndpoint` parameter to use the accelerated S3 endpoint.

## Override storage resource

Start by overriding your storage resources to enable Transfer Acceleration on your S3 bucket.

```sh
$ amplify override storage
✅ Successfully generated "override.ts" folder at <project>/amplify/backend/storage/accelerated-bucket
✔ Do you want to edit override.ts file now? (Y/n) · yes
Edit the file in your editor: <project>/amplify/backend/storage/accelerated-bucket/override.ts
```

In the generated `override.ts` file use the following CDK snippet to enable transfer acceleration. 

```typescript
// amplify/backend/storage/accelerated-bucket/override.ts

Next, deploy this storage resource:

```sh
amplify push
```

## Upload files using the accelerated S3 endpoint

We switch to the accelerated S3 endpoint by using the `useAccelerateEndpoint` parameter set to `true` for the `Storage.put` method.

```javascript
const result = await Storage.put("test.txt", "Hello", );
```


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/js/transfer-acceleration.mdx`