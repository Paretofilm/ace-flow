---
title: Enabling deletion protection on a Auth resource
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/deletion-backup-resources/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Enabling deletion protection on a Auth resource

> **Note**: 

Deleting a Amplify sandbox with a resource enabled with deletion protection, the deploy process will fail and the resource will need to be manually deleted on the AWS console. 

Using the [AWS Cloud Development Kit (CDK)](https://docs.aws.amazon.com/cdk/latest/guide/home.html) we can configure Amplify generated resource to enable deletion protection and backups on supported resources. For example, you can use AWS CDK to enable [Point-in-time recovery for DynamoDB tables](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/PointInTimeRecovery.html), or use [AWS Backup](https://aws.amazon.com/backup/) as a advanced backup option.

Using underlying CDK construct properties you can modify resource configurations. This allows you to customize backend resources beyond what is offered via the `define*` functions.

## Enabling deletion protection on a Auth resource

For example, if you would like to enable deletion protection on a Cognito user pool resource created by Amplify Auth.

```ts title="amplify/backend.ts"

const backend = defineBackend();

// highlight-start
const  = backend.auth.resources.cfnResources
cfnUserPool.deletionProtection = "ACTIVE";
// highlight-end
```

## Enabling Deletion protection on a Data resource

For example, if you would like to enable Deletion protection on all DynamoDB tables created by GraphQL API.

```ts title="amplify/backend.ts"

const backend = defineBackend();

// highlight-start
const  = backend.data.resources.cfnResources;
for (const table of Object.values(amplifyDynamoDbTables)) 
// highlight-end
```

## Enabling Point-in-time recovery for DynamoDB tables

For example, enabling Point-in-time recovery for all the DynamoDB tables created by GraphQL API. By default Point-in-Time recovery retains backups for 35 days.

```ts title="amplify/backend.ts"

const backend = defineBackend();

// highlight-start
const  = backend.data.resources.cfnResources;
for (const table of Object.values(amplifyDynamoDbTables)) 
// highlight-end
```

## Enabling Backups for DynamoDB tables

For example, if your DynamoDB tables requires backups that extend the default 35 days point-in-time recovery, AWS Backup service can be utilized to centralize and automate backups for DynamoDB tables. 
The example below outlines a backup plan configured to run daily at midnight, for all DynamoDB tables. 

```ts title="amplify/backend.ts"
// highlight-start
import  from "aws-cdk-lib/aws-backup";
// highlight-end

const backend = defineBackend();

// highlight-start
const backupStack = backend.createStack("backup-stack");
const myTables = Object.values(backend.data.resources.tables);

const vault = new BackupVault(backupStack, "BackupVault", );

const plan = new BackupPlan(backupStack, "BackupPlan", );

plan.addRule(
  new BackupPlanRule(),
  })
);

plan.addSelection("BackupPlanSelection", );
// highlight-end
```

## Retaining resources on stack deletion

For example, if you would like to retain a resource on stack deletion, you can use the `applyRemovalPolicy` property on the resource to add a retention policy.

> **Note**: 

`ampx sandbox delete` ignores any resource removal policy and always deletes all resources.

```ts title="amplify/backend.ts"

const backend = defineBackend();

// highlight-start
// Retain the S3 bucket on stack deletion
backend.storage.resources.bucket.applyRemovalPolicy(RemovalPolicy.RETAIN);

// Retain the Cognito user pool on stack deletion
backend.auth.resources.userPool.applyRemovalPolicy(RemovalPolicy.RETAIN);

// Retain the DynamoDB table on stack deletion
backend.data.resources.cfnResources.amplifyDynamoDbTables["Todo"].applyRemovalPolicy(RemovalPolicy.RETAIN);
// highlight-end
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/deletion-backup-resources/index.mdx`