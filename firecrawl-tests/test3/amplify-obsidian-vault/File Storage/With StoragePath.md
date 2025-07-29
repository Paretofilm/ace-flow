---
title: With StoragePath
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib/storage/ios/list.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# With StoragePath

You can list files without having to download all the files. You can do this by using the list API from the Amplify Library for Storage.

## With StoragePath

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

## With Key (Deprecated)
The following example lists all public files:

```swift
let listResult = try await Amplify.Storage.list()
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

You can also list private or protected files by passing options. For example, to list all protected files owned by a user identified by the ID `otherUserID` (This behavior is deprecated):

```swift
let listResult = try await Amplify.Storage.list(
    options: .init(
        accessLevel: .protected, 
        targetIdentityId: "otherUserID"
    )
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

If you like limit the response to keys that begin with the specified path provide the path options (This behavior is deprecated):

```swift
let listResult = try await Amplify.Storage.list(
    options: .init(
        path: "path"
    )
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

## More `list` options

| Option | Type | Description |
| --- | --- | --- |
| pageSize | UInt | Number between 1 and 1,000 that indicates the limit of how many entries to fetch when retrieving file lists from the server |
| nextToken | String | String indicating the page offset at which to resume a listing. |

If the `pageSize` is set lower than the total file size available, a single `list` call only returns a subset of all the files. To list all the files with multiple calls, the user can use the `nextToken` value from the previous response.


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib/storage/ios/list.mdx`