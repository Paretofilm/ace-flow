---
title: With StoragePath
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib/storage/ios/remove.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

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


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib/storage/ios/remove.mdx`