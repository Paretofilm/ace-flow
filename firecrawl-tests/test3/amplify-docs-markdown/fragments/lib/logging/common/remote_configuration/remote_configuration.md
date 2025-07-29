---
title: Set up remote configuration backend resources
source: fragments/lib/logging/common/remote_configuration/remote_configuration.mdx
---

# Set up remote configuration backend resources

You can remotely configure the Amplify Logger, enabling you to make changes to your logging levels or user allow list in your deployed applications.

> **Note**: 
  The logging configurations you set remotely will overwrite the local log level
  and persist for future app sessions.

## Set up remote configuration backend resources

> **Note**: 

You can use the Amplify CLI to [add custom CDK resources](/gen1/[platform]/tools/cli/custom/cdk/).

Below is an example CDK construct that provisions the Amazon CloudWatch, AWS API Gateway, AWS Lambda, and AWS S3 bucket. The CDK construct also deploys the remote configuration file to the AWS S3 bucket which you can then update to change the configuration level or user allow list.

### Permissions

The CDK construct creates IAM policies and assigns them to the Amplify authenticated and unauthenticated roles.

1. The API Gateway endpoint can only be invoked by user with the Amplify authenticated or unauthenticated roles.
2. The AWSCloudWatch logs can only be created and sent by users with the Amplify authenticated or unauthenticated roles. The permission policy cannot be modified to be more restrictive and scoped to specific users.
3. The lambda invocation is only allowed from the provisioned AWS API Gateway resource.
4. The S3 bucket containing the `remoteloggingconstraints.json` can only be read by the Lambda execution role.

### Replace the placeholder values with your own values:

- `<log-group-name>` is the log group that logs will be sent to. Note that this CDK construct sample includes logic to create the CloudWatch log group that you may have already created in previous steps.
- `<s3-bucket-name>` is the S3 bucket that will hold the logging constraints json file that gets fetched remotely.
- `<amplify-authenticated-role-name>` and `<amplify-unauthenticated-role-name>` are Amplify roles created as part of Amplify Auth configuration via Amplify CLI.

### Resource dependencies

- `lambdaConfig` provides the location and lambda for reading from S3. An example is provided in the [lambda handler](#sample-lambda-handler) section.
- `configFileName` and `loggingConfigLocation` provides the location and file name of the log level configuration file that is deployed to S3. An example is provided in the [Creating remote configuration file](#creating-remote-configuration-file) section.

```ts

    // ** provision CloudWatch Log Group to send logs **
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

    // ** provision resource to support remote configuration (API Gateway, S3 bucket, and Lambda) **
    const <loggingConfigLocation> = 'resources/config/remoteloggingconstraints.json'
    const <lambdaConfig> = 'resources/lambda/remoteconfig.js'
    const <configFileName> = 'remoteloggingconstraints.json'

    const remoteConfigBucket = new s3.Bucket(this, 'AmplifyRemoteLogging-Bucket', );

    new BucketDeployment(this, `AmplifyRemoteLogging-BucketDeployment`, );

    const handler = new lambda.Function(this, "AmplifyRemoteLogging-Handler", 
    })

    remoteConfigBucket.grantRead(handler)

    const api = new apigateway.RestApi(this, "AmplifyRemoteLogging-API", )

    const getRemoteLoggingIntegration = new apigateway.LambdaIntegration(handler)
    const loggingConstraints = api.root.addResource('loggingconstraints')
    const getLoggingConstraints = loggingConstraints.addMethod('GET', getRemoteLoggingIntegration, )

    const apiInvokePolicy = new iam.PolicyStatement()

    authRole.addToPrincipalPolicy(apiInvokePolicy)
    unAuthRole.addToPrincipalPolicy(apiInvokePolicy)

    new cdk.CfnOutput(this, 'APIEndpoint', .execute-api.$.amazonaws.com/prod/loggingconstraints`,
    });
    new cdk.CfnOutput(this, 'CloudWatchLogGroupName', );
    new cdk.CfnOutput(this, 'CloudWatchRegion', );
  }
}
```

The API endpoint, CloudWatch log group, and region will be printed out in the terminal. You can use this information to setup the Amplify library.

### Sample Lambda handler

Below is a sample lambda that reads and returns the `remoteloggingconstraints.json` from AWS S3. Note that the configuration is cached by version via the usages of ETag in this example. This lets lambda be more efficient and save bandwidth, as it does not need to resend a full configuration file if the content was not changed.

```js
const  = require('@aws-sdk/client-s3');
const s3 = new S3Client();
const bucketName = process.env.BUCKET;
const key = process.env.KEY;
let cachedConfig = ;

exports.main = async function (event, context) );
        const s3Resp = await s3.send(command);
        await setCachedConfig(s3Resp);
      }

      if (event.headers['If-None-Match'] === cachedConfig.ETag) ;
      } else ,
          body: cachedConfig.config
        };
      }
    }
  } catch (error) ,
      body: JSON.stringify(resp)
    };
  }
};

const setCachedConfig = async (s3Resp) => ;
};
```

## Creating remote configuration file

Below is a sample remote config file that overwrites the local file in the mobile application. This file will be deployed to S3. Once deployed, you can change your application log levels by editing this file in S3.

```json
,
  "userLogLevel": 
    }
  }
}
```

## Enable remote configuration in your app

To enable Amplify Logger to fetch remote log levels, you will need to provide the API endpoint that has the log levels and the refresh interval for updating the remote configuration locally on the user's device.

  </Block>

  </Block>
</BlockSwitcher>
