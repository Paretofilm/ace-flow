---
title: Interactions with AWS
source: pages/build-a-backend/add-aws-services/interactions/set-up-interactions/index.mdx
---

# Interactions with AWS

AWS Amplify Interactions enables AI-powered chatbots in your web or mobile apps. You can use _Interactions_ to configure your backend chatbot provider and to integrate a chatbot UI into your app with just a single line of code.

## Interactions with AWS

AWS Amplify supports [Amazon Lex](https://aws.amazon.com/lex) as the default chatbots service. Amazon Lex supports creating conversational bots with the same deep learning technologies that power Amazon Alexa.

## Setup AWS LexV2 bot

You can create an Amazon Lex V2 chatbot in Amazon Lex console. To create your bot, follow the steps shown in [Amazon Lex V2 Developer Guide](https://docs.aws.amazon.com/lexv2/latest/dg/getting-started.html).

![Amazon Lex intents page with a bot called 'BookTripNew', showing a list of two created intents 'BookCar' and 'FallbackIntent' that your users want to accomplish like booking a car](/images/interactions_lex_v2_console_edit_bot.png)

## Update your IAM Policy

Amazon Lex service requires an IAM policy in order to use the interactions APIs (_remember to replace the template with real value_):

```json

  ]
}
```

## Configure your frontend

Add the aws-amplify and interactions package to your project:

```bash title="Terminal" showLineNumbers= 
npm add --save @aws-amplify/interactions aws-amplify
```
</InlineFilter>

### Install Amplify and its dependencies

  `@aws-amplify/react-native` requires a minimum iOS deployment target of `13.0` if you are using `react-native` version less than or equal to `0.72`. Open the _Podfile_ located in the _ios_ directory and update the `target` value:

  ```diff
   - platform :ios, min_ios_version_supported
   + platform :ios, 13.0
   ```

</Accordion>

```bash title="Terminal" showLineNumbers= 
npm add aws-amplify \
  @aws-amplify/react-native \
  @aws-amplify/interactions \
  @react-native-community/netinfo \
  @react-native-async-storage/async-storage \
  react-native-get-random-values
```
</InlineFilter>

> **Note**: 

Make sure that the `@aws-amplify/interactions` package has the same version number as the `aws-amplify` package in your `package.json` file.

### Configure Amplify
Import and load the configuration file in your app. It's recommended you add the Amplify configuration step to your app's root entry point. For example, **App.js** (Expo) or **index.js** (React Native CLI).

```javascript title="src/index.js"

const amplifyConfig = parseAmplifyConfig(outputs);

Amplify.configure(
    }
  }
});
```

You need to add the `crypto.getRandomValues` polyfills to your application's entry point file (in most React Native apps this will be the top level index.js).

```js title="src/index.js"
import 'react-native-get-random-values';

AppRegistry.registerComponent(appName, () => App);
```
</InlineFilter>

> **Note**: 

Make sure you call `Amplify.configure` as early as possible in your application’s life-cycle. A missing configuration or `NoCredentials` error is thrown if `Amplify.configure` has not been called before other Amplify JavaScript APIs. Review the [Library Not Configured Troubleshooting guide](/[platform]/build-a-backend/troubleshooting/library-not-configured/) for possible causes of this issue.

## Known Issues

You may encounter the following error when starting the bundler:

> Error: Unable to resolve module stream from /path/to/node_modules/@aws-sdk/...

This is a [known issue](https://github.com/aws/aws-sdk-js-v3/issues/4877). Please follow [the steps](https://github.com/aws/aws-sdk-js-v3/issues/4877#issuecomment-1656007484) 
outlined in the linked issue to resolve the error.

</InlineFilter>
