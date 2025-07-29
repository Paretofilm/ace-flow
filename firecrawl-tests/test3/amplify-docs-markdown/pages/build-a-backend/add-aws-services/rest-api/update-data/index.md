---
title: PUT requests
source: pages/build-a-backend/add-aws-services/rest-api/update-data/index.mdx
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
