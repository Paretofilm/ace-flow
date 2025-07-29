---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/js/datastore-events.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/js/datastore-events.mdx`