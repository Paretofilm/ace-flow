---
title: How do I opt out?
topics: ['General']
primary_topic: General
source: pages/reference/telemetry/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# How do I opt out?

Amplify Gen 2 collects anonymous telemetry data about general usage of the CLI. Participation is optional, and you may [opt out](#how-do-i-opt-out) by using `ampx configure telemetry disable`.

Your decision to opt out is stored for your user, meaning all Amplify apps you work with on that computer will not send telemetry data.

## How do I opt out?

You may opt out by using the `configure telemetry disable` command from the root of your Amplify app:

```bash title="Terminal" showLineNumbers=
npx ampx configure telemetry disable
```

You can opt back in to the program by running the following from the root of your Amplify app:

```bash title="Terminal" showLineNumbers=
npx ampx configure telemetry enable
```

In the event you would like to disable telemetry on a one-time basis, you can opt out by defining an environment variable:

```bash title="Terminal" showLineNumbers=


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/reference/telemetry/index.mdx`