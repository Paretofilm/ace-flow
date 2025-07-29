---
title: Working with the API
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/predictions/label-image/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Working with the API

> **Note**: 

**Note:** Make sure to complete the [getting started](../set-up-predictions) section first, where you will set up the IAM roles with the right policy actions

## Working with the API

Detect labels, such if an image has a desk or a chair in it

```javascript

Predictions.identify(,
    type: 'LABELS'
  }
})
  .then((response) =>  = response;
    labels.forEach((object) =>  = object;
    });
  })
  .catch((err) => console.log());
```

Detect unsafe content in an image

```ts

const  = await Predictions.identify(,
    type: 'UNSAFE'
  }
})
```

For both labels and unsafe content

```ts

const  = await Predictions.identify(,
    type: 'ALL'
  }
})
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/predictions/label-image/index.mdx`