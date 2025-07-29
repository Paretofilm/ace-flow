---
title: Documentation
source: fragments/lib/geo/android/maps/30_styles.mdx
---

# Documentation

The `getAvailableMaps` API fetches information for all maps that are available to be displayed.

This is useful if you would like to give your users a variety of map styles to choose from.

```java
Amplify.Geo.getAvailableMaps(
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "Failed to get available maps.", error)
);
```

</Block>

```kotlin
Amplify.Geo.getAvailableMaps(
    
    },
    
)
```

</Block>

```kotlin
try 
} catch (error: GeoException) 
```

</Block>

```java
RxAmplify.Geo.getAvailableMaps().subscribe(
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "Failed to get available maps.", error)
);
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
