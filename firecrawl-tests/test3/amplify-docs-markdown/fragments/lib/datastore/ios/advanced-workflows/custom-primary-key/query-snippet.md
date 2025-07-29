---
title: Documentation
source: fragments/lib/datastore/ios/advanced-workflows/custom-primary-key/query-snippet.mdx
---

# Documentation

A record with a custom primary key can be queried for in the following ways:

With the value of the primary key:

```swift
Amplify.DataStore.query(Book.self, byIdentifier: .identifier(isbn: "12345")) 
        print("Query was successful, retrieved book: \(book)")
    case .failure(let error):
        print("Error on query() for type Book with error: \(error)")
    }
}
```

</Block>

```swift
let sink = Amplify.DataStore.query(Book.self, byIdentifier: .identifier(isbn: "12345")).sink 
} receiveValue:
    print("Query was successful, retrieved book: \(book)")
}
```

</Block>

</BlockSwitcher>

With the value of QueryPredicate:

```swift
Amplify.DataStore.query(Book.self, where: Book.keys.isbn == "12345") 
}
```

</Block>

```swift
let sink = Amplify.DataStore.query(Book.self, where: Book.keys.isbn == "12345").sink 
} receiveValue: 
```

</Block>

</BlockSwitcher>
