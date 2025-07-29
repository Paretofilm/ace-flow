---
title: Set up existing analytics backend
source: fragments/lib-v1/analytics/js/existing-resources.mdx
---

# Set up existing analytics backend

## Set up existing analytics backend

The manual setup enables you to use your existing Amazon Pinpoint resource in your app.

```javascript

Amplify.configure(,
  Analytics: ,
        channelType: 'APNS', // The channel type. Valid values: APNS, GCM
        demographic: ,
        location: ,
        metrics: ,
        /** Indicates whether a user has opted out of receiving messages with one of the following values:
         * ALL (default) - User has opted out of all messages.
         * NONE - Users has not opted out and receives all messages.
         */
        optOut: 'ALL',
        // Customized userId
        userId: 'XXXXXXXXXXXX',
        // User attributes
        userAttributes: 
      },

      // Buffer settings used for reporting analytics events.
      // OPTIONAL - The buffer size for events in number of items.
      bufferSize: 1000,

      // OPTIONAL - The interval in milliseconds to perform a buffer check and flush if necessary.
      flushInterval: 5000, // 5s

      // OPTIONAL - The number of events to be deleted from the buffer when flushed.
      flushSize: 100,

      // OPTIONAL - The limit for failed recording retries.
      resendLimit: 5
    }
  }
});
```

## Update your IAM Policy

Amazon Pinpoint service requires an IAM policy in order to use the `record` API:

```json
:apps/$*"]
    }
  ]
}
```
