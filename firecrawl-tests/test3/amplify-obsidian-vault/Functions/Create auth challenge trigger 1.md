---
title: Create auth challenge trigger
topics: ['Functions']
primary_topic: Functions
source: pages/build-a-backend/functions/examples/google-recaptcha-challenge/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, functions]
---


## 🧭 Navigation
**Topics**: [[Functions/]]
**Primary**: [[Functions/]]

---


# Create auth challenge trigger

You can use `defineAuth` and `defineFunction` to create an auth experience that requires a [reCAPTCHA v3](https://developers.google.com/recaptcha/docs/v3) token. This can be accomplished by leveraging [Amazon Cognito's feature to define a custom auth challenge](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow.html#Custom-authentication-flow-and-challenges) and 3 triggers:

1. [Create auth challenge](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-create-auth-challenge.html)
2. [Define auth challenge](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-define-auth-challenge.html)
3. [Verify auth challenge response](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-verify-auth-challenge-response.html) 

## Create auth challenge trigger

To get started, create the first of the three triggers, `create-auth-challenge`. This is the trigger responsible for creating the reCAPTCHA challenge after a password is verified.

```ts title="amplify/auth/create-auth-challenge/resource.ts"

After creating the resource file, create the handler with the following contents:

```ts title="amplify/auth/create-auth-challenge/handler.ts"

  if (
    // session will contain 3 "steps": SRP, password verification, custom challenge
    request.session.length === 2 &&
    request.challengeName === "CUSTOM_CHALLENGE"
  ) 
    response.privateChallengeParameters = 
    // optionally set challenge metadata
    response.challengeMetadata = "CAPTCHA_CHALLENGE"
  }

  return event
}
```

## Define auth challenge trigger

Next, you will want to create the trigger responsible for _defining_ the auth challenge flow, `define-auth-challenge`.

```ts title="amplify/auth/define-auth-challenge/resource.ts"

After creating the resource file, create the handler with the following contents:

```ts title="amplify/auth/define-auth-challenge/handler.ts"

  // deny by default
  response.issueTokens = false
  response.failAuthentication = true

  if (srp?.challengeName === "SRP_A") 

  if (
    password?.challengeName === "PASSWORD_VERIFIER" &&
    password.challengeResult === true
  ) 

  if (
    captcha?.challengeName === "CUSTOM_CHALLENGE" &&
    // check for the challenge metadata set in "create-auth-challenge"
    captcha?.challengeMetadata === "CAPTCHA_CHALLENGE" &&
    captcha.challengeResult === true
  ) 

  return event
}
```

## Verify auth challenge response trigger

Lastly, create the trigger responsible for _verifying_ the challenge response, which in this case is the reCAPTCHA token verification.

> **Note**: 

If you have not done so already, you will need to register your application and retrieve a reCAPTCHA secret key. This can then be configured for use with your cloud sandbox using:

```bash title="Terminal" showLineNumbers=
npx ampx sandbox secret set GOOGLE_RECAPTCHA_SECRET_KEY
```

```ts title="amplify/auth/verify-auth-challenge-response/resource.ts"

After creating the resource file, create the handler with the following contents:

```ts title="amplify/auth/verify-auth-challenge-response/handler.ts"

/**
 * Google ReCAPTCHA verification response
 * @see https://developers.google.com/recaptcha/docs/v3#site_verify_response
 */
type GoogleRecaptchaVerifyResponse = 

  // https://developers.google.com/recaptcha/docs/verify#api_request
  const url = new URL("https://www.google.com/recaptcha/api/siteverify")
  const params = new URLSearchParams()
  url.search = params.toString()

  const request = new Request(url, )

  const response = await fetch(request)
  const result = (await response.json()) as GoogleRecaptchaVerifyResponse

  if (!result.success) )
  }

  // indicate whether the answer is correct
  event.response.answerCorrect = result.success

  return event
}
```

## Configure auth resource

Finally, import and set the three triggers on your auth resource:

```ts title="amplify/auth/resource.ts"

/**
 * Define and configure your auth resource
 * @see https://docs.amplify.aws/gen2/build-a-backend/auth
 */


---

## 📚 Related Topics
- [[Functions/]]

## 📖 Source
Original: `pages/build-a-backend/functions/examples/google-recaptcha-challenge/index.mdx`