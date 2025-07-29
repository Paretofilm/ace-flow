---
title: Next steps
source: pages/build-a-backend/auth/concepts/phone/index.mdx
---

# Next steps

By default Amplify Auth is scaffolded with `email` as the default method for user sign-in, however this can be changed or extended to also allow your users to sign in using their phone number.

```ts title="amplify/auth/resource.ts"

This will configure the `phone_number` attribute that is required for sign-up and cannot be changed.

## Next steps

- [Learn how to use the `signIn` API](/[platform]/build-a-backend/auth/connect-your-frontend/sign-in/)
- [Learn how to configure your account for production SMS workloads](/[platform]/build-a-backend/auth/moving-to-production/)
