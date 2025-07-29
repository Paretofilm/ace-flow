---
title: Identify entities from images
source: fragments/lib-v1/predictions/js/identify-entity.mdx
---

# Identify entities from images

## Identify entities from images

Setup your backend with the following:
If you haven't already done so, run `amplify init` inside your project and then `amplify add auth` (we recommend selecting the *default configuration*).

Run `amplify add predictions` and select **Identify**. Then use the following answers:

```console
? What would you like to identify? 
  Identify Text 
❯ Identify Entities 
  Identify Labels 
  Learn More 

? Would you like use the default configuration? Default Configuration

? Who should have access? Auth and Guest users
```

Now run `amplify push` which will generate your `aws-exports.js` and create resources in the cloud. You can now either add this to your backend or skip and add more features to your app.

Services used: Amazon Rekognition

### Advanced configuration

You can enhance your application's ability to identify entities by performing [indexing against a pre-defined collection of images and providing them to Amazon Rekognition](https://docs.aws.amazon.com/rekognition/latest/dg/API_IndexFaces.html). This can be done in one of two ways:
1. Administrators provide images to be indexed from an S3 bucket
2. Application users upload files to an S3 bucket which are indexed

Amplify configures Lambda Triggers to automatically perform this indexing when the files are uploaded. As Rekognition does not store any faces, but rather the facial features into a vector which are stored in the backend, these images can be deleted after indexing if you choose to do so. However note that by default the Lambda Triggers will remove the index if you delete an image so you will need to modify their behavior if you desire this functionality.

To add this functionality into your application choose **advanced** when prompted in the **Identify** flow (if you already enabled `Identify Entities` you will need to run `amplify update predictions`):

```console
? What would you like to identify? Identify Entities
? Would you like use the default configuration? Advanced Configuration
? Would you like to enable celebrity detection? Yes
? Would you like to identify entities from a collection of images? Yes
? How many entities would you like to identify 50
? Would you like to allow users to add images to this collection? Yes
? Who should have access? Auth and Guest users
? The CLI would be provisioning an S3 bucket to store these images please provide bucket name: mybucket
```

Note that if you already have an S3 bucket in your project from running `amplify add storage` it would be reused. To upload images from the CLI for administrator indexing, you can run `amplify predictions console` and select `Identify` which will open the S3 bucket location in the AWS console for you to upload your images.

For application users, when they upload images with `Storage.put()` they will specify a prefix which the Lambda functions perform indexing like so:

```javascript
Storage.put('test.jpg', file, ,
});
```

In the sample React application code ahead, you will see that to use this functionality you will need to set `collection:true` when calling `Predictions.identify()` and remove `celebrityDetection: true`. The flow is that you will first upload an image to S3 with the `PredictionsUpload` function (which is connected to a button in the app) and after a few seconds you can send this same image to `Predictions.identify()` and it will check if that image has been indexed in the Collection.

## Working with the API

`Predictions.identify(}) => Promise<>`
Detects entities from an image and potentially related information such as position, faces, and landmarks. Can also identify celebrities and entities that were previously added. This function returns a Promise that returns an object with the entities that was identified.  

Input can be sent directly from the browser (using File object or ArrayBuffer object) or an Amazon S3 key from project bucket.

Detect entities directly from image uploaded from the browser. (File object)

```javascript
Predictions.identify(,
  }
})
.then((response) => console.log())
.catch(err => console.log());
```

Detect entities directly from image binary from the browser. (ArrayBuffer object)
This technique is useful when you have base64 encoded binary image data, for example, from a webcam source.

```javascript
Predictions.identify(,
  }
})
.then((response) => console.log())
.catch(err => console.log());
```

From Amazon S3 key
```javascript
Predictions.identify(,
  }
})
.then((response) => console.log())
.catch(err => console.log());
```

The following options are independent of which `source` is specified. For demonstration purposes it will be used `file` but it can be used S3 Key as well. 

Detecting bounding box of faces from an image with its landmarks (eyes, mouth, nose).

```javascript
Predictions.identify(,
  }
})
.then(() => ) =>  = boundingBox;
    landmarks.forEach(landmark =>  = landmark;
    })
  })
})
.catch(err => console.log());
```

Detecting celebrities on an image. It will return only celebrities the name and urls with related information.

```javascript
Predictions.identify(,
    celebrityDetection: true // boolean. It will only show detected celebrities 
  }
})
.then(() => ) =>  = metadata; // celebrity info
    
    // ...
  })
})
.catch(err => console.log());
```

Detecting entities from previously uploaded images (e.g. Advanced Configuration for Identify Entities)

```javascript
Predictions.identify(,
    collection: true
  }
})
.then(() =>  }) =>  = boundingBox;
    console.log(); // this is the object key on S3 from the original image!
    
    Storage.get("", ,
      level: "public",
    }).then(src => console.log());
  })
})
.catch(err => console.log(err));
```
