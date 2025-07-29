---
title: Upload InputStream
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/android/upload.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Upload InputStream

Amplify allows you to upload `File`s and `InputStream`s.

## Upload InputStream
To upload data to S3 from an `InputStream`:

```java
private void uploadInputStream()   catch (FileNotFoundException error) 
}
```

</Block>

```kotlin
private fun uploadInputStream(uri: Uri) ") },
        
    )
}
```

</Block>

```kotlin
private suspend fun uploadInputStream(uri: Uri) .")
    } catch (error: StorageException) 
}
```

</Block>

```java
private void uploadInputStream()  catch (FileNotFoundException error) 
}
```

</Block>
</BlockSwitcher>

## Upload files
To upload to S3 from a data object, specify the key and the file to be uploaded. 

```java
private void uploadFile()  catch (Exception exception) 

    Amplify.Storage.uploadFile(
            "ExampleKey",
            exampleFile,
            result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getKey()),
            storageFailure -> Log.e("MyAmplifyApp", "Upload failed", storageFailure)
    );
}
```

</Block>

```kotlin
private fun uploadFile() ") },
        
    )
}
```

</Block>

```kotlin
private suspend fun uploadFile() ")
    } catch (error: StorageException) 
}
```

</Block>

```java
private void uploadFile()  catch (Exception exception) 

    RxProgressAwareSingleOperation rxUploadOperation =
            RxAmplify.Storage.uploadFile("ExampleKey", exampleFile);

    rxUploadOperation
            .observeResult()
            .subscribe(
                result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getKey()),
                error -> Log.e("MyAmplifyApp", "Upload failed", error)
            );
}
```

</Block>
</BlockSwitcher>

To track progress of the upload, use the `uploadFile` API that includes a progress listener callback.

```java
private void uploadFile()  catch (Exception exception) 

    Amplify.Storage.uploadFile(
        "ExampleKey",
        exampleFile,
        StorageUploadFileOptions.defaultInstance(),
        progress -> Log.i("MyAmplifyApp", "Fraction completed: " + progress.getFractionCompleted()),
        result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getKey()),
        storageFailure -> Log.e("MyAmplifyApp", "Upload failed", storageFailure)
    );
}
```

</Block>

```kotlin
private fun uploadFile() ") },
        ") },
        
    )
}
```

</Block>

```kotlin
private suspend fun uploadFile() ")
        }
    }
    try ")
    } catch (error: StorageException) 
    progressJob.cancel()
}
```

</Block>

```java
RxProgressAwareSingleOperation upload =
        RxAmplify.Storage.uploadFile("exampleKey", exampleFile);

upload
    .observeProgress()
    .subscribe(
      progress -> Log.i("MyAmplifyApp", progress.getFractionCompleted())
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/android/upload.mdx`