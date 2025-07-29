---
title: List Files
source: pages/build-a-backend/storage/list-files/index.mdx
---

# List Files

You can list files without having to download all the files. You can do this by using the `list` API from the Amplify Library for Storage. You can also get properties individually for a file using the `getProperties` API.</InlineFilter>

## List Files

```javascript

const result = await list() => `album/$/photos/`
});
```

Note the trailing slash `/` - if you had requested `list()` it would also match against files like `album/photos123.jpg` alongside `album/photos/123.jpg`.

The format of the response will look similar to the below example:

```js
,
    // ...
  ],
}
````

If the `pageSize` is set lower than the total file size, a single `list` call only returns a subset of all the files. To list all the files with multiple calls, users can use the `nextToken` flag:

```javascript

const PAGE_SIZE = 20;
let nextToken;
// ...
const loadNextPage = async () => ) => `album/$/photos/`
    options: ,
  });
  if (response.nextToken)  else 
  // render list items from response.items
};
```

### List All files
```javascript

const result = await list() => `album/$/photos/`,
  options: 
});
```

 Manually created folders will show up as files with a `size` of 0, but you can also match keys against a regex like `file.key.match(/\.[0-9a-z]+$/i)` to distinguish files from folders. Since "folders" are a virtual concept in Amazon S3, any file may declare any depth of folder just by having a `/` in its name.

To access the contents and subpaths of a "folder", you have two options:

1. Request the entire path and parse the contents.
2. Use the subpathStrategy option to retrieve only the files within the specified path (i.e. exclude files under subpaths).

### Get all nested files within a path

This retrieves all files and folders under a given path. You may need to parse the result to get only the files within the specified path.

```js
function processStorageList(response)  else 
  });
  return ;
}
```

If you need the files and folders in terms of a nested object instead (for example, to build an explorer UI), you could parse it recursively:

```js
function processStorageList(response) ;
  // https://stackoverflow.com/questions/44759750/how-can-i-create-a-nested-object-representation-of-a-folder-structure
  const add = (source, target, item) => ; // element;
    if (elements.length) ;
      add(elements.join('/'), target[element], item);
    }
  };
  response.items.forEach((item) => add(item.path, filesystem, item));
  return filesystem;
}
```

This places each item's data inside a special `__data` key.

### Excluding subpaths

In addition to using the `list` API to get all the contents of a path, you can also use it to get only the files within a path while excluding files under subpaths.

For example, given the following keys in your `path` you may want to return only the jpg object, and not the "vacation" subpath and its contents:

```
photos/photo1.jpg
photos/vacation/
```

This can be accomplished with the `subpathStrategy` option:

```ts title="src/main.ts"
const result = await list(
  }
});
```

The response will include only the objects within the `photos/` path and will also communicate any excluded subpaths:

```js
,
    ]
}
```

The default delimiter character is '/', but this can be changed by supplying a custom delimiter:

```ts title="src/main.ts"
const result = await list(
  }
});
```

### List files from a specified bucket

You can also perform an `copy` operation to a specific bucket by providing the `bucket` option. This option can either be a string representing the target bucket's assigned name in Amplify Backend or an object specifying the bucket name and region from the console.

```ts

const result = await list(
  }
});
```

### More `list` options

| Option | Type | Default | Description |
| -- | :--: | :--: | ----------- |
| bucket | string \| <br />\ | Default bucket and region from Amplify configuration | A string representing the target bucket's assigned name in Amplify Backend or an object specifying the bucket name and region from the console.<br/><br/>Read more at [Configure additional storage buckets](/[platform]/build-a-backend/storage/set-up-storage/#configure-additional-storage-buckets) |
| listAll | boolean | false | Set to true to list all files within the specified `path` |
| pageSize | number | 1000 | Sets the maximum number of files to be return. The range is 0 - 1000 |
| nextToken | string | — | Indicates whether the list is being continued on this bucket with a token |
| subpathStrategy | \ \|<br/>\ | \ | An object representing the subpath inclusion strategy and the delimiter used to group results for exclusion. <br/><br/> Read more at [Excluding subpaths](/[platform]/build-a-backend/storage/list-files/#excluding-subpaths) |
| useAccelerateEndpoint | boolean | false | Whether to use accelerate endpoint. <br/><br/> Read more at [Transfer Acceleration](/[platform]/build-a-backend/storage/extend-s3-resources/#example---enable-transfer-acceleration) |
| expectedBucketOwner | string | Optional | The account ID that owns requested bucket. |

</InlineFilter>

The following example lists all objects inside the `public/photos/` path:

```java
StoragePagedListOptions options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .build();

Amplify.Storage.list(
    StoragePath.fromString("public/photos/"),
    options,
    result -> 
        Log.i("MyAmplifyApp", "Next Token: " + result.getNextToken());
    },
    error -> Log.e("MyAmplifyApp", "List failure", error);
);
```

</Block>

```kotlin
val options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .build()

Amplify.Storage.list(StoragePath.fromString("public/photos/"), options,
    ")
        }
        Log.i("MyAmplifyApp", "Next Token: $")
    },
    
)
```

</Block>

```kotlin
val options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .build()

try 
    Log.i("MyAmplifyApp", "next token: $")
} catch (error: StorageException) 
```

</Block>

```java
StoragePagedListOptions options = StoragePagedListOptions.builder()
        .setPageSize(1000)
        .build();

RxAmplify.Storage.list(StoragePath.fromString("public/photos/"), options)
        .subscribe(
            result -> 
                Log.i("MyAmplifyApp", "Next Token: " + result.getNextToken());
            },
            error -> Log.e("MyAmplifyApp", "List failure", error);
        );
```

</Block>
</BlockSwitcher>

> **Note**: 
Note the trailing slash `/` in the given path.

If you had used `public/photos` as path, it would also match against files like `public/photos01.jpg`.

### List files from a specified bucket

You can also perform a list operation to a specific bucket by providing the `bucket` option. You can pass in a string representing the target bucket's assigned name in Amplify Backend.

```java
StorageBucket secondBucket = StorageBucket.fromOutputs("secondBucket");
StoragePagedListOptions options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .bucket(secondBucket)
    .build();

Amplify.Storage.list(
    StoragePath.fromString("public/photos/"),
    options,
    result -> 
        Log.i("MyAmplifyApp", "Next Token: " + result.getNextToken());
    },
    error -> Log.e("MyAmplifyApp", "List failure", error);
);
```

</Block>

```kotlin
val secondBucket = StorageBucket.fromOutputs("secondBucket")
val options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .bucket(secondBucket)
    .build()

Amplify.Storage.list(StoragePath.fromString("public/photos/"), options,
    ")
        }
        Log.i("MyAmplifyApp", "Next Token: $")
    },
    
)
```

</Block>

```kotlin
val secondBucket = StorageBucket.fromOutputs("secondBucket")
val options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .bucket(secondBucket)
    .build()

try 
    Log.i("MyAmplifyApp", "next token: $")
} catch (error: StorageException) 
```

</Block>

```java      
StorageBucket secondBucket = StorageBucket.fromOutputs("secondBucket");
StoragePagedListOptions options = StoragePagedListOptions.builder()
        .setPageSize(1000)
        .bucket(secondBucket)
        .build();

RxAmplify.Storage.list(StoragePath.fromString("public/photos/"), options)
        .subscribe(
            result -> 
                Log.i("MyAmplifyApp", "Next Token: " + result.getNextToken());
            },
            error -> Log.e("MyAmplifyApp", "List failure", error);
        );
```

</Block>
</BlockSwitcher>

Alternatively, you can also pass in an object by specifying the bucket name and region from the console.

```java
BucketInfo bucketInfo = new BucketInfo("second-bucket-name-from-console", "us-east-2");
StorageBucket secondBucket = StorageBucket.fromBucketInfo(bucketInfo);
StoragePagedListOptions options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .bucket(secondBucket)
    .build();

Amplify.Storage.list(
    StoragePath.fromString("public/photos/"),
    options,
    result -> 
        Log.i("MyAmplifyApp", "Next Token: " + result.getNextToken());
    },
    error -> Log.e("MyAmplifyApp", "List failure", error);
);
```

</Block>

```kotlin
val bucketInfo = BucketInfo("second-bucket-name-from-console", "us-east-2")
val secondBucket = StorageBucket.fromBucketInfo(bucketInfo)
val options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .bucket(secondBucket)
    .build()

Amplify.Storage.list(StoragePath.fromString("public/photos/"), options,
    ")
        }
        Log.i("MyAmplifyApp", "Next Token: $")
    },
    
)
```

</Block>

```kotlin
val bucketInfo = BucketInfo("second-bucket-name-from-console", "us-east-2")
val secondBucket = StorageBucket.fromBucketInfo(bucketInfo)
val options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .bucket(secondBucket)
    .build()

try 
    Log.i("MyAmplifyApp", "next token: $")
} catch (error: StorageException) 
```

</Block>

```java
BucketInfo bucketInfo = new BucketInfo("second-bucket-name-from-console", "us-east-2");
StorageBucket secondBucket = StorageBucket.fromBucketInfo(bucketInfo);
StoragePagedListOptions options = StoragePagedListOptions.builder()
        .setPageSize(1000)
        .bucket(secondBucket)
        .build();

RxAmplify.Storage.list(StoragePath.fromString("public/photos/"), options)
        .subscribe(
            result -> 
                Log.i("MyAmplifyApp", "Next Token: " + result.getNextToken());
            },
            error -> Log.e("MyAmplifyApp", "List failure", error);
        );
```

</Block>
</BlockSwitcher>

### Exclude results from nested subpaths

By default, the `list` API will return all objects contained within the given path, including objects inside nested subpaths.

For example, the previous `public/photos/` path would include these objects:

```bash
Path: public/photos/photo1.jpg
Path: public/photos/vacation/photo1.jpg
Path: public/photos/thumbnails/photo1.jpg
```

In order to exclude objects within the `vacation` and `thumbnails` subpaths, you can set the `subpathStrategy` option to `SubpathStrategy.Exclude()`:

```java
StoragePagedListOptions options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .setSubpathStrategy(SubpathStrategy.Exclude())
    .build();

Amplify.Storage.list(
    StoragePath.fromString("public/photos/"),
    options,
    result -> 
        Log.i("MyAmplifyApp", "Next Token: " + result.getNextToken());
    },
    error -> Log.e("MyAmplifyApp", "List failure", error);
);
```

</Block>

```kotlin
val options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .setSubpathStrategy(SubpathStrategy.Exclude())
    .build()

Amplify.Storage.list(StoragePath.fromString("public/photos/"), options,
    ")
        }
        Log.i("MyAmplifyApp", "Next Token: $")
    },
    
)
```

</Block>

```kotlin
val options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .setSubpathStrategy(SubpathStrategy.Exclude())
    .build()

try 
    Log.i("MyAmplifyApp", "next token: $")
} catch (error: StorageException) 
```

</Block>

```java
StoragePagedListOptions options = StoragePagedListOptions.builder()
        .setPageSize(1000)
        .setSubpathStrategy(SubpathStrategy.Exclude())
        .build();

RxAmplify.Storage.list(StoragePath.fromString("public/photos/"), options)
        .subscribe(
            result -> 
                Log.i("MyAmplifyApp", "Next Token: " + result.getNextToken());
            },
            error -> Log.e("MyAmplifyApp", "List failure", error);
        );
```

</Block>
</BlockSwitcher>

The response will only include objects within the `public/photos/` path and will also provide a list of the excluded subpaths:

```bash
Path: public/photos/photo01.jpg
Subpath: public/photos/vacation/
Subpath: public/photos/thumbnails/
```

The default delimiter character is `"/"`, but this can be changed by supplying a custom delimiter:

```java
StoragePagedListOptions options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .setSubpathStrategy(SubpathStrategy.Exclude("-"))
    .build();

Amplify.Storage.list(
    StoragePath.fromString("public/photos/"),
    options,
    result -> 
        Log.i("MyAmplifyApp", "Next Token: " + result.getNextToken());
    },
    error -> Log.e("MyAmplifyApp", "List failure", error);
);
```

</Block>

```kotlin
val options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .setSubpathStrategy(SubpathStrategy.Exclude("-"))
    .build()

Amplify.Storage.list(StoragePath.fromString("public/photos/"), options,
    ")
        }
        Log.i("MyAmplifyApp", "Next Token: $")
    },
    
)
```

</Block>

```kotlin
val options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .setSubpathStrategy(SubpathStrategy.Exclude("-"))
    .build()

try 
    Log.i("MyAmplifyApp", "next token: $")
} catch (error: StorageException) 
```

</Block>

```java
StoragePagedListOptions options = StoragePagedListOptions.builder()
        .setPageSize(1000)
        .setSubpathStrategy(SubpathStrategy.Exclude("-"))
        .build();

RxAmplify.Storage.list(StoragePath.fromString("public/photos/"), options)
        .subscribe(
            result -> 
                Log.i("MyAmplifyApp", "Next Token: " + result.getNextToken());
            },
            error -> Log.e("MyAmplifyApp", "List failure", error);
        );
```

</Block>
</BlockSwitcher>

The response will only include objects within the `public/photos/` path not grouped by the delimiter `-`.

```bash
Path: public/photos/2023/photos01.jpg
Path: public/photos/2024/photos02.jpg
Subpath: public/photos/202-
```

### All `list` options

| Option | Type | Description |
| --- | --- | --- |
| subpathStrategy | SubpathStrategy | The strategy to use when listing contents from subpaths. |
| pageSize | int | Number between 1 and 1,000 that indicates the limit of how many entries to fetch when retrieving file lists from the server. |
| bucket | StorageBucket | The bucket in which the objects are stored. |
| nextToken | String | String indicating the page offset at which to resume a listing. |

If the `pageSize` is set lower than the total file size available, a single `list` call only returns a subset of all the files. To list all the files with multiple calls, the user can use the `nextToken` value from the previous response.

</InlineFilter>

The following example lists all objects inside the `public/photos/` path:

```swift
let listResult = try await Amplify.Storage.list(
    path: .fromString("public/photos/")
)
listResult.items.forEach 
```

</Block>

```swift
let sink = Amplify.Publisher.create .sink 
}
receiveValue: 
}
```

</Block>

</BlockSwitcher>

> **Note**: 
Note the trailing slash `/` in the given path.

If you had used `public/photos` as path, it would also match against files like `public/photos01.jpg`.

### List files from a specified bucket

You can perform a list operation from a specific bucket by providing the `bucket` option.

You can use `.fromOutputs(name:)` to provide a string representing the target bucket's assigned name in the Amplify Backend.

```swift
let listResult = try await Amplify.Storage.list(
    path: .fromString("public/photos/"),
    options: .init(
        bucket: .fromOutputs(name: "secondBucket")
    )
)
```
</Block>

You can also use `.fromBucketInfo(_:)` to provide a bucket name and region directly.

```swift
let listResult = try await Amplify.Storage.list(
    path: .fromString("public/photos/"),
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

### Exclude results from nested subpaths

By default, the `list` API will return all objects contained within the given path, including objects inside nested subpaths.

For example, the previous `public/photos/` path would include these objects:

```bash
Path: public/photos/photo1.jpg
Path: public/photos/vacation/photo1.jpg
Path: public/photos/thumbnails/photo1.jpg
```

In order to exclude objects within the `vacation` and `thumbnails` subpaths, you can set the `subpathStrategy` option to `.exclude`:

```swift
let listResult = try await Amplify.Storage.list(
    path: .fromString("public/photos/"),
    options: .init(
        subpathStrategy: .exclude
    )
)
listResult.items.forEach 
listResult.excludedSubpaths.forEach 
```

</Block>

```swift
let sink = Amplify.Publisher.create .sink 
}
receiveValue: 
    listResult.excludedSubpaths.forEach 
}
```

</Block>

</BlockSwitcher>

The response will only include objects within the `public/photos/` path and will also provide a list of the excluded subpaths:

```bash
Path: public/photos/photo01.jpg
Subpath: public/photos/vacation/
Subpath: public/photos/thumbnails/
```

The default delimiter character is `"/"`, but this can be changed by supplying a custom delimiter:

```swift
let listResult = try await Amplify.Storage.list(
    path: .fromString("public/photos-"),
    options: .init(
        subpathStrategy: .exclude(delimitedBy: "-")
    )
)
```

</Block>

```swift
let sink = Amplify.Publisher.create .sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>

### All `list` options

| Option | Type | Description |
| --- | --- | --- |
| subpathStrategy | SubpathStrategy | The strategy to use when listing contents from subpaths |
| pageSize | UInt | Number between 1 and 1,000 that indicates the limit of how many entries to fetch when retrieving file lists from the server |
| bucket | StorageBucket | The bucket in which the objects are stored |
| nextToken | String | String indicating the page offset at which to resume a listing. |

If the `pageSize` is set lower than the total file size available, a single `list` call only returns a subset of all the files. To list all the files with multiple calls, the user can use the `nextToken` value from the previous response.

</InlineFilter>

This will list all files located under path `album` that:

- have `private` access level
- are in the root of `album/` (the result doesn't include files under any sub path)

```dart
Future<void> listAlbum() async ');
      nextToken = result.nextToken;
      hasNextPage = result.hasNextPage;
    } while (hasNextPage);
  } on StorageException catch (e) 
}
```

Pagination is enabled by default. The default `pageSize` is `1000` if it is not set in the `StorageListOptions`.

### List all files without pagination

You can also list all files under a given path without pagination by using the `pluginOptions` and `S3ListPluginOptions.listAll()` constructor.

This will list all public files (i.e. those with `guest` access level):

```dart

Future<void> listAllUnderPublicPath() async ');
  } on StorageException catch (e) 
}

```

### List files from a specified bucket
You can also perform a `list` operation to a specific bucket by providing the `bucket` option. You can pass in a `StorageBucket` object representing the target bucket from the name defined in the Amplify Backend.

```dart
final result = await Amplify.Storage.list(
  path: const StoragePath.fromString('path/to/dir'),
  options: StorageListOptions(
    // highlight-start
    // Specify a target bucket using name assigned in Amplify Backend
    bucket: StorageBucket.fromOutputs('secondBucket'),
    // highlight-end
  ),
).result;
```
Alternatively, you can also pass in an object by specifying the bucket name and region from the console.

```dart
final result = await Amplify.Storage.list(
  path: const StoragePath.fromString('path/to/dir'),
  options: StorageListOptions(
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
</InlineFilter>

### More `list` options

| Option | Type | Description |
| --- | --- | --- |
| bucket | StorageBucket | The target bucket from the assigned name in the Amplify Backend or from the bucket name and region in the console<br/><br/>Defaults to the default bucket and region from the Amplify configuration if this option is not provided.<br/><br/>Read more at [Configure additional storage buckets](/[platform]/build-a-backend/storage/set-up-storage/#configure-additional-storage-buckets) |
| excludeSubPaths | boolean | Whether to exclude objects under the sub paths of the path to list. Defaults to false. |
| delimiter | String | The delimiter to use when evaluating sub paths. If excludeSubPaths is false, this value has no impact on behavior. |

</InlineFilter>

## Get File Properties

You can also view the properties of an individual file.

```javascript

try ) => `album/$/1.jpg`
    options: 
  });
  console.log('File Properties ', result);
} catch (error) 
```

The properties and metadata will look similar to the below example

```js
,
  metadata: 
}
```

### More `getProperties` options

Option | Type | Default | Description |
| -- | -- | -- | ----------- |
| bucket | string \| <br />\ | Default bucket and region from Amplify configuration | A string representing the target bucket's assigned name in Amplify Backend or an object specifying the bucket name and region from the console.<br/><br/>Read more at [Configure additional storage buckets](/[platform]/build-a-backend/storage/set-up-storage/#configure-additional-storage-buckets) |
| useAccelerateEndpoint | boolean | false | Whether to use accelerate endpoint. | [Transfer Acceleration](/[platform]/build-a-backend/storage/extend-s3-resources/#example---enable-transfer-acceleration) |

> **Note**: 

To get the metadata in result for all APIs you have to configure user defined metadata in CORS.

Learn more about how to setup an appropriate [CORS Policy](/[platform]/build-a-backend/storage/extend-s3-resources/#for-manually-configured-s3-resources).

</InlineFilter>

## Get File Properties

You can also view properties of an individual file.

```dart
Future<void> getFileProperties() async ');
  } on StorageException catch (e) 
}
```

As well as specify a bucket to target to view properties of a file

```dart
Future<void> getFileProperties() async ');
  } on StorageException catch (e) 
}
```

> **Note**: 

To get the metadata in result for all APIs when building against a web target, you have to configure user defined metadata in CORS.

Learn more about how to setup an appropriate [CORS Policy](/[platform]/build-a-backend/storage/extend-s3-resources/#for-manually-configured-s3-resources).

</InlineFilter>
