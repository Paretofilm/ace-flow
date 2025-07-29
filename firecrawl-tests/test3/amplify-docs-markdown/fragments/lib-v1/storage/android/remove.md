---
title: Documentation
source: fragments/lib-v1/storage/android/remove.mdx
---

# Documentation

To delete an object uploaded to S3, use `Amplify.Storage.remove` and specify the key:

```java
Amplify.Storage.remove(
    "myUploadedFileName.txt",
    result -> Log.i("MyAmplifyApp", "Successfully removed: " + result.getKey()),
    error -> Log.e("MyAmplifyApp", "Remove failure", error)
);
```

</Block>

```kotlin
Amplify.Storage.remove("myUploadedFileName.txt",
    ") },
    
)
```

</Block>

```kotlin
try ")
} catch (error: StorageException) 
```

</Block>

```java
RxAmplify.Storage.remove("myUploadedFileName.txt")
        .subscribe(
            result -> Log.i("MyAmplifyApp", "Successfully removed: " + result.getKey()),
            error -> Log.e("MyAmplifyApp", "Remove failure", error)
        );
```

</Block>
</BlockSwitcher>
