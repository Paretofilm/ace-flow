---
title: Update your IAM Policy
topics: ['Analytics']
primary_topic: Analytics
source: fragments/lib/analytics/android/existing-resources.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, analytics]
---


## 🧭 Navigation
**Topics**: [[Analytics/]]
**Primary**: [[Analytics/]]

---


# Update your IAM Policy

Existing Amazon Pinpoint resources can be used with the Amplify Libraries by referencing your **Application ID** and **Region** in your `amplifyconfiguration.json` file.

```json
,
                "pinpointTargeting": 
            }
        }
    }
}
```

- **pinpointAnalytics**
  - **appId**: Amazon Pinpoint application ID
  - **region**: AWS Region where the resources are provisioned (e.g. `us-east-1`)
- **pinpointTargeting**
  - **region**: AWS Region where the resources are provisioned (e.g. `us-east-1`)

Note that before you can add an AWS resource to your application, the application must have the Amplify libraries installed. If you need to perform this step, see [Install Amplify Libraries](/gen1/[platform]/start/project-setup/create-application/#n2-install-amplify-libraries).

## Update your IAM Policy

Amazon Pinpoint requires an AWS Identity and Access Management (IAM) policy in order to use the `record` and `identifyUser` APIs:
```json

  ]
}
```


---

## 📚 Related Topics
- [[Analytics/]]

## 📖 Source
Original: `fragments/lib/analytics/android/existing-resources.mdx`