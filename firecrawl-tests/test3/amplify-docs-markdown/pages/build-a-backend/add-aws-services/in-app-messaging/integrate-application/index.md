---
title: Install the Amplify React Native Package and other dependencies
source: pages/build-a-backend/add-aws-services/in-app-messaging/integrate-application/index.mdx
---

# Install the Amplify React Native Package and other dependencies

## Install the Amplify React Native Package and other dependencies
Installing the `@aws-amplify/react-native` will bring in the necessary polyfills for React Native. 

`@aws-amplify/react-native` requires a minimum iOS deployment target of `13.0` if you are using `react-native` version less than or equal to `0.72`. Open the _Podfile_ located in the _ios_ directory and update the `target` value:

```diff showLineNumbers=
- platform :ios, min_ios_version_supported
+ platform :ios, 13.0
```

</Accordion>

```bash title="Terminal" showLineNumbers=
npm add @aws-amplify/react-native @react-native-community/netinfo @react-native-async-storage/async-storage
```

## Install Amplify UI for React Native and its dependencies

Although Amplify In-App Messaging can be used as a standalone JavaScript library, this guide will show you how to use it together with Amplify UI, which currently supports integration with React and React Native, to get started quickly.

> **Note**: 

Learn more about Amplify In-App Messaging UI and how to fully unlock its capabilities here: [Amplify UI for In-App Messaging](https://ui.docs.amplify.aws/react-native/connected-components/in-app-messaging)

```bash title="Terminal" showLineNumbers=
npm add @aws-amplify/ui-react-native react-native-safe-area-context@^4.2.5
```
</InlineFilter>

## Install Amplify UI for React

Although Amplify In-App Messaging can be used as a standalone JavaScript library, this guide will show you how to use it together with Amplify UI, which currently supports integration with React and React Native, to get started quickly.

> **Note**: 

Learn more about Amplify In-App Messaging UI and how to fully unlock its capabilities here: [Amplify UI for In-App Messaging](https://ui.docs.amplify.aws/react/connected-components/in-app-messaging)

```bash title="Terminal" showLineNumbers=
npm add @aws-amplify/ui-react @aws-amplify/ui-react-notifications
```
</InlineFilter>

## Integrate Amplify UI

Amplify UI provides a Higher-Order Component for ease of integrating the In-App Messaging UI with your application. Simply wrap your application root component in, for example, `App.js`.

```js

const App = () => (
  
);

```js title="src/App.js"

import '@aws-amplify/ui-react/styles.css';

const App = () => (
  
);

Below is an example of what your entry file should look like:

```jsx title="src/index.js"
import  from 'aws-amplify/in-app-messaging';

Amplify.configure(outputs);
initializeInAppMessaging();

// To display your in-app message, make sure this event name matches one you created
// in an In-App Messaging campaign!
const myFirstEvent = ;

const App = () => , []);

  return (

       }
        title="Record Analytics Event"
      />

       }
        title="Send In-App Messaging Event"
      />
    </View>
  );
};

</InlineFilter>

```jsx title="src/index.js"
import  from 'aws-amplify/in-app-messaging';
import '@aws-amplify/ui-react/styles.css';

Amplify.configure(outputs);
initializeInAppMessaging();

// To display your in-app message, make sure this event name matches one you created
// in an In-App Messaging campaign!
const myFirstEvent = ;

const App = () => , []);

  return (

       }
      >
        Record Analytics Event
      </Button>

       }
      >
        Send In-App Messaging Event
      </Button>
    </View>
  );
};

You can now build and run your app in your terminal. If you click on one of the buttons shown in the above example, the in-app message you defined in the Pinpoint console should be displayed in your app.
