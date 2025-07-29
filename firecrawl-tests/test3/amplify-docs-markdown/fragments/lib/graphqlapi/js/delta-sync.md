---
title: Delta Sync
source: fragments/lib/graphqlapi/js/delta-sync.mdx
---

# Delta Sync

## Delta Sync

DeltaSync allows you to perform automatic synchronization with an AWS AppSync GraphQL server. The client will perform reconnection, exponential backoff, and retries when network errors take place for simplified data replication to devices. It does this by taking the results of a GraphQL query and caching it in the local Apollo cache. The DeltaSync API manages writes to the Apollo cache for you, and all rendering in your app (such as from React components, Angular bindings) should be done through a read-only fetch.

In the most basic form, you can use a single query with the API to replicate the state from the backend to the client. This is referred to as a "Base Query" and could be a list operation for a GraphQL type which might correspond to a DynamoDB table. For large tables where the content changes frequently and devices switch between offline and online frequently as well, pulling all changes for every network reconnect can result in poor performance on the client. In these cases you can provide the client API a second query called the "Delta Query" which will be merged into the cache. When you do this the Base Query is run an initial time to hydrate the cache with data, and on each network reconnect the Delta Query is run to just get the changed data. The Base Query is also run on a regular bases as a "catch-up" mechanism. By default this is every 24 hours however you can make it more or less frequent.

