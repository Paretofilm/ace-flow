---
title: Create new authentication resource
topics: ['Authentication', 'Getting Started']
primary_topic: Authentication
source: fragments/lib/auth/js/start.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication, getting-started]
---


## 🧭 Navigation
**Topics**: [[Authentication/]] • [[Getting Started/]]
**Primary**: [[Authentication/]]

---


# Create new authentication resource

## Create new authentication resource

> If you have previously enabled an Amplify category that uses Auth behind the scenes (e.g. API category), you can run the `amplify update auth` command to edit your configuration if needed.

```bash
amplify add auth
```

The CLI prompts will help you to customize your auth flow for your app. With the provided options, you can:

- Customize sign-in/registration flow
- Customize email and SMS messages for Multi-Factor Authentication
- Customize attributes for your users, e.g. name, email
- Enable 3rd party social providers, e.g. Facebook, Twitter, Google and Amazon

If you wish to federate with social providers [you will need to configure them first](/gen1/[platform]/build-a-backend/auth/add-social-provider/#social-providers-and-federation).

After configuring your Authentication options, update your backend:

```bash
amplify push
```

A configuration file called `amplifyconfiguration.json` will be copied to your configured source directory, for example `./src`.

> If your Authentication resources were created with Amplify CLI version 1.6.4 and below, you will need to manually update your project to avoid Node.js runtime issues with AWS Lambda. [Read more](/gen1/[platform]/build-a-backend/functions/configure-options/)

### Configure your application

Add Amplify to your app with `yarn` or `npm`:

```bash
yarn add aws-amplify
```

For React Native applications, install `aws-amplify-react-native` and link:

```bash
yarn add aws-amplify aws-amplify-react-native @react-native-picker/picker
react-native link amazon-cognito-identity-js # DO NOT run this when using Expo or ExpoKit
```

If you are using React Native 0.60.0+, iOS and using Auth methods e.g. `Auth.signIn`, `Auth.signUp`, etc., please run the following commands instead of linking:

```
yarn add amazon-cognito-identity-js
cd ios
pod install --repo-update
```

In your app's entry point i.e. App.js, import and load the configuration file:

```javascript
Amplify.configure(amplifyconfig);
```

## Re-use existing authentication resource

If you want to re-use an existing authentication resource from AWS (e.g. Amazon Cognito UserPool or Identity Pool), update `Amplify.configure()` method with the following information.

```javascript

Amplify.configure(,

    // OPTIONAL - customized storage object
    storage: MyStorage,

    // OPTIONAL - Manually set the authentication flow type. Default is 'USER_SRP_AUTH'
    authenticationFlowType: 'USER_PASSWORD_AUTH',

    // OPTIONAL - Manually set key value pairs that can be passed to Cognito Lambda Triggers
    clientMetadata: ,

    // OPTIONAL - Hosted UI configuration
    oauth: 
  }
});

// You can get the current config object
const currentConfig = Auth.configure();
```

### Note about OAuth configuration parameters

These settings can be found in the Cognito User Pools console under **App Integration** section

- `domain`: This can be found in the **Domain name** sub section
- `scope`: Remember to have the scope allowed on the Cognito App client, this can be found on **App client settings** sub section
- `redirectSignIn`: URL must be present on **Callback URL(s)** , check on **App client settings** sub section
- `redirectSignOut`: URL must be present on **Sign out URL(s)**, check on **App client settings** sub section
- `responseType`: Option must be enabled on the App client, look for **Allowed OAuth Flows** on **App client settings** sub section. _Authorization code grant_ is for 'code' value and _Implicit grant_ is for 'token' value.


---

## 📚 Related Topics
- [[Authentication/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/auth/js/start.mdx`