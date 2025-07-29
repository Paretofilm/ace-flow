---
title: Setup a new Location Search Index
topics: ['Maps & Location']
primary_topic: Maps & Location
source: pages/build-a-backend/add-aws-services/geo/configure-location-search/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]]
**Primary**: [[Maps & Location/]]

---


# Setup a new Location Search Index

Amplify's `geo` category enables you to search by places, addresses, and coordinates in your app with "place index" resources.

## Setup a new Location Search Index

```ts title="amplify/backend.ts"
// highlight-next-line

const backend = defineBackend();

const geoStack = backend.createStack("geo-stack");

// create a location services map
const map = new CfnMap(geoStack, "Map", ,
  pricingPlan: "RequestBasedUsage",
  tags: [
    ,
  ],
});

// create an IAM policy to allow interacting with geo resource
const myGeoPolicy = new Policy(geoStack, "GeoPolicy", ),
  ],
});

// apply the policy to the authenticated and unauthenticated roles
backend.auth.resources.authenticatedUserIamRole.attachInlinePolicy(myGeoPolicy);
backend.auth.resources.unauthenticatedUserIamRole.attachInlinePolicy(myGeoPolicy);

// highlight-start
// create a location services place index
const myIndex = new CfnPlaceIndex(geoStack, "PlaceIndex", ,
  indexName: "myPlaceIndex",
  pricingPlan: "RequestBasedUsage",
  tags: [
    ,
  ],
});

// create a policy to allow access to the place index
const myIndexPolicy = new Policy(geoStack, "IndexPolicy", ),
  ],
});

// attach the policy to the authenticated and unauthenticated IAM roles
backend.auth.resources.authenticatedUserIamRole.attachInlinePolicy(myIndexPolicy);
backend.auth.resources.unauthenticatedUserIamRole.attachInlinePolicy(myIndexPolicy);
// highlight-end

// patch the place index resource to the expected output configuration
backend.addOutput(,
      },
      default: map.mapName,
    },
// highlight-start
    search_indices: ,
// highlight-end
  },
});
```

## Location Search Index Pricing Plan
The pricing plan for Search Index will be set to `RequestBasedUsage`.
We advice you to go through the [location service pricing](https://aws.amazon.com/location/pricing/) along with the [location service terms](https://aws.amazon.com/service-terms/) (_82.5 section_) to learn more about the pricing plan.

## Advanced Settings
You can optionally configure the data provider and result storage location for your location search index.

### Location Search data provider
You can select a data provider as the source for geocoding, reverse geocoding and searches.
Each provider gathers and curates their data using different means. They may also have varying expertise in different regions of the world.
The available data providers of geospatial data are shown. To learn more about data providers, please refer this [location service documentation](https://docs.aws.amazon.com/location/latest/developerguide/what-is-data-provider.html).

- Here – For additional information about HERE Technologies, see [Here guide](https://docs.aws.amazon.com/location/latest/developerguide/HERE.html).
- Esri – For additional information about Esri, see [Esri guide](https://docs.aws.amazon.com/location/latest/developerguide/esri.html).

> **Note**: 

**Note:** If your application is tracking or routing assets you use in your business (such as delivery vehicles or employees), you may only use `HERE` as your geolocation provider. 
See section 82 of the [AWS service terms](https://aws.amazon.com/service-terms/) for more details.

### Location Search result storage location
You can specify how the results of a search operation will be stored by the caller.

- SingleUse - specifies that the results won't be stored.
- Storage - specifies that the result can be cached or stored in a database.

Refer [this location service doc](https://docs.aws.amazon.com/location-places/latest/APIReference/API_DataSourceConfiguration.html#locationplaces-Type-DataSourceConfiguration-IntendedUse) for more information.


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/geo/configure-location-search/index.mdx`