---
title: Select your user interface
source: fragments/lib/geo/android/maps/20_display_map.mdx
---

# Select your user interface

### Select your user interface

There are two UI components available to render maps on an Android app, the `MapLibreView` and the `AmplifyMapView`. The `MapLibreView` is an extension of the standard [Android MapLibre MapView](https://docs.maptiler.com/maplibre-gl-native-android/) that is integrated with the `Amplify.Geo` APIs, while the `AmplifyMapView` is a wrapper with built-in location search, map controls, markers and a few standard UX interactions.

#### `MapLibreView` vs `AmplifyMapView`

If the goal is to customize the UI, the `MapLibreView` provides a plain map that allows you to build and integrate your own controls and flow. If the goal is to use the map to search and select places, with a standard UI, then `AmplifyMapView` is a good choice.

Note that even though the extensibility of `AmplifyMapView` is limited, you have access to the wrapped `MapLibreView` through the `mapView` property (`getMapView()` on Java). So any API available to `MapLibreView` is also available on `AmplifyMapView`.

## MapLibreView

The `MapLibreView` is an extension of the standard `MapView` provided by the MapLibre library. The implementation adds the `Amplify.Geo` integration behind the scenes to enable developers to focus on their UI instead of the library integration. That also means all MapLibre APIs are available and will work as expected. Check the [official MapLibre SDK for Android documentation](https://docs.maptiler.com/maplibre-gl-native-android/) for the API reference and guides.

### Add a map to your app

1. Navigate to your app's `src/main/res/layout` directory in Android Studio

2. Create a new layout named `activity_main.xml`, or use an existing layout of your choice, and add the following:

```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    xmlns:mapbox="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <com.amplifyframework.geo.maplibre.view.MapLibreView
        android:id="@+id/mapView"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
    />

</androidx.constraintlayout.widget.ConstraintLayout>
```

### Initialize the MapLibreView

1. Navigate to your app's activity (e.g. `MainActivity`)

2. Add an import statement for MapLibreView at the top of your app's activity:

```java
import com.amplifyframework.geo.maplibre.view.MapLibreView;
```

</Block>

```kotlin
import com.amplifyframework.geo.maplibre.view.MapLibreView
```

</Block>
</BlockSwitcher>

3. Declare the view instance variable at top-level of the activity:

```java
private MapLibreView mapView;
```

</Block>

```kotlin
private val mapView by lazy 
```

</Block>
</BlockSwitcher>

4. Interact with the map in the Activity's `onCreate`:

```java
@Override
protected void onCreate(@Nullable Bundle savedInstanceState) 
```

</Block>

```kotlin
override fun onCreate(savedInstanceState: Bundle?) 
```

</Block>

</BlockSwitcher>

### Interact with the map

The map needs to be loaded in order to interact with it. You can use either `getMapAsync` that is called when the map is ready or `getStyle` that is called when both the map and its style are ready. Some APIs, like the `SymbolManager`, require the style to also be loaded so you can draw markers and other symbols on the map, that's when `getStyle` comes in handy.

### Update the map center

```java
import com.mapbox.mapboxsdk.camera.CameraPosition;
import com.mapbox.mapboxsdk.geometry.LatLng;
```

```java
mapView.getMapAsync(map -> );
```

</Block>

```kotlin
import com.mapbox.mapboxsdk.camera.CameraPosition
import com.mapbox.mapboxsdk.geometry.LatLng
```

```kotlin
mapView.getMapAsync 
```

</Block>

</BlockSwitcher>

Updating `cameraPosition` moves the camera to the passed coordinates without any animation. If animation is needed, use `map.animateCamera()` instead. See the [official reference](https://docs.mapbox.com/android/maps/guides/camera-and-animation/camera/) for more details.

### Add markers to your map

The MapLibre SDK for Android relies on the [MapLibre Annotation Plugin](https://docs.mapbox.com/android/maps/guides/annotations/) in order to display markers on a map.

```java
import com.mapbox.mapboxsdk.camera.CameraUpdateFactory;
import com.mapbox.mapboxsdk.plugins.annotation.SymbolOptions;
```

```java
mapView.getStyle((map, style) -> );
```

</Block>

```kotlin
import com.mapbox.mapboxsdk.camera.CameraUpdateFactory
import com.mapbox.mapboxsdk.plugins.annotation.SymbolOptions
```

```kotlin
mapView.getStyle 
```

</Block>

</BlockSwitcher>

**Notes:**

- The `mapView.symbolManager` is a built-in reference of `SymbolManager` from the [MapLibre Annotation Plugin](https://docs.mapbox.com/android/maps/guides/annotations/) with some standard configuration.
- If customized icons or render other types of shapes and layers are needed, an instance of `SymbolManager` can be created and used to manage the different types of custom use-cases.

### MapLibreView configuration parameters

The `MapLibreView` has several configuration parameters that are not present in the official guides yet. For a complete list, refer to the [source xml file](https://github.com/maplibre/maplibre-gl-native/blob/main/platform/android/MapLibreAndroid/src/main/res/values/attrs.xml).

Also, check the [official MapView API reference](https://docs.maptiler.com/maplibre-gl-native-android/com.mapbox.mapboxsdk.maps/#mapview) for the available public API documentation.

## AmplifyMapView

The `AmplifyMapView` provides a default search field, place markers, visualization modes (map or list) and map controls. It can be used to easily embed a place picker into any app. To use the search functionality of `AmplifyMapView`, provision a search index resource using the instructions in either [Configure Location Search](/gen1/[platform]/build-a-backend/more-features/geo/configure-location-search/) or [Use existing Amazon Location Service resources](/gen1/[platform]/build-a-backend/more-features/geo/existing-resources/).

### Add a map to your app

1. Navigate to your app's `src/main/res/layout` directory in Android Studio

2. Create a new layout named `activity_main.xml`, or use an existing layout of your choice, and add the following:

```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    xmlns:map="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <com.amplifyframework.geo.maplibre.view.AmplifyMapView
        android:id="@+id/mapView"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
    />

</androidx.constraintlayout.widget.ConstraintLayout>
```

### Initialize the AmplifyMapView

1. Navigate to your app's activity (e.g. `MainActivity`)

2. Add an import statement for AmplifyMapView at the top of your app's activity:

```java
import com.amplifyframework.geo.maplibre.view.AmplifyMapView;
```

</Block>

```kotlin
import com.amplifyframework.geo.maplibre.view.AmplifyMapView
```

</Block>
</BlockSwitcher>

3. Declare the view instance variable at top-level of the activity:

```java
private AmplifyMapView amplifyMapView;
```

</Block>

```kotlin
private val amplifyMapView by lazy 
```

</Block>
</BlockSwitcher>

4. Interact with the map in the Activity's `onCreate`:

```java
@Override
protected void onCreate(@Nullable Bundle savedInstanceState) 
```

</Block>

```kotlin
override fun onCreate(savedInstanceState: Bundle?) 
```

</Block>

</BlockSwitcher>

### Place select

The main API provided by `AmplifyMapView` is an event listener that is called when a place is selected on the map, either by clicking on the mark or the item on the list.

```java
import android.util.Log;
```

```java
amplifyMapView.setOnPlaceSelectListener((place, symbol) -> );
```

</Block>

```kotlin
import android.util.Log
```

```kotlin
amplifyMapView.onPlaceSelect ")
    Log.i("MyAmplifyApp", "It is located at $")
}
```

</Block>

</BlockSwitcher>

### AmplifyMapView configuration parameters

The view can be initialized with the following configuration parameters:

| Property                       | Type    | Description                                          | Default |
|--------------------------------|---------|------------------------------------------------------|---------|
| `map:map_centerLatitude`       | Float   | The initial center latitude                          | `0.0`   |
| `map:map_centerLongitude`      | Float   | The initial center longitude                         | `0.0`   |
| `map:map_minZoomLevel`         | Integer | The minimum zoom level (min is 0)                    | `3`     |
| `map:map_maxZoomLevel`         | Integer | The maximum zoom level (max is 22)                   | `18`    |
| `map:map_showCompassIndicator` | Boolean | Whether the compass should be displayed or not       | `true`  |
| `map:map_showZoomControls`     | Boolean | Whether the zoom controls should be displayed or not | `false` |
| `map:map_zoomLevel`            | Integer | The initial zoom level (between 0 and 22)            | `14`    |

Example:

```xml
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout
    xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools"
    xmlns:map="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    tools:context=".MainActivity">

    <com.amplifyframework.geo.maplibre.view.AmplifyMapView
        android:id="@+id/mapView"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        map:map_zoomLevel="12"
        map:map_centerLatitude="47.6160281982247"
        map:map_centerLongitude="-122.32642111977668"
        map:map_showCompassIndicator="true"
        map:map_showZoomControls="true"
    />

</androidx.constraintlayout.widget.ConstraintLayout>
```
