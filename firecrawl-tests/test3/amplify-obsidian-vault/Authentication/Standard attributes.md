---
title: Standard attributes
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/concepts/user-attributes/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Standard attributes

Amplify Auth stores user profile information in user attributes. When the default method for user sign-in, Amplify Auth will automatically configure an `email` or `phoneNumber` attribute that is required for sign-in.

To extend a user profile beyond the default `email` or `phoneNumber` attribute that is automatically configured when specified in your auth resource's `loginWith` property, you can configure attributes with the `userAttributes` property:

> **Note**: 

**Warning**: After you create your auth resource, you cannot switch an attribute between required and not required.

```ts title="amplify/auth/resource.ts"

## Standard attributes

User attributes are defined as [Cognito Standard Attributes](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html#cognito-user-pools-standard-attributes). Attributes can be configured to be _required_ for user sign-up in addition to whether the values are _mutable_. When configuring your resource to allow your users to login with `email`, an email must be specified for user sign-up and cannot be changed later. However additional attributes can be configured to be optional, and mutable after sign-up.

```ts title="amplify/auth/resource.ts"

## Custom attributes

In addition to the provided standard attributes, you can configure [Custom Attributes](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html#user-pool-settings-custom-attributes). These are attributes that are typically unique to your use case, such as a tenant ID or a user's display name. Custom attributes are identified by the `custom:` prefix:

```ts title="amplify/auth/resource.ts"

Unlike standard attributes, custom attributes cannot natively be required for sign-up, however can be codified to require some value by [validating user attributes upon sign-up with a pre sign-up trigger](/[platform]/build-a-backend/functions/examples/user-attribute-validation/).

Custom attributes can also be configured with specific data types. The following data types are supported:

- `String`
- `Number`
- `Boolean`
- `DateTime`

Shown in the snippet above, `String` and `Number` can be assigned minimum and maximum constraints. This is useful to defer simple validations to the underlying service, although does not extend to complex validations such as matching against a regular expression.

## Next steps

- [Learn how attributes are surfaced to tokens](/[platform]/build-a-backend/auth/concepts/tokens-and-credentials/)
- [Learn how to manage your user attributes](/[platform]/build-a-backend/auth/connect-your-frontend/manage-user-attributes)


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/concepts/user-attributes/index.mdx`