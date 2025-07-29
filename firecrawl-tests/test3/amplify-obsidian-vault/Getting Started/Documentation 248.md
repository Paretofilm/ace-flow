---
title: Documentation
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/lib-v1/restapi/android/getting-started/11_amplifyInit.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Documentation

To start provisioning api resources in the backend, go to your project directory and **execute the command**:

```bash
amplify add api
```

Enter the following when prompted:
```console
? Please select from one of the below mentioned services:
    `REST`
? Provide a friendly name for your resource to be used as a label for this category in the project:
    `api`
? Provide a path (e.g., /book/):
    `/todo`
? Choose a Lambda source
    `Create a new Lambda function`
? Provide an AWS Lambda function name:
    `todo`
? Choose the runtime that you want to use:
    `NodeJS`
? Choose the function template that you want to use:
    `Serverless ExpressJS function (Integration with API Gateway)`
? Do you want to configure advanced settings?
    `No`
? Do you want to edit the local lambda function now?
    `No`
? Restrict API access
    `Yes`
? Who should have access?
    `Authenticated and Guest users`
? What kind of access do you want for Authenticated users?
    `create, read, update, delete`
? What kind of access do you want for Guest users?
    `create, read, update, delete`
Successfully added auth resource locally.
? Do you want to add another path?
    `No`
```

To push your changes to the cloud, **execute the command**:

```bash
amplify push
```

Upon completion, `amplifyconfiguration.json` should be updated to reference provisioned backend storage resources.  Note that these files should already be a part of your project if you followed the [Project setup walkthrough](/gen1/[platform]/prev/start/project-setup/create-application/).

> **Note**: 

The current version of the Amplify CLI will create classes intended for use with the AWS SDK for Android in your project. If you see compilation errors relating to `com.amazonaws.mobileconnectors.apigateway.annotation`, please delete the directory with the name of your API in Android Studio.


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/restapi/android/getting-started/11_amplifyInit.mdx`