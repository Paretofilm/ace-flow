---
title: Download to file
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib/storage/android/download.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Download to file

## Download to file

### With StoragePath

```java
Amplify.Storage.downloadFile(
        StoragePath.fromString("public/example"),
        new File(getApplicationContext().getFilesDir() + "/download.txt"),
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
);
```

</Block>

```kotlin
val file = File("$/download.txt")
Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file,
    ") },
    
)
```

</Block>

```kotlin
try /download.txt")
    val download = Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file)
    try  catch (error: StorageException) 
}
```

</Block>

```java
RxProgressAwareSingleOperation download =
        RxAmplify.Storage.downloadFile(
            StoragePath.fromString("public/example"),
            new File(getApplicationContext().getFilesDir() + "/download.txt"
        );

download
    .observeResult()
    .subscribe(
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
    );
```

</Block>
</BlockSwitcher>

#### With Key (Deprecated)

```java
Amplify.Storage.downloadFile(
        "ExampleKey",
        new File(getApplicationContext().getFilesDir() + "/download.txt"),
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
);
```

</Block>

```kotlin
val file = File("$/download.txt")
Amplify.Storage.downloadFile("ExampleKey", file,
    ") },
    
)
```

</Block>

```kotlin
try /download.txt")
    val download = Amplify.Storage.downloadFile("ExampleKey", file)
    try  catch (error: StorageException) 
}
```

</Block>

```java
RxProgressAwareSingleOperation download =
        RxAmplify.Storage.downloadFile(
            "ExampleKey",
            new File(getApplicationContext().getFilesDir() + "/download.txt"
        );

download
    .observeResult()
    .subscribe(
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
    );
```

</Block>
</BlockSwitcher>

## Track download progress

To track progress of the download, use the `downloadFile` API that includes a progress listener callback.

### With StoragePath

```java
Amplify.Storage.downloadFile(
        StoragePath.fromString("public/example"),
        new File(getApplicationContext().getFilesDir() + "/download.txt"),
        StorageDownloadFileOptions.defaultInstance(),
        progress -> Log.i("MyAmplifyApp", "Fraction completed: " + progress.getFractionCompleted()),
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
);
```

</Block>

```kotlin
val file = File("$/download.txt")
val options = StorageDownloadFileOptions.defaultInstance()
Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file, options,
    ") },
    ") },
    
)
```

</Block>

```kotlin
val file = File("$/download.txt")
val options = StorageDownloadFileOptions.defaultInstance()
val download = Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file, options)
val progressJob = activityScope.async ")
    }
}
try  catch (error: StorageException) 
progressJob.cancel()
```

</Block>

```java
RxProgressAwareSingleOperation download =
        RxAmplify.Storage.downloadFile(StoragePath.fromString("public/example"), localFile);

download
    .observeProgress()
    .subscribe(
      progress -> Log.i("MyAmplifyApp", progress.getFractionCompleted())
    );
```

</Block>
</BlockSwitcher>

#### With Key (Deprecated)

```java
Amplify.Storage.downloadFile(
        "ExampleKey",
        new File(getApplicationContext().getFilesDir() + "/download.txt"),
        StorageDownloadFileOptions.defaultInstance(),
        progress -> Log.i("MyAmplifyApp", "Fraction completed: " + progress.getFractionCompleted()),
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
);
```

</Block>

```kotlin
val file = File("$/download.txt")
val options = StorageDownloadFileOptions.defaultInstance()
Amplify.Storage.downloadFile("ExampleKey", file, options,
    ") },
    ") },
    
)
```

</Block>

```kotlin
val file = File("$/download.txt")
val options = StorageDownloadFileOptions.defaultInstance()
val download = Amplify.Storage.downloadFile("ExampleKey", file, options)
val progressJob = activityScope.async ")
    }
}
try  catch (error: StorageException) 
progressJob.cancel()
```

</Block>

```java
RxProgressAwareSingleOperation download =
        RxAmplify.Storage.downloadFile(remoteKey, localFile);

download
    .observeProgress()
    .subscribe(
      progress -> Log.i("MyAmplifyApp", progress.getFractionCompleted())
    );
```

</Block>
</BlockSwitcher>

## Generate a download URL

You can also retrieve a URL for the object in storage:

### With StoragePath

```java
Amplify.Storage.getUrl(
    StoragePath.fromString("public/example"),
    result -> Log.i("MyAmplifyApp", "Successfully generated: " + result.getUrl()),
    error -> Log.e("MyAmplifyApp", "URL generation failure", error)
);
```

</Block>

```kotlin
Amplify.Storage.getUrl(
    StoragePath.fromString("public/example"),
    ") },
    
)
```

</Block>

```kotlin
try  catch (error: StorageException) 
```

</Block>

```java
RxAmplify.Storage.getUrl(StoragePath.fromString("public/example")).subscribe(
    result -> Log.i("MyAmplifyApp", "Successfully generated: " + result.getUrl()),
    error -> Log.e("MyAmplifyApp", "URL generation failure", error)
);
```

</Block>
</BlockSwitcher>

#### With Key (Deprecated)

```java
Amplify.Storage.getUrl(
    "ExampleKey",
    result -> Log.i("MyAmplifyApp", "Successfully generated: " + result.getUrl()),
    error -> Log.e("MyAmplifyApp", "URL generation failure", error)
);
```

</Block>

```kotlin
Amplify.Storage.getUrl(
    "ExampleKey",
    ") },
    
)
```

</Block>

```kotlin
try  catch (error: StorageException) 
```

</Block>

```java
RxAmplify.Storage.getUrl("ExampleKey").subscribe(
    result -> Log.i("MyAmplifyApp", "Successfully generated: " + result.getUrl()),
    error -> Log.e("MyAmplifyApp", "URL generation failure", error)
);
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib/storage/android/download.mdx`