---
title: Goal
source: fragments/lib/storage/native_common/getting-started/common.mdx
---

# Goal

The Amplify Storage category provides an interface for managing user content for your app in public, protected, or private storage buckets. The Storage category comes with default built-in support for Amazon Simple Storage Service (S3). The Amplify CLI helps you to create and configure the storage buckets for your app. The Amplify AWS S3 Storage plugin leverages [Amazon S3](https://aws.amazon.com/s3).

## Goal

To setup and configure your application with Amplify Storage and go through a simple upload file example

## Prerequisites

## Provision backend storage

To start provisioning storage resources in the backend, go to your project directory and **execute the command**:

```bash
amplify add storage
```

Enter the following when prompted:

```console
? Please select from one of the below mentioned services:
    `Content (Images, audio, video, etc.)`
? You need to add auth (Amazon Cognito) to your project in order to add storage for user files. Do you want to add auth now?
    `Yes`
? Do you want to use the default authentication and security configuration?
    `Default configuration`
? How do you want users to be able to sign in?
    `Username`
? Do you want to configure advanced settings?
    `No, I am done.`
? Please provide a friendly name for your resource that will be used to label this category in the project:
    `S3friendlyName`
? Please provide bucket name:
    `storagebucketname`
? Who should have access:
    `Auth and guest users`
? What kind of access do you want for Authenticated users?
    `create/update, read, delete`
? What kind of access do you want for Guest users?
    `create/update, read, delete`
? Do you want to add a Lambda Trigger for your S3 Bucket?
    `No`
```

To push your changes to the cloud, **execute the command**:

```bash
amplify push
```

## Install Amplify Libraries

## Initialize Amplify Storage
