---
title: With StoragePath
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib/storage/android/remove.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# With StoragePath

To delete an object uploaded to S3, use `Amplify.Storage.remove`.

#### With StoragePath

```java
Amplify.Storage.remove(
    StoragePath.fromString("public/myUploadedFileName.txt"),
    result -> Log.i("MyAmplifyApp", "Successfully removed: " + result.getPath()),
    error -> Log.e("MyAmplifyApp", "Remove failure", error)
);
```

</Block>

```kotlin
Amplify.Storage.remove(StoragePath.fromString("public/myUploadedFileName.txt"),
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
RxAmplify.Storage.remove(StoragePath.fromString("public/myUploadedFileName.txt"))
        .subscribe(
            result -> Log.i("MyAmplifyApp", "Successfully removed: " + result.getPath()),
            error -> Log.e("MyAmplifyApp", "Remove failure", error)
        );
```

</Block>
</BlockSwitcher>

#### With Key (Deprecated)

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


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib/storage/android/remove.mdx`