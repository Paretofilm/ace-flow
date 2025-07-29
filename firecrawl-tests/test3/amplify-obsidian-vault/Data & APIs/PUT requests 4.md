---
title: PUT requests
topics: ['Data & APIs']
primary_topic: Data & APIs
source: pages/build-a-backend/add-aws-services/rest-api/update-data/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# PUT requests

## PUT requests

To create or update a item via the API endpoint:

```ts

async function updateItems() ;
    const restOperation = put(,
    });
    const response = await restOperation.response;
    console.log('PUT call succeeded: ', response);
  } catch (error) 
}
```


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/rest-api/update-data/index.mdx`