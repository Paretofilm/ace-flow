---
title: Fetch the current user's attributes
source: fragments/lib-v1/auth/native_common/user_attributes/common.mdx
---

# Fetch the current user's attributes

## Fetch the current user's attributes

Invoke the following api to get the list of attributes assigned to the user.

## Update user attribute

Invoke the update api for creating new or updating existing user attributes.

## Verify user attribute

Some attributes require confirmation for the attribute update to complete. If the attribute need to be confirmed, the result of the above api will be `CONFIRM_ATTRIBUTE_WITH_CODE`. A confirmation code will be sent to the delivery medium mentioned in the delivery details. When the user gets the confirmation code, you can present a UI to the user to enter the code and invoke the confirm attribute api with their input:

## Send user attribute verification code

If an attribute needs to be verified while the user is authenticated, invoke the api as shown below:
