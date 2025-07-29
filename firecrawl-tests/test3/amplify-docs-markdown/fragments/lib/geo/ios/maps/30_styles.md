---
title: Documentation
source: fragments/lib/geo/ios/maps/30_styles.mdx
---

# Documentation

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
