---
title: Set up REST API with Lambda Function
source: pages/build-a-backend/add-aws-services/rest-api/set-up-rest-api/index.mdx
---

# Set up REST API with Lambda Function

Using the [AWS Cloud Development Kit (AWS CDK)](https://aws.amazon.com/cdk/), you can configure Amplify Functions as resolvers for routes of a [REST API powered by Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html).

## Set up REST API with Lambda Function

Create a new directory and a resource file, `amplify/functions/api-function/resource.ts`. Then, define the function with `defineFunction`:

```ts title="amplify/functions/api-function/resource.ts"

Create the corresponding handler file, `amplify/functions/api-function/handler.ts`, file with the following contents:

```ts title="amplify/functions/api-function/handler.ts"

Use the [AWS CDK](https://docs.aws.amazon.com/cdk/latest/guide/home.html) to create an REST API resource powered by [Amazon API Gateway](https://aws.amazon.com/api-gateway/).

```ts title="amplify/backend.ts"
import  from "aws-cdk-lib/aws-apigateway";

const backend = defineBackend();

// create a new API stack
const apiStack = backend.createStack("api-stack");

// create a new REST API
const myRestApi = new RestApi(apiStack, "RestApi", ,
  defaultCorsPreflightOptions: ,
});

// create a new Lambda integration
const lambdaIntegration = new LambdaIntegration(
  backend.myApiFunction.resources.lambda
);

// create a new resource path with IAM authorization
const itemsPath = myRestApi.root.addResource("items", ,
});

// add methods you would like to create to the resource path
itemsPath.addMethod("GET", lambdaIntegration);
itemsPath.addMethod("POST", lambdaIntegration);
itemsPath.addMethod("DELETE", lambdaIntegration);
itemsPath.addMethod("PUT", lambdaIntegration);

// add a proxy resource path to the API
itemsPath.addProxy();

// create a new Cognito User Pools authorizer
const cognitoAuth = new CognitoUserPoolsAuthorizer(apiStack, "CognitoAuth", );

// create a new resource path with Cognito authorization
const booksPath = myRestApi.root.addResource("cognito-auth-path");
booksPath.addMethod("GET", lambdaIntegration, );

// create a new IAM policy to allow Invoke access to the API
const apiRestPolicy = new Policy(apiStack, "RestApiPolicy", `,
        `$`,
        `$`,
      ],
    }),
  ],
});

// attach the policy to the authenticated and unauthenticated IAM roles
backend.auth.resources.authenticatedUserIamRole.attachInlinePolicy(
  apiRestPolicy
);
backend.auth.resources.unauthenticatedUserIamRole.attachInlinePolicy(
  apiRestPolicy
);

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

Import and load the configuration file in your app. It's recommended you add the Amplify configuration step to your app's root entry point. For example `index.js` in React or `main.ts` in Angular.

```javascript title="src/main.ts"

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
