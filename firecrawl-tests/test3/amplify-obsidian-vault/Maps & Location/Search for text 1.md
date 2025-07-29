---
title: Search for text
topics: ['Maps & Location']
primary_topic: Maps & Location
source: fragments/lib/geo/ios/search/10_search_by_text.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]]
**Primary**: [[Maps & Location/]]

---


# Search for text

### Search for text

The `Amplify.Geo.search(for text:)` API enables you to search for places or points of interest by free-form text, such as an address, name, city, or region.

```swift
do  catch 
```

You can refine your search by specifying following parameters inside `Geo.SearchForTextOptions`

- `area`
  - `.near` - to act as the search origination location.
  - `.within` - to limit the area to search within.
- `countries` - to limit the search results to given countries.
- `maxResults` - to limit the maximum result set (defaults to 50).

```swift
let coordinates = Geo.Coordinates(latitude: 47.62246, longitude: -122.336775)
let options = Geo.SearchForTextOptions(area: .near(coordinates), countries: [.usa, .can], maxResults: 25)

do  catch let error as Geo.Error  catch 
```


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `fragments/lib/geo/ios/search/10_search_by_text.mdx`