---
title: Option 1: Use pre-built UI components
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/js/enable_sign_in_sign_up.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Option 1: Use pre-built UI components

There are two ways to add authentication capabilities to your application.

1. [Use pre-built UI components](#option-1-use-pre-built-ui-components)

2. [Call Authentication APIs manually](#option-2-call-authentication-apis-manually)

## Option 1: Use pre-built UI components

Creating the login flow can be quite difficult and time consuming to get right. Amplify has authentication UI components you can use that will provide the entire authentication flow for you, using your configuration specified in your __amplifyconfiguration.json__ file.

Amplify has pre-built UI components for React, Vue, Angular and React Native.

First, install the `@aws-amplify/ui-react` library as well as `aws-amplify` if you have not already:

```sh
npm install aws-amplify @aws-amplify/ui-react
```

Next, open __src/App.js__ and add the `withAuthenticator` component.

**withAuthenticator**

</Block>

First, install the `@aws-amplify/ui-vue` library as well as `aws-amplify` if you have not already:

```bash
npm install aws-amplify @aws-amplify/ui-vue
```

Next, open __src/App.js__ and add the `Authenticator` component.

**Authenticator**

The `Authenticator` component offers a simple way to add authentication flows into your app. This component encapsulates an authentication workflow in the framework of your choice and is backed by the cloud resources set up in your Auth cloud resources. You’ll also notice that `user` and `signOut` are passed to the inner template.

```html
<script setup>
  import  from "@aws-amplify/ui-vue";
  import "@aws-amplify/ui-vue/styles.css";

  import  from 'aws-amplify';
  import amplifyconfig from './amplifyconfiguration.json';

  Amplify.configure(amplifyconfig);
</script>

<template>
  <authenticator>
    <template v-slot="">
      <h1>Hello }!</h1>
      <button @click="signOut">Sign Out</button>
    </template>
  </authenticator>
</template>
```

</Block>

First, install the `@aws-amplify/ui-components` library as well as `aws-amplify` if you have not already:

```bash
npm install aws-amplify @aws-amplify/ui-components
```

Now open __src/main.js__ and add the following below your last import:

```js
import '@aws-amplify/ui-components';
import  from '@aws-amplify/ui-components/loader';

Vue.config.ignoredElements = [/amplify-\w*/];

applyPolyfills().then(() => );
```

Next, open __src/App.js__ and add the `amplify-authenticator` component.

**amplify-authenticator**

The `amplify-authenticator` component offers a simple way to add authentication flows into your app. This component encapsulates an authentication workflow in the framework of your choice and is backed by the cloud resources set up in your Auth cloud resources. You’ll also notice the `amplify-sign-out` component. This is an optional component if you’d like to render a sign out button.

```html
<template>
  <amplify-authenticator>
    <div>
      My App
      <amplify-sign-out></amplify-sign-out>
    </div>
  </amplify-authenticator>
</template>
```

</Block>

First, install the `@aws-amplify/ui-angular` library as well as `aws-amplify` if you have not already:

```bash
npm install aws-amplify @aws-amplify/ui-angular
```

Now open __app.module.ts__ and add the Amplify imports and configuration:

```js

Amplify.configure(amplifyconfig);

@NgModule()

Next, import the default theme inside __styles.css__:

```css
@import '~@aws-amplify/ui-angular/theme.css';
````

Next, open __app.component.html__ and add the `amplify-authenticator` component.

**amplify-authenticator**

The `amplify-authenticator` component offers a simple way to add authentication flows into your app. This component encapsulates an authentication workflow in the framework of your choice and is backed by the cloud resources set up in your Auth cloud resources. You’ll also notice that `user` and `signOut` are provided to the inner template.

```html
<amplify-authenticator>
  <ng-template
    amplifySlot="authenticated"
    let-user="user"
    let-signOut="signOut"
  >
    <h1>Welcome }!</h1>
    <button (click)="signOut()">Sign Out</button>
  </ng-template>
</amplify-authenticator>
```

</Block>
</BlockSwitcher>

## Option 2: Call Authentication APIs manually


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/js/enable_sign_in_sign_up.mdx`