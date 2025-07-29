---
title: Setup a new Geofence Collection
topics: ['Maps & Location']
primary_topic: Maps & Location
source: pages/build-a-backend/add-aws-services/geo/configure-geofencing/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]]
**Primary**: [[Maps & Location/]]

---


# Setup a new Geofence Collection

A Geofence is a virtual perimeter for a real-world geographic area. A Geofence contains points or vertices that form a closed boundary, defining an area of interest. Geofence collections store one or multiple Geofences.

## Setup a new Geofence Collection

```ts title="amplify/backend.ts"

const backend = defineBackend();

const geoStack = backend.createStack("geo-stack");

// create a location services geofence collection
const myGeofenceCollection = new CfnGeofenceCollection(
  geoStack,
  "GeofenceCollection",
  ,
    ],
  }
);

// create an IAM policy to allow interacting with geofence collection resource
const myGeofenceCollectionPolicy = new Policy(
  geoStack,
  "GeofenceCollectionPolicy",
  ),
    ],
  }
);

// apply the policy to the authenticated and unauthenticated roles
backend.auth.resources.authenticatedUserIamRole.attachInlinePolicy(myGeofenceCollectionPolicy);
backend.auth.resources.unauthenticatedUserIamRole.attachInlinePolicy(myGeofenceCollectionPolicy);

// patch the geofence collection resource to the expected output configuration
backend.addOutput(,
  },
});
```

## Geofence Collection Pricing Plan

The pricing plan for the Geofence Collection will be set to `RequestBasedUsage`. We advice you to go through the [location service pricing](https://aws.amazon.com/location/pricing/) along with the [location service terms](https://aws.amazon.com/service-terms/) (_82.5 section_) to learn more about the pricing plan.

#### Group access

To scope access permissions based on [Cognito User Groups](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-user-groups.html)

1. Create a Cognito User Pool Group

```ts title="amplify/auth/resource.ts"

2. Add permissions to the Cognito User Pool Group role

```ts title="amplify/backend.ts"
const myGeofenceCollectionPolicy = new Policy(
  geoStack,
  "GeofenceCollectionPolicy",
  ),
    ],
  }
);

backend.auth.resources.groups["User"].role.attachInlinePolicy(myGeofenceCollectionPolicy);
```

> Note: If you combine `Auth/Guest user access` and `Individual Group access`, users who are members of a group will only be granted the permissions of the group, and not the authenticated user permissions. The permissions apply to ALL Geofences in a collection. For example, If you add `Read` permission such as `ListGeofences` and `GetGeofence` to `User` Cognito group, ALL users added to that group will be able to read the properties of ALL Geofences in that Geofence collection.

#### Using the AWS SDK for Javascript

Alternatively, if you want to add users to an existing Cognito user pool group programmatically, you can use the AWS SDK for Javascript. Refer to the [API documentation](https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/CognitoIdentityServiceProvider.html#adminAddUserToGroup).

> **Note**: 

**Note:** After you have provisioned the Geofence Collection, depending on your application's use-case, you can also add Geofences to the provisioned Geofence Collection programmatically. Refer this [API documentation](/[platform]/build-a-backend/add-aws-services/geo/geofences/#savegeofences) for more information.

</InlineFilter>


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/geo/configure-geofencing/index.mdx`