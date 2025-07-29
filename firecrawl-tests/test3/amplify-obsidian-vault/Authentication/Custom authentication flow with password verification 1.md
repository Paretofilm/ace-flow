---
title: Custom authentication flow with password verification
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/flutter/signin_with_custom_flow/50_custom_challenge_password_verification.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Custom authentication flow with password verification

## Custom authentication flow with password verification

The example in this documentation demonstrates the passwordless custom authentication flow. However, it is also possible to require that users supply a valid password as part of the custom authentication flow.

To require a valid password, you can alter the `DefineAuthChallenge` code to handle a `PASSWORD_VERIFIER` step:

```js
exports.handler = async (event) =>  else if (
    event.request.session.length === 2 &&
    event.request.session[1].challengeName === 'PASSWORD_VERIFIER' &&
    event.request.session[1].challengeResult === true
  )  else if (
    event.request.session.length === 3 &&
    event.request.session[2].challengeName === 'CUSTOM_CHALLENGE' &&
    event.request.session[2].challengeResult === true
  )  else 

  return event;
};
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/flutter/signin_with_custom_flow/50_custom_challenge_password_verification.mdx`