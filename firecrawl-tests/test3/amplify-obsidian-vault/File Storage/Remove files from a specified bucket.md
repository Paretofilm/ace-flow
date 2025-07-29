---
title: Remove files from a specified bucket
topics: ['File Storage']
primary_topic: File Storage
source: pages/build-a-backend/storage/remove-files/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Remove files from a specified bucket

Files can be removed from a storage bucket using the `remove` API. If a file is protected by an identity Id, only the user who owns the file will be able to remove it.

You can also perform a remove operation from a specific bucket by providing the target bucket's assigned name from Amplify Backend in `bucket` option.

```javascript

try ) => `album/$/1.jpg`
    bucket: 'assignedNameInAmplifyBackend', // Specify a target bucket using name assigned in Amplify Backend
  });
} catch (error) 
```

Alternatively, you can also pass in an object by specifying the bucket name and region from the console.

```javascript

try 

  });
} catch (error) 
```
</InlineFilter>

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

## Remove files from a specified bucket

You can also perform a remove operation to a specific bucket by providing the `bucket` option. You can pass in a string representing the target bucket's assigned name in Amplify Backend.

```java
StorageBucket secondBucket = StorageBucket.fromOutputs("secondBucket");
StorageRemoveOptions options = StorageRemoveOptions.builder()
    .bucket(secondBucket)
    .build();

Amplify.Storage.remove(
    StoragePath.fromString("public/myUploadedFileName.txt"), 
    options,
    result -> Log.i("MyAmplifyApp", "Successfully removed: " + result.getPath()),
    error -> Log.e("MyAmplifyApp", "Remove failure", error)
);
```

</Block>

```kotlin
val secondBucket = StorageBucket.fromOutputs("secondBucket")
val options = StorageRemoveOptions.builder()
    .bucket(secondBucket)
    .build()

Amplify.Storage.remove(StoragePath.fromString("public/myUploadedFileName.txt"), options,
    ") },
    
)
```

</Block>

```kotlin
val secondBucket = StorageBucket.fromOutputs("secondBucket")
val options = StorageRemoveOptions.builder()
    .bucket(secondBucket)
    .build()

try ")
} catch (error: StorageException) 
```

</Block>

```java     
StorageBucket secondBucket = StorageBucket.fromOutputs("secondBucket");
StorageRemoveOptions options = StorageRemoveOptions.builder()
    .bucket(secondBucket)
    .build(); 
RxAmplify.Storage.remove(StoragePath.fromString("public/myUploadedFileName.txt"), options)
        .subscribe(
            result -> Log.i("MyAmplifyApp", "Successfully removed: " + result.getPath()),
            error -> Log.e("MyAmplifyApp", "Remove failure", error)
        );
```

</Block>
</BlockSwitcher>

Alternatively, you can also pass in an object by specifying the bucket name and region from the console.

```java
BucketInfo bucketInfo = new BucketInfo("second-bucket-name-from-console", "us-east-2");
StorageBucket secondBucket = StorageBucket.fromBucketInfo(bucketInfo);
StorageRemoveOptions options = StorageRemoveOptions.builder()
    .bucket(secondBucket)
    .build(); 

Amplify.Storage.remove(
    StoragePath.fromString("public/myUploadedFileName.txt"),
    options,
    result -> Log.i("MyAmplifyApp", "Successfully removed: " + result.getPath()),
    error -> Log.e("MyAmplifyApp", "Remove failure", error)
);
```

</Block>

```kotlin
val bucketInfo = BucketInfo("second-bucket-name-from-console", "us-east-2")
val secondBucket = StorageBucket.fromBucketInfo(bucketInfo)
val options = StorageRemoveOptions.builder()
    .bucket(secondBucket)
    .build()

Amplify.Storage.remove(StoragePath.fromString("public/myUploadedFileName.txt"), options,
    ") },
    
)
```

</Block>

