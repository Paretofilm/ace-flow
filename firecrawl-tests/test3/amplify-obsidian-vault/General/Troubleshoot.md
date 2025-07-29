---
title: Troubleshoot
topics: ['General']
primary_topic: General
source: pages/build-a-backend/troubleshooting/cannot-find-module-amplify-env/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Troubleshoot

When deploying a Amplify Gen 2 app, you may encounter the error message `Cannot find module $amplify/env/<function-name>` in your frontend build on Amplify Console. This error occurs when your framework `tsconfig.json` configuration picks up the `amplify` directory and tries to resolve it as a module. This module is a placeholder for environment variables that are injected at build time by Amplify. To resolve this error, you need to exclude the `amplify` directory.

To exclude the `amplify` directory in your `tsconfig.json`, add the following lines to the `exclude` section:

```ts title='tsconfig.json'

```

Amplify will perform type-checking on sandbox and pipeline-deploy using the tsconfig local to the Amplify backend `amplify/tsconfig.json`. If you'd like to extend your base configuration you can add it to the localized tsconfig.

Alternatively, if you work within a monorepo you can move your backend to its own package and export the Schema and outputs for ease of sharing with your other apps. For example, in your backend package's `package.json`

```json title='package.json'

}
```

</InlineFilter>

When deploying a Amplify Gen 2 app, you may encounter the error message `Cannot find module $amplify/env/<function-name>` in your frontend build on Amplify Console. This error occurs when your framework `tsconfig.json` configuration picks up the `amplify` directory and tries to resolve it as a module. This module is a placeholder for environment variables that are injected at build time by Amplify. To resolve this error, you will need to include the `resource.ts` files in your `tsconfig.app.json` file.

For example, if you have a `function` resource dependent on the `data` resource, you will need to include both the `resource.ts` files in your `tsconfig.app.json` file.

```ts title='tsconfig.app.json'

```

</InlineFilter>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/troubleshooting/cannot-find-module-amplify-env/index.mdx`