---
title: SMS OTP
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/concepts/passwordless/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# SMS OTP

Amplify supports the use of passwordless authentication flows using the following methods:

- [SMS-based one-time password (SMS OTP)](#sms-otp)
- [Email-based one-time password (Email OTP)](#email-otp)
- [WebAuthn passkey](#webauthn-passkey)

Passwordless authentication removes the security risks and user friction associated with traditional passwords.

> **Note**: 

**Warning:** Passwordless configuration is currently not available in `defineAuth`. We are currently working towards enabling support for passwordless configurations. [Visit the GitHub issue to track the progress](https://github.com/aws-amplify/amplify-backend/issues/2276)

Learn how to enable passwordless sign-in flows by [overriding the Cognito UserPool to enable the sign-in methods below](/[platform]/build-a-backend/auth/modify-resources-with-cdk/#override-cognito-userpool-to-enable-passwordless-sign-in-methods).

## SMS OTP

SMS-based authentication uses phone numbers as the identifier and text messages as the verification channel. At a high level end users will perform the following steps to authenticate:

1. User enters their phone number to sign up/sign in
2. They receive a text message with a time-limited code
3. After the user enters their code they are authenticated

</InlineFilter>

</InlineFilter>

</InlineFilter>

> **Note**: 

SMS-based one-time password requires your Amazon Cognito user pool to be configured to use Amazon Simple Notification Service (SNS) to send text messages. [Learn how to configure your auth resource with SNS](/[platform]/build-a-backend/auth/moving-to-production/#sms).

[Learn more about using SMS OTP in your application code](/[platform]/build-a-backend/auth/connect-your-frontend/sign-in/#sms-otp).

## Email OTP

Email-based authentication uses email addresses for identification and verification. At a high level end users will perform the following steps to authenticate:

1. User enters their email address to sign up/sign in
2. They receive an email message with a time-limited code
3. After the users enters their code they are authenticated

</InlineFilter>

</InlineFilter>

</InlineFilter>

> **Note**: 

Email-based one-time password requires your Amazon Cognito user pool to be configured to use Amazon Simple Email Service (SES) to send email messages. [Learn how to configure your auth resource with SES](/[platform]/build-a-backend/auth/moving-to-production/#email).

[Learn more about using email OTP in your application code](/[platform]/build-a-backend/auth/connect-your-frontend/sign-in/#email-otp).

## WebAuthn Passkey

WebAuthn uses biometrics or security keys for authentication, leveraging device-specific security features. At a high level end users will perform the following steps to authenticate:

1. User chooses to register a passkey
2. Their device prompts for biometric/security key verification
3. For future logins, they'll authenticate using the same method

</InlineFilter>

You can read more about how passkeys work in the [Android developer docs](https://developer.android.com/design/ui/mobile/guides/patterns/passkeys).

> **Note**: 
Registering a passkey is supported on Android 9 (API level 28) and above.

Using passkeys with Amplify requires following these steps:

1. Deploy a Digital Asset Links file to your website granting the `get_login_creds` permission to your application. See the [Credential Manager documentation](https://developer.android.com/identity/sign-in/credential-manager#add-support-dal) for more details about this file.
1. [Configure your Amazon Cognito user pool](/[platform]/build-a-backend/auth/modify-resources-with-cdk/#override-cognito-userpool-to-enable-passwordless-sign-in-methods) with `WEB_AUTHN` as an allowed first factor, and specify your website domain as the `WebAuthnRelyingPartyID`.
1. Use the Amplify Android APIs to first [register a passkey](/[platform]/build-a-backend/auth/manage-users/manage-webauthn-credentials/#associate-webauthn-credentials) and then to [sign in with WebAuthn](/[platform]/build-a-backend/auth/connect-your-frontend/sign-in/#webauthn-passkeys).

</InlineFilter>

</InlineFilter>

[Learn more about using WebAuthn passkeys in your application code](/[platform]/build-a-backend/auth/connect-your-frontend/sign-in/#webauthn-passkeys).

### Managing credentials

Passwordless authentication with WebAuthn requires associating one or more credentials with the user's Amazon Cognito account. Amplify provides APIs that integrate with each platform's local authenticator to easily create, view, and delete these credential associations.

[Learn more about managing WebAuthn credentials](/[platform]/build-a-backend/auth/manage-users/manage-webauthn-credentials).


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/concepts/passwordless/index.mdx`