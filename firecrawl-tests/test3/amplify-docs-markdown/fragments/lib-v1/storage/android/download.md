---
title: Download to file
source: fragments/lib-v1/storage/android/download.mdx
---

# Download to file

## Download to file

If you uploaded the data using the key `ExampleKey`, you can retrieve the data using `Amplify.Storage.downloadFile`.

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

### Track download progress

To track progress of the download, use the `downloadFile` API that includes a progress listener callback.

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

### Generate a download URL

You can also retrieve a URL for the object in storage:

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
    ") }
    
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
