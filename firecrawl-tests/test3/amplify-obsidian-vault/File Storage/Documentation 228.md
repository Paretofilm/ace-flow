---
title: Documentation
topics: ['File Storage', 'Getting Started']
primary_topic: File Storage
source: fragments/lib-v1/storage/android/getting-started/40_upload.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage, getting-started]
---


## 🧭 Navigation
**Topics**: [[File Storage/]] • [[Getting Started/]]
**Primary**: [[File Storage/]]

---


# Documentation

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

    RxProgressAwareSingleOperation upload =
            RxAmplify.Storage.uploadFile("ExampleKey", exampleFile);

    upload
        .observeResult()
        .subscribe(
            result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getKey()),
            error -> Log.e("MyAmplifyApp", "Upload failed", error)
        );
}
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[File Storage/]]
- [[Getting Started/]]

## 📖 Source
Original: `fragments/lib-v1/storage/android/getting-started/40_upload.mdx`