---
title: Using natural language
topics: ['Functions']
primary_topic: Functions
source: pages/build-a-backend/functions/scheduling-functions/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, functions]
---


## 🧭 Navigation
**Topics**: [[Functions/]]
**Primary**: [[Functions/]]

---


# Using natural language

Amplify offers the ability to schedule Functions to run on specific intervals using natural language or [cron expressions](https://en.wikipedia.org/wiki/Cron). To get started, specify the `schedule` property in `defineFunction`:

> **Note**: 

**Note:** Configuring the schedule in `defineFunction` is not supported for [Custom Functions](/[platform]/build-a-backend/functions/custom-functions/).

```ts title="amplify/jobs/weekly-digest/resource.ts"

Function schedules are powered by [Amazon EventBridge rules](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-rules.html), and can be leveraged to address use cases such as:

- generating a "front page" of top-performing posts
- generating a weekly digest of top-performing posts
- generating a monthly report of warehouse inventory

Their handlers can be typed using the `EventBridgeHandler` type:

```ts title="amplify/jobs/weekly-digest/handler.ts"

> **Note**: 

**Note**: AWS Lambda types can be installed with

```bash title="Terminal" showLineNumbers=
npm add --save-dev @types/aws-lambda
```

Schedules can either be a single interval, or multiple intervals:

```ts title="amplify/jobs/generate-report/resource.ts"

Schedules can also be defined to execute using minutes or hours with a shorthand syntax:

```ts title="amplify/jobs/drink-some-water/resource.ts"

Or combined to create complex schedules:

```ts title="amplify/jobs/remind-me/resource.ts"

## Using natural language

Schedules can be written using natural language, using terms you use every day. Amplify supports the following time periods:

- `day` will always start at midnight
- `week` will always start on Sunday at midnight
- `month` will always start on the first of the month at midnight
- `year` will always start on the first of the year at midnight
- `m` for minutes
- `h` for hours

Natural language expressions are prefixed with "every":

```ts title="amplify/jobs/drink-some-water/resource.ts"

## Using cron expressions

Schedules can be written using cron expressions.

```ts title="amplify/jobs/remind-me/resource.ts"


---

## 📚 Related Topics
- [[Functions/]]

## 📖 Source
Original: `pages/build-a-backend/functions/scheduling-functions/index.mdx`