---
title: Working with the API
source: pages/build-a-backend/add-aws-services/predictions/identify-text/index.mdx
---

# Working with the API

> **Note**: 

**Note:** Make sure to complete the [getting started](../set-up-predictions) section first, where you will set up the IAM roles with the right policy actions

## Working with the API

Detect text in an input image. Input can be sent directly from the browser or an Amazon S3 key from project bucket.

```ts

const response = await Predictions.identify(
  }
});
```

## Identify image stored in Amazon S3

```ts

const response = await Predictions.identify(
  }
})
```

> The following options are independent of which `source` is specified. For demonstration purposes we will reference a `file` but it can be an S3 Key as well. `Predictions.identify(})` can detect unstructured text `PLAIN`, structured text from tables `TABLE` or text from forms `FORM`.

## Identify plain text

For detecting plain text, you can see the whole detected text, the lines detected, the position of each line of text, and each word.

```ts

const response = await Predictions.identify(,
    format: 'PLAIN'
  }
});

const ,
        polygon // Array of  coordinates as a ratio of overall image width and height
        */,
    words // Array of objects that contains 
  }
} = response;
```

## Identify structured forms

For detecting structured forms (documents, tables, etc.) from an image, `keyValues` will return a string of the entity found in the image as well as metadata such as selected checkboxes or the relative location in the image using a `boundingBox`.

```ts

const response = await Predictions.identify(,
    format: 'FORM'
  }
});

const , polygon, boundingBox }
  }
} = response;
```

For example the below image would return `keyValues` with "Test" or "Checked" as a key, and `true` since they are selected. The location of these elements would be returned in the `boundingBox` value.

![A table of key values containing "Test" or "Checked" as keys, with a value of true indicating their selection status. The positions of these elements will be provided within the boundingBox parameter](/images/IdentifyTable.png)

## Identify structured tables

For detecting structured tables from an image

```ts

const response = await Predictions.identify(,
    format: 'TABLE'
  }
});

const ,
        table // Matrix Array[ Array ] of size rows
        // each element of the array contains 
      }
    ]
  }
} = response;
```

For detecting tables and forms on the image just select format "ALL"

```ts

const  = await Predictions.identify(,
    format: 'ALL'
  }
});
```
