---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/in-app-messaging/integrate-your-application/js/full-example.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

```jsx
import  from 'aws-amplify/in-app-messaging';
import '@aws-amplify/ui-react/styles.css';

Amplify.configure(amplifyconfig);
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


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/in-app-messaging/integrate-your-application/js/full-example.mdx`