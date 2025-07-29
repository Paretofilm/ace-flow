---
title: Set up the backend
source: fragments/lib/predictions/js/identify-text.mdx
---

# Set up the backend

## Set up the backend

If you haven't already done so, run `amplify init` inside your project and then `amplify add auth` (we recommend selecting the _default configuration_).

Run `amplify add predictions` and select **Identify**. Then use the following answers:

```console
? What would you like to identify? (Use arrow keys)
❯ Identify Text
  Identify Entities
  Identify Labels
  Learn More

? Would you also like to identify documents? Yes
? Who should have access? Auth and Guest users
```

**NOTE:** Due to a [known issue](https://github.com/aws-amplify/amplify-cli/issues/12159), you will need to update your amplify backend configuration with the properties below before pushing to the cloud:

**amplify/backend/identify-text-resource/parameters.json**

```json
"identifyDoc": true,
"access": "auth | authAndGuest",
"format": "PLAIN | FORM | TABLE | ALL"
```

Now run `amplify push` which will generate your `amplifyconfiguration.json` and create resources in the cloud. You can now either add this to your backend or skip and add more features to your app.

Services used: Amazon Rekognition (default for plain text) and Amazon Textract (default for documents)

## Working with the API

Detect text in an input image. Input can be sent directly from the browser or an Amazon S3 key from project bucket.

```javascript

const response = await Predictions.identify(
  }
});
console.log();
```

## Identify image stored in Amazon S3

```javascript

const response = await Predictions.identify(
  }
})
console.log();
```

> The following options are independent of which `source` is specified. For demonstration purposes we will reference a `file` but it can be an S3 Key as well. `Predictions.identify(})` can detect unstructured text `PLAIN`, structured text from tables `TABLE` or text from forms `FORM`.

## Identify plain text

For detecting plain text, you can see the whole detected text, the lines detected, the position of each line of text, and each word.

```javascript

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

```javascript

const response = await Predictions.identify(,
    format: 'FORM'
  }
});

const , polygon, boundingBox }
  }
} = response;
```

For example the below image would return `keyValues` with "Test" or "Checked" as a key, and `true` since they are selected. The location of these elements would be returned in the `boundingBox` value.

![Image](/images/IdentifyTable.png)

## Identify structured tables

For detecting structured tables from an image

```javascript

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

```javascript

const response = await Predictions.identify(,
    format: 'ALL'
  }
});

const 
} = response;
```
