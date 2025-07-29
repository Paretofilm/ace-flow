---
title: Deleting records with custom primary keys
source: fragments/lib/datastore/ios/advanced-workflows/custom-primary-key/delete-snippet.mdx
---

# Deleting records with custom primary keys

### Deleting records with custom primary keys

A record with a custom primary key can be deleted in the following ways:

With the value of the primary key:

```swift
Amplify.DataStore.delete(Book.self, withIdentifier: .identifier(isbn: "12345")) 
}
```

</Block>

```swift
let sink = Amplify.DataStore.delete(Book.self, withIdentifier: .identifier(isbn: "12345")).sink 
} receiveValue: 
```
</Block>

</BlockSwitcher>

With the value of QueryPredicate:

```swift
Amplify.DataStore.delete(Book.self, where: Book.keys.isbn == "12345") 
}
```
</Block>

```swift
let sink = Amplify.DataStore.delete(Book.self, where: Book.keys.isbn == "12345").sink 
} receiveValue: 
```
</Block>

</BlockSwitcher>
