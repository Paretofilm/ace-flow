---
title: Add location search functionality on a map
topics: ['Maps & Location']
primary_topic: Maps & Location
source: pages/build-a-backend/add-aws-services/geo/location-search/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]]
**Primary**: [[Maps & Location/]]

---


# Add location search functionality on a map

## Add location search functionality on a map

First, make sure you've provisioned a search index resource and configured your app using the instructions in either [Configure Location Search](/[platform]/build-a-backend/add-aws-services/geo/configure-location-search/) or [Use existing Amazon Location Service resources](/[platform]/build-a-backend/add-aws-services/geo/existing-resources/) and you have already setup [displaying a map](/[platform]/build-a-backend/add-aws-services/geo/maps) in your application.

> **Note**: 

**Note:** For React, you can use the [Amplify UI Location Search component](https://ui.docs.amplify.aws/react/connected-components/geo#location-search) to generate and display the search results.

To add a location search UI component to your map, you can use the [maplibre-gl-geocoder](https://github.com/maplibre/maplibre-gl-geocoder) library. `maplibre-gl-js-amplify` package makes it easy to integrate `maplibre-gl-geocoder` with Amplify Geo by exporting a utility function `createAmplifyGeocoder()` that returns an instance of `maplibre-gl-geocoder` with some pre-defined settings and supports all the [options](https://maplibre.org/maplibre-gl-geocoder/types/MaplibreGeocoderOptions.html) for customizing the UI component

Install the necessary dependencies with the following command:

```bash title="Terminal" showLineNumbers= 
npm add @maplibre/maplibre-gl-geocoder maplibre-gl@1 maplibre-gl-js-amplify
```

> **Note:** Make sure that `maplibre-gl-js-amplify` version `4.0.0` or above is installed.

First, create a map onto which you want to add the location search UI component. See the guide on [creating and displaying maps](/[platform]/build-a-backend/add-aws-services/geo/maps).

Then, use `createAmplifyGeocoder()` to get a new instance of `MaplibreGeocoder` and add the location search UI component to the map.

> **Note:** Ensure that your package bundler (webpack, rollup, etc) is configured to handle css files. Check out the webpack documentation [here](https://webpack.js.org/loaders/css-loader/).

```javascript
import "maplibre-gl/dist/maplibre-gl.css";
import "@maplibre/maplibre-gl-geocoder/dist/maplibre-gl-geocoder.css";
import "maplibre-gl-js-amplify/dist/public/amplify-geocoder.css"; // Optional CSS for Amplify recommended styling

async function initializeMap() )

    map.addControl(createAmplifyGeocoder());
}

initializeMap();
```

![A search box on the top right corner of a map](/images/geocoder-search-box-map.png)

### Display the location search box outside the map

You can also use [maplibre-gl-geocoder](https://github.com/maplibre/maplibre-gl-geocoder) to display the location search UI component anywhere in your application, even outside the map.

To do so, extract the html element using function `onAdd()` and attach it anywhere in your DOM instead of adding it via the map's `addControl()` function.

```javascript
const geocoder = createAmplifyGeocoder();
document.getElementById("search").appendChild(geocoder.onAdd());
```

![A search box with multiple Starbucks locations](/images/geocoder-search-box.png)

### Customize Search Icons

You can customize the search icons used by the [maplibre-gl-geocoder](https://github.com/maplibre/maplibre-gl-geocoder) to use any image of your choosing. [MapLibre markers](https://maplibre.org/maplibre-gl-js/docs/API/#markers-and-controls) require an [HTMLElement](https://developer.mozilla.org/en-US/docs/Web/HTML/Element) when passing in custom images.

The following example puts an existing SVG icon into an HTMLElement before being passed to `createAmplifyGeocoder` which creates a [maplibre-gl-geocoder](https://github.com/maplibre/maplibre-gl-geocoder).

```javascript

const icon = new Image(100, 100);
icon.src = myIcon;

const geocoder = createAmplifyGeocoder( });
map.addControl(geocoder);
```

![A search box on a map with multiple pointers](/images/geocoder-custom-images.png)

## Location-based search capabilities

Amplify Geo enables you to search for locations by text, addresses, or geo-coordinates.

### Search by text, address, business name, city, and more

The `Geo.searchByText()` API enables you to search for places or points of interest by free-form text, such as an address, name, city, or region.

```javascript

Geo.searchByText("Amazon Go Store")
```

Customize your search results further by providing:
- `countries` - to limit the search results to given countries (specified in [ISO Alpha-3 country codes](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3))
- `maxResults` - to limit the maximum result set
- `biasPosition` - to act as the search origination location
- `searchAreaConstraints` - to limit the area to search inside of
- `searchIndexName` - to use a different Location Service search index resource than the default

 **Note:** Providing both `biasPosition` and `searchAreaConstraints` parameters simultaneously returns an error.

```javascript
const searchOptionsWithBiasPosition = 

const searchOptionsWithSearchAreaConstraints = 

Geo.searchByText('Amazon Go Stores', searchOptionsWithBiasPosition)
```

This returns places and their coordinates that match the search constraints. A place can also have additional metadata as shown in the example below.

```javascript
// returns
[
  ,
    addressNumber: "2131" // optional string for the address number alone
    country: "USA" // optional Alpha-3 country code
    label: "Amazon Go, 2131 7th Ave, Seattle, WA, 98121, USA" // Optional string
    municipality: "Seattle" // Optional string
    neighborhood: undefined // Optional string
    postalCode: "98121" // Optional string
    region: "Washington" // Optional string
    street: "7th Ave" // Optional string
    subRegion: "King County" // Optional string
  }
]
```

### Search by coordinates

The `Geo.searchByCoordinates()` API is a reverse Geocoder that takes a coordinate point and returns information about what it finds at that point on the map. The returned object is the same shape as `searchByText()` API above.

```javascript

Geo.searchByCoordinates([longitudePoint, latitudePoint])
```

You can optionally limit your result set with the `maxResults` parameter or override the default search index with the `searchIndexName` parameter.

```javascript
const searchOptionsWithBiasPosition = 

Geo.searchByCoordinates([-122.3399573, 47.616179], searchOptionsWithBiasPosition)
```

### Search for suggestions

The `Geo.searchForSuggestions()` API enables you to search for suggestions by free-form text, such as a place, address, city, or region.

```javascript

Geo.searchForSuggestions("Amazon Go Store")
```

Similar to `Geo.searchByText()` API, customize your search results further by providing:
- `countries` - to limit the search results to given countries (specified in [ISO Alpha-3 country codes](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3))
- `maxResults` - to limit the maximum result set
- `biasPosition` - to act as the search origination location
- `searchAreaConstraints` - to limit the area to search inside of
- `searchIndexName` - to use a different Location Service search index resource than the default

 **Note:** Providing both `biasPosition` and `searchAreaConstraints` parameters simultaneously returns an error.

```javascript
const searchOptionsWithBiasPosition = 

const searchOptionsWithSearchAreaConstraints = 

Geo.searchForSuggestions('Amazon Go', searchOptionsWithBiasPosition)
```
This returns a list of suggestions (places and their respective `placeId` if available) that match the search constraints.

```javascript
// returns
[
  ,
  
]
```

In cases where `placeId` is not available on the list of suggestions as below, use ``searchByText`` to search for the selected place by text.

```javascript
Geo.searchForSuggestions("Amazon", )

// returns
[
  ,
  
]

Geo.searchByText('Amazon Go', )
```

This returns places and their coordinates that match the search text.

### Search by PlaceId

The `Geo.searchByPlaceId()` API enables you to search for a place by a `placeId`, which is a unique opaque token for a place returned by the provider.

```javascript

Geo.searchByPlaceId(placeId)
```
You can optionally override the default search index with the `searchIndexName` parameter.

```javascript
const searchByPlaceIdOptions = 

Geo.searchByPlaceId("8fd9d4c6-2527-4190-a7df-0dae352c9dc6", searchByPlaceIdOptions)
```

This returns a place with metadata as shown in the example below.

```javascript
// returns
,
  addressNumber: "2131" // optional string for the address number alone
  country: "USA" // optional Alpha-3 country code
  label: "Amazon Go, 2131 7th Ave, Seattle, WA, 98121, USA" // Optional string
  municipality: "Seattle" // Optional string
  neighborhood: undefined // Optional string
  postalCode: "98121" // Optional string
  region: "Washington" // Optional string
  street: "7th Ave" // Optional string
  subRegion: "King County" // Optional string
}
```
</InlineFilter>

## Add location search functionality on a map

First, make sure you've provisioned a search index resource and configured your app using the instructions in either [Configure Location Search](/[platform]/build-a-backend/add-aws-services/geo/configure-location-search/) or [Use existing Amazon Location Service resources](/[platform]/build-a-backend/add-aws-services/geo/existing-resources/) and you have already setup [displaying a map](/[platform]/build-a-backend/add-aws-services/geo/maps/) in your application.

`AmplifyMapView` provides built-in location search, search field, and place markers. Follow the [AmplifyMapView section](/[platform]/build-a-backend/add-aws-services/geo/maps/#amplifymapview) on the Maps page to setup the `AmplifyMapView`.
</InlineFilter>

To add a location search UI component to your `AMLMapView`, you will add an `AMLSearchBar` to your View in your desired layout. Upon searching, `Geo.Place`s are converted to `MGLPointFeature`s using `AmplifyMapLibre.createFeatures(places)`. Lastly assign those converted `MGLPointFeature`s to `mapState.features`. Alternatively, you can leverage the `AMLMapCompositeView` directly, which includes an `AMLSearchBar` among other pre-configured UI components.

```swift
import SwiftUI
import AmplifyMapLibreUI
import AmplifyMapLibreAdapter
import Amplify

struct MyMapView: View ,
                onCommit: search,
                onCancel: 
            )
            .padding()
        }
    }

    private func search() 
            } catch let error as Geo.Error  catch 
        }
    }
}
```

![map view of a area with search bar](/images/ios-geocoder-search-box-map.png)

### Customize Feature Icons

You can customize the feature images displayed on the `AMLMapView` or `AMLMapCompositeView`, you can leverage the `featureImage()` view modifier.

```swift
var body: some View 
        .edgesIgnoringSafeArea(.all)
}
```

![AMLMapView featureImage view modifier](/images/ios-geocoder-custom-images.png)
</InlineFilter>

## Location-based search capabilities

Amplify Geo enables you to search for locations by text, addresses, or geo-coordinates.

### Search by text

The `Amplify.Geo.searchByText()` API enables you to search for places or points of interest by free-form text, such as an address, name, city, or region.

```java
String searchQuery = "Amazon Go";
Amplify.Geo.searchByText(searchQuery,
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "Failed to search for " + searchQuery, error)
);
```

</Block>

```kotlin
val searchQuery = "Amazon Go"
Amplify.Geo.searchByText(searchQuery,
    
    },
    
)
```

</Block>

```kotlin
val searchQuery = "Amazon Go"
try 
} catch (error: GeoException) 
```

</Block>

```java
String searchQuery = "Amazon Go";
RxAmplify.Geo.searchByText(searchQuery).subscribe(
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "Failed to search for " + searchQuery, error)
);
```

</Block>
</BlockSwitcher>

Restrict your search results by specifying following parameters inside `GeoSearchByTextOptions`:
- `countries` - to limit the search results to given countries. Follows [ISO Alpha-3 country codes](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3). (defaults to "USA")
- `maxResults` - to limit the maximum result set (defaults to 50)
- `searchArea`
  - `near` - to act as the search origination location
  - `within` - to limit the area to search inside of

```java
Coordinates position = new Coordinates(47.6153, -122.3384);
GeoSearchByTextOptions options = GeoSearchByTextOptions.builder()
    .maxResults(10)
    .searchArea(SearchArea.near(position))
    .countries(Collections.singletonList(CountryCode.USA))
    .build();
```

</Block>

```kotlin
val position = Coordinates(47.6153, -122.3384)
val options = GeoSearchByTextOptions.builder()
    .maxResults(10)
    .searchArea(SearchArea.near(position))
    .countries(listOf(CountryCode.USA))
    .build()
```

</Block>

```kotlin
val position = Coordinates(47.6153, -122.3384)
val options = GeoSearchByTextOptions.builder()
    .maxResults(10)
    .searchArea(SearchArea.near(position))
    .countries(listOf(CountryCode.USA))
    .build()
```

</Block>

```java
Coordinates position = new Coordinates(47.6153, -122.3384);
GeoSearchByTextOptions options = GeoSearchByTextOptions.builder()
    .maxResults(10)
    .searchArea(SearchArea.near(position))
    .countries(Collections.singletonList(CountryCode.USA))
    .build();
```

</Block>
</BlockSwitcher>
</InlineFilter>

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

</InlineFilter>

### Search by coordinates

The `Amplify.Geo.searchByCoordinates()` API is a reverse Geocoder that takes a coordinate point and returns information about what it finds at that point on the map.
The returned object is the same shape as `Amplify.Geo.searchByText()` API.

```java
Coordinates position = new Coordinates(47.6153, -122.3384);
Amplify.Geo.searchByCoordinates(position,
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "Failed to reverse geocode " + position, error)
);
```

</Block>

```kotlin
val position = Coordinates(47.6153, -122.3384)
Amplify.Geo.searchByCoordinates(position,
    
    },
    
)
```

</Block>

```kotlin
val position = Coordinates(47.6153, -122.3384)
try 
} catch (error: GeoException) 
```

</Block>

```java
Coordinates position = new Coordinates(47.6153, -122.3384);
RxAmplify.Geo.searchByCoordinates(position).subscribe(
    result -> 
    },
    error -> Log.e("MyAmplifyApp", "Failed to reverse geocode " + position, error)
);
```

</Block>
</BlockSwitcher>

Restrict your search results by specifying following parameters inside `GeoSearchByCoordinatesOptions`:
- `maxResults` - to limit the maximum result set (defaults to 50)

```java
GeoSearchByCoordinatesOptions options = GeoSearchByCoordinatesOptions.builder()
    .maxResults(1)
    .build();
```

</Block>

```kotlin
val options = GeoSearchByCoordinatesOptions.builder()
    .maxResults(1)
    .build()
```

</Block>

```kotlin
val options = GeoSearchByCoordinatesOptions.builder()
    .maxResults(1)
    .build()
```

</Block>

```java
GeoSearchByCoordinatesOptions options = GeoSearchByCoordinatesOptions.builder()
    .maxResults(1)
    .build();
```

</Block>
</BlockSwitcher>
</InlineFilter>

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
</InlineFilter>
</InlineFilter>


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `pages/build-a-backend/add-aws-services/geo/location-search/index.mdx`