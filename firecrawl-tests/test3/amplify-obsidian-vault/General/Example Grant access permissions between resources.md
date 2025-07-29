---
title: Example - Grant access permissions between resources
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/overriding-resources/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Example - Grant access permissions between resources

}

> **Note**: 

By using overrides, you may create a backend that the Amplify libraries or client config is unable to interpret properly. Always test changes in a staging environment.

When defining resources, you can access some underlying [AWS Cloud Development Kit (CDK)](https://docs.aws.amazon.com/cdk/latest/guide/home.html) construct properties to modify resource configurations. This allows you to customize backend resources beyond what is offered through the `define*` functions.

Overrides are defined in the `amplify/backend.ts` file after the `defineBackend` call has been made.

```ts title="amplify/backend.ts"

const backend = defineBackend();

// overrides go here
```

The `backend` object exposes a `resources` property with objects for each of the components passed into the `defineBackend` function. Each of these resource objects exposes underlying L1 and L2 AWS CDK constructs that you can modify.

For example, here is how you can access the Cognito user pool that is created by `defineAuth` and set a custom removal policy on the resource.

```ts title="amplify/backend.ts"

const backend = defineBackend();

const userPool = backend.auth.resources.userPool;
userPool.applyRemovalPolicy(RemovalPolicy.RETAIN_ON_UPDATE_OR_DELETE);
```

Most L1 and L2 AWS CDK constructs that are used by the `define*` functions are accessible in this way.

## Example - Grant access permissions between resources

Consider the case that we want to grant a function created by `defineFunction` access to call the Cognito user pool created by `defineAuth`. For most cases it is recommended to use the [`access` property on `defineAuth`](/[platform]/build-a-backend/auth/grant-access-to-auth-resources/), however for permissions not exposed by this property, access can be accomplished with the following overrides.

```ts title="amplify/backend.ts"

const backend = defineBackend();

const userPool = backend.auth.resources.userPool;
const lambdaFunction = backend.authAuditorFunction.resources.lambda;

// grant the lambdaFunction access to list auth events for a particular user
userPool.grant(lambdaFunction, 'cognito:AdminListUserAuthEvents');

// pass the Lambda the UserPool ID so that the Lambda can use it to make SDK calls
backend.authAuditorFunction.addEnvironment('USER_POOL_ID', userPool.userPoolId);
```

## Example - Modify L1 CDK Constructs

It's possible to reach all the way down to the raw CloudFormation to mutate properties using `addPropertyOverride` on an AWS CDK construct. To edit the password policies of the Cognito user pool in `defineAuth`, you can use the following code.

```ts title="amplify/backend.ts"

const backend = defineBackend();
// extract L1 CfnUserPool resources
const  = backend.auth.resources.cfnResources;
// modify cfnUserPool policies directly
cfnUserPool.policies = ,
};
```

Note the usage of `auth.resources.cfnResources`. This property exposes [L1 CDK constructs](https://docs.aws.amazon.com/cdk/v2/guide/constructs.html#constructs_l1_using) that map one-to-one with the underlying CloudFormation properties.

The `auth.resources.cfnResources.cfnUserPool` property in the above example directly maps to the [AWS::Cognito::UserPool CloudFormation resource](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpool.html).

This is different from `auth.resources.userPool` in the first example, which is an [L2 CDK construct](https://docs.aws.amazon.com/cdk/v2/guide/constructs.html#constructs_using). These are constructs that provide a convenient interface around several related L1 constructs.

For situations where you need even more customization of your app backend, see the documentation on [custom resources](/[platform]/build-a-backend/add-aws-services/custom-resources).


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/overriding-resources/index.mdx`