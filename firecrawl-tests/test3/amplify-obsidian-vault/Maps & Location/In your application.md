---
title: In your application
topics: ['Maps & Location']
primary_topic: Maps & Location
source: fragments/lib-v1/geo/js/existing-resources.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]]
**Primary**: [[Maps & Location/]]

---


# In your application

## In your application

To configure Amplify Geo manually, you will have to configure Amplify Auth category as well. Instead of configuring Amplify by importing the CLI generated `aws-exports.js`, you will be calling `Amplify.configure` with your existing Amazon Cognito and Amazon Location Service information in your app like this:

```js

Amplify.configure(,
  geo: ,
        },
        default: "XXXXXXXXXXX", // REQUIRED - Amazon Location Service Map resource name to set as default
      },
      search_indices: ,
      geofenceCollections: 
      region: 'XX-XXXX-X', // REQUIRED - Amazon Location Service Region
    },
  },
})
```

Now you can proceed to [displaying a map](/gen1/[platform]/prev/build-a-backend/more-features/geo/maps/) or [adding location search](/gen1/[platform]/prev/build-a-backend/more-features/geo/location-search/) to your app.


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `fragments/lib-v1/geo/js/existing-resources.mdx`