---
title: Extending Amplify outputs file
topics: ['General']
primary_topic: General
source: pages/reference/amplify_outputs/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Extending Amplify outputs file

In Amplify Gen 2, the CLI will generate an `amplify_outputs.json` file with your backend's outputs such as your Data endpoint and Auth metadata. This file -- also known as the "client configuration file" -- is used to configure the client libraries in order to interact with your backend resources. Locally, this file is created while using `ampx sandbox`. In Amplify's CI/CD, this is created automatically for you based on the current Amplify app ID and git branch.

You can also manually create this file for a specified Amplify app ID and branch, or an AWS CloudFormation stack name with [`ampx generate outputs`](/[platform]/reference/cli-commands#npx-ampx-generate-outputs).

> **Note**: 

**Note:** if you are using Expo EAS build, you will need to force commit the `amplify_outputs.json` file to local git repository before running `eas build` command. This is because the `amplify_outputs.json` file is excluded in the default `.gitignore`, and the `eas build` command will not include untracked files in the build. <b>When build completes you must remove the `amplifyconfiguration.json` file from the git repository and never commit and push it to the remote repository</b>.

</InlineFilter>

## Extending Amplify outputs file

The `amplify_outputs.json` file is not just a static artifact; it is designed to be extendable to suit the evolving needs of your application. By leveraging the `addOutput` method from your `backend`, you can programmatically add configurations. This is particularly useful for customizing outputs that are not directly exposed through the Amplify constructs or for dynamically adjusting your app's configuration in response to changes in your backend strategy.

> **Note**: 

Overriding Amplify-managed configurations on `amplify_outputs.json` is not supported.

One common scenario where extending the configuration becomes handy is when you need to add custom outputs or extend existing configurations without manual file edits.

Consider a scenario where you want to add output parameters in your `amplify_outputs.json` that specify an S3 bucket and its region that your application will use for storing files.

```ts title="amplify/backend.ts"

const backend = defineBackend();

backend.addOutput(,
});
```

In your frontend end application, you can configure Amplify as follows:

```ts title="src/index.ts"

Amplify.configure(outputs);
```

### Custom configuration

In addition to extending existing configurations, you can also add custom output parameters to your `amplify_outputs.json`. This is useful for surfacing arbitrary outputs, values from custom CDK resources, or any other information that might be necessary for your application's logic or configuration.

```ts title="amplify/backend.ts"

const backend = defineBackend();

backend.addOutput(,
});
```

In your frontend application, you can access these custom configurations as follows:

```ts title="src/index.ts"

const amplifyConfig = parseAmplifyConfig(outputs);

Amplify.configure(,
    },
  },
});
```

## Schema reference

The Amplify outputs file is defined using a JSON schema. You can find this schema in the [`aws-amplify/amplify-backend` repository](https://github.com/aws-amplify/amplify-backend/blob/main/packages/client-config/src/client-config-schema/schema_v1.json).

<pre><code tabIndex="0" style=}>

</code></pre>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/reference/amplify_outputs/index.mdx`