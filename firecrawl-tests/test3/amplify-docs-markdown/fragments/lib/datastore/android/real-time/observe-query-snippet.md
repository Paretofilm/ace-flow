---
title: Documentation
source: fragments/lib/datastore/android/real-time/observe-query-snippet.mdx
---

# Documentation

```java
String tag = "ObserveQuery";
Consumer> onQuerySnapshot = value ->;
Consumer observationStarted = value ->;
Consumer onObservationError = value ->;
Action onObservationComplete = () ->;
QueryPredicate predicate =
        Post.TITLE.beginsWith("post").and(Post.RATING.gt(10));
QuerySortBy querySortBy = new QuerySortBy("post", "rating", QuerySortOrder.ASCENDING);
List sortByList = new ArrayList();
sortByList.add(querySortBy);
ObserveQueryOptions options = new ObserveQueryOptions(predicate, sortByList);
Amplify.DataStore.observeQuery(
        Post.class,
        options,
        observationStarted,
        onQuerySnapshot,
        onObservationError,
        onObservationComplete
);
```

</Block>

```kotlin
val tag = "ObserveQuery"
val onQuerySnapshot: Consumer> =
    Consumer> 

val observationStarted =
    Consumer 
val onObservationError =
    Consumer 
val onObservationComplete = Action 
val predicate: QueryPredicate =
    Post.TITLE.beginsWith("post").and(Post.RATING.gt(10))
val querySortBy = QuerySortBy("post", "rating", QuerySortOrder.ASCENDING)

val options = ObserveQueryOptions(predicate, listOf(querySortBy))
Amplify.DataStore.observeQuery(
    Post::class.java,
    options,
    observationStarted,
    onQuerySnapshot,
    onObservationError,
    onObservationComplete
)
```

</Block>

```kotlin
val querySortBy = QuerySortBy("post", "rating", QuerySortOrder.ASCENDING)
Amplify.DataStore.observeQuery(
    Post::class,
    ObserveQueryOptions(Post.TITLE.beginsWith("post").and(Post.RATING.gt(10)),
        listOf(querySortBy))
    ).onStart 
        .catch 
        .onCompletion 
        .collect ") }
```

</Block>

```java
QueryPredicate predicate =
    Post.TITLE.beginsWith("post")
        .and(Post.RATING.gt(10));
QuerySortBy querySortBy = new QuerySortBy("post", "rating", QuerySortOrder.ASCENDING);
List sortByList = new ArrayList();
sortByList.add(querySortBy);
ObserveQueryOptions options = new ObserveQueryOptions(predicate, sortByList);
rxDataStore.observeQuery(Model.class, options).subscribe(
    modelDataStoreQuerySnapshot -> );
```

</Block>
</BlockSwitcher>
