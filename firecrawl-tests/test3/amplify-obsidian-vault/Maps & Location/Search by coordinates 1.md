---
title: Search by coordinates
topics: ['Maps & Location']
primary_topic: Maps & Location
source: fragments/lib/geo/android/search/20_search_by_coordinates.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]]
**Primary**: [[Maps & Location/]]

---


# Search by coordinates

### Search by coordinates

The `Amplify.Geo.searchByCoordinates()` API is a reverse Geocoder that takes a coordinate point and returns information about what it finds at that point on the map.
The returned object is the same shape as `Amplify.Geo.searchByText()` API.

```java
Coordinates position = new Coordinates(47.6153, -122.3384);
Amplify.Geo.searchByCoordinates(position,
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "Failed to reverse geocode " + position, error)
);
```

</Block>

```kotlin
val position = Coordinates(47.6153, -122.3384)
Amplify.Geo.searchByCoordinates(position,
    
    },
    
)
```

</Block>

```kotlin
val position = Coordinates(47.6153, -122.3384)
try 
} catch (error: GeoException) 
```

</Block>

```java
Coordinates position = new Coordinates(47.6153, -122.3384);
RxAmplify.Geo.searchByCoordinates(position).subscribe(
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "Failed to reverse geocode " + position, error)
);
```

</Block>
</BlockSwitcher>

Restrict your search results by specifying following parameters inside `GeoSearchByCoordinatesOptions`:
- `maxResults` - to limit the maximum result set (defaults to 50)

```java
GeoSearchByCoordinatesOptions options = GeoSearchByCoordinatesOptions.builder()
    .maxResults(1)
    .build();
```

</Block>

```kotlin
val options = GeoSearchByCoordinatesOptions.builder()
    .maxResults(1)
    .build()
```

</Block>

```kotlin
val options = GeoSearchByCoordinatesOptions.builder()
    .maxResults(1)
    .build()
```

</Block>

```java
GeoSearchByCoordinatesOptions options = GeoSearchByCoordinatesOptions.builder()
    .maxResults(1)
    .build();
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `fragments/lib/geo/android/search/20_search_by_coordinates.mdx`