---
title: Customize Amplify-generated AppSync GraphQL API resources
source: pages/build-a-backend/data/override-resources/index.mdx
---

# Customize Amplify-generated AppSync GraphQL API resources

}

Amplify GraphQL API uses a variety of auto-generated, underlying AWS services and resources. You can customize these underlying resources to optimize the deployed stack for your specific use case.

In your Amplify app, you can access every underlying resource using CDK ["L2"](https://docs.aws.amazon.com/cdk/v2/guide/constructs.html#constructs_using) or ["L1"](https://docs.aws.amazon.com/cdk/v2/guide/constructs.html#constructs_l1_using) constructs. Access the generated resources as L2 constructs via the `.resources` property on the returned stack or access the generated resources as L1 constructs using the `.resources.cfnResources` property.

```ts title="amplify/backend.ts"

const backend = defineBackend();

const  = backend.data.resources;

for (const table of Object.values(cfnResources.amplifyDynamoDbTables)) 
```

## Customize Amplify-generated AppSync GraphQL API resources

Apply all the customizations on `backend.data.resources.graphqlApi` or `backend.data.resources.cfnResources.cfnGraphqlApi`. For example, to enable X-Ray tracing for the AppSync GraphQL API:

```ts title="amplify/backend.ts"

const backend = defineBackend();

const  = backend.data.resources;

cfnResources.cfnGraphqlApi.xrayEnabled = true;
```

## Customize Amplify-generated resources for data models

Pass in the model type name into `backend.data.resources.amplifyDynamoDbTables["MODEL_NAME"]` to modify the resources generated for that particular model type. For example, to enable time-to-live on the Todo `@model` type's DynamoDB table:

```ts title="amplify/backend.ts"

const backend = defineBackend();

const  = backend.data.resources;

cfnResources.amplifyDynamoDbTables["Todo"].timeToLiveAttribute = ;
```

### Example - Configure billing mode on a DynamoDB table

Set the [DynamoDB billing mode](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dynamodb-table.html#cfn-dynamodb-table-billingmode) for the DynamoDB table as either "PROVISIONED" or "PAY_PER_REQUEST".

```ts title="amplify/backend.ts"

const backend = defineBackend();

const  = backend.data.resources;

cfnResources.amplifyDynamoDbTables['Todo'].billingMode = BillingMode.PAY_PER_REQUEST;
```

### Example - Configure provisioned throughput for a DynamoDB table

Override the default [ProvisionedThroughput](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-dynamodb-table.html#cfn-dynamodb-table-provisionedthroughput) provisioned for each model table and its Global Secondary Indexes (GSI). This override is only valid if the "DynamoDBBillingMode" is set to "PROVISIONED".

```ts title="amplify/backend.ts"

const backend = defineBackend();

const  = backend.data.resources;

cfnResources.amplifyDynamoDbTables["Todo"].provisionedThroughput = ;
```

### Example - Enable point-in-time recovery for a DynamoDB table

Enable/disable [DynamoDB point-in-time recovery](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-dynamodb-table-pointintimerecoveryspecification.html) for each model table.

```ts title="amplify/backend.ts"

const backend = defineBackend();

const  = backend.data.resources;

cfnResources.amplifyDynamoDbTables['Todo'].pointInTimeRecoveryEnabled = true;
```
