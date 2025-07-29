---
title: CANCEL API requests
source: fragments/lib-v1/graphqlapi/js/cancel-request.mdx
---

# CANCEL API requests

## CANCEL API requests

You may cancel any query or mutation request made through API category by keeping a reference to the promise returned.

```javascript
const promise = API.graphql(graphqlOperation(...));

try  catch (error) 
}

...

// To cancel the above request
API.cancel(promise, "my message for cancellation");
```

You need to ensure that the promise returned from `API.graphql()` has not been modified. Typically async functions wrap the promise being returned into another promise. For example, the following will not work

```javascript
async function makeAPICall() 
const promise = makeAPICall();

// The following will NOT cancel the request.
API.cancel(promise, "my error message");
```
