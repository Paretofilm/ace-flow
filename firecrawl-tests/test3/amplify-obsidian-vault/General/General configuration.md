---
title: General configuration
topics: ['General']
primary_topic: General
source: fragments/lib-v1/client-configuration/js/js-configuration.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# General configuration

When using the Amplify CLI, the **aws-exports.js** file gets created and updated automatically for you based upon the resources you have added and configured.

If you are not using the Amplify CLI or need to override these settings, this documentation shows the available configuration properties for each category.

## General configuration

The `Amplify.configure()` configuration can generally be included in your project _entrypoint_ file (i.e. _/src/main.js_).

```js
Amplify.configure();
```

## Authentication (Amazon Cognito)

### Top level configuration

```js
Amplify.configure();
```

### Scoped configuration

```js
Amplify.configure(,

    // (optional) - customized storage object
    storage: MyStorage,

    // (optional) - Manually set the authentication flow type. Default is 'USER_SRP_AUTH'
    authenticationFlowType: 'USER_PASSWORD_AUTH',

    // (optional) - Manually set key value pairs that can be passed to Cognito Lambda Triggers
    clientMetadata: ,

    // (optional) - Hosted UI configuration
    oauth: 
  }
});
```

## Storage (Amazon S3)

### Top level configuration

```js
Amplify.configure();
```

### Scoped configuration - `Storage`

```js
Amplify.configure(,
  Storage: 
  }
});
```

## GraphQL API (AWS AppSync)

### Top level configuration

```js
Amplify.configure();

// Authentication type options are API_KEY, AWS_IAM, AMAZON_COGNITO_USER_POOLS and OPENID_CONNECT
```

### Scoped configuration - `GraphQL API`

```js
Amplify.configure()
  }
});
```

## REST API (Amazon API Gateway)

```js
Amplify.configure(
  ]
});
```

## Predictions

### Top level configuration

```js
Amplify.configure(,
  predictions: 
      },
      speechGenerator: 
      },
      transcription: 
      }
    },
    identify: 
      },
      identifyEntities: 
      },
      identifyLabels: 
      }
    },
    interpret: 
      }
    }
  }
});
```

## Analytics (Amazon Pinpoint)

### Top level configuration

```js
Amplify.configure();
```

### Scoped configuration `Analytics`

```js
Amplify.configure(,
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
      },

      // Buffer settings used for reporting analytics events.
      // (optional) - The buffer size for events in number of items.
      bufferSize: 1000,

      // (optional) - The interval in milliseconds to perform a buffer check and flush if necessary.
      flushInterval: 5000, // 5s

      // (optional) - The number of events to be deleted from the buffer when flushed.
      flushSize: 100,

      // (optional) - The limit for failed recording retries.
      resendLimit: 5
    }
  }
});
```

## Geo

### Top level configuration

```js
Amplify.configure(,
  geo: 
        },
        default: 'XXXXXXXXXXX' // REQUIRED - Amazon Location Service Map resource name to set as default
      },
      search_indices: ,
      region: 'XX-XXXX-X' // REQUIRED - Amazon Location Service Region
    }
  }
});
```

## Interactions

### Top level configuration

```js
Amplify.configure(,
  Interactions: 
    }
  }
});
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/client-configuration/js/js-configuration.mdx`