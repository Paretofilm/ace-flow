---
title: Download data
source: fragments/lib-v1/storage/ios/download.mdx
---

# Download data

There are three ways of getting data that was previously uploaded:

## Download data

You can download to in-memory buffer [Data](https://developer.apple.com/documentation/foundation/data) object with `Amplify.Storage.downloadData`:

```swift
let storageOperation = Amplify.Storage.downloadData(
    key: "myKey",
    progressListener: , resultListener: 
})
```

</Block>

```swift
let storageOperation = Amplify.Storage.downloadData(key: "myKey")
let progressSink = storageOperation.progressPublisher.sink 
let resultSink = storageOperation.resultPublisher.sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>

## Download to file

You can download to a file [URL](https://developer.apple.com/documentation/foundation/url) with `Amplify.Storage.downloadFile`:

```swift
let downloadToFileName = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
)[0].appendingPathComponent("myFile.txt")

let storageOperation = Amplify.Storage.downloadFile(
    key: "myKey",
    local: downloadToFileName,
    progressListener: , resultListener: 
    })
```

</Block>

```swift
let downloadToFileName = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
)[0].appendingPathComponent("myFile.txt")

let storageOperation = Amplify.Storage.downloadFile(
    key: "myKey",
    local: downloadToFileName
)

let progressSink = storageOperation.progressPublisher.sink 

let resultSink = storageOperation.resultPublisher.sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>

## Cancel, Pause, Resume

Calls to `downloadData` or `downloadFile` return a reference to the operation that is actually performing the download.

To cancel the download (for example, in response to the user pressing a **Cancel** button), you simply call `cancel()` on the download operation.

```swift
func cancelDownload() 
```

You can also pause and then resume the operation.

> **Note**: 

Note that pause internally uses the `suspend` api of `NSURLSessionTask`, which suspends the task temporarily and does not fully pause the transfer. Complete pausing of task is tracked in this Github issue - https://github.com/aws-amplify/aws-sdk-ios/issues/3668

```swift
storageOperation.pause()
storageOperation.resume()
```

## Generate a download URL

You can also retrieve a URL for the object in storage:

```swift
Amplify.Storage.getURL(key: "myKey") 
}
```

</Block>

```swift
let sink = Amplify.Storage.getURL(key: "myKey")
    .resultPublisher
    .sink 
    }
    receiveValue: 
```

</Block>

</BlockSwitcher>
