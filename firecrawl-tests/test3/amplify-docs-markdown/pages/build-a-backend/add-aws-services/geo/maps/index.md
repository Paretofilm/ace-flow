---
title: Display a map
source: pages/build-a-backend/add-aws-services/geo/maps/index.mdx
---

# Display a map

## Display a map

First, ensure you've provisioned an Amazon Location Service Map resource and configured your app using the instructions in either [Set up map](/[platform]/build-a-backend/add-aws-services/geo/set-up-geo/) or [Use existing resources](/[platform]/build-a-backend/add-aws-services/geo/existing-resources/) guide.

> **Note**: 

**Note:** For React, you can use the [Amplify React MapView component](https://ui.docs.amplify.aws/react/components/geo)

To render a map, the [MapLibre GL](https://github.com/maplibre/maplibre-gl-js) and the `maplibre-gl-js-amplify` libraries are required. MapLibre GL is an open source map rendering library and `maplibre-gl-js-amplify` library makes it easy to integrate MapLibre with Amplify Geo and handles Authentication.

Add the dependencies to your app:

```bash title="Terminal" showLineNumbers= 
npm add maplibre-gl maplibre-gl-js-amplify
```

> **Note**: 

Verify the following:

- `maplibre-gl-js-amplify` version `4.0.0` or above is installed
- Any package bundlers (webpack, rollup, etc) are configured to handle css files. Check out the webpack documentation [here](https://webpack.js.org/loaders/css-loader/).

Import the library into your application:

```javascript
import 'maplibre-gl/dist/maplibre-gl.css';
```

Next, create and render the [Map](https://maplibre.org/maplibre-gl-js/docs/API/classes/Map/) with the help of [createMap](https://github.com/aws-amplify/maplibre-gl-js-amplify/blob/main/API.md#createmap).

**Note:** There must be a `div` with an `id="map"` on the DOM before making the call to `createMap` in this way.

```javascript
async function initializeMap() );
}

initializeMap();
```

To render a map using a className or something other than the ID you can pass in a reference to the HTML Element itself.

```javascript
const element = document.getElementsByClassName("class")[0];

const map = await createMap()
```

> **Note**: 

The MapLibre canvas requires a defined height to display properly, otherwise you may end up with a blank screen where the map is supposed to be.

The [amplify-map.css](https://github.com/aws-amplify/maplibre-gl-js-amplify/blob/main/src/public/amplify-map.css) file has a few commonly used methods for setting the height of the map component. You can add some of the examples listed to your own styles or directly import `amplify-map.css` like so:

```
import "maplibre-gl-js-amplify/dist/public/amplify-map.css";
```

To render a map using percentage based height you need to ensure that all ancestor elements to the map container have a height:

```css
html,
body,
#root 

### Sample application

```html
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Display a map on a webpage</title>
        <meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no">
        <link href="https://cdn.amplify.aws/packages/maplibre-gl/1.15.2/maplibre-gl.css" rel="stylesheet" integrity="sha384-DrPVD9GufrxGb7kWwRv0CywpXTmfvbKOZ5i5pN7urmIThew0zXKTME+gutUgtpeD" crossorigin="anonymous" referrerpolicy="no-referrer"></link>
        <script src="https://cdn.amplify.aws/packages/maplibre-gl/1.15.2/maplibre-gl.js" integrity="sha384-rwYfkmAOpciZS2bDuwZ/Xa/Gog6jXem8D/whm3wnsZSVFemDDlprcUXHnDDUcrNU" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdn.amplify.aws/packages/core/5.0.5/aws-amplify-core.min.js" integrity="sha384-eM2urkpomL9SRm/kuPHZG3XPEItAiUAAyotT/AqlhSus8iAqs/EfHaYy1Jn5ih7K" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdn.amplify.aws/packages/auth/5.0.5/aws-amplify-auth.min.js" integrity="sha384-H25CFLYd7YHa1Oib73fs3kJN36VhaHHkLjo4AhGrhJ4HuKam05pg2/0t2MR6epun" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdn.amplify.aws/packages/geo/2.0.5/aws-amplify-geo.min.js" integrity="sha384-Esc9xx0X7ckb/yeYHuYsZGqBB4FwYr98NFHS3BRXLeRE/eB0uVrad2w+G6cGxYb5" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdn.amplify.aws/packages/maplibre-gl-js-amplify/1.5.0/maplibre-gl-js-amplify.umd.min.js" integrity="sha384-9kJyZavd3Jk6QzHeaLpugVonfZmZZZdixek6uglOwzKtZvDS9K3W4dshw1uswmlV" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <style>
            body 
            #map 
        </style>
    </head>
    <body>
        <div id="map"></div>
        <script type="module">
            import outputs from "./amplify_outputs.json" assert ;
            const  = aws_amplify_core;
            const  = AmplifyMapLibre;
            Amplify.configure(outputs);
            createMap();
        </script>
    </body>
</html>
```

## Map API's

If you want more information about the maps you currently have configured or want a way to switch between maps programmatically, the `@aws-amplify/geo` package provides API's that return more information about your currently provisioned maps.

First, you need to import Geo from the `@aws-amplify/geo` package.

```javascript
```

### getAvailableMaps

`getAvailableMaps` will return the map resources you currently have provisioned in your Amplify project. You can switch between any of these different maps and display their different map styles.

#### API

```javascript
Geo.getAvailableMaps() => Promise;
```

#### Parameters

- N/A

#### Return

The return from `getAvailableMaps` is a Promise that resolves to `AmazonLocationServiceMapStyle[]` which is an array of `mapName`, `style`, and `region`.

Each object has the following properties:

- `mapName` - name of the map you created.
- `style` - the Amazon Location Service style used to create the map.
- `region` - the AWS region the map is hosted in.

> **Note**: 

**Note:** When changing a map with Amplify and MapLibre the [setStyle](https://maplibre.org/maplibre-gl-js/docs/API/classes/Map/#setstyle) function should be called with the name of the Location Service map NOT the style. This is because the `transformRequest` function uses the Location Service map name to make a new request for map tile data.

#### Example

```js
const availableMaps = await Geo.getAvailableMaps();

map.setStyle(availableMaps[0].mapName);
```

### getDefaultMap

`getDefaultMap` is used to get a the default map object.

#### API

```javascript
Geo.getDefaultMap() => Promise;
```

#### Parameters

- N/A

#### Return

The return from `getDefaultMap` is a Promise that resolves to a AmazonLocationServiceMapStyle object.

The object has the following properties:

- `mapName` - name of the map you created.
- `style` - the Amazon Location Service style used to create the map.
- `region` - the AWS region the map is hosted in.

#### Example

```javascript
const defaultMap = await Geo.getDefaultMap();
```

</InlineFilter>

## Install Amplify-MapLibre adapter

Add the following dependency to your **build.gradle (Module :app)** file and click "Sync Now" when prompted:

```groovy
dependencies 
```

> **Note**: 

**Note:** the minimum API level required for the UI components is 21.

</InlineFilter>

> **Note**: 

MapLibre is
[not officially supported on macOS](https://github.com/maplibre/maplibre-gl-native/blob/9d37d3d4aab293675f3df3a7f9bee7b2f476daf5/platform/ios/platform/macos/README.md?plain=1#L22),
and as a result `amplify-ios-maplibre` can only be used on iOS. Apple's [MapKit](https://developer.apple.com/documentation/mapkit/)
framework may be used in order to display maps on macOS applications.

First, ensure you've provisioned an Amazon Location Service Map resource and configured your app using the instructions in either [Configure maps](/[platform]/build-a-backend/add-aws-services/geo/set-up-geo/) or [Use existing resources](/[platform]/build-a-backend/add-aws-services/geo/existing-resources/) guide.

Amplify-MapLibre is an open source adapter that enables the popular MapLibre SDK to work seamlessly with Amplify Geo.

1. To install the Amplify-MapLibre adapter to your application, open your project in Xcode and select **File > Add Packages...**

1. Enter the amplify-ios-maplibre GitHub repo URL (`https://github.com/aws-amplify/amplify-ios-maplibre`) into the search bar and hit **Enter**. Wait for the result to load. You'll see the repository rules for which version of amplify-ios-mapLibre you want Swift Package Manager to install. 

1. Choose the dependency rule **Up to Next Major Version**, as it will use the latest compatible version of the dependency, then click **Add Package**.

1. Lastly, choose which of the libraries you want added to your project. If you want to use the SwiftUI user interface components provided by the adapter, select both **AmplifyMapLibreAdapter** and **AmplifyMapLibreUI**. If you only want to enable Amplify Geo to work directly with MapLibre and do not wish use use the provided SwiftUI views, you can just select **AmplifyMapLibreAdapter**. After you select the libraries, click **Add Package**.

> **Note**: 

You can always go back and modify which SPM packages are included in your project by opening the Swift Packages tab for your project (`Project file > Project > Package Dependencies`)

</InlineFilter>

## Display a map

First, ensure you've provisioned an Amazon Location Service Map resource and configured your app using the instructions in either [Configure maps](/[platform]/build-a-backend/add-aws-services/geo/set-up-geo/) or [Use existing resources](/[platform]/build-a-backend/add-aws-services/geo/existing-resources/) guide.

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

The `AmplifyMapView` provides a default search field, place markers, visualization modes (map or list) and map controls. It can be used to easily embed a place picker into any app. To use the search functionality of `AmplifyMapView`, provision a search index resource using the instructions in either [Configure Location Search](/[platform]/build-a-backend/add-aws-services/geo/configure-location-search/) or [Use existing Amazon Location Service resources](/[platform]/build-a-backend/add-aws-services/geo/configure-location-search/).

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
</InlineFilter>

### Select your user interface

There are two ways to display a map. The easiest way to get started is to use the `AmplifyMaplibreUI` library to create an instance of `AMLMapView`. This is the recommended approach for new projects or anyone who wants to use SwiftUI.

Alternatively, if you are using UIKit or have existing code using the MapLibre/MapBox SDK, you can simply call `AmplifyMapLibre.createMap(completionHandler:)` to create an instance of `MGLMapView` that is pre-wired for use with Amazon Location Service and Amplify. For more information on using `MGLMapView` directly, please see the [MapLibre Documentation](https://docs.maptiler.com/maplibre-gl-native-ios/)

```swift
import SwiftUI
import AmplifyMapLibreUI

struct ContentView: View 
}
```

</Block>

```swift
import AmplifyMapLibreAdapter
import Mapbox
import Amplify

var mapView: MGLMapView?
do  catch 
```

</Block>
</BlockSwitcher>

## Customize the map and access state

The `AMLMapView` can be customized through a number of view modifiers. The map state information can be set and observed through an instance of `AMLMapViewState`, which can optionally be passed into `AMLMapView` to set initial values. The following example sets an initial zoom level and center location for the map and configures the map to show the user's location.

```swift
@StateObject private var mapState = AMLMapViewState(
    zoomLevel: 8,
    center: CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903)
)

var body: some View 
```

## Inject custom behavior

The `AMLMapView` also allows for custom behavior triggered by user interaction to be injected. The following example sets a custom feature image and defines the maps behavior when that feature is tapped - zooming in two levels above the current level.

```swift
var body: some View 
        .featureTapped 
        .edgesIgnoringSafeArea(.all)
}
```

## AMLMapCompositeView

The `AMLMapCompositeView` combines `AMLMapView`, `AMLSearchBar`, `AMLMapControlView`, and `AMLPlaceCellView` to create a full user experience. This includes accessible map control buttons, a search bar that automatically searches for points of interest based on user input, and a list representation of points.
In its simplest form, which still leverages all of the above mentioned functionality, the `AMLMapCompositeView` can be instantiated without any arguments. All of the view modifiers and state tracking capabilities of `AMLMapView` are also available on `AMLMapCompositeView`.

```swift
var body: some View 
```
> **Note**: 

For full details on `AMLMapView` usage and customization, see the [AmplifyMapLibre documentation](https://aws-amplify.github.io/amplify-ios-maplibre/docs/).

</InlineFilter>

## Display different map styles

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
</InlineFilter>

The `availableMaps` API fetches information for all maps that are available to be displayed.

This is useful if you would like to give your users a variety of maps styles to choose from.

```swift
var maps = [Geo.MapStyle]()
do  catch let error as Geo.Error  catch 
```

You can load a different style map by passing it to the createMap function.

```swift
guard let mapStyle = maps.first else 

let mapView = AmplifyMapLibre.createMap(mapStyle)
```
</InlineFilter>

</InlineFilter>
