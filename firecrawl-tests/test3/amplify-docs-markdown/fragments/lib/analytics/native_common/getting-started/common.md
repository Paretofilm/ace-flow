---
title: Goal
source: fragments/lib/analytics/native_common/getting-started/common.mdx
---

# Goal

The Analytics category enables you to collect analytics data for your App. The Analytics category comes with built-in support for [Amazon Pinpoint](https://aws.amazon.com/pinpoint) and [Amazon Kinesis](https://aws.amazon.com/kinesis) (Kinesis support is currently only available in the Amplify JavaScript library). The Analytics category uses [Amazon Cognito Identity pools](https://docs.aws.amazon.com/cognito/latest/developerguide/identity-pools.html) to identify users in your App. Cognito allows you to receive data from authenticated, and unauthenticated users in your App.

## Goal

To setup and configure your application with Amplify Analytics and record an analytics event.

## Prerequisites

## Set up Analytics backend

Run the following command in your project's root folder. The CLI will prompt configuration options for the Analytics category such as Amazon Pinpoint resource name and analytics event settings.

> The Analytics category utilizes the Authentication category behind the scenes to authorize your app to send analytics events.

```bash
amplify add analytics
```

```console
? Select an Analytics provider (Use arrow keys)
    `Amazon Pinpoint`
? Provide your pinpoint resource name:
    `yourPinpointResourceName`
? Apps need authorization to send analytics events. Do you want to allow guests and unauthenticated users to send analytics events? (we recommend you allow this when getting started)
    `Yes`
```

To deploy your backend, run:

```bash
amplify push
```

## Install Amplify Libraries

## Initialize Amplify Analytics

## View Analytics console

If you have not saved the link from before, you can still reach it from the terminal. Run the following command for opening the console.

```console
amplify console analytics
```

Next Steps:

Congratulations! Now that you have Analytics' backend provisioned and Analytics library installed. Check out the following links to see Amplify Analytics use cases:

- [Record Events](/gen1/[platform]/build-a-backend/more-features/analytics/record-events/)
- [Track Sessions](/gen1/[platform]/build-a-backend/more-features/analytics/auto-track-sessions/)
- [Identify User](/gen1/[platform]/build-a-backend/more-features/analytics/identify-user/)
- [Escape Hatch](/gen1/[platform]/build-a-backend/more-features/analytics/sdk/)
