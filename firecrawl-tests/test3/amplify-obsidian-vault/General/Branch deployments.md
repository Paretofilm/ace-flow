---
title: Branch deployments
topics: ['General']
primary_topic: General
source: pages/reference/iam-policy/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Branch deployments

## Branch deployments

Branch deployments require the [`AmplifyBackendDeployFullAccess`](https://docs.aws.amazon.com/amplify/latest/userguide/security-iam-awsmanpol.html#security-iam-awsmanpol-AmplifyBackendDeployFullAccess) managed policy to be able to deploy backend resources during a fullstack deployment. When connecting your project through the console, a role with this policy attached will be automatically created for you.

## Cloud sandbox deployments

Sandbox deployments, by design, use local credentials to deploy resources. You need to ensure that the local profile has the `AmplifyBackendDeployFullAccess` policy attached to it.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/reference/iam-policy/index.mdx`