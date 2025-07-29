---
title: Search by text
topics: ['Maps & Location']
primary_topic: Maps & Location
source: fragments/lib/geo/android/search/10_search_by_text.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]]
**Primary**: [[Maps & Location/]]

---


# Search by text

### Search by text

The `Amplify.Geo.searchByText()` API enables you to search for places or points of interest by free-form text, such as an address, name, city, or region.

```java
String searchQuery = "Amazon Go";
Amplify.Geo.searchByText(searchQuery,
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "Failed to search for " + searchQuery, error)
);
```

</Block>

```kotlin
val searchQuery = "Amazon Go"
Amplify.Geo.searchByText(searchQuery,
    
    },
    
)
```

</Block>

```kotlin
val searchQuery = "Amazon Go"
try 
} catch (error: GeoException) 
```

</Block>

```java
String searchQuery = "Amazon Go";
RxAmplify.Geo.searchByText(searchQuery).subscribe(
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "Failed to search for " + searchQuery, error)
);
```

</Block>
</BlockSwitcher>

Restrict your search results by specifying following parameters inside `GeoSearchByTextOptions`:
- `countries` - to limit the search results to given countries. Follows [ISO Alpha-3 country codes](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3). (defaults to "USA")
- `maxResults` - to limit the maximum result set (defaults to 50)
- `searchArea`
  - `near` - to act as the search origination location
  - `within` - to limit the area to search inside of

```java
Coordinates position = new Coordinates(47.6153, -122.3384);
GeoSearchByTextOptions options = GeoSearchByTextOptions.builder()
    .maxResults(10)
    .searchArea(SearchArea.near(position))
    .countries(Collections.singletonList(CountryCode.USA))
    .build();
```

</Block>

```kotlin
val position = Coordinates(47.6153, -122.3384)
val options = GeoSearchByTextOptions.builder()
    .maxResults(10)
    .searchArea(SearchArea.near(position))
    .countries(listOf(CountryCode.USA))
    .build()
```

</Block>

```kotlin
val position = Coordinates(47.6153, -122.3384)
val options = GeoSearchByTextOptions.builder()
    .maxResults(10)
    .searchArea(SearchArea.near(position))
    .countries(listOf(CountryCode.USA))
    .build()
```

</Block>

```java
Coordinates position = new Coordinates(47.6153, -122.3384);
GeoSearchByTextOptions options = GeoSearchByTextOptions.builder()
    .maxResults(10)
    .searchArea(SearchArea.near(position))
    .countries(Collections.singletonList(CountryCode.USA))
    .build();
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `fragments/lib/geo/android/search/10_search_by_text.mdx`