---
title: Working with the API
topics: ['General']
primary_topic: General
source: pages/build-a-backend/add-aws-services/predictions/identify-entity/index.mdx
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

`Predictions.identify(}) => Promise<>`
Detects entities from an image and potentially related information such as position, faces, and landmarks. Can also identify celebrities and entities that were previously added. This function returns a Promise that returns an object with the entities that was identified.  

Input can be sent directly from the browser (using File object or ArrayBuffer object) or an Amazon S3 key from project bucket.

Detect entities directly from image uploaded from the browser. (File object)

```ts

const response = await Predictions.identify(,
  }
});
```

Detect entities directly from image binary from the browser. (ArrayBuffer object)
This technique is useful when you have base64 encoded binary image data, for example, from a webcam source.

```ts

const response = await Predictions.identify(,
  }
});
```

From Amazon S3 key

```ts

const response = await Predictions.identify(,
  }
});
```

The following options are independent of which `source` is specified. For demonstration purposes it will be used `file` but it can be used S3 Key as well. 

Detecting bounding box of faces from an image with its landmarks (eyes, mouth, nose).

```ts

const  = await Predictions.identify(,
  }
})
for (const  of entities)  = boundingBox;
  
  for (const landmark of landmarks)  = landmark;
  }
}
```

Detecting celebrities on an image. It will return only celebrities the name and urls with related information.

```ts

const  = await Predictions.identify(,
    celebrityDetection: true // boolean. It will only show detected celebrities 
  }
})

for (const  of entities)  = metadata; // celebrity info
  
  // ...
}
.catch(err => console.log());
```

Detecting entities from previously uploaded images (e.g. Advanced Configuration for Identify Entities)

```ts

const  = await Predictions.identify(,
    collection: true
  }
})

for (const  of entities)  = boundingBox;
  const  = metadata; // this is the object key on S3 from the original image
}
```


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/predictions/identify-entity/index.mdx`