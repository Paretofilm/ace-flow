---
title: With StoragePath
source: fragments/lib/storage/android/list.mdx
---

# With StoragePath

You can list files without having to download all the files. You can do this by using the list API from the Amplify Library for Storage.

## With StoragePath
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

#### With Key (Deprecated)
This will list all public files:

```java
StoragePagedListOptions options = StoragePagedListOptions.builder()
    .setPageSize(1000)
    .build();

Amplify.Storage.list(
    "",
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

Amplify.Storage.list("", options,
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

RxAmplify.Storage.list("", options)
        .subscribe(
            result -> 
                Log.i("MyAmplifyApp", "Next Token: " + result.getNextToken());
            },
            error -> Log.e("MyAmplifyApp", "List failure", error);
        );
```

</Block>
</BlockSwitcher>

> **Note**: Note: The range of pageSize can be from 1 - 1000.

You can also list private or protected files by passing options. For example, to list all protected files owned by a user identified by the ID `otherUserID` (This behavior is deprecated):

```java
StoragePagedListOptions options = StoragePagedListOptions.builder()
    .accessLevel(StorageAccessLevel.PROTECTED)
    .targetIdentityId("otherUserID")
    .setPageSize(1000)
    .build();

Amplify.Storage.list(
    "",
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
    .accessLevel(StorageAccessLevel.PROTECTED)
    .targetIdentityId("otherUserID")
    .setPageSize(1000)
    .build()

Amplify.Storage.list("", options,
    ")
        }
        Log.i("MyAmplifyApp", "Next Token: $")
    },
    
)
```

</Block>

```kotlin
val options = StoragePagedListOptions.builder()
    .accessLevel(StorageAccessLevel.PROTECTED)
    .targetIdentityId("otherUserID")
    .setPageSize(1000)
    .build()

try 
    Log.i("MyAmplifyApp", "next token: $")
} catch (error: StorageException) 
```

</Block>

```java
StoragePagedListOptions options = StoragePagedListOptions.builder()
        .accessLevel(StorageAccessLevel.PROTECTED)
        .targetIdentityId("otherUserID")
        .setPageSize(1000)
        .build();

RxAmplify.Storage.list("", options)
        .subscribe(
            result -> 
                Log.i("MyAmplifyApp", "Next Token: " + result.getNextToken());
            },
            error -> Log.e("MyAmplifyApp", "List failure", error);
        );
```

</Block>
</BlockSwitcher>

### More `list` options

| Option | Type | Description |
| --- | --- | --- |
| pageSize | int | Number between 1 and 1,000 that indicates the limit of how many entries to fetch when retrieving file lists from the server |
| nextToken | String | String indicating the page offset at which to resume a listing. |

If the `pageSize` is set lower than the total file size available, a single `list` call only returns a subset of all the files. To list all the files with multiple calls, the user can use the `nextToken` value from the previous response.
