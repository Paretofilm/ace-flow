---
title: Create auth challenge trigger
source: pages/build-a-backend/functions/examples/custom-auth-flows/index.mdx
---

# Create auth challenge trigger

Secure Remote Password (SRP) is a cryptographic protocol enabling password-based authentication without transmitting the password over the network. In Amazon Cognito custom authentication flows, CUSTOM_WITH_SRP incorporates SRP steps for enhanced security, while CUSTOM_WITHOUT_SRP bypasses these for a simpler process. The choice between them depends on your application's security needs and performance requirements. 
This guide demonstrates how to implement both types of custom authentication flows using AWS Amplify with Lambda triggers.

You can use `defineAuth` and `defineFunction` to create an auth experience that uses `CUSTOM_WITH_SRP` and `CUSTOM_WITHOUT_SRP`. This can be accomplished by leveraging [Amazon Cognito's feature to define a custom auth challenge](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow.html#Custom-authentication-flow-and-challenges) and 3 triggers:

1. [Create auth challenge](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-create-auth-challenge.html)
2. [Define auth challenge](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-define-auth-challenge.html)
3. [Verify auth challenge response](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-verify-auth-challenge-response.html) 

To get started, install the `aws-lambda` package, which is used to define the handler type.

```bash title="Terminal" showLineNumbers=
npm add --save-dev @types/aws-lambda
```

## Create auth challenge trigger

To get started, create the first of the three triggers, `create-auth-challenge`. This is the trigger responsible for creating the reCAPTCHA challenge after a password is verified.

```ts title="amplify/auth/create-auth-challenge/resource.ts"

After creating the resource file, create the handler with the following contents:

```ts title="amplify/auth/create-auth-challenge/handler.ts"

    event.response.challengeMetadata = "TOKEN_CHECK";

    event.response.publicChallengeParameters = ;

    event.response.privateChallengeParameters = ;
    event.response.privateChallengeParameters.answer = challengeCode;
  }
  return event;
};
```

## Define auth challenge trigger

Next, you will want to create the trigger responsible for _defining_ the auth challenge flow, `define-auth-challenge`.

```ts title="amplify/auth/define-auth-challenge/resource.ts"

After creating the resource file, create the handler with the following contents if you are using `CUSTOM_WITHOUT_SRP`:

```ts title="amplify/auth/define-auth-challenge/handler.ts"

  return event;
};
```

Or if you are using `CUSTOM_WITH_SRP`:

```ts title="amplify/auth/define-auth-challenge/handler.ts"

  return event;
};
```

## Verify auth challenge response trigger

Lastly, create the trigger responsible for _verifying_ the challenge response. For the purpose of this example, the verification check will always return true.

```ts title="amplify/auth/verify-auth-challenge-response/resource.ts"

After creating the resource file, create the handler with the following contents:

```ts title="amplify/auth/verify-auth-challenge-response/handler.ts"

```

## Configure auth resource

Finally, import and set the three triggers on your auth resource:

```ts title="amplify/auth/resource.ts"

/**
 * Define and configure your auth resource
 * @see https://docs.amplify.aws/gen2/build-a-backend/auth
 */

After deploying the changes, whenever a user attempts to sign in with `CUSTOM_WITH_SRP` or `CUSTOM_WITHOUT_SRP`, the Lambda challenges will be triggered.
