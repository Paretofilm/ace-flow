---
title: Documentation
source: fragments/lib-v1/analytics/js/update-endpoint.mdx
---

# Documentation

An endpoint uniquely identifies your app within Pinpoint. In order to update your [endpoint](https://docs.aws.amazon.com/pinpoint/latest/apireference/rest-api-endpoints.html) use the `updateEndpoint()` method:

```javascript

// NOTE: All fields are OPTIONAL
await Analytics.updateEndpoint(,
  channelType: 'APNS', // The channel type. Valid values: APNS, GCM
  demographic: ,
  location: ,
  metrics: ,
  /** Indicates whether a user has opted out of receiving messages with one of the following values:
   * ALL - User has opted out of all messages.
   * NONE - Users has not opted out and receives all messages.
   */
  optOut: 'ALL',
  // Customized userId
  userId: 'XXXXXXXXXXXX',
  // User attributes
  userAttributes: 
}).then(() => );
```

> **Note**: 

  There is a limit of 15 unique endpoints per user ID. See Pinpoint's
  [documentation](https://docs.aws.amazon.com/pinpoint/latest/developerguide/quotas.html#quotas-endpoint)
  on endpoint quotas to learn more.

[Learn more](https://docs.aws.amazon.com/pinpoint/latest/developerguide/audience-define-user.html) about Amazon Pinpoint and Endpoints.
