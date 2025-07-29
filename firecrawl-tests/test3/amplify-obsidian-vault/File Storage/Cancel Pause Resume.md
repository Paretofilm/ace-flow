---
title: Cancel, Pause, Resume
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/ios/upload.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Cancel, Pause, Resume

To upload to S3 from a data object, specify the `key` and the `data` object to be uploaded.

```swift
let dataString = "My Data"
let data = dataString.data(using: .utf8)!
let storageOperation = Amplify.Storage.uploadData(
    key: "ExampleKey",
    data: data,
    progressListener: , resultListener: 
    }
)
```

</Block>

```swift
let dataString = "My Data"
let data = dataString.data(using: .utf8)!
let storageOperation = Amplify.Storage.uploadData(key: "ExampleKey", data: data)
let progressSink = storageOperation.progressPublisher.sink 
let resultSink = storageOperation.resultPublisher.sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>

When you have a file that you want to upload, you can specify the url to the file in the `local` parameter.

```swift
let dataString = "My Data"
let fileNameKey = "myFile.txt"
let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    .appendingPathComponent(fileNameKey)
do  catch 

let storageOperation = Amplify.Storage.uploadFile(
    key: fileNameKey,
    local: filename,
    progressListener: , resultListener: 
    }
)
```

</Block>

```swift
let dataString = "My Data"
let fileNameKey = "myFile.txt"
let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    .appendingPathComponent(fileNameKey)
do  catch 

let storageOperation = Amplify.Storage.uploadFile(key: fileNameKey, local: filename)
let progressSink = storageOperation.progressPublisher.sink 
let resultSink = storageOperation.resultPublisher.sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>

## Cancel, Pause, Resume

Calls to `uploadData` or `uploadFile` return a reference to the operation that is actually performing the upload.

To cancel the upload (for example, in response to the user pressing a **Cancel** button), you simply call `cancel()` on the upload operation.

```swift
func cancelUpload() 
```

You can also pause then resume the operation.

> **Note**: 

Note that pause internally uses the `suspend` api of `NSURLSessionTask`, which suspends the task temporarily and does not fully pause the transfer. Complete pausing of task is tracked in this Github issue - https://github.com/aws-amplify/aws-sdk-ios/issues/3668

```swift
storageOperation.pause()
storageOperation.resume()
```

## MultiPart upload

The upload will automatically perform a S3 multipart upload for files larger than 5MB. For more information about S3's multipart upload, see [Uploading and copying objects using multipart upload
](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html)


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/ios/upload.mdx`