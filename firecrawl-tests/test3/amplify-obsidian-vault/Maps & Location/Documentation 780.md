---
title: Documentation
topics: ['Maps & Location']
primary_topic: Maps & Location
source: fragments/lib/geo/ios/maps/30_styles.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]]
**Primary**: [[Maps & Location/]]

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


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `fragments/lib/geo/ios/maps/30_styles.mdx`