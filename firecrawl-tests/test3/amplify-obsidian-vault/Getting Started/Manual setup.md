---
title: Manual setup
topics: ['Getting Started']
primary_topic: Getting Started
source: pages/start/manual-installation/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Manual setup

To get started with AWS Amplify we recommend that you use our [quickstart](/[platform]/start/quickstart) starter template. However, for some use cases, it may be preferable to start from scratch, either with a brand new directory or an existing frontend app. In that case we recommend to use [npm](https://npmjs.com) with [`create-amplify`](https://www.npmjs.com/package/create-amplify). 

```bash title="Terminal" showLineNumbers=
npm create amplify@latest
```

```console title="Terminal" showLineNumbers=
? Where should we create your project? (.) # press enter
```

Running this command will scaffold a lightweight Amplify project in your current project with the following files:

```text
├── amplify/
│   ├── auth/
│   │   └── resource.ts
│   ├── data/
│   │   └── resource.ts
│   ├── backend.ts
│   ├── tsconfig.json
│   └── package.json
├── node_modules/
├── .gitignore
├── package-lock.json
├── package.json
└── tsconfig.json
``` 

 If needed, you can manually install AWS Amplify without using `create-amplify` or the starter template. This guide will walk you through how to initialize your project, install dependencies, and author your first backend.

## Manual setup

First, if your frontend framework of choice doesn't have it already, create your project's `package.json` with `npm init -y`. Then, install the Amplify dependencies for building a backend:

```bash title="Terminal" showLineNumbers=
npm add --save-dev @aws-amplify/backend@latest @aws-amplify/backend-cli@latest typescript
```

> **Note**: 

**Note**: TypeScript is not a requirement but is recommended for an optimal experience.

Next, create the entry point for your backend, `amplify/backend.ts`, with the following code:

```ts

defineBackend();
```

Now you can run `npx ampx sandbox` to create your first backend!

> **Note**: 

Amplify Gen 2 requires your backend to be configured for use with [ECMAScript modules (ESM)](https://nodejs.org/api/esm.html). If you encounter the following error during `ampx sandbox`, consider modifying your `package.json` with `"type": "module"`:

```text
The current file is a CommonJS module whose imports will produce 'require' calls; however, the referenced file is an ECMAScript module and cannot be imported with 'require'. Consider writing a dynamic 'import("@aws-amplify/backend")' call instead.
```

Or, you can create a local file in the Amplify backend directory, `amplify/package.json`:

```json

```

You can use `define*` functions to _define_ your resources. For example, you can define authentication:

```ts title="amplify/auth/resource.ts"

Or define your data resource:

```ts title="amplify/data/resource.ts"

const schema = a.schema()
    .authorization(allow => [allow.publicApiKey()])
});

Each of these newly defined resources are then imported and set in the backend definition:

```ts title="amplify/backend.ts"

defineBackend();
```

## Upgrade existing projects

You can also update an existing frontend app. To upgrade existing Amplify code-first DX (Gen 2) apps, use your Node.js package manager (for example, `npm`) to update relevant backend packages:

```bash title="Terminal" showLineNumbers=
npm update @aws-amplify/backend @aws-amplify/backend-cli
```

## Next steps

We recommend the following next steps:

- [Learn more about defining authentication](/[platform]/build-a-backend/auth)
- [Learn more about defining data](/[platform]/build-a-backend/data)
- [Get started with cloud sandbox](/[platform]/deploy-and-host/sandbox-environments)
- [Deploy and host your first app](/[platform]/deploy-and-host/fullstack-branching)


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `pages/start/manual-installation/index.mdx`