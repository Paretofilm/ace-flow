---
title: Customize Feature Icons
topics: ['Maps & Location']
primary_topic: Maps & Location
source: fragments/lib-v1/geo/ios/search/30_location_search_map.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, maps-&-location]
---


## 🧭 Navigation
**Topics**: [[Maps & Location/]]
**Primary**: [[Maps & Location/]]

---


# Customize Feature Icons

To add a location search UI component to your `AMLMapView`, you will add an `AMLSearchBar` to your View in your desired layout. Upon searching, `Geo.Place`s are converted to `MGLPointFeature`s using `AmplifyMapLibre.createFeatures(places)`. Lastly assign those converted `MGLPointFeature`s to `mapState.features`. Alternatively, you can leverage the `AMLMapCompositeView` directly, which includes an `AMLSearchBar` among other pre-configured UI components.

```swift
import SwiftUI
import AmplifyMapLibreUI
import AmplifyMapLibreAdapter
import Amplify

struct MyMapView: View 
            )
            .padding()
        }
    }

    private func search() 
            case .failure(let geoError):
                print(geoError)
            }
        }
    }
}
```

![AMLMapView with AMLSearchBar](/images/ios-geocoder-search-box-map.png)

### Customize Feature Icons

You can customize the feature images displayed on the `AMLMapView` or `AMLMapCompositeView`, you can leverage the `featureImage()` view modifier.

```swift
    var body: some View 
            .edgesIgnoringSafeArea(.all)
    }
```

![AMLMapView featureImage view modifier](/images/ios-geocoder-custom-images.png)


---

## 📚 Related Topics
- [[Maps & Location/]]

## 📖 Source
Original: `fragments/lib-v1/geo/ios/search/30_location_search_map.mdx`