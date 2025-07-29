---
title: Search by coordinates
source: fragments/lib-v1/geo/android/search/20_search_by_coordinates.mdx
---

# Search by coordinates

### Search by coordinates

The `Amplify.Geo.searchByCoordinates()` API is a reverse Geocoder that takes a coordinate point and returns information about what it finds at that point on the map.
The returned object is the same shape as `Amplify.Geo.searchByText()` API.

```java
import android.util.Log;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.geo.models.Coordinates;
import com.amplifyframework.geo.models.Place;
```

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
import android.util.Log
import com.amplifyframework.core.Amplify
import com.amplifyframework.geo.models.Coordinates
```

```kotlin
val position = Coordinates(47.6153, -122.3384)
Amplify.Geo.searchByCoordinates(position,
    
    },
    
)
```

</Block>
</BlockSwitcher>

Restrict your search results by specifying following parameters inside `GeoSearchByCoordinatesOptions`:
- `maxResults` - to limit the maximum result set (defaults to 50)

```java
import com.amplifyframework.geo.options.GeoSearchByCoordinatesOptions;
```

```java
GeoSearchByCoordinatesOptions options = GeoSearchByCoordinatesOptions.builder()
    .maxResults(1)
    .build();
```

</Block>

```kotlin
import com.amplifyframework.geo.options.GeoSearchByCoordinatesOptions
```

```kotlin
val options = GeoSearchByCoordinatesOptions.builder()
    .maxResults(1)
    .build()
```

</Block>
</BlockSwitcher>
