---
title: Interactions with AWS
source: fragments/lib-v1/interactions/js/getting-started.mdx
---

# Interactions with AWS

AWS Amplify Interactions category enables AI-powered chatbots in your web or mobile apps. You can use _Interactions_ to configure your backend chatbot provider and to integrate a chatbot UI into your app with just a single line of code.

## Interactions with AWS

AWS Amplify implements [Amazon Lex](https://aws.amazon.com/lex) as the default chatbots service. Amazon Lex supports creating conversational bots with the same deep learning technologies that power Amazon Alexa.

## Create new chatbot

> Prerequisite: [Install and configure the Amplify CLI](/gen1/[platform]/tools/cli/start/set-up-cli/)

Run the following command in your project's root folder:

```bash
amplify add interactions
```

> **Note**: 

Adding interactions from the CLI only allows you to create a Lex V1 bot. If you want to create a Lex V2 bot, you can do so following the [instructions here](#lex-v2-bot).

The CLI will lead you through the steps to specify the chatbot to be created.

You can choose to start from a sample chatbot or start from scratch. If you choose to start from scratch, the CLI will prompt you with a series of questions to set the intents and slots for the chatbot.

You are allowed to run the `amplify add interactions` command multiple times to add multiple chatbots into your project.

> **Note**: 
  The Interactions category utilizes the Authentication category behind the
  scenes to authorize your app to send analytics events.

The `add` command automatically creates a backend configuration locally. To update your backend in the cloud, run:

```bash
amplify push
```

Upon successful execution of the push command, a configuration file called `aws-exports.js` will be copied to your configured source directory, for example `./src`.

> If your Interactions resources were created with Amplify CLI version 1.6.4 and below, you will need to manually update your project to avoid Node.js runtime issues with AWS Lambda. [Read more](/gen1/[platform]/build-a-backend/functions/configure-options/)

## Manual setup

### Lex V1 bot

You can create Amazon Lex V1 chatbot in Amazon Lex console. To create your bot, follow the steps shown in [Amazon Lex V1 Developer Guide](https://docs.aws.amazon.com/lex/latest/dg/getting-started.html).

![Interactions](/images/interactions_lex_console_edit_bot.jpg)

With manual setup, you need to provide your auth credentials and bot details to configure your app:

```javascript

Amplify.configure(,
  Interactions: 
    }
  }
});
```

### Lex V2 bot

You can create Amazon Lex V2 chatbot in Amazon Lex console. To create your bot, follow the steps shown in [Amazon Lex V2 Developer Guide](https://docs.aws.amazon.com/lexv2/latest/dg/getting-started.html).

![Interactions](/images/interactions_lex_v2_console_edit_bot.png)

With manual setup, you need to provide your auth credentials and bot details to configure your app:

```javascript

Amplify.addPluggable(new AWSLexV2Provider());

const interactionsConfig = ,
  Interactions: ,
    }
  }
}

Amplify.configure(interactionsConfig);
```

## Configure frontend
