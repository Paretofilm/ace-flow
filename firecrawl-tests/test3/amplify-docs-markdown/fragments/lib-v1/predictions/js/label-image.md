---
title: Setup the backend
source: fragments/lib-v1/predictions/js/label-image.mdx
---

# Setup the backend

## Setup the backend

If you haven't already done so, run `amplify init` inside your project and then `amplify add auth` (we recommend selecting the *default configuration*).

Run `amplify add predictions` and select **Identify**. Then use the following answers:

```console
? What would you like to identify? 
  Identify Text 
  Identify Entities 
❯ Identify Labels 
  Learn More 

? Would you like use the default configuration? (Use arrow keys)
❯ Default Configuration 
  Advanced Configuration 

? Who should have access? Auth and Guest users
```

The Advanced Configuration will allow you to select moderation for unsafe content or all of the identified labels. Default uses both.

Now run `amplify push` which will generate your `aws-exports.js` and create resources in the cloud. You can now either add this to your backend or skip and add more features to your app.

Services used: Amazon Rekognition

## Working with the API

Detect labels, such if an image has a desk or a chair in it

```javascript
Predictions.identify(,
    type: "LABELS"
  }
})
.then(response =>  = response;
  labels.forEach(object =>  = object
  });
})
.catch(err => console.log());
```

Detect unsafe content in an image

```javascript
Predictions.identify(,
    type: "UNSAFE"
  }
})
.then(response =>  = response; // boolean 
})
.catch(err => console.log());
```

for both labels and unsafe content
```javascript
Predictions.identify(,
    type: "ALL"
  }
})
.then(response =>  = response;
  const  = response; // boolean 
  labels.forEach(object =>  = object
  });
})
.catch(err => console.log();
```
