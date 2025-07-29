---
title: Display a map
source: fragments/lib-v1/geo/js/maps.mdx
---

# Display a map

> **Note**: 

**Note:** Please reach out to us for any feedback and/or issues [here](https://github.com/aws-amplify/amplify-js/issues)

## Display a map

First, ensure you've provisioned an Amazon Location Service Map resource and configured your app using the instructions in either [Configuring Maps](/gen1/[platform]/prev/build-a-backend/more-features/geo/configure-maps/) or [Use existing resources](/gen1/[platform]/prev/build-a-backend/more-features/geo/existing-resources) guide.

> **Note**: 

**Note:** For React, you can use the [Amplify React MapView component](https://ui.docs.amplify.aws/react/components/geo)

To render a map, the [MapLibre GL](https://github.com/maplibre/maplibre-gl-js) and the `maplibre-gl-js-amplify` libraries are required. MapLibre GL is an open source map rendering library and `maplibre-gl-js-amplify` library makes it easy to integrate MapLibre with Amplify Geo and handles Authentication.

Add the dependencies to your app:

```bash
npm install maplibre-gl maplibre-gl-js-amplify
```

> **Note**: 

Verify the following:

- `maplibre-gl-js-amplify` version `2.0.0` or above is installed
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
            import awsconfig from "./aws-exports.js";
            const  = aws_amplify_core;
            const  = AmplifyMapLibre;
            Amplify.configure(awsconfig);
            createMap();
        </script>
    </body>
</html>
```

## Map API's

If you want more information about the maps you currently have configured or want a way to switch between maps programmatically, the `@aws-amplify/geo` package provides API's that return more information about your currently provisioned maps.

First, you need to import Geo from either the `@aws-amplify/geo` or `aws-amplify` packages.

```javascript
// Or
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
