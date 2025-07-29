---
title: Setup cloud sync
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/native_common/sync.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Setup cloud sync

Once you're happy with your application, you can start syncing with the cloud by provisioning a backend from your project. DataStore can connect to remote backend and automatically sync all locally saved data using GraphQL as a data protocol.

> **Note**: 

**Best practice:** it is recommended to develop without cloud synchronization enabled initially so you can change the schema as your application takes shape without the impact of having to update the provisioned backend. Once you are satisfied with the stability of your data schema, setup cloud synchronization as described below and the data saved locally will be synchronized to the cloud automatically.

## Setup cloud sync

Synchronization between offline and online data can be tricky. DataStore's goal is to remove that burden from the application code and handle all data consistency and reconciliation between local and remote behind the scenes, while developers focus on their application logic. Up to this point the focus was to setup a local data store that works offline and has all the capabilities you would expect from a data persistence framework.

The next step is to make sure the locally saved data is synchronized with a cloud backend powered by [AWS AppSync](https://aws.amazon.com/appsync/).

> **Note**: 

**Note:** Syncing data between the cloud and the local device starts automatically whenever you run any DataStore operation after your app is set up.

### Push the backend to the cloud

By now you should have a backend created with conflict detection enabled, as described in the [Getting started](/gen1/[platform]/build-a-backend/more-features/datastore/set-up-datastore/) guide.

**Check the status of the backend** to verify if it is already provisioned in the cloud.

```bash
amplify status
```

You should see a table similar to this one.

```
| Category | Resource name     | Operation | Provider plugin   |
| -------- | ----------------- | --------- | ----------------- |
| Api      | amplifyDatasource | No Change | awscloudformation |
```

> **Note**: 

**Troubleshooting:** if `amplify status` gives you an error saying _"You are not working inside a valid Amplify project"_, make sure you run `amplify init` before the next step.

In case `Operation` says `Create` or `Update` you need to **push the backend to the cloud**.

```bash
amplify push
```

> **Note**: 

**AWS credentials needed.** At this point an AWS account is required. If you have never run `amplify configure` before, do it so and follow the steps to configure Amplify with your AWS account. Details can be found in the [Configure the Amplify CLI](/gen1/[platform]/tools/cli/start/set-up-cli/#configure-the-amplify-cli) guide.

## Existing backend

DataStore can connect to an existing AWS AppSync backend that has been deployed from another project, no matter the platform it was originally created in. In these workflows it is best to work with the CLI directly by running an `amplify pull` command from your terminal and then generating models afterwards, using the process described in the [Getting started](/gen1/[platform]/build-a-backend/more-features/datastore/set-up-datastore/#idiomatic-persistence-models) guide.

For more information on this workflow please see the [Multiple Frontends documentation](/gen1/[platform]/tools/cli/teams/multi-frontend/).

## Clear local data

`Amplify.DataStore.clear()` provides a way for you to clear all local data if needed. This is a destructive operation but the **remote data will remain intact**. When the next sync happens, data will be pulled into the local storage again and reconstruct the local data.

One common use for `clear()` is to manage different users sharing the same device or even as a development-time utility.

> **Note**: 

**Note:** In case multiple users share the same device and your schema defines user-specific data, make sure you call `Amplify.DataStore.clear()` when switching users. Visit [Auth events](/gen1/[platform]/build-a-backend/auth/auth-events/) for all authentication related events.

This is a simple yet effective example. However, in a real scenario you might want to only call `clear()` when a different user is `signedIn` in order to avoid clearing the database for a repeated sign-in of the same user.


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/native_common/sync.mdx`