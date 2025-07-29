---
title: Documentation
topics: ['Maps & Location']
primary_topic: Maps & Location
source: fragments/lib-v1/geo/android/maps/30_styles.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]]
**Primary**: [[Maps & Location/]]

---


# Documentation

The `getAvailableMaps` API fetches information for all maps that are available to be displayed.

This is useful if you would like to give your users a variety of map styles to choose from.

```java
import com.amplifyframework.core.Amplify;
import com.amplifyframework.geo.models.MapStyle;
```

```java
Amplify.Geo.getAvailableMaps(
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "Failed to get available maps.", error)
);
```

</Block>

```kotlin
import com.amplifyframework.core.Amplify
```

```kotlin
Amplify.Geo.getAvailableMaps(
    
    },
    
)
```

</Block>
</BlockSwitcher>

You can set a different style to your map using `setStyle` method from the adapter:

With `MapLibreView`:

```java
// where mapStyle is a reference to the selected style from Amplify.Geo.getAvailableMaps
mapView.setStyle(mapStyle, style -> );
```

With `AmplifyMapView`:
```java
// where mapStyle is a reference to the selected style from Amplify.Geo.getAvailableMaps
amplifyMapView.getMapView().setStyle(mapStyle, style -> );
```

</Block>

With `MapLibreView`:

```kotlin
// where mapStyle is a reference to the selected style from Amplify.Geo.getAvailableMaps
mapView.setStyle(mapStyle) .")
}
```

With `AmplifyMapView`:

```kotlin
// where mapStyle is a reference to the selected style from Amplify.Geo.getAvailableMaps
amplifyMapView.mapView.setStyle(mapStyle) .")
}
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `fragments/lib-v1/geo/android/maps/30_styles.mdx`