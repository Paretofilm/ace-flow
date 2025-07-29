---
title: Download data
source: fragments/lib/storage/ios/download.mdx
---

# Download data

There are three ways of getting data that was previously uploaded:

## Download data

You can download to in-memory buffer [Data](https://developer.apple.com/documentation/foundation/data) object with `Amplify.Storage.downloadData`:

### With StoragePath

```swift
let downloadTask = Amplify.Storage.downloadData(path: .fromString("public/example/path"))
Task 
}
let data = try await downloadTask.value
print("Completed: \(data)")
```

</Block>

```swift
let downloadTask = Amplify.Storage.downloadData(path: .fromString("public/example/path"))
let progressSink = downloadTask
    .inProcessPublisher
    .sink 

let resultSink = downloadTask
    .resultPublisher
    .sink 
    }
    receiveValue: 
```

</Block>

</BlockSwitcher>

### With Key (Deprecated)

```swift
let downloadTask = Amplify.Storage.downloadData(key: "ExampleKey")
Task 
}
let data = try await downloadTask.value
print("Completed: \(data)")
```

</Block>

```swift
let downloadTask = Amplify.Storage.downloadData(key: "ExampleKey")
let progressSink = downloadTask
    .inProcessPublisher
    .sink 

let resultSink = downloadTask
    .resultPublisher
    .sink 
    }
    receiveValue: 
```

</Block>

</BlockSwitcher>

## Download to file

You can download to a file [URL](https://developer.apple.com/documentation/foundation/url) with `Amplify.Storage.downloadFile`:

### With StoragePath

```swift
let downloadToFileName = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
)[0].appendingPathComponent("myFile.txt")

let downloadTask = Amplify.Storage.downloadFile(
    path: .fromString("public/example/path"),
    local: downloadToFileName,
    options: nil
)
Task 
}
try await downloadTask.value
print("Completed")
```

</Block>

```swift
let downloadToFileName = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
)[0].appendingPathComponent("myFile.txt")

let downloadTask = Amplify.Storage.downloadFile(
    path: .fromString("public/example/path"),
    local: downloadToFileName,
    options: nil
)
let progressSink = downloadTask
    .inProcessPublisher
    .sink 

let resultSink = downloadTask
    .resultPublisher
    .sink 
    }
    receiveValue: 
```

</Block>

</BlockSwitcher>

### With Key (Deprecated)

```swift
let downloadToFileName = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
)[0].appendingPathComponent("myFile.txt")

let downloadTask = Amplify.Storage.downloadFile(
    key: "myKey",
    local: downloadToFileName,
    options: nil
)
Task 
}
try await downloadTask.value
print("Completed")
```

</Block>

```swift
let downloadToFileName = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
)[0].appendingPathComponent("myFile.txt")

let downloadTask = Amplify.Storage.downloadFile(
    key: "myKey",
    local: downloadToFileName,
    options: nil
)
let progressSink = downloadTask
    .inProcessPublisher
    .sink 

let resultSink = downloadTask
    .resultPublisher
    .sink 
    }
    receiveValue: 
```

</Block>

</BlockSwitcher>

## Generate a download URL

You can also retrieve a URL for the object in storage:

```swift
let url = try await Amplify.Storage.getURL(path: .fromString("public/example/path"))
print("Completed: \(url)")
```
</Block>

```swift
let url = try await Amplify.Storage.getURL(key: "ExampleKey")
print("Completed: \(url)")
```
</Block>
</BlockSwitcher>

When creating a downloadable URL, you can choose to check if the file exists by setting `validateObjectExistence` to
`true` in `AWSStorageGetURLOptions`. If the file is inaccessible or does not exist, a `StorageError` is thrown.
This allows you to check if an object exists during generating the presigned URL, which you can then use to download
that object.

```swift
let url = try await Amplify.Storage.getURL(
    path: .fromString("public/example/path"),
    options: .init(
        pluginOptions: AWSStorageGetURLOptions(
            validateObjectExistence: true
        )
    )
)
```
</Block>

```swift
let url = try await Amplify.Storage.getURL(
    key: "ExampleKey",
    options: .init(
        pluginOptions: AWSStorageGetURLOptions(
            validateObjectExistence: true
        )
    )
)
```
</Block>

</BlockSwitcher>
## Cancel, Pause, Resume

Calls to `downloadData` or `downloadFile` return a reference to the task that is actually performing the download.

To cancel the download (for example, in response to the user pressing a **Cancel** button), you simply call `cancel()` on the download task.

```swift
func cancelDownload() 
```

You can also pause and then resume the task.

```swift
downloadTask.pause()
downloadTask.resume()
```

> **Note**: 

Download tasks are run using `URLSessionTask` instances internally. You can learn more about them in [Apple's official documentation](https://developer.apple.com/documentation/foundation/urlsessiontask).
