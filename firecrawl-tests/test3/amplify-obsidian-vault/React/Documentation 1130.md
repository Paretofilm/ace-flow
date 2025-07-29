---
title: Documentation
topics: ['React']
primary_topic: React
source: fragments/lib/in-app-messaging/integrate-your-application/react-native/full-example.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, react]
---


## 🧭 Navigation
**Topics**: [[React/]]
**Primary**: [[React/]]

---


# Documentation

```jsx
import  from 'aws-amplify/in-app-messaging';

Amplify.configure(amplifyconfig);
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


---

## 📚 Related Topics
- [[React/]]

## 📖 Source
Original: `fragments/lib/in-app-messaging/integrate-your-application/react-native/full-example.mdx`