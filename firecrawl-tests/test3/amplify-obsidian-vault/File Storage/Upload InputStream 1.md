---
title: Upload InputStream
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib/storage/android/upload.mdx
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

#### With StoragePath

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

#### With Key (Deprecated)

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
To upload data to S3 from a `File`:

#### With StoragePath

```java
private void uploadFile()  catch (Exception exception) 

    Amplify.Storage.uploadFile(
            StoragePath.fromString("public/example"),
            exampleFile,
            result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
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
            RxAmplify.Storage.uploadFile(StoragePath.fromString("public/example"), exampleFile);

    rxUploadOperation
            .observeResult()
            .subscribe(
                result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
                error -> Log.e("MyAmplifyApp", "Upload failed", error)
            );
}
```

</Block>
</BlockSwitcher>

#### With Key (Deprecated)

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

## Track Progress

To track progress of the upload, use the `uploadFile` API that includes a progress listener callback.

#### With StoragePath

```java
private void uploadFile()  catch (Exception exception) 

    Amplify.Storage.uploadFile(
        StoragePath.fromString("public/example"),
        exampleFile,
        StorageUploadFileOptions.defaultInstance(),
        progress -> Log.i("MyAmplifyApp", "Fraction completed: " + progress.getFractionCompleted()),
        result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
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
        RxAmplify.Storage.uploadFile("example", exampleFile);

upload
    .observeProgress()
    .subscribe(
      progress -> Log.i("MyAmplifyApp", progress.getFractionCompleted())
    );
```

</Block>
</BlockSwitcher>

#### With Key (Deprecated)

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

## Transfer with Object Metadata

To upload a file accompanied by metadata, utilize the `StorageUploadFileOptions` builder. Start by creating a hashMap object, then incorporate it into the `StorageUploadFileOptions` during the build process before passing it along to the upload function.

#### With StoragePath

```java
private void uploadFile()  catch (Exception exception) 

    // Create metadata
    Map userMetadata = new HashMap<>();
    userMetadata.put("myKey", "myVal");

    // Configure upload options with metadata
    StorageUploadFileOptions options = StorageUploadFileOptions.builder()
        .metadata(userMetadata)
        .build();

    // Perform the upload
    Amplify.Storage.uploadFile(
        StoragePath.fromString("public/example"),
        exampleFile,
        options,
        result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
        error -> Log.e("MyAmplifyApp", "Upload failed", error)
    );
}
```
</Block>

```kotlin
fun uploadFile() ") },
        
    )
}
```
</Block>

```kotlin
fun uploadFile() ")
        }
    }
    try ")
    } catch (error: StorageException) 
    progressJob.cancel()
}
```
</Block>

```Java
private void uploadFile()  catch (Exception exception) 

    Map userMetadata = new HashMap<>();
    userMetadata.put("myKey", "myVal");

    StorageUploadFileOptions options = StorageUploadFileOptions.builder()
            .metadata(userMetadata)
            .build();

    RxStorageBinding.RxProgressAwareSingleOperation rxUploadOperation =
            RxAmplify.Storage.uploadFile(StoragePath.fromString("public/example"), exampleFile, options);

    rxUploadOperation
            .observeResult()
            .subscribe(
                    result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
                    error -> Log.e("MyAmplifyApp", "Upload failed", error)
            );
}
 ```
</Block>
</BlockSwitcher>

#### With Key (Deprecated)

```java
private void uploadFile()  catch (Exception exception) 

    // Create metadata
    Map userMetadata = new HashMap<>();
    userMetadata.put("myKey", "myVal");

    // Configure upload options with metadata
    StorageUploadFileOptions options = StorageUploadFileOptions.builder()
        .metadata(userMetadata)
        .build();

    // Perform the upload
    Amplify.Storage.uploadFile(
        "ExampleKey",
        exampleFile,
        options,
        result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getKey()),
        error -> Log.e("MyAmplifyApp", "Upload failed", error)
    );
}
```
</Block>

```kotlin
fun uploadFile() ") },
        
    )
}
```
</Block>

```kotlin
fun uploadFile() ")
        }
    }
    try ")
    } catch (error: StorageException) 
    progressJob.cancel()
}
```
</Block>

```Java
private void uploadFile()  catch (Exception exception) 

    Map userMetadata = new HashMap<>();
    userMetadata.put("myKey", "myVal");

    StorageUploadFileOptions options = StorageUploadFileOptions.builder()
            .metadata(userMetadata)
            .build();

    RxStorageBinding.RxProgressAwareSingleOperation rxUploadOperation =
            RxAmplify.Storage.uploadFile("ExampleKey", exampleFile, options);

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

## MultiPart upload

Amplify will automatically perform a S3 multipart upload for objects that are larger than 5MB. For more information about S3's multipart upload, see [Uploading and copying objects using multipart upload](https://docs.aws.amazon.com/AmazonS3/latest/userguide/mpuoverview.html)


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib/storage/android/upload.mdx`