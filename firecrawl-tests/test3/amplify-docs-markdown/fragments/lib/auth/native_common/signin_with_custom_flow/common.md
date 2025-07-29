---
title: Prerequisites
source: fragments/lib/auth/native_common/signin_with_custom_flow/common.mdx
---

# Prerequisites

The Auth category can be configured to perform a [custom authentication flow](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-challenge.html) defined by you. The following guide shows how to setup a simple passwordless authentication flow.

## Prerequisites

## Configure Auth Category

## Register a user

The CLI flow as mentioned above requires a username and a valid email id as parameters to register a user. Invoke the following api to initiate a sign up flow.

The next step in the sign up flow is to confirm the user. A confirmation code will be sent to the email id provided during sign up. Enter the confirmation code received via email in the `confirmSignUp` call.

## Sign in a user

Implement a UI to get the username from the user. After the user enters the username you can start the sign in flow by calling the following method:

## Confirm sign in with custom challenge

Get the custom challenge (`1234` in this case) from the user and pass it to the `confirmSignin()` api.
