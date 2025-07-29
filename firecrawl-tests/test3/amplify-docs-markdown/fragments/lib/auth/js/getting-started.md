---
title: Authentication with Amplify
source: fragments/lib/auth/js/getting-started.mdx
---

# Authentication with Amplify

## Authentication with Amplify

Amplify uses [Amazon Cognito](https://aws.amazon.com/cognito/) as the main authentication provider. Amazon Cognito is a robust user directory service that handles user registration, authentication, account recovery & other operations. In this tutorial, you'll learn how to add authentication to your application using Amazon Cognito and username/password login.

## Install Amplify Libraries

## Set Up Backend Resources

The most common way to use Authentication with Amplify is via the Amplify CLI, which allows you to create new Amazon Cognito resources or import existing ones. However, you can also use the Amplify Studio console to configure authentication or use the `Amplify.configure()` method to set up authentication with existing resources.

## Enable sign-up, sign-in, and sign-out

Follow the instructions in the [Sign in, Sign up and Sign out](/gen1/[platform]/build-a-backend/auth/enable-sign-up/) to learn about how to integrate these authentication flows in your application with the Auth APIs.

## Summary

To implement authentication flows using Amplify you can either use the Amplify UI libraries or call authentication methods directly on the `Auth` class.

`Auth` has over 30 methods including [`signUp`](/gen1/[platform]/build-a-backend/auth/enable-sign-up/#sign-up), [`signIn`](/gen1/[platform]/build-a-backend/auth/enable-sign-up/#sign-in), [`forgotPassword`](/gen1/[platform]/build-a-backend/auth/manage-user-session/#forgot-password), and [`signOut`](/gen1/[platform]/build-a-backend/auth/enable-sign-up/#sign-out) that allow you full control over all aspects of the user authentication flow.

Check out the complete API [here](https://aws-amplify.github.io/amplify-js/api/modules/aws_amplify.auth.html).
