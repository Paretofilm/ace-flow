---
title: Set up HTTP API with Lambda Function
source: pages/build-a-backend/add-aws-services/rest-api/set-up-http-api/index.mdx
---

# Set up HTTP API with Lambda Function

Using the [AWS Cloud Development Kit (AWS CDK)](https://aws.amazon.com/cdk/), you can configure Amplify Functions as resolvers for routes of an [HTTP API powered by Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api.html).

## Set up HTTP API with Lambda Function

To get started, create a new directory and a resource file, `amplify/functions/api-function/resource.ts`. Then, define the function with `defineFunction`:

```ts title="amplify/functions/api-function/resource.ts"

Then, create the corresponding handler file, `amplify/functions/api-function/handler.ts`, file with the following contents:

```ts title="amplify/functions/api-function/handler.ts"

Next, using the AWS CDK, create an HTTP API in your backend file:

```ts title="amplify/backend.ts"
import  from "aws-cdk-lib/aws-apigatewayv2";
import  from "aws-cdk-lib/aws-apigatewayv2-authorizers";

const backend = defineBackend();

// create a new API stack
const apiStack = backend.createStack("api-stack");

// create a IAM authorizer
const iamAuthorizer = new HttpIamAuthorizer();

// create a User Pool authorizer
const userPoolAuthorizer = new HttpUserPoolAuthorizer(
  "userPoolAuth",
  backend.auth.resources.userPool,
  
);

// create a new HTTP Lambda integration
const httpLambdaIntegration = new HttpLambdaIntegration(
  "LambdaIntegration",
  backend.myApiFunction.resources.lambda
);

// create a new HTTP API with IAM as default authorizer
const httpApi = new HttpApi(apiStack, "HttpApi", ,
  createDefaultStage: true,
});

// add routes to the API with a IAM authorizer and different methods
httpApi.addRoutes();

// add a proxy resource path to the API
httpApi.addRoutes(",
  methods: [HttpMethod.ANY],
  integration: httpLambdaIntegration,
  authorizer: iamAuthorizer,
});

// add the options method to the route
httpApi.addRoutes(",
  methods: [HttpMethod.OPTIONS],
  integration: httpLambdaIntegration,
});

// add route to the API with a User Pool authorizer
httpApi.addRoutes();

// create a new IAM policy to allow Invoke access to the API
const apiPolicy = new Policy(apiStack, "ApiPolicy", `,
        `$`,
        `$`,
      ],
    }),
  ],
});

// attach the policy to the authenticated and unauthenticated IAM roles
backend.auth.resources.authenticatedUserIamRole.attachInlinePolicy(apiPolicy);
backend.auth.resources.unauthenticatedUserIamRole.attachInlinePolicy(apiPolicy);

// add outputs to the configuration file
backend.addOutput(,
    },
  },
});
```

## Install Amplify Libraries

Use the package manager of your choice to install the Amplify JavaScript library. For example, with `npm`:

```bash title="Terminal" showLineNumbers=
npm add aws-amplify
```
</InlineFilter>

Use the package manager of your choice to install the Amplify JavaScript library. For example, with `npm`:

  `@aws-amplify/react-native` requires a minimum iOS deployment target of `13.0` if you are using `react-native` version less than or equal to `0.72`. Open the _Podfile_ located in the _ios_ directory and update the `target` value:

  ```diff
   - platform :ios, min_ios_version_supported
   + platform :ios, 13.0
   ```

</Accordion>

```bash title="Terminal" showLineNumbers=
npm add aws-amplify @aws-amplify/react-native
```

</InlineFilter>

## Initialize Amplify API

To initialize the Amplify API category you need to configure Amplify with `Amplify.configure()`.

Import and load the configuration file in your app. It's recommended you add the Amplify configuration step to your app's root entry point. For example `src/main.ts`:

```ts title="src/main.ts"

const amplifyConfig = parseAmplifyConfig(outputs);

Amplify.configure(
  ,
  },
  ,
      }
    },
  }
);
```
</InlineFilter>

```tsx title="pages/_app.tsx"

const amplifyConfig = parseAmplifyConfig(outputs);

Amplify.configure(
  ,
  },
  ,
      }
    }
  }
);
```
</InlineFilter>

> **Note**: 

Make sure you call `Amplify.configure` as early as possible in your application’s life-cycle. A missing configuration or `NoCredentials` error is thrown if `Amplify.configure` has not been called before other Amplify JavaScript APIs. Review the [Library Not Configured Troubleshooting guide](/[platform]/build-a-backend/troubleshooting/library-not-configured/) for possible causes of this issue.

</InlineFilter>
