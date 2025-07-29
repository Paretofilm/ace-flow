---
title: Documentation
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/js/existing-resources.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Documentation

If you are using the Amplify CLI, an existing Amazon S3 bucket can be used with the Amplify Libraries by running:

```bash
amplify import storage
```

For more details, see how to [Use an existing S3 bucket or DynamoDB table](/gen1/[platform]/build-a-backend/storage/import/).

If you are not using the Amplify CLI, an existing Amazon S3 bucket can be used by adding it to your `Amplify.configure` statement.

> **Note**: 
  When you are not using Amplify CLI, adding existing Amazon S3 bucket to your
  application may require configuring bucket access permissions. e.g. Enabling
  read/write access to the cognito user pool that you are using with the Amplify
  Auth category.

```js
Amplify.configure();
```

- **aws_user_files_s3_bucket**: Name of the bucket to use for storage
- **aws_user_files_s3_bucket_region**: AWS Region where the bucket is provisioned (e.g. _us-east-1_)

You can also configure the resources on a scoped level by [following the steps shown here](#storage-amazon-s3).

Note that before you can add an AWS resource to your application, the application must have the Amplify libraries installed. If you need to perform this step, see [Install Amplify Libraries](/gen1/[platform]/prev/start/project-setup/create-application/#n2-install-amplify-libraries).


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/js/existing-resources.mdx`