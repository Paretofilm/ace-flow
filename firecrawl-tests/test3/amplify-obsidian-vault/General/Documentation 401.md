---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib-v1/project-setup/flutter/platform-setup/sqlite3_wasm.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

Amplify uses SQLite via the [`drift`](https://pub.dev/packages/drift) package. This requires a custom build of SQLite when targeting web. You will need to download `sqlite3.wasm` from the [releases](https://github.com/simolus3/sqlite3.dart/releases) page of the `sqlite3` pub package and copy it into the `web/` directory of your Flutter project.
For more info, see [https://drift.simonbinder.eu/web/#drift-wasm](https://drift.simonbinder.eu/web/#drift-wasm).


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/project-setup/flutter/platform-setup/sqlite3_wasm.mdx`