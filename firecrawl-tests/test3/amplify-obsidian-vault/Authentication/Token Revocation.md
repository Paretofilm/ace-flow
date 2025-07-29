---
title: Token Revocation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/native_common/signout/common.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Token Revocation

Invoke the `signOut` api to sign out a user from the Auth category. You can only have one user signed in at a given time. Calling signOut without any options will delete the local cache and keychain of the user and revoke the token if enabled on Amazon Cognito User Pools. If you would like to sign out of all devices, invoke the signOut api with advanced options.

## Token Revocation

[Amazon Cognito now supports token revocation](https://aws.amazon.com/about-aws/whats-new/2021/06/amazon-cognito-now-supports-targeted-sign-out-through-refresh-token-revocation/). This means that the Cognito refresh token cannot be used anymore to generate new Access and Id Tokens.

Access and Id Tokens are short-lived (60 minutes by default but can be set from 5 minutes to 1 day). After revocation, these tokens cannot be used with Cognito User Pools anymore. However, they are still valid when used with other services like AppSync or API Gateway.

For limiting subsequent calls to these other services after invalidating tokens, we recommend lowering token expiration time for your app client in the Cognito User Pools console. If you are using the Amplify CLI this can be accessed by running `amplify console auth`.

Token revocation is enabled automatically on new Amazon Cognito User Pools, however existing User Pools must enable this feature, [using the Cognito Console or AWS CLI](https://docs.aws.amazon.com/cognito/latest/developerguide/token-revocation.html).

## Global Sign Out

Calling signout with `globalSignOut = true` will invalidate all the Cognito User Pool tokens of the signed in user. If the user is signed into a device, they won't be authorized to perform a task that requires a valid token when a global signout is called from some other device. They need to sign in again to get valid tokens.


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/native_common/signout/common.mdx`