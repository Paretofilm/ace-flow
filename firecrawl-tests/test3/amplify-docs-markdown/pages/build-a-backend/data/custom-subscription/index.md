---
title: Define a custom subscription
source: pages/build-a-backend/data/custom-subscription/index.mdx
---

# Define a custom subscription

Create a custom real-time subscription for any mutation to enable PubSub use cases. 

## Define a custom subscription

For every custom subscription, you need to set:
1. the mutation(s) that should trigger a subscription event,
2. a return type that matches the subscribed mutations' return type,
3. authorization rules.

Optionally, you can set filter arguments to customize the server-side subscription filter rules.

Use `a.subscription()` to define your custom subscription in your **amplify/data/resource.ts** file:

```ts title="amplify/data/resource.ts"

const schema = a.schema(),

  // Message publish mutation
  publish: a.mutation()
    .arguments()
    .returns(a.ref('Message'))
    .handler(a.handler.custom())
    .authorization(allow => [allow.publicApiKey()]),

  // highlight-start
  // Subscribe to incoming messages
  receive: a.subscription()
    // subscribes to the 'publish' mutation
    .for(a.ref('publish')) 
    // subscription handler to set custom filters
    .handler(a.handler.custom()) 
    // authorization rules as to who can subscribe to the data
    .authorization(allow => [allow.publicApiKey()]),
  // highlight-end

  // A data model to manage channels
  Channel: a.model().authorization(allow => [allow.publicApiKey()]),
});

For this example, we're building a generic PubSub capability. This requires us to convert the arguments for `publish` into the `Channel`'s format. Create a new `publish.js` file in your **amplify/data/** folder with the following contents:

```js title="amplify/data/publish.js"
// This handler simply passes through the arguments of the mutation through as the result

/**
 * @param  ctx
 */

Next, create a new `receive.js` file in your **amplify/data/** folder to define handlers for your subscription. In this case, it'll just be a simple passthrough. In the next section, we'll explore how to use this handler to construct more advanced subscription filters.

> **Note**: 

**Note:** We're planning a developer experience enhancement in the near future that'll create this passthrough under the hood.

```ts title="amplify/data/receive.js"

## Subscribe to custom subscriptions client-side

From your generated Data client, you can find all your custom subscriptions under `client.subscriptions`. Subscribe using the `.subscribe()` function and then use the `next` function to handle incoming events.

```ts

const client = generateClient()

const sub = client.subscriptions.receive()
  .subscribe(
  }
)
```

You can try publishing an event using the custom mutation to test the real-time subscription.

```ts
client.mutations.publish()
```

Your subscription event should be received and logs the payload into your app's developer console. Unsubscribe your subscription to disconnect using the `unsubscribe()` function.

```ts
sub.unsubscribe()
```

## (Optionally) Add server-side subscription filters

> **Note**: 

**Note:** The custom subscription `.authorization()` modifier does not support the `owner` strategy. This differs from model subscriptions and may result in a subscription event being broadcast to a larger audience.

You can add subscription filters by adding arguments to the custom subscriptions. 

If you want to customize the filters, modify the subscription handler. For this example, we'll allow a customer to pass in a `namePrefix` parameter that allows the end users to only receive channel events in channels that start with the `namePrefix`.

```ts title="amplify/data/resource.ts"

const schema = a.schema().authorization(allow => [allow.publicApiKey()]),

  Message: a.customType(),

  publish: a.mutation()
    .arguments()
    .returns(a.ref('Message'))
    .handler(a.handler.custom())
    .authorization(allow => [allow.publicApiKey()]),

  receive: a.subscription()
    .for(a.ref('publish'))
    // highlight-next-line
    .arguments()
    .handler(a.handler.custom())
    .authorization(allow => [allow.publicApiKey()])
});

In your handler, you can set custom subscription filters based on arguments passed into the custom subscription. For this example, create a new **receive.js** file alongside the **amplify/data/resource.ts** file:

```js

// Subscription handlers must return a `null` payload on the request

/**
 * @param  ctx
 */

  extensions.setSubscriptionFilter(util.transform.toSubscriptionFilter(filter))

  return null
}
```
