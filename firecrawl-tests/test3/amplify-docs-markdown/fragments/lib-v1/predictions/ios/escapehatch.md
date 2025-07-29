---
title: Documentation
source: fragments/lib-v1/predictions/ios/escapehatch.mdx
---

# Documentation

If you need functionality in the AWS services used by the Amplify Predictions category that isn't available, we provide an escape hatch so you can get a reference to that service.  For example, to get a reference to `AWSRekognition`:

```swift
guard let predictionsPlugin = try Amplify.Predictions.getPlugin(for: "awsPredictionsPlugin") as? AWSPredictionsPlugin else 

guard let rekognitionService = predictionsPlugin.getEscapeHatch(key: .rekognition) as? AWSRekognition else 

let request = AWSRekognitionCreateCollectionRequest()
if let request = request 
```

In addition to `AWSRekognition`, this same pattern can be used to get access to `AWSTranslate`, `AWSPolly`, `AWSTranscribeStreaming`, `AWSComprehend`, and `AWSTextract`.  For example:
```swift
guard let translateService = predictionsPlugin.getEscapeHatch(key: .translate) as? AWSTranslate else 

guard let pollyService = predictionsPlugin.getEscapeHatch(key: .polly) as? AWSPolly else 

guard let transcribeService = predictionsPlugin.getEscapeHatch(key: .transcribe) as? AWSTranscribeStreaming else 

guard let comprehendService = predictionsPlugin.getEscapeHatch(key: .comprehend) as? AWSComprehend else 

guard let textractService = predictionsPlugin.getEscapeHatch(key: .textract) as? AWSTextract else 
```

**API Documentation Resources**
* [Amazon Rekognition API Reference](https://docs.aws.amazon.com/rekognition/latest/dg/API_Reference.html)
* [Amazon Translate API Reference](https://docs.aws.amazon.com/translate/latest/dg/API_Reference.html)
* [Amazon Polly API Reference](https://docs.aws.amazon.com/polly/latest/dg/API_Reference.html)
* [Amazon Transcribe API Reference](https://docs.aws.amazon.com/transcribe/latest/dg/API_Reference.html)
* [Amazon Comprehend API Reference](https://docs.aws.amazon.com/comprehend/latest/dg/API_Reference.html)
* [Amazon Textract API Reference](https://docs.aws.amazon.com/textract/latest/dg/API_Reference.html)
