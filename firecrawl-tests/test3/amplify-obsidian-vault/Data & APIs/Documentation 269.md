---
title: Documentation
topics: ['Data & APIs', 'Getting Started']
primary_topic: Data & APIs
source: fragments/lib-v1/datastore/js/getting-started/40_codegen.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, getting-started]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[Getting Started/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

When using `npx amplify-app`, an npm script named `amplify-modelgen` should be added to your `package.json`. You can **generate model code** with the following command.

```console
npm run amplify-modelgen
```

The following files will be generated.

```
src/
|_ models/
   |_ index.d.ts
   |_ index.js
   |_ schema.d.ts
   |_ schema.js
```

> **Note**: 

The `.d.ts` are [TypeScript declaration files](https://www.typescriptlang.org/docs/handbook/declaration-files/introduction.html). If your project does not use TypeScript, do not worry, those files can still provide most editors a better developer experience, with a more accurate auto-complete and realtime type checking. Worst case scenario they will just be ignored.


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/datastore/js/getting-started/40_codegen.mdx`