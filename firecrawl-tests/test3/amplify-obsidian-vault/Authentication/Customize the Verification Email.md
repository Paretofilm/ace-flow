---
title: Customize the Verification Email
topics: ['Authentication', 'AI & Machine Learning']
primary_topic: Authentication
source: pages/build-a-backend/auth/customize-auth-lifecycle/email-customization/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication, ai-&-machine-learning]
---


## 🧭 Navigation
**Topics**: [[Authentication/]] • [[AI & Machine Learning/]]
**Primary**: [[Authentication/]]

---


# Customize the Verification Email

## Customize the Verification Email

By default, Amplify Auth resources are scaffolded with email as the default method for your users to sign in. When you users sign up they receive a verification email to confirm their ownership of the email they specified during sign-up. Emails such as the verification email can be customized with your app's brand identity.

To get started, change the `email` attribute of `loginWith` from `true` to an object to begin customizing its default behavior:

```diff title="amplify/auth/resource.ts"

## Customize the Invitation Email 

In some cases, you may [set up a user account on behalf of a user in the Amplify console](/[platform]/build-a-backend/auth/manage-users/with-amplify-console/). In this case, Amplify Auth will send an invitation email to the user welcoming them to your application. This email includes a brief welcome message, along with the email address they can log in with and the temporary password you've set up for them. 

If you'd like to customize that email, you can override the `userInvitation` attribute of the `email` object:

```diff title="amplify/auth/resource.ts"

Note that when using the `user` and `code` arguments of the `emailBody` function, `user` and `code` are **functions** which must be called. Failure to call them will result in an error when your sandbox deploys.


---

## 📚 Related Topics
- [[Authentication/]]
- [[AI & Machine Learning/]]

## 📖 Source
Original: `pages/build-a-backend/auth/customize-auth-lifecycle/email-customization/index.mdx`