---
title: Adding an existing CDK construct
source: pages/build-a-backend/add-aws-services/custom-resources/index.mdx
---

# Adding an existing CDK construct

}

> **Note**: 

Custom resources allow you to integrate any AWS service into an Amplify backend. You are responsible for ensuring that your custom resources are secure, adhere to best practices, and work with the resources that Amplify creates for your app.

With Amplify Gen 2, you can add custom AWS resources to an Amplify app using the [AWS Cloud Development Kit (AWS CDK)](https://docs.aws.amazon.com/cdk/latest/guide/home.html), which is installed by default as part of the [`create-amplify`](https://www.npmjs.com/package/create-amplify) workflow. The AWS CDK is an open source software development framework that defines your cloud application resources using familiar programming languages, such as TypeScript.

The AWS CDK can be used within an Amplify app to add custom resources and configurations beyond what Amplify supports out of the box. For example, a developer could use CDK to hook up a Redis cache, implement custom security rules, deploy containers on AWS Fargate, or use any other AWS service.

The infrastructure defined through the AWS CDK code is deployed along with the Amplify app backend. This provides the simplicity of Amplify combined with the flexibility of CDK for situations where you need more customization.

> **Note**: 

AWS CDK apps are composed of building blocks known as [constructs](https://docs.aws.amazon.com/cdk/v2/guide/constructs.html), which are composed together to form [stacks](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.Stack.html) and [apps](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.App.html). You can learn more in the [Concepts](https://docs.aws.amazon.com/cdk/v2/guide/core_concepts.html) section of the AWS Cloud Development Kit (AWS CDK) v2 Developer Guide.

With the Amplify code-first DX, you can add existing or custom CDK [constructs](https://docs.aws.amazon.com/cdk/v2/guide/constructs.html) to the [backend](/[platform]/how-amplify-works/concepts/#backend) of your Amplify app.

## Adding an existing CDK construct

The AWS CDK comes with [many existing constructs](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-construct-library.html) that can be directly added to your Amplify backend. For example, to add an [Amazon Simple Queue Service (Amazon SQS)](https://aws.amazon.com/sqs/) queue and an [Amazon Simple Notification Service (Amazon SNS)](https://aws.amazon.com/sns/) topic to your backend, you can add the following to your `amplify/backend.ts` file.

```ts title="amplify/backend.ts"

const backend = defineBackend();

const customResourceStack = backend.createStack('MyCustomResources');

new sqs.Queue(customResourceStack, 'CustomQueue');
new sns.Topic(customResourceStack, 'CustomTopic');
```

Note the use of `backend.createStack()`. This method instructs the backend to create a new CloudFormation Stack for your custom resources to live in. You can create multiple custom stacks and you can place multiple resources in any given stack.

## Defining a CDK construct

> **Note**: 

Constructs are the basic building blocks of AWS CDK apps. A construct represents a "cloud component" and encapsulates everything AWS CloudFormation needs to create the component. [Read more](https://docs.aws.amazon.com/cdk/v2/guide/constructs.html).

As shown above, you can use the existing AWS CDK constructs directly in an Amplify backend. However, you may find yourself repeating some patterns of common constructs. Custom constructs allow you to encapsulate common patterns into reusable components. This helps you implement best practices, accelerate development, and maintain consistency across applications.

A common use case is creating a custom notification construct that combines a Lambda function with Amazon SNS and Amazon Simple Email Service (Amazon SES).

This AWS CDK construct implements a decoupled notification system using Amazon SNS and Lambda. It allows publishing notification messages to an SNS topic from one Lambda function, and processing those messages asynchronously using a separate Lambda subscribed to the topic.

The key components are:

- An Amazon SNS topic to receive notification messages
- A Lambda function to publish messages to the Amazon SNS topic
- A second Lambda subscribed to the topic that processes the messages and sends emails through Amazon SES

The publisher Lambda allows publishing a message containing the email subject, body text, and recipient address. The emailer Lambda retrieves messages from the SNS topic and handles sending the actual emails.

The `CustomNotifications` custom CDK construct can be defined as follows:

```ts title="amplify/custom/CustomNotifications/resource.ts"

// message to publish

type CustomNotificationsProps = ;

    const  = props;

    // Create SNS topic
    this.topic = new sns.Topic(this, 'NotificationTopic');

    // Create Lambda to publish messages to SNS topic
    const publisher = new lambda.NodejsFunction(this, 'Publisher', ,
      runtime: Runtime.NODEJS_18_X
    });

    // Create Lambda to process messages from SNS topic
    const emailer = new lambda.NodejsFunction(this, 'Emailer', ,
      runtime: Runtime.NODEJS_18_X
    });

    // Subscribe emailer Lambda to SNS topic
    this.topic.addSubscription(new subscriptions.LambdaSubscription(emailer));

    // Allow publisher to publish to SNS topic
    this.topic.grantPublish(publisher);
  }
}
```

The Lambda function code for the `Publisher` is:

```ts title="amplify/custom/CustomNotifications/publisher.ts"
// amplify/custom/CustomNotifications/publisher.ts

const client = new SNSClient();

// define the handler that will publish messages to the SNS Topic

The Lambda function code for the `Emailer` is:

```ts title="amplify/custom/CustomNotifications/emailer.ts"
// amplify/custom/CustomNotifications/emailer.ts

const sesClient = new SESClient();

// define the handler to process messages from the SNS topic and send via SES

    // send the message via email
    await sendEmail(message);
  }
};

const sendEmail = async (message: Message) =>  = message;

  const command = new SendEmailCommand(,
    Message: 
      },
      Subject: 
    }
  });

  try : $`);
  } catch (error) : $`);
    throw new Error(`Failed to send email to $`, );
  }
};
```

The `CustomNotifications` CDK construct can then be added to the Amplify `backend` one or more times, with different properties for each instance.

```ts title="amplify/backend.ts"
// amplify/backend.ts

const backend = defineBackend();

const customNotifications = new CustomNotifications(
  backend.createStack('CustomNotifications'),
  'CustomNotifications',
  
);

backend.addOutput(,
});
```

## Community CDK resources

The [Construct Hub](https://constructs.dev/) is a community-driven catalog of reusable infrastructure components. It is a place for developers to discover and share reusable patterns for AWS CDK, maintained by AWS.

In addition, the [example projects using the AWS CDK](https://github.com/aws-samples/aws-cdk-examples) repository contains a number of examples of reusable CDK constructs.

You can use these resources to create custom CDK constructs that can be used in your Amplify app.