By allowing clients to separate the base hydration of the cache using one query and incremental updates in another query, you can move the computation from your client application to the backend. This is substantially more efficient on the clients when regularly switching between online and offline states. This could be implemented in your AWS AppSync backend in different ways such as using a DynamoDB Query on an index along with a conditional expression. You can also leverage Pipeline Resolvers to partition your records to have the delta responses come from a second table acting as a journal. [A full sample with CloudFormation is available in the AppSync documentation](https://docs.aws.amazon.com/appsync/latest/devguide/tutorial-delta-sync.html). The rest of this documentation will focus on the client usage.

You can also use Delta Sync functionality with GraphQL subscriptions, taking advantage of both only sending changes to the clients when they switch network connectivity but also when they are online. In this case you can pass a third query called the "Subscription Query" which is a standard GraphQL subscription statement. When the device is connected, these are processed as normal and the client API simply helps make setting up realtime data easy. However, when the device transitions from offline to online, to account for high velocity writes the client will execute the resubscription along with synchronization and message processing in the following order:

1. Subscribe to any queries defined and store results in an incoming queue
2. Run the appropriate query (If `baseRefreshIntervalInSeconds` has elapsed, run the Base Query otherwise only run the Delta Query)
3. Update the cache with results from the appropriate query
4. Drain the subscription queue and continue processing as normal

Finally, you might have other queries which you wish to represent in your application other than the base cache hydration. For instance a `getItem(id:ID)` or other specific query. If your alternative query corresponds to items which are already in the normalized cache, you can point them at these cache entries with the `cacheUpdates` function which returns an array of queries and their variables. The DeltaSync client will then iterate through the items and populate a query entry for each item on your behalf. If you wish to use additional queries which don't correspond to items in your base query cache, you can always create another instance of the `client.sync()` process.

## Usage

```typescript
// Start DeltaSync
const subscription = client.sync(options)
/*
Under the covers, this is actually an Observable that the AppSync client automatically subscribes to for you, so the returned object is a "subscription". This means that you can automatically stop the synchronization process like so:
*/
// Stop DeltaSync
subscription.unsubscribe();
```

**The `options` object**

**baseQuery**
  - `query`: A `DocumentNode` for the base data (e.g. as returned by [`gql`](https://github.com/apollographql/graphql-tag#gql))
  - `variables` [optional]: An object with the query variables, if any.
  - `baseRefreshIntervalInSeconds` [optional]: Number of seconds after which the base query will be run again. Default value: `86400` (24 hrs)
  - `update` [optional]: A function to update the cache, see: [Apollo's `update` function](https://www.apollographql.com/docs/react/data/mutations#the-update-function)

**subscriptionQuery**
  - `query`: A `DocumentNode` for the subscription (e.g. as returned by [`gql`](https://github.com/apollographql/graphql-tag#gql))
  - `variables` [optional]: An object with the query variables, if any.
  - `update` [optional]: A function to update the cache, see: [Apollo's `update` function](https://www.apollographql.com/docs/react/data/mutations#the-update-function)

**deltaQuery**
  - `query`: A `DocumentNode` for the deltas (e.g. as returned by [`gql`](https://github.com/apollographql/graphql-tag#gql))
  - `variables` [optional]: An object with the query variables, if any.
  - `update` [optional]: A function to update the cache, see: [Apollo's `update` function](https://www.apollographql.com/docs/react/data/mutations#the-update-function)

## The buildSync helper

The quickest way to get started with the DeltaSync feature is by using the `buildSync` helper function. This helper function will build an `options` object with the appropriate `update` functions that will update the cache for you in a similar fashion to the [offline helpers](https://github.com/awslabs/aws-mobile-appsync-sdk-js/blob/master/OFFLINE_HELPERS.md).

The first argument you need to pass is the GraphQL `__typename` for your base query. The second argument is the `options` object from the previous section (without the `update` keys, since those will be generated for you by this helper function).

You can **optionally** pass a `cacheUpdates` parameter to the second argument with the following structure:
- **deltaRecord**: A function which receives a `deltaRecord` (e.g. an individual item in the cache populated by the base/delta/subscription query) and returns an array of GraphQL queries and it's variables to be written to the cache.

Example:

```typescript
  client.sync(
    buildSync("Post", ,
      subscriptionQuery: ,
      deltaQuery: ,
      cacheUpdates: ( deltaRecord  ) =>  }];
      }
    })
  )
```

### Requirements for helper function
- Your `baseQuery` returns a list, not a nested type
- Your `deltaQuery` expects a parameter called `lastSync` of type `AWSTimestamp` and returns a list with the same fields as your `baseQuery` (an optionally, an `aws_ds` field with a value of `'DELETE'` for deletions, any other value for insert/update)
- The mutations that trigger the subscription in your `subscriptionQuery` should return a single record with the same fields as the items from your `baseQuery`, (an optionally, an `aws_ds` field with a value of `'DELETE'` for deletions, any other value for insert/update)

### Example

The schema for this sample is below. [A full sample with CloudFormation is available in the AppSync documentation](https://docs.aws.amazon.com/appsync/latest/devguide/tutorial-delta-sync.html).

```graphql
input CreatePostInput 

enum DeltaAction 

type Mutation 

type Post 

type Query 

type Subscription 

input UpdatePostInput 

schema 
```

### Sample queries

```graphql
query Base 
}

query Delta($lastSync: AWSTimestamp!) 
}

subscription Subscription 
}
```

Define the queries from above in a `./graphql/DeltaSync.js` file to import in your app:

```javascript

```typescript

const client = new AWSAppSyncClient();

const subscription = client.sync(
  buildSync('Post', ,
    subscriptionQuery: ,
    deltaQuery: ,
    cacheUpdates : () => []
  })
);
```

### React example

Suppose you have an app created with [Create React App](https://github.com/facebook/create-react-app) with the following structure:

- App.js
  - Sets up `AWSAppSyncClient` and `client.sync` as above
  - Renders `` and ``
- AllPosts.jsx exports ``
- GetPost.jsx exports ``

`App.js`

```typescript
const client = new AWSAppSyncClient(
});

client.hydrated().then(() =>
  client.sync(
    buildSync("Post", ,
      subscriptionQuery: ,
      deltaQuery: ,
      cacheUpdates: () => [
         }
      ]
    })
  )
);

const App = () => (

      <div>
        
        <hr />
        
      </div>
    </Rehydrated>
  </ApolloProvider>
);
```

In `AllPosts.jsx` you would have code like so:

```typescript
const AllPosts = () => (
  <div>
    <pre style=}>
      
    </pre>
  </div>
);

In `GetPost.jsx` you would have:

```typescript
const OnePost = () => (
  <div>
    <pre style=}></pre>
  </div>
);

**Note**: The `fetchPolicy` is `cache-only` as all of the network requests are handled automatically by the `client.sync()` operation. You should use this if using different queries in other components as the `client.sync()` API manages the cache lifecycle. If you use another `fetch-policy` such as `cache-and-network` then extra network requests may take place negating the Delta Sync benefits.

## Writing update functions

If you do not want to use the `buildSync` helper then you are responsible for managing cache updates in your application code. Note that this can be a complex process as you will need to manage create, update, and deletes appropriately. An example of this would be updating the cache with a delta record as below, noting that you must update the returned type to match the type from your base query.

```javascript
client.sync(,
      deltaQuery:  }) => ;

            cache.writeQuery( }
            });
          });
        }
      }
    });
```
