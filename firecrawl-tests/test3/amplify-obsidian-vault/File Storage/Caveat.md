---
title: Caveat
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/js/cancel-requests.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Caveat

You may cancel any `put`, `get`, or `copy` requests made by the Storage API by keeping a
reference to the promise returned.

```javascript
const promise = Storage.get('key');

Storage.cancel(promise, "my message for cancellation");

try  catch (error) 
}
```

## Caveat
Since the cancellation requires original reference of the promise, you need to
make sure the return value of the request has not been modified. Usually `async` function
wraps the promise being returned into another promise. For example
```javascript
async function makeRequest() 
const promise = makeRequest();

// This won't cancel the request
Storage.cancel(promise);
```


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/js/cancel-requests.mdx`