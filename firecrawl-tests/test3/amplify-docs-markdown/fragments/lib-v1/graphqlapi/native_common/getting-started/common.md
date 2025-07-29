---
title: Goal
source: fragments/lib-v1/graphqlapi/native_common/getting-started/common.mdx
---

# Goal

The Amplify API category provides an interface for retrieving and persisting your model data. The API category comes with default built-in support for AWS AppSync. The Amplify CLI allows you to define your API and provision a GraphQL service with CRUD operations and real-time functionality.

## Goal

To setup and configure your application with Amplify API to save items in the backend.

## Prerequisites

## Configure API

To start provisioning API resources in the backend, go to your project directory and **execute the command**:

```bash
amplify add api
```

Enter the following when prompted:

```console
? Please select from one of the below mentioned services:
    `GraphQL`
# The part below will show you some options you can change, if you wish to change any of them you can navigate with
# your arrow keys and update any field, otherwise you can click on `Continue` to move on
? Here is the GraphQL API that we will create. Select a setting to edit or continue
    `Continue`
? Choose a schema template:
    `Single object with fields (e.g., “Todo” with ID, name, description)`
? Do you want to edit the schema now?
    `No`
```

> **Note**: 

**Troubleshooting:** The AWS API plugins do not support conflict detection. If AppSync returns errors about missing `_version` and `_lastChangedAt` fields, or unhandled conflicts, disable **conflict detection**. Run `amplify update api`, and choose **Disable conflict detection**. If you started with the Getting Started guide, which introduces DataStore, this step is required.

The guided schema creation will output `amplify/backend/api//schema.graphql` containing the following:

```graphql
type Todo @model 
```

To push your changes to the cloud, **execute the command**:

```bash
amplify push
```

## Install Amplify Libraries

## Initialize Amplify API

## Create a Todo

Upon successfully executing this code, you should see an instance of `todo` persisted in your dynamoDB table.

To navigate to your backend, run `amplify console api` and choose `GraphQL`. This will open the AppSync console to your GraphQL service. Select `Data Sources` and select the Resource link in your `TodoTable` to bring you to the DynamoDB Console. Select the `items` tab to see the `Todo` object that has been persisted in your database.

## Next steps

Congratulations! You've created a `Todo` object in your database. Check out the following links to see other Amplify API use cases:

- [Fetch data](/gen1/[platform]/prev/build-a-backend/graphqlapi/query-data/)
- [Update data](/gen1/[platform]/prev/build-a-backend/graphqlapi/mutate-data/)
- [Subscribe to data](/gen1/[platform]/prev/build-a-backend/graphqlapi/subscribe-data/)
- [Concepts](/gen1/[platform]/prev/build-a-backend/graphqlapi/api-graphql-concepts/)
- [Configure authorization modes](/gen1/[platform]/prev/build-a-backend/graphqlapi/customize-authz-modes)
