---
title: Documentation
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/android/list.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Documentation

You can list all of the objects uploaded under a given prefix. This will list all public files:

```java
Amplify.Storage.list("",
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "List failure", error)
);
```

</Block>

```kotlin
Amplify.Storage.list("",
    ")
        }
    },
    
)
```

</Block>

```kotlin
try ")
    }
} catch (error: StorageException) 
```

</Block>

```java
RxAmplify.Storage.list("")
    .subscribe(
        result -> 
        },
        error -> Log.e("MyAmplifyApp", "List failure", error)
    );
```

</Block>
</BlockSwitcher>

You can also list private or protected files by passing options. For example, to list all protected files owned by a user identified by the ID `otherUserID`:

```java
StorageListOptions options = StorageListOptions.builder()
    .accessLevel(StorageAccessLevel.PROTECTED)
    .targetIdentityId("otherUserID")
    .build();

Amplify.Storage.list(
    "",
    options,
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "List failure", error)
);
```

</Block>

```kotlin
val options = StorageListOptions.builder()
    .accessLevel(StorageAccessLevel.PROTECTED)
    .targetIdentityId("otherUserID")
    .build()

Amplify.Storage.list("", options,
    ")
        }
    },
    
)
```

</Block>

```kotlin
val options = StorageListOptions.builder()
    .accessLevel(StorageAccessLevel.PROTECTED)
    .targetIdentityId("otherUserID")
    .build()

try 
} catch (error: StorageException) 
```

</Block>

```java
StorageListOptions options = StorageListOptions.builder()
        .accessLevel(StorageAccessLevel.PROTECTED)
        .targetIdentityId("otherUserID")
        .build();

RxAmplify.Storage.list("", options)
        .subscribe(
            result -> 
            },
            error -> Log.e("MyAmplifyApp", "List failure", error)
        );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/android/list.mdx`