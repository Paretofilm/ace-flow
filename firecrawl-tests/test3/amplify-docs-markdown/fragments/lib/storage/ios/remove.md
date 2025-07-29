---
title: With StoragePath
source: fragments/lib/storage/ios/remove.mdx
---

# With StoragePath

Delete an object uploaded to S3 by using `Amplify.Storage.remove`:

#### With StoragePath

```swift
let removedObject = try await Amplify.Storage.remove(path: .fromString("public/example/path"))
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

#### With Key (Deprecated)

```swift
let removedKey = try await Amplify.Storage.remove(key: "myKey")
print("Deleted \(removedKey)")
```

</Block>

```swift
let sink = Amplify.Publisher.create .sink 
}
receiveValue: 
```

</Block>

</BlockSwitcher>
