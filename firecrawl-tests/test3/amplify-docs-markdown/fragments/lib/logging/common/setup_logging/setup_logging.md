---
title: Prerequisites
source: fragments/lib/logging/common/setup_logging/setup_logging.mdx
---

# Prerequisites

The Amplify Logger enables you to troubleshoot and debug issues with your apps, to help you provide the best experience for your customers. You can log messages for errors by the Amplify library and add custom logs as well and send them to Amazon CloudWatch. With the Amplify Logger, you also can remotely change your logging configuration to adjust your logging levels, or add an allow list of customer IDs to help you detect issues more granularly for your apps in production.

## Prerequisites

## Provision backend resources

> **Note**: 

You can use the Amplify CLI to [add custom CDK resources](/gen1/[platform]/tools/cli/custom/cdk/).

You will need to create a log group in Amazon CloudWatch to send logs to. You can create and provision a log group by going through the AWS Console and creating your log group manually or using Amplify CLI and AWS CDK to provision and deploy the AWS resources.

Below is a sample CDK construct to create the Amazon CloudWatch log group as well as creating and assigning the permission policies to Amplify roles.

The `<log-group-name>` and `<region>` configured in the CDK construct will be used later to initialize the Amplify Logger plugin.

### Replace the placeholder values with your own values:

- `<log-group-name>` is the log group that logs will be sent to. Note that this CDK construct sample includes logic to create the CloudWatch log group that you may have already created in previous steps.
- `<amplify-authenticated-role-name>` and `<amplify-unauthenticated-role-name>` are Amplify roles created as part of Amplify Auth configuration via Amplify CLI.

```ts

    const region = cdk.Stack.of(this).region
    const account = cdk.Stack.of(this).account
    const logGroupName = <log-group-name>
    const authRoleName = <amplify-authenticated-role-name>
    const unAuthRoleName = <amplify-unauthenticated-role-name>

    new logs.LogGroup(this, 'Log Group', )

    const authRole = iam.Role.fromRoleName(this, "Auth-Role", authRoleName)
    const unAuthRole = iam.Role.fromRoleName(this, "UnAuth-Role", unAuthRoleName)
    const logResource = `arn:aws:logs:$:$:log-group:$:log-stream:*`
    const logIAMPolicy = new iam.PolicyStatement()

    authRole.addToPrincipalPolicy(logIAMPolicy)
    unAuthRole.addToPrincipalPolicy(logIAMPolicy)

    new cdk.CfnOutput(this, 'CloudWatchLogGroupName', );
    new cdk.CfnOutput(this, 'CloudWatchRegion', );
  }
}
```

The `<log-group-name>` and `<region>` will be printed out in the in the terminal. You can use this information to setup the Amplify library in the next section.

## Install Amplify Libraries

Add the following dependencies to your `build.gradle (Module :app)` file and click "Sync Now" when prompted:

```
android 
}

dependencies 
```

> **Note**: 

**Note:** The CloudWatch plugin has a dependency on Cognito Auth.

</InlineFilter>

## Initialize Amplify Logging

In this section, we will initialize and setup the Amplify library. The Logger can be configured via a configuration file or in code when your app is initializing.

  </Block>

</Block>

</BlockSwitcher>
