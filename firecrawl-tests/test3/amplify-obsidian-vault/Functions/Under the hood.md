---
title: Under the hood
topics: ['Functions']
primary_topic: Functions
source: pages/build-a-backend/functions/configure-client-library/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, functions]
---


## 🧭 Navigation
**Topics**: [[Functions/]]
**Primary**: [[Functions/]]

---


# Under the hood

The [`aws-amplify`](https://www.npmjs.com/package/aws-amplify) client library can be configured for use inside function handler files by using the credentials available from the AWS Lambda runtime. To get started, use the `getAmplifyDataClientConfig` from the backend runtime package and pass the generated `env` object to retrieve the preconfigured `resourceConfig` and `libraryOptions`.

```ts title="amplify/my-function/handler.ts"

const  = await getAmplifyDataClientConfig(
  env
);
```

> **Note**: 

When using `getAmplifyDataClientConfig`, your function requires schema information stored in an Amplify deployed Amazon S3 bucket. This bucket is created during backend deployment and includes necessary access grants for your function. Modifying this bucket outside of the backend deployment process may cause unexpected failures on your function.

`resourceConfig` and `libraryOptions` are returned for you to pass into `Amplify.configure`. This will instruct the client library which resources it can interact with, and where to retrieve AWS credentials to use when signing requests to those resources.

```ts title="amplify/my-function/handler.ts"
// highlight-next-line

const  = await getAmplifyDataClientConfig(
  env
);

// highlight-next-line
Amplify.configure(resourceConfig, libraryOptions);
```

The client library will now have access to perform operations against other AWS resources as specified by the function's IAM role. This is handled for you when [granting access to other resources using the `access` property](/[platform]/build-a-backend/functions/grant-access-to-other-resources/#using-the-access-property), however it can also be [extended using CDK](/[platform]/build-a-backend/functions/grant-access-to-other-resources/#using-cdk).

## Under the hood

The `getAmplifyDataClientConfig` function assists with creating the arguments' values to pass to `Amplify.configure`, which reads from the generated `env` object in order to produce configuration for the resources you have granted your function access to interact with. Under the hood this is also generating the configuration that specifies how the client library should behave, namely where the library should read credentials.

```ts title="amplify/my-function/handler.ts"

Amplify.configure(
  ,
  ,
        }),
        clearCredentialsAndIdentityId: () => ,
      },
    },
  }
);
```


---

## 📚 Related Topics
- [[Functions/]]

## 📖 Source
Original: `pages/build-a-backend/functions/configure-client-library/index.mdx`