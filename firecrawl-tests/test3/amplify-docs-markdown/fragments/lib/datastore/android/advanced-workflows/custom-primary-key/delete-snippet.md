---
title: Deleting records with custom primary keys
source: fragments/lib/datastore/android/advanced-workflows/custom-primary-key/delete-snippet.mdx
---

# Deleting records with custom primary keys

### Deleting records with custom primary keys

In addition to deleting by the model type (or `Predicates.ALL`), a record with a custom primary key can be deleted the following ways:

With a predicate:

#### Custom Primary Key

```java
Amplify.DataStore.query(Book.class, Where.identifier(Book.class,
                                                      Where.identifier(Book.class, "12345")),
    matches -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure));

```

</Block>

```kotlin
Amplify.DataStore.query(Book::class.java, Where.identifier(Book::class.java, "12345"),
    ,
                
            )
        }
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore.query(Book::class, Where.identifier(Book::class.java, "12345"))
    .catch 
    .onEach 
    .catch 
    .collect 
```

</Block>

```java
RxAmplify.DataStore.query(Book.class, Where.identifier(Book::class.java, "12345"))
    .flatMapCompletable(RxAmplify.DataStore::delete)
    .subscribe(
        () -> Log.i("MyAmplifyApp", "Deleted a book."),
        failure -> Log.e("MyAmplifyApp", "Delete failed.", failure)
    );
```

</Block>
</BlockSwitcher>

#### Composite Key

```java
Amplify.DataStore.query(Book.class, Where.identifier(Book.class, Where.identifier(Book::class.java,
                                                      new BookIdentifier( "12345", "My Title")),
    matches -> 
    },
    failure -> Log.e("MyAmplifyApp", "Query failed.", failure));

```

</Block>

```kotlin
Amplify.DataStore.query(Book::class.java, Where.identifier(Book::class.java,
                                                 BookIdentifier( "12345", "My Title")),
    ,
                
            )
        }
    },
    
)
```

</Block>

```kotlin
Amplify.DataStore.query(Book::class, Where.identifier(Book::class.java,
                                               BookIdentifier( "12345", "My Title")))
    .catch 
    .onEach 
    .catch 
    .collect 
```

</Block>

```java
RxAmplify.DataStore.query(Book.class, Where.identifier(Book::class.java,
                                       new BookIdentifier( "12345", "My Title")))
    .flatMapCompletable(RxAmplify.DataStore::delete)
    .subscribe(
        () -> Log.i("MyAmplifyApp", "Deleted a book."),
        failure -> Log.e("MyAmplifyApp", "Delete failed.", failure)
    );
```

</Block>
</BlockSwitcher>
