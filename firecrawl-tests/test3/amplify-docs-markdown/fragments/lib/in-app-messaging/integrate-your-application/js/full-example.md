---
title: Documentation
source: fragments/lib/in-app-messaging/integrate-your-application/js/full-example.mdx
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
