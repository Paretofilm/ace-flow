---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib-v1/auth/native_common/access_credentials/common.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

An intentional decision with Amplify Auth was to avoid any public methods exposing credentials or manipulating them.

With Auth, you simply sign in and it handles everything else needed to keep the credentials up to date and vend them to the other categories.

However, if you need to access them in relation to working with an API outside Amplify or want access to AWS specific identifying information (e.g. IdentityId), you can access these implementation by following the example below:


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib-v1/auth/native_common/access_credentials/common.mdx`