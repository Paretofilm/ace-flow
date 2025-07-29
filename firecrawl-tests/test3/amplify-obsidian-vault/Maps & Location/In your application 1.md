---
title: In your application
topics: ['Maps & Location']
primary_topic: Maps & Location
source: fragments/lib/geo/js/existing-resources.mdx
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

You can first import and configure the CLI generated `amplifyconfiguration.json`. You can then manually configure Amplify Geo like this:

```js

Amplify.configure(
        },
        default: 'XXXXXXXXXXX' // REQUIRED - Amazon Location Service Map resource name to set as default
      },
      search_indices: ,
      geofenceCollections: ,
      region: 'XX-XXXX-X' // REQUIRED - Amazon Location Service Region
    }
  }
});
```

Now you can proceed to [displaying a map](/gen1/[platform]/build-a-backend/more-features/geo/maps/) or [adding location search](/gen1/[platform]/build-a-backend/more-features/geo/location-search/) to your app.


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `fragments/lib/geo/js/existing-resources.mdx`