---
title: Documentation
source: fragments/lib/push-notifications/android/getting_started/30_existing_resources.mdx
---

# Documentation

Amplify reads configuration information at runtime from a file called `amplifyconfiguration.json`. If you used the Amplify CLI to create backend resources, this file was created for you. If it does not already exist, create the file and add it to your Android project.

Existing Amazon Pinpoint resources can be used with the Amplify Libraries by referencing your **Application ID** and **Region** in your `amplifyconfiguration.json` file.

```json
"notifications": 
    }
}
```

- **appId**: Amazon Pinpoint application ID
- **region**: AWS Region where the resources are provisioned (e.g. `us-east-1`)
