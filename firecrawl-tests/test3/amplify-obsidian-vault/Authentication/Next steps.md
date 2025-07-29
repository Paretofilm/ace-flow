---
title: Next steps
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/concepts/phone/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Next steps

By default Amplify Auth is scaffolded with `email` as the default method for user sign-in, however this can be changed or extended to also allow your users to sign in using their phone number.

```ts title="amplify/auth/resource.ts"

This will configure the `phone_number` attribute that is required for sign-up and cannot be changed.

## Next steps

- [Learn how to use the `signIn` API](/[platform]/build-a-backend/auth/connect-your-frontend/sign-in/)
- [Learn how to configure your account for production SMS workloads](/[platform]/build-a-backend/auth/moving-to-production/)


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/concepts/phone/index.mdx`