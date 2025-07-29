---
title: Documentation
source: fragments/guides/api-rest/js/express-api-call.mdx
---

# Documentation

Now you can start interacting with the API:

```js
// get request
const items = await API.get('myapi', '/items')

// post with data
const data =  }
await API.post('myapi', '/items', data)
```
