---
title: Using Amplify GraphQL client
source: fragments/lib-v1/graphqlapi/js/subscribe-data.mdx
---

# Using Amplify GraphQL client

## Using Amplify GraphQL client

Subscriptions is a GraphQL feature allowing the server to send data to its clients when a specific event happens. You can enable real-time data integration in your app with a subscription.

```ts

// Subscribe to creation of Todo
const sub = API.graphql>(
  graphqlOperation(subscriptions.onCreateTodo)
).subscribe() => console.log(),
  error: (error) => console.warn(error)
});

// Stop receiving data updates from the subscription
sub.unsubscribe();
```

</Block>

```js

// Subscribe to creation of Todo
const sub = API.graphql(graphqlOperation(subscriptions.onCreateTodo)).subscribe(
  ) => console.log(),
    error: (error) => console.warn(error)
  }
);

// Stop receiving data updates from the subscription
sub.unsubscribe();
```

</Block>
</BlockSwitcher>

When using **AWS AppSync** subscriptions, be sure that your AppSync configuration is at the root of the configuration object, instead of being under API:

```javascript
Amplify.configure(
  },
  aws_appsync_graphqlEndpoint: 'xxxx',
  aws_appsync_region: 'xxxx',
  aws_appsync_authenticationType: 'xxxx',
  aws_appsync_apiKey: 'xxxx'
});
```

Subscriptions take an optional `filter` argument to define service-side subscription filters:

```ts
// ...
import  from './API';

const variables: OnCreateTodoSubscriptionVariables = 
  }
};

const sub = API.graphql>(
  graphqlOperation(subscriptions.onCreateTodo, variables)
).subscribe() => console.log(),
  error: (error) => console.warn(error)
});
```

</Block>

```js
// ...

const variables = 
  }
};

const sub = API.graphql(
  graphqlOperation(subscriptions.onCreateTodo, variables)
).subscribe() => console.log(),
  error: (error) => console.warn(error)
});
```

</Block>
</BlockSwitcher>

If you want to get all subscription events, don’t pass any `filter` parameters.

> **Note**: 

**Important**: Passing an empty object `` as a filter is NOT recommended. Using `` as a filter might cause inconsistent behavior based on your data model's authorization rules.

### Subscription connection status updates

Now that your application is setup and using subscriptions, you may want to know when the subscription is finally established, or reflect to your users when the subscription isn't healthy. You can monitor the connection state for changes via Hub.

```ts

Hub.listen('api', (data: any) =>  = data;
  if (payload.event === CONNECTION_STATE_CHANGE) 
});
```

### Connection issues and automated reconnection

```ts
// ...
import  from './API';

const fetchRecentData = () => );
}

let priorConnectionState: ConnectionState;

Hub.listen("api", (data: any) =>  = data;
  if (
    payload.event === CONNECTION_STATE_CHANGE
  ) 
    priorConnectionState = payload.data.connectionState;
  }
});

const createSub = API.graphql>(
  graphqlOperation(subscriptions.onCreateTodo)
).subscribe();

const updateSub = API.graphql>(
  graphqlOperation(subscriptions.onUpdateTodo)
).subscribe();

const deleteSub = API.graphql>(
  graphqlOperation(subscriptions.onDeleteTodo)
).subscribe();

const cleanupSubscriptions = () => 
```

</Block>

```js
// ...

const fetchRecentData = () => );
}

let priorConnectionState: ConnectionState;

Hub.listen("api", (data: any) =>  = data;
  if (
    payload.event === CONNECTION_STATE_CHANGE
  ) 
    priorConnectionState = payload.data.connectionState;
  }
});

const createSub = API.graphql(
  graphqlOperation(subscriptions.onCreateTodo)
).subscribe();

const updateSub = API.graphql(
  graphqlOperation(subscriptions.onUpdateTodo)
).subscribe();

const deleteSub = API.graphql(
  graphqlOperation(subscriptions.onDeleteTodo)
).subscribe();

const cleanupSubscriptions = () => 
```

</Block>
</BlockSwitcher>
