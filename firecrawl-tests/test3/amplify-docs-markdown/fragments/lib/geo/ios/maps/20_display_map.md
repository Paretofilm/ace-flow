---
title: Select your user interface
source: fragments/lib/geo/ios/maps/20_display_map.mdx
---

# Select your user interface

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

AmplifyMapLibre.createMap 
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
