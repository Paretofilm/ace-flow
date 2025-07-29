---
title: Search for coordinates
source: fragments/lib/geo/ios/search/20_search_by_coordinates.mdx
---

# Search for coordinates

### Search for coordinates

The `Amplify.Geo.search(for coordinates:)` API is a reverse Geocoder that takes a coordinate point and returns information about what it finds at that point on the map.

```swift
do  catch let error as Geo.Error  catch 
```

You can refine your search by specifying following parameters inside `Geo.SearchForCoordinatesOptions`
- `maxResults` - to limit the maximum result set (defaults to 50)

```swift
let options = Geo.SearchForCoordinatesOptions(maxResults: 25)
```
