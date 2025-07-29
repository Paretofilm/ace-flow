---
title: Deleting records with custom primary keys
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/ios/advanced-workflows/custom-primary-key/delete-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

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


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/ios/advanced-workflows/custom-primary-key/delete-snippet.mdx`