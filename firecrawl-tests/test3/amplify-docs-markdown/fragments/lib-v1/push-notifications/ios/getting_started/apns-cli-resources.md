---
title: Documentation
source: fragments/lib-v1/push-notifications/ios/getting_started/apns-cli-resources.mdx
---

# Documentation

Choose _APNS_ when promoted:

```console
? Choose the push notification channel to enable.
❯ APNS |  Apple Push Notifications
  FCM  | » Firebase Push Notifications
  In-App Messaging
  Email
  SMS
```

Follow the setup prompts: 

> **Note**: 

Authorizing the app for analytics events is crucial for unauthenticated users, particularly if you intend to configure Amplify or send push notifications to your users before their authentication. If authorization is declined, please keep in mind that updating the Cognito user pool would become necessary, and any subsequent updates could potentially result in the deletion of the current user data.

```console
? Provide your pinpoint resource name: › [pinpoint_resource_name]
? Apps need authorization to send analytics events. Do you want to allow guests
 and unauthenticated users to send analytics events? (we recommend you allow this 
 when getting started) (Y/n)
```

Choose _Certificate_ when promoted:

```console
? Choose authentication method used for APNs
> Certificate
Key
```

The CLI will prompt for your _p12 certificate path_, enter a path relative to the location where you ran the command.

> **Note**: 

Note: If you receive this error:
```console 
🛑 Command failed: openssl pkcs12 -in [path_to_your_cert].p12 -out [output_path].pem -nodes -passin pass:
Error outputting keys and certificates
```

Please try using LibreSSL 3.3.6 instead of OpenSSL. [See issue #12969](https://github.com/aws-amplify/amplify-cli/issues/12969)
