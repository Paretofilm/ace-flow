---
title: Prerequisites
topics: ['Push Notifications', 'Getting Started']
primary_topic: Push Notifications
source: fragments/lib-v1/push-notifications/common/getting_started/getting-started.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, push-notifications, getting-started]
---


## 🧭 Navigation
**Topics**: [[Push Notifications/]] • [[Getting Started/]]
**Primary**: [[Push Notifications/]]

---


# Prerequisites

The Push Notifications category allows you to integrate push notifications in your app with Amazon Pinpoint targeting, campaign, and journey management support. You can segment your users, trigger push notifications to your app, and record metrics in Pinpoint when users receive or open notifications. Amazon Pinpoint helps you to create messaging campaigns and journeys targeted to specific user segments or demographics and collect interaction metrics with push notifications.

## Prerequisites

## Set up backend resources

To use Push Notifications with Amplify, you have the option to either have the Amplify CLI setup resources for you, or you can use an existing Amazon Pinpoint resource in your AWS account.

> Prerequisite: [Install and configure the Amplify CLI](/gen1/[platform]/tools/cli/start/set-up-cli/)

> **Note**: 

Push Notifications requires version **12.12.3+** of the Amplify CLI. You can check your current version with `amplify -version` and upgrade to the latest version with `amplify upgrade`.

To start provisioning push notification resources in the backend, go to your project directory and execute the command:

```sh
amplify add notifications
```

</Block>

</Block>
</BlockSwitcher>

## Install Amplify Libraries

## Initialize Amplify Push Notifications


---

## 📚 Related Topics
- [[Push Notifications/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/push-notifications/common/getting_started/getting-started.mdx`