---
title: Set secrets
topics: ['General']
primary_topic: General
source: pages/deploy-and-host/fullstack-branching/secrets-and-vars/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Set secrets

}

Amplify Gen 2 offers centralized management of secrets and environment variables for all fullstack branches. Secrets allow you to securely configure environment-specific values like social sign-in keys, function environment variables, function secrets, and other sensitive data needed by your application across environments.

  In Amplify Gen 1, you need to define environment variables and secrets using the CLI and store keys in both AWS Parameter Store and a local `team-provider.json` file. We have streamlined this workflow in Amplify Gen 2 by centralizing the management of secrets and environment variables in the Amplify console.
</Accordion>

## Set secrets

You can set secrets for your fullstack branch deployments or your local dev server.

### Branch environment

You can add secrets for branch deployments in the Amplify console. From the App home page, navigate to **Hosting > Secrets**, and then choose the **Manage secrets** button. You can add a secret key or value that applies to all deployed branches or just specific branches.

Secrets are stored in AWS Systems Manager Parameter Store under the following naming conventions:

- Secrets that apply to all branches: `/amplify/shared/<app-id>/<secret-key>`
- Secrets that apply to a specific branch: `/amplify/<app-id>/<branchname>-branch-<unique-hash>/<secret-key>`

### Local environment

[comment]: <> (When editing this section, also update /gen2/deploy-and-host/sandbox-environments/features/index.md -)

> **Note**: 
  Secrets set in a sandbox do not show up in the Amplify console. You can view them in the AWS Parameter Store console.

When testing features locally, you might want to test with real secrets. You can add secrets while running the cloud sandbox with the following command:

```bash title="Terminal" showLineNumbers=
npx ampx sandbox secret set foo
? Enter secret value: ###
Done!

> npx ampx sandbox secret set bar
? Enter secret value: ###
Done!
```

## Access secrets

Once you have set a secret, you can access the values in code by calling the `secret()` function. The following example shows how to set up social sign-in with authentication in your app. Depending on your environment, Amplify will automatically load the correct secret value with no extra configuration.

```ts

## Remove secrets

> **Note**: 
When deleting branch environments or sandbox environments, you need to manually delete the secrets as well.

### Branch environment

Secrets that are used in branch deployments can be managed directly in the Amplify console. You can remove them under **Secret management** by choosing **Remove**.

![Removing application secrets in Secret management section of Amplify console.](/images/gen2/secrets-and-vars/secret-management.png)

### Local environment

To remove a secret in your local environment, run the following command in your terminal:

```bash title="Terminal" showLineNumbers=
npx ampx sandbox secret remove foo
```

## Set environment variables

> **Note**: 

Note: do not store secret values in environment variables. Environment variables values are rendered in plaintext to the build artifacts and can be accessed by anyone with access to the build artifacts or [get-app](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/amplify/get-app.html) command.

Environment variables work like key-value pairs to help manage configurable settings across different deployment environments, including development, staging, and production. Unlike secrets, which store sensitive data, environment variables are typically nonconfidential and are used for controlling application behavior in different environments. Another key difference is that environment variables are stored and managed by the Amplify managed service. You can set environment variables in the Amplify console (view the [AWS Amplify Hosting User Guide](https://docs.aws.amazon.com/amplify/latest/userguide/environment-variables.html#setting-env-vars) for detailed instructions).

## Access environment variables

You can enable access to environment variables for your fullstack branch deployments or your local dev server.

### Branch environment

You can manage your branch environment access through the Amplify console.

1. First, create an environment variable in the Amplify console (in this example, you will name it `REACT_APP_TEST_VARIABLE`)

1. Next, navigate to the Build Settings in console (or to the `amplify.yml` file) and update the build settings to pipe the environment variable into a file. Here is an example of writing it into an `.env` file:

```yml title="amplify.yml"
build:
  commands:
    // highlight-next-line
    - echo "REACT_APP_TEST_VARIABLE=$REACT_APP_TEST_VARIABLE" >> .env
    - npm run build
```

> **Note**: 
With the implementation above, the environment variable is written in a `.env` file. However, you can write it to any file depending on your platform.

- For Flutter, you can still use `.env` with an external package or generate your configuration file in Dart or JSON format.
- For Android, you can use Build Configurations or Gradle variables.
- For iOS, you can update your plist file with the necessary code or create a configuration file in JSON format.

Now the `.env` can access the environment variable through `process.env` in your client code:

```typescript
console.log('REACT_APP_TEST_VARIABLE', process.env.REACT_APP_TEST_VARIABLE);
```

### Local environment

When working on your local machine, you must manually load the sandbox's environment variables. First, add the environment variable in your `.env.local` file. Then, a library such as [`@dotenvx/dotenvx`](https://www.npmjs.com/package/@dotenvx/dotenvx) can load the environment variables, which you can then reference with `process.env`.

```bash title="Terminal" showLineNumbers=
npx dotenvx run --env-file=.env.local -- ampx sandbox
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/deploy-and-host/fullstack-branching/secrets-and-vars/index.mdx`