---
title: Goal
source: fragments/lib-v1/auth/native_common/getting_started/common.mdx
---

# Goal

The Amplify Auth category provides an interface for authenticating a user. Behind the scenes, it provides the necessary authorization to the other Amplify categories. It comes with default, built-in support for [Amazon Cognito](https://aws.amazon.com/cognito) User Pool and Identity Pool. The Amplify CLI helps you create and configure the auth category with an authentication provider.

## Goal

To setup and configure your application with Amplify Auth and go through a simple api to check the current auth session.

## Prerequisites

## Install Amplify Libraries

## Set Up Backend Resources

The most common way to use Authentication with Amplify is via the Amplify CLI, which allows you to create new Amazon Cognito resources or import existing ones. However, you can also use the Amplify Studio console to configure authentication or use the `Amplify.configure()` method to set up authentication with existing resources.

## Initialize Amplify Auth

## Check the current auth session

You can now check the current auth session.

The `isSignedIn` property of the `authSession` will be false since you haven't signed in to the category yet.

## Next Steps

Congratulations! You've successfully setup AWS Cognito Auth plugin. Check out the following links to see other Amplify Auth use cases:

- [Authenticate a user with username password](/gen1/[platform]/prev/build-a-backend/auth/enable-sign-in/)
- [Authenticate a user using a web UI](/gen1/[platform]/prev/build-a-backend/auth/sign-in-with-web-ui/)
- [Authenticate a user with another auth provider](/gen1/[platform]/prev/build-a-backend/auth/add-social-provider/)
