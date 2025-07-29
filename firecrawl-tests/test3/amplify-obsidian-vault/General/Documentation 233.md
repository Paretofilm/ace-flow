---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib-v1/restapi/existing-resources.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

Existing Amazon API Gateway resources can be used with the Amplify Libraries by referencing your API Gateway **endpoint** and configuring authorization in your `amplifyconfiguration.json` file.

```json

            }
        }
    }
}
```

- **API NAME**: Friendly name for the API (e.g., *api*)
  - **endpoint**: The HTTPS endpoint of the API (e.g. *https://aaaaaaaaaa.execute-api.us-east-1.amazonaws.com/api*)
  - **region**:  AWS Region where the resources are provisioned (e.g. *us-east-1*)
  - **authorizationType**: Authorization mode for accessing the API. This can be one of: `NONE`, `AWS_IAM`, `AMAZON_COGNITO_USER_POOLS`, or `API_KEY`. Each mode with the exception of `NONE` requires additional configuration parameters. See [Configure authorization modes](/gen1/[platform]/prev/build-a-backend/restapi/customize-authz/) for  details.

Note that before you can add an AWS resource to your application, the application must have the Amplify libraries installed. If you need to perform this step, see [Install Amplify Libraries](/gen1/[platform]/prev/start/project-setup/create-application/#n2-install-amplify-libraries).


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/restapi/existing-resources.mdx`