---
title: Documentation
source: fragments/lib/graphqlapi/js/cancel-request.mdx
---

# Documentation

You may cancel any query or mutation request made through API category by keeping a reference to the promise returned.

```javascript
const promise = client.graphql();

try  catch (error) 
}

...

// To cancel the above request
client.cancel(promise, "my message for cancellation");
```

You need to ensure that the promise returned from `client.graphql()` has not been modified. Typically async functions wrap the promise being returned into another promise. For example, the following will not work

```javascript
async function makeAPICall() );
}
const promise = makeAPICall();

// The following will NOT cancel the request.
client.cancel(promise, 'my error message');
```
