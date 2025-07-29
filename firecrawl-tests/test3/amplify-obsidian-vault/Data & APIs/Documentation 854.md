---
title: Documentation
topics: ['Data & APIs', 'React', 'Getting Started']
primary_topic: Data & APIs
source: fragments/lib/datastore/react-native/getting-started/30_platformIntegration.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis, react, getting-started]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]] • [[React/]] • [[Getting Started/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

Start with the [React Native CLI](https://reactnative.dev/docs/getting-started):

```sh
npx react-native init AmplifyDataStoreRN
cd AmplifyDataStoreRN
npm install aws-amplify @aws-amplify/react-native @react-native-community/netinfo @react-native-async-storage/async-storage react-native-get-random-values @azure/core-asynciterator-polyfill
```

You will also need to install the pod dependencies for iOS:

```sh
npx pod-install
```

After installing pod dependencies, rebuild the app:

```sh
npm run ios
```

**Use SQLite for enhanced performance (optional)**

React Native CLI apps can now use SQLite with DataStore. SQLite offers considerable performance advantages over the default "AsyncStorage" database.

To enable SQLite with DataStore for enhanced local database performance, follow the steps below:

```sh
npx react-native init AmplifyDataStoreRN
cd AmplifyDataStoreRN
npm install aws-amplify @aws-amplify/react-native @react-native-community/netinfo @aws-amplify/datastore-storage-adapter react-native-sqlite-storage @react-native-async-storage/async-storage react-native-get-random-values @azure/core-asynciterator-polyfill
npx pod-install
```

Then configure the SQLite storage adapter with DataStore in your app:

```js

DataStore.configure();
```

> **Note**: 

The SQLite storage adapter does not currently support custom primary keys. Disable custom primary key in `amplify/cli.json` by setting `graphQLTransformer.respectPrimaryKeyAttributesOnConnectionField` to `false`.

</Block>

Start with the [Expo CLI](https://docs.expo.dev/):

```sh
npx create-expo-app AmplifyDataStoreExpo
cd AmplifyDataStoreExpo
expo install aws-amplify @aws-amplify/react-native @react-native-community/netinfo @aws-amplify/datastore-storage-adapter react-native-sqlite-storage @react-native-async-storage/async-storage react-native-get-random-values @azure/core-asynciterator-polyfill
```

**Use SQLite for enhanced performance (optional)**

Expo built apps can now use SQLite with DataStore. SQLite offers considerable performance advantages over the default "AsyncStorage" database.

To enable SQLite with DataStore for enhanced local database performance, follow the steps below:

```sh
npx create-expo-app AmplifyDataStoreExpo
cd AmplifyDataStoreExpo
expo install aws-amplify @aws-amplify/react-native @react-native-community/netinfo @aws-amplify/datastore-storage-adapter react-native-sqlite-storage @react-native-async-storage/async-storage react-native-get-random-values @azure/core-asynciterator-polyfill
```

Then configure the SQLite storage adapter with DataStore in your app:

```js

DataStore.configure();
```

> **Note**: 

The SQLite storage adapter does not currently support custom primary keys. Disable custom primary key in `amplify/cli.json` by setting `graphQLTransformer.respectPrimaryKeyAttributesOnConnectionField` to `false`.

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]
- [[React/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib/datastore/react-native/getting-started/30_platformIntegration.mdx`