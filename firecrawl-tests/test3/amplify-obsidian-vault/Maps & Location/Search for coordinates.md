---
title: Search for coordinates
topics: ['Maps & Location']
primary_topic: Maps & Location
source: fragments/lib-v1/geo/ios/search/20_search_by_coordinates.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]]
**Primary**: [[Maps & Location/]]

---


# Search for coordinates

### Search for coordinates

The `Amplify.Geo.search(for coordinates:)` API is a reverse Geocoder that takes a coordinate point and returns information about what it finds at that point on the map.

```swift
Amplify.Geo.search(for: coordinates) 
}
```

You can refine your search by specifying following parameters inside `Geo.SearchForCoordinatesOptions`
- `maxResults` - to limit the maximum result set (defaults to 50)

```swift
let options = Geo.SearchForCoordinatesOptions(maxResults: 25)
```


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `fragments/lib-v1/geo/ios/search/20_search_by_coordinates.mdx`