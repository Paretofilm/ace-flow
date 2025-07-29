---
title: Documentation
source: fragments/lib/restapi/js/cancel.mdx
---

# Documentation

You may cancel any request made through API category. This is useful for cancelling requests when a user navigates away from a page or when a component unmounts.

```javascript

const restOperation = get(input);
try  catch (error)  else 
}

...

// To cancel the above request
restOperation.cancel('my optional message for cancellation');
```

> **Note**: 
  The cancellation is best-effort. If the server has already processed the
  request, the effect of cancellation is non-deterministic.
