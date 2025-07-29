---
title: Documentation
source: fragments/lib/datastore/js/datastore-events.mdx
---

# Documentation

```js
// Create listener
const listener = Hub.listen('datastore', async hubData =>  = hubData.payload;
  if (event === 'networkStatus') `)
  }
})

// Remove listener
listener();
```

To wait for the entire sync process to finish, you can listen for the `ready` event:

```js
// Create listener
const listener = Hub.listen("datastore", async hubData =>  = hubData.payload;
  if (event === "ready") 
})

// Remove listener
listener();
```

Here is an illustrative sample of events and payloads that happen when you start from an empty DataStore and start a sync. If you do:

```js
await DataStore.clear();
await DataStore.start();
```

This gets logged:

```bash
Event:  ,"source":"","patternInfo":[]}

Event:  },"source":"","patternInfo":[]}

Event:  },"source":"","patternInfo":[]}

Event:  ,"source":"","patternInfo":[]}

Event:  },"source":"","patternInfo":[]}

Event:  }},"source":"","patternInfo":[]}

Event:  }},"source":"","patternInfo":[]}

Event:  }},"source":"","patternInfo":[]}

Event:  ,"source":"","patternInfo":[]}

Event:  ,"source":"","patternInfo":[]}
```
