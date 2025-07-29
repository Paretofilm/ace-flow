---
title: Documentation
source: fragments/lib/storage/android/query-transfers.mdx
---

# Documentation

When an upload or download operation is requested using the Amplify Android library, the request is first persisted in the local SQLite Database and then queued for execution. You can query the transfer operation queued in the local database using the transfer ID returned by an upload or download API. Get-Transfer API could retrieve a pending transfer previously en-queued and enable attaching a listener to receive updates on progress change, on-error or on-success, or pause, cancel or resume it.

```java
Amplify.Storage.getTransfer("TRANSFER_ID",
    operation -> );
        operation.setOnSuccess( result -> );
        operation.setOnError(error -> );

        // possible actions
        operation.pause();
        operation.resume();
        operation.start();
        operation.cancel();
    },
    
);
```

</Block>

```kotlin
Amplify.Storage.getTransfer("TRANSFER_ID",
    
        operation.setOnSuccess 
        operation.setOnError 

        // possible actions
        operation.pause()
        operation.resume()
        operation.start()
        operation.cancel()
    },
    
)
```

</Block>

```kotlin
try 
    operation.setOnSuccess 
    operation.setOnError 

    // possible actions
    operation.pause()
    operation.resume()
    operation.start()
    operation.cancel()
} catch (error: StorageException) 
```

</Block>

```java
RxAmplify.Storage.getTransfer("TRANSFER_ID")
    .subscribe(
        operation -> );
            operation.setOnSuccess( result -> );
            operation.setOnError(error -> );

            // possible actions
            operation.pause();
            operation.resume();
            operation.start();
            operation.cancel();
        },
        error -> Log.e("MyAmplifyApp", "Failed to query transfer", error);
    );
```

</Block>
</BlockSwitcher>
