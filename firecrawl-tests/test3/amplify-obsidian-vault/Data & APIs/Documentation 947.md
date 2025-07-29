---
title: Documentation
topics: ['Data & APIs']
primary_topic: Data & APIs
source: fragments/lib/datastore/android/advanced-workflows/custom-primary-key/query-snippet.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, data-&-apis]
---


## 🧭 Navigation
**Topics**: [[Data & APIs/]]
**Primary**: [[Data & APIs/]]

---


# Documentation

With the value of the primary key:

```java
Amplify.DataStore.query(Book.class, Where.identifier(Book.class, "12345"),
    matches -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure));
```

</Block>

```kotlin
Amplify.DataStore.query(Book::class.java, Where.identifier(Book::class.java, "12345"),
    
                            },
   )
```

</Block>

```kotlin
Amplify.DataStore.query(Book::class, Where.identifier(Book::class.java, "12345"))
    .catch 
    .collect ") }
```

</Block>

```java
RxAmplify.DataStore.query(Book.class, Where.identifier(Book::class.java, "12345")).subscribe(
    book -> Log.i("MyAmplifyApp", "Title: " + book.getTitle()),
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>
</BlockSwitcher>

With the values of the composite key:

```java
Amplify.DataStore.query(Book.class, Where.identifier(Book.class,
    new BookIdentifier( "12345", "My Title")),
    matches -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure));
```

</Block>

```kotlin
Amplify.DataStore.query(Book::class.java, Where.identifier(Book::class.java,
                                          BookIdentifier( "12345", "My Title")),
    
                            },
   )
```

</Block>

```kotlin
Amplify.DataStore.query(Book::class, Where.identifier(Book::class.java,
        BookIdentifier( "12345", "My Title")))
  .catch 
  .collect ") }
```

</Block>

```java
RxAmplify.DataStore.query(Post.class, Where.identifier(Book::class.java,
                            new BookIdentifier( "12345", "My Title"))).subscribe(
    post -> Log.i("MyAmplifyApp", "Title: " + post.getTitle()),
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure)
);
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Data & APIs/]]

## 📖 Source
Original: `fragments/lib/datastore/android/advanced-workflows/custom-primary-key/query-snippet.mdx`