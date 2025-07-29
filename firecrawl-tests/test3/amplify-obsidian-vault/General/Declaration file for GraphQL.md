---
title: Declaration file for GraphQL
topics: ['General']
primary_topic: General
source: fragments/lib-v1/troubleshooting/js/strict-mode.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Declaration file for GraphQL

This section lists known TypeScript errors and their workarounds when [strict mode](https://www.typescriptlang.org/tsconfig#strict) is enabled on your application.

## Declaration file for GraphQL

If you see the error

```
Could not find a declaration file for module 'graphql/error/GraphQLError'` 
Could not find a declaration file for module 'graphql/language/ast'` 
```

Add a declaration file `src/types.d.ts` with the following content to resolve the error:

```ts
declare module 'graphql/language/ast' 
declare module 'graphql/error/GraphQLError' 
```

## Declaration file for aws-exports

If you see the error

```
Could not find a declaration file for module './aws-exports'. 'aws-exports.js' implicitly has an 'any' type.
```

Create a `aws-exports.d.ts` file on the same level as `aws-exports` with the following content:

```ts
declare const awsmobile: Record<string, any>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/troubleshooting/js/strict-mode.mdx`