---
title: Reset password
source: fragments/lib-v1/auth/native_common/password_management/common.mdx
---

# Reset password

## Reset password

In order to reset your password, use the resetPassword api - this will send a code to the user attribute configured to receive such a reset code (e.g. email or SMS):

To complete the password reset process, invoke the confirmResetPassword api with the code you were sent and the new password you want.

## Change password

A signed in user can update their password using the updatePassword api:
