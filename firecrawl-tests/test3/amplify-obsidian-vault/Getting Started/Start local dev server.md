---
title: Start local dev server
topics: ['Getting Started']
primary_topic: Getting Started
source: fragments/gen2/quickstart/create-amplify.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, getting-started]
---


## 🧭 Navigation
**Topics**: [[Getting Started/]]
**Primary**: [[Getting Started/]]

---


# Start local dev server

The easiest way to get started with AWS Amplify is through npm with `create-amplify`.

```bash showLineNumbers=
npm create amplify@latest
```

```console showLineNumbers=
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
│   └── package.json
├── node_modules/
├── .gitignore
├── package-lock.json
├── package.json
└── tsconfig.json
```

## Start local dev server

Let's start a local dev server for your app development. For the frontend, run `npm run dev` to spin up a `localhost` dev server with the default Next.js template.

```bash showLineNumbers=
npm run dev
```

> **Note**: 

Now [configure your AWS account to use Amplify](/[platform]/start/account-setup/). Note: If you already have an AWS profile with credentials on your local machine, and you have configured the corresponding AWS profile with the **AmplifyBackendDeployFullAccess** permission policy, you can skip this step.

For the backend, we're going to start a cloud sandbox environment. Amplify gives every developer a personal cloud sandbox environment that provides isolated development spaces to rapidly build, test, and iterate. When you're working with a team, each developer will have their own personal cloud sandbox. In a new terminal window, run the following command:

```bash showLineNumbers=
npx ampx sandbox
```
> **Note**: Do not use cloud sandbox environments in production.

You should now have these two commands running concurrently in different terminal windows.


---

## 📚 Related Topics
- [[Getting Started/]]

## 📖 Source
Original: `fragments/gen2/quickstart/create-amplify.mdx`