```kotlin
val bucketInfo = BucketInfo("second-bucket-name-from-console", "us-east-2")
val secondBucket = StorageBucket.fromBucketInfo(bucketInfo)
val options = StorageRemoveOptions.builder()
    .bucket(secondBucket)
    .build()

try ")
} catch (error: StorageException) 
```

</Block>

```java
BucketInfo bucketInfo = new BucketInfo("second-bucket-name-from-console", "us-east-2");
StorageBucket secondBucket = StorageBucket.fromBucketInfo(bucketInfo);
StorageRemoveOptions options = StorageRemoveOptions.builder()
    .bucket(secondBucket)
    .build(); 

RxAmplify.Storage.remove(StoragePath.fromString("public/myUploadedFileName.txt"), options)
        .subscribe(
            result -> Log.i("MyAmplifyApp", "Successfully removed: " + result.getPath()),
            error -> Log.e("MyAmplifyApp", "Remove failure", error)
        );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
let removedObject = try await Amplify.Storage.remove(
    path: .fromString("public/example/path")
)
print("Deleted \(removedObject)")
```

</Block>

```swift
let sink = Amplify.Publisher.create .sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>

## Remove files from a specified bucket

You can perform a remove operation from a specific bucket by providing the `bucket` option.

You can use `.fromOutputs(name:)` to provide a string representing the target bucket's assigned name in the Amplify Backend.

```swift
let removedObject = try await Amplify.Storage.remove(
    path: .fromString("public/example/path"),
    options: .init(
        bucket: .fromOutputs(name: "secondBucket")
    )
)
```
</Block>

You can also use `.fromBucketInfo(_:)` to provide a bucket name and region directly.

```swift
let removedObject = try await Amplify.Storage.remove(
    path: .fromString("public/example/path"),
    options: .init(
        bucket: .fromBucketInfo(.init(
            bucketName: "another-bucket-name",
            region: "another-bucket-region")
        )    
    )
)
```
</Block>
</BlockSwitcher>

</InlineFilter>

You can also perform a `remove` operation to a specific bucket by providing the `bucket` option. You can pass in a `StorageBucket` object representing the target bucket from the name defined in the Amplify Backend.

```dart
final result = await Amplify.Storage.remove(
  path: const StoragePath.fromString('path/to/file.txt'),
  options: StorageRemoveOptions(
    // highlight-start
    // Specify a target bucket using name assigned in Amplify Backend
    bucket: StorageBucket.fromOutputs('secondBucket'),
    // highlight-end
  ),
).result;
```

Alternatively, you can also pass in an object by specifying the bucket name and region from the console.

```dart
final result = await Amplify.Storage.remove(
  path: const StoragePath.fromString('path/to/file.txt'),
  options: StorageRemoveOption(
    // highlight-start
    // Alternatively, provide bucket name from console and associated region
   bucket: StorageBucket.fromBucketInfo(
        BucketInfo(
          bucketName: 'second-bucket-name-from-console',
          region: 'us-east-2',
        ),
      ),
      // highlight-end
  ),
).result;
```

## Remove multiple Files

You can remove multiple files using `Amplify.Storage.removeMany`, as well as specify a bucket to target, the files to be removed in a batch should have the same access level:

```dart
Future<void> remove() async ');
  } on StorageException catch (e) 
}
```

</InlineFilter>

## More `remove` options

Option | Type | Default | Description |
| -- | :--: | :--: | ----------- |
| bucket | string \| <br />\ | Default bucket and region from Amplify configuration | A string representing the target bucket's assigned name in Amplify Backend or an object specifying the bucket name and region from the console.<br/><br/>Read more at [Configure additional storage buckets](/[platform]/build-a-backend/storage/set-up-storage/#configure-additional-storage-buckets) |
| expectedBucketOwner | string | Optional | The account ID that owns requested bucket. |
</InlineFilter>


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `pages/build-a-backend/storage/remove-files/index.mdx`