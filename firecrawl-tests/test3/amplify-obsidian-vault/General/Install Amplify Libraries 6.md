---
title: Install Amplify Libraries
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/predictions/set-up-predictions/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Install Amplify Libraries

To enable Predictions we need to set up the appropriate IAM policy for Roles in your Cognito Identity Pool in order to use an appropriate feature. Additionally, we need to use the ```addOutput``` method to patch the custom Predictions resource to the expected output configuration.

> **Note**: 

**Note:** In the following example, we configure the policy to enable all supported ML capabilities. Ensure to include only the actions & resources relevant to your specific use cases.
To learn more, check the docs of [Amazon Translate](https://docs.aws.amazon.com/translate/latest/dg/what-is.html), [Amazon Polly](https://docs.aws.amazon.com/polly/latest/dg/what-is.html), [Amazon Transcribe](https://docs.aws.amazon.com/transcribe/latest/dg/what-is-transcribe.html), [Amazon Rekognition](https://docs.aws.amazon.com/rekognition/latest/dg/what-is.html), [Amazon Textract](https://docs.aws.amazon.com/textract/latest/dg/what-is.html), and [Amazon Comprehend](https://docs.aws.amazon.com/comprehend/latest/dg/what-is.html).

```ts title="amplify/backend.ts"

const backend = defineBackend();

// Configure a policy for the required use case.
// The actions included below cover all supported ML capabilities
backend.auth.resources.unauthenticatedUserIamRole.addToPrincipalPolicy(
  new PolicyStatement()
);

backend.addOutput(,
          proxy: false,
          region: backend.auth.stack.region,
        },
        speechGenerator: ,
          proxy: false,
          region: backend.auth.stack.region,
        },
        transcription: ,
          proxy: false,
          region: backend.auth.stack.region,
        },
      },
      identify: ,
          celebrityDetectionEnabled: true,
          proxy: false,
          region: backend.auth.stack.region,
        },
        identifyLabels: ,
          proxy: false,
          region: backend.auth.stack.region,
        },
        identifyText: ,
          proxy: false,
          region: backend.auth.stack.region,
        },
      },
      interpret: ,
          proxy: false,
          region: backend.auth.stack.region,
        },
      },
    },
  },
});
```

## Install Amplify Libraries

To install the Amplify library to use predictions features, run the following commands in your project's root folder:

```bash title="Terminal" showLineNumbers=
npm add aws-amplify @aws-amplify/predictions
```

## Configure the frontend

Import and load the configuration file in your app. It is recommended you add the Amplify configuration step to your app's root entry point. For example `main.ts` in React and Angular.

```ts title="src/main.ts"

const amplifyConfig = parseAmplifyConfig(outputs);

Amplify.configure();
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/predictions/set-up-predictions/index.mdx`