---
title: Documentation
topics: ['General']
primary_topic: General
source: fragments/lib/predictions/android/escapehatch.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# Documentation

If you need functionality in the AWS services used by the Amplify Predictions category that isn't available, we provide an escape hatch so you can get a reference to that service. For example, to get a reference to `RekognitionClient`:

```java
// Obtain reference to the plugin
AWSPredictionsPlugin predictionsPlugin = (AWSPredictionsPlugin)
  Amplify.Predictions.getPlugin("awsPredictionsPlugin");
AWSPredictionsEscapeHatch escapeHatch = predictionsPlugin.getEscapeHatch();

// Send a new request to the Rekognition endpoint directly using the client
RekognitionClient client = escapeHatch.getRekognitionClient();
CreateCollectionRequest request = CreateCollectionRequest.Companion.invoke((requestBuilder) -> );
client.createCollection(request, new Continuation() 

  @Override
  public void resumeWith(@NonNull Object resultOrException) 
});
```

</Block>

```kotlin
// Obtain reference to the plugin
val plugin = Amplify.Predictions.getPlugin("awsPredictionsPlugin")
val escapeHatch = (plugin as AWSPredictionsPlugin).escapeHatch

// Send a new request to the Rekognition endpoint directly using the client
val client = escapeHatch.rekognitionClient
val request = CreateCollectionRequest 
client.createCollection(request)
```

</Block>
</BlockSwitcher>

In addition to the Amazon Polly APIs, the `PollyClient` returned in the escape hatch provides a way to create a presigned URL for a text to speech request. An example of creating a presigned URL is below.

```java
// Obtain reference to the plugin
AWSPredictionsPlugin predictionsPlugin = (AWSPredictionsPlugin)
  Amplify.Predictions.getPlugin("awsPredictionsPlugin");
AWSPredictionsEscapeHatch escapeHatch = predictionsPlugin.getEscapeHatch();

// Create a presigned URL to convert text to speech using the client
AmazonPollyPresigningClient client = (AmazonPollyPresigningClient) escapeHatch.getPollyClient();
SynthesizeSpeechRequest request = SynthesizeSpeechRequest.Companion.invoke((requestBuilder) -> );

// The presigned URL needs to be created on a worker thread
runOnUiThread(new Runnable() 
});
```

</Block>

```kotlin
// Obtain reference to the plugin
val plugin = Amplify.Predictions.getPlugin("awsPredictionsPlugin")
val escapeHatch = (plugin as AWSPredictionsPlugin).escapeHatch

// Create a presigned URL to convert text to speech using the client
val client = escapeHatch.pollyClient as AmazonPollyPresigningClient
val request = SynthesizeSpeechRequest 

// The presigned URL needs to be created on a worker thread
runOnUiThread 
```

</Block>
</BlockSwitcher>

**API Documentation Resources**

* [Amazon Rekognition API Reference](https://docs.aws.amazon.com/rekognition/latest/dg/API_Reference.html)
* [Amazon Translate API Reference](https://docs.aws.amazon.com/translate/latest/dg/API_Reference.html)
* [Amazon Polly API Reference](https://docs.aws.amazon.com/polly/latest/dg/API_Reference.html)
* [Amazon Comprehend API Reference](https://docs.aws.amazon.com/comprehend/latest/dg/API_Reference.html)
* [Amazon Textract API Reference](https://docs.aws.amazon.com/textract/latest/dg/API_Reference.html)


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/predictions/android/escapehatch.mdx`