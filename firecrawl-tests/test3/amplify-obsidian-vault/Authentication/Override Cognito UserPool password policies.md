---
title: Override Cognito UserPool password policies
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/modify-resources-with-cdk/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Override Cognito UserPool password policies

Amplify Auth provides sensible defaults for the underlying Amazon Cognito resource definitions. You can customize your authentication resource to enable it to behave exactly as needed for your use cases by modifying it directly using [AWS Cloud Development Kit (CDK)](https://aws.amazon.com/cdk/)

## Override Cognito UserPool password policies

You can override the password policy by using the L1 `cfnUserPool` construct and adding a `addPropertyOverride`.

```ts title="amplify/backend.ts"

const backend = defineBackend();
// extract L1 CfnUserPool resources
const  = backend.auth.resources.cfnResources;
// modify cfnUserPool policies directly
cfnUserPool.policies = ,
};
```

## Override Cognito UserPool multi-factor authentication options

While Email MFA is not yet supported with `defineAuth`, this feature can be enabled by modifying the underlying CDK construct.

Start by ensuring your `defineAuth` resource configuration includes a compatible account recovery option and a custom SES sender.

```ts title="amplify/auth/resource.ts"

/**
 * Define and configure your auth resource
 * @see https://docs.amplify.aws/gen2/build-a-backend/auth
 */

Next, extend the underlying CDK construct by activating [Amazon Cognito's Advanced Security Features (ASF)](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pool-settings-advanced-security.html) and add `EMAIL_OTP` to the enabled MFA options.

```ts title="amplify/backend.ts"

const backend = defineBackend()

const  = backend.auth.resources.cfnResources

// enable ASF
cfnUserPool.userPoolAddOns = 

// add email mfa
// https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-cognito-userpool.html#cfn-cognito-userpool-enabledmfas
cfnUserPool.enabledMfas = [...(cfnUserPool.enabledMfas || []), "EMAIL_OTP"]
```

### Override Cognito UserPool to enable passwordless sign-in methods

You can modify the underlying Cognito user pool resource to enable sign in with passwordless methods. [Learn more about passwordless sign-in methods](/[platform]/build-a-backend/auth/concepts/passwordless/). 

You can also read more about how passwordless authentication flows are implemented in the [Cognito documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow-methods.html).

```ts title="amplify/backend.ts"

const backend = defineBackend()

const  = backend.auth.resources;
const  = cfnResources;

// Specify which authentication factors you want to allow with USER_AUTH
cfnUserPool.addPropertyOverride(
	'Policies.SignInPolicy.AllowedFirstAuthFactors',
	['PASSWORD', 'WEB_AUTHN', 'EMAIL_OTP', 'SMS_OTP']
);

// The USER_AUTH flow is used for passwordless sign in
cfnUserPoolClient.explicitAuthFlows = [
	'ALLOW_REFRESH_TOKEN_AUTH',
	'ALLOW_USER_AUTH'
];

/* Needed for WebAuthn */
// The WebAuthnRelyingPartyID is the domain of your relying party, e.g. "example.domain.com"
cfnUserPool.addPropertyOverride('WebAuthnRelyingPartyID', '');
cfnUserPool.addPropertyOverride('WebAuthnUserVerification', 'preferred');
```
</InlineFilter>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/modify-resources-with-cdk/index.mdx`