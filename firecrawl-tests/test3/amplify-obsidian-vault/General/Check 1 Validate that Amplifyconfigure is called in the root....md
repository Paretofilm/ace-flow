---
title: Check 1: Validate that `Amplify.configure` is called in the root of your project
topics: ['General']
primary_topic: General
source: pages/build-a-backend/troubleshooting/library-not-configured/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Check 1: Validate that `Amplify.configure` is called in the root of your project

If you are running into a missing configuration or `NoCredentials` error message and have called `Amplify.configure` in your project, your Amplify API is most likely being called before `Amplify.configure`. This can happen in a few different ways. Below are three possibilities you can check to troubleshoot this issue.

## Check 1: Validate that `Amplify.configure` is called in the root of your project

Make sure you are calling `Amplify.configure` in the root file of your project. The root file of your app may be different depending on your frontend framework. The current default for some common frameworks are listed below (if you are not using TypeScript the `ts` and `tsx` extensions would be `js` and `jsx`):

* Vue.js: **src/main.ts**
* React: **src/main.tsx**
* Angular: **src/main.ts**
* Next.js Page Router: **pages/_app.tsx** or **src/pages/_app.tsx**
* Nuxt: **app.vue** (Or in a plugins file, as recommended [here](https://docs.amplify.aws/react/build-a-backend/server-side-rendering/nuxt/).)

> **Note**: 

If you are using the Next.js App Router, you can follow the suggestions in our [Next.js documentation](/[platform]/build-a-backend/server-side-rendering/#configure-amplify-apis-for-server-side-usage) for root-level configuration. Keep in mind that if you are calling any APIs at the module-level (i.e. at the top of your file) in any of the Child components, you may still run into this issue. Continue on the [Check 2](/[platform]/build-a-backend/troubleshooting/library-not-configured/#check-2-move-module-level-amplify-api-invocations) if this is the case.

## Check 2: Move module-level Amplify API invocations

When Amplify APIs are used outside of your application lifecycle, there is a risk that a JavaScript bundler may place that API call before `Amplify.configure`. Module-level function calls (calls at the top-level of a file), are generally evaluated in the order that they are imported.

Below is an example of code that will likely result in a missing configuration or `NoCredentials` error message:

```tsx title="index.ts"

// fetchAuthSession() in ComponentX executed on import

Amplify.configure();

```tsx title="module-fetch-auth.tsx"

fetchAuthSession(); // Will throw "AuthUserPoolException: Auth UserPool not configured."

This error can also happen when using Next.js Layouts and calling Amplify APIs in child components at the module-level (at the top of your file/module). See below for an example of this issue:

```tsx title="layout.tsx"

```tsx title="ConfigureAmplifyClientSide.tsx"

Amplify.configure(config, );

```tsx title="page.tsx"

// The layout calls configure, but fetchAuthSession ends up executing first
// Will throw "AuthUserPoolException: Auth UserPool not configured."
fetchAuthSession().then((session) => );

To fix this, we suggest moving all Amplify API calls to within the application lifecycle. For instance, if you are using **React**, you can use the `useEffect` hook for functions that should run before the app is loaded:

```tsx title="index.ts"

Amplify.configure();

```tsx title="module-fetch-auth.tsx"

  const getSession = async () =>  catch (error: unknown) 
  };

  useEffect(() => , []);

  return (
    <div className="box">
      ...
    </div>
  );
}
```

## Check 3: Configure Amplify on each page of a multi-page app

If you are working in a multi-page app, you need to call `Amplify.configure()` for each page/route of your application. We recommend calling `Amplify.configure` in a common source file and importing it into each page.


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/troubleshooting/library-not-configured/index.mdx`