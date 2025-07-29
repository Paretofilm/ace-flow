---
title: Documentation
source: fragments/lib/datastore/ios/relational/query-snippet.mdx
---

# Documentation

Models with one-to-many connections are lazy-loaded when accessing the connected property, so accessing a relation is as simple as:

```swift
do 
    // call fetch to lazy load the postResult before accessing its result
    try await comments.fetch()
    for comment in comments 
} catch let error as DataStoreError  catch let error as CoreError  catch 
```

</Block>

```swift
let sink = Amplify.Publisher.create .sink 
} receiveValue: 
    // call fetch to lazy load the postResult before accessing its result
    Task 
        } catch let error as CoreError  catch 
    }
}
```

</Block>

</BlockSwitcher>

The connected properties are of type `List`, where `M` is the model type, and that type is a custom [Swift Collection](https://developer.apple.com/documentation/swift/collection), which means that you can `filter`, `map`, etc:

```swift
let excitedComments = comments
    .compactMap 
    .filter 
```
