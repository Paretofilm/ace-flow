---
title: Protected access
source: fragments/lib/storage/android/configureaccess.mdx
---

# Protected access

When adding the Storage category, you configure the level of access authenticated and guest users have to your S3 bucket. Additionally, when uploading files using the Storage category, you can specify the access level for that file to be either public, protected, or private.

- **Public** Accessible by all users
- **Protected** Readable by all users, but only writable by the creating user
- **Private** Readable and writable only by the creating user

For protected and private access, the `user_id` in the prefix corresponds to the unique ID for the creating user.

> **Note**: 

The default access level for the Storage category is **public**. Unless you specify otherwise, all uploaded files will be publicly available for all users.

## Protected access

Create an options object specifying the protected access level to allow other users to read the object:

```java
private void uploadFile(String key, File file) 
```

</Block>

```kotlin
private fun uploadFile(key: String, file: File) 
        
    )
}
```

</Block>

```kotlin
private suspend fun uploadFile(key: String, file: File)  catch (error: StorageException) 
}
```

</Block>

```java
private void uploadFile(String key, File file) 
```

</Block>
</BlockSwitcher>

For other users to read the file, you must specify the user ID of the creating user in the passed options:

```java
private void downloadFile(File file, String key, String otherUserId) 
```

</Block>

```kotlin
private fun downloadFile(file: File, key: String, otherUserId: String) ,
        
    )
}
```

</Block>

```kotlin
private suspend fun downloadFile(file: File, key: String, otherUserId: String)  catch (error: StorageException) 
}
```

</Block>
</BlockSwitcher>

## Private Access

Create an options object specifying the private access level to only allow an object to be accessed by the creating user

```java
private void uploadFile(String key, File file) 
```

</Block>

```kotlin
private fun uploadFile(key: String, file: File) ,
        
    )
}
```

</Block>

```kotlin
private suspend fun uploadFile(key: String, file: File)  catch (error: StorageException) 
}
```

</Block>
</BlockSwitcher>

For the user to read the file, you must specify the user ID of the creating user in the passed options:

```java
private void downloadFile(File file, String key, String userId) 
```

</Block>

```kotlin
private fun downloadFile(file: File, key: String, userId: String) 
        
    )
}
```

</Block>

```kotlin
private suspend fun downloadFile(file: File, key: String, userId: String)  catch (error: StorageException) 
}
```

</Block>
</BlockSwitcher>
