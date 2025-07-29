---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib-v1/restapi/js/cancel.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

You may cancel any request made through API category by keeping a reference to the promise returned.

```javascript
const promise = API.get(myApiName, myPath, myInit);

try  catch (error) 
}

...

// To cancel the above request
API.cancel(promise, "my message for cancellation");
```

You need to ensure that the promise returned from `API.get()` or any other API calls has not been modified. Typically async functions wrap the promise being returned into another promise. For example, the following will not work

```javascript
async function makeAPICall() 
const promise = makeAPICall();

// The following will NOT cancel the request.
API.cancel(promise, 'my error message');
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/restapi/js/cancel.mdx`