---
title: Overview
source: pages/build-a-backend/add-aws-services/geo/amazon-location-sdk/index.mdx
---

# Overview

Amplify Geo provides solutions for common use cases with [Amazon Location Service](https://aws.amazon.com/location/) but for any functionality that is not currently supported by Amplify Geo you can access the [Amazon Location Service SDK](https://github.com/aws/aws-sdk-js-v3/tree/main/clients/client-location) directly.

Follow this guide to get started with the `aws-sdk` for Amazon Location Service using Amplify Auth credentials.

## Overview

In this tutorial, we’ll go over the following:

- Setting up the AWS SDK JavaScript v3 package for the Amazon Location Service SDK calls with Amplify auth.
- Code examples using the Amazon Location Service SDK.

## Installing SDK dependencies

The first step to using the SDKs in the client is to install the necessary dependencies with the following command:

```bash title="Terminal" showLineNumbers=
npm add @aws-sdk/client-location
```

## Connecting your app to Amazon Location Service

In the following procedure, you’ll connect your app to the Amazon Location Service APIs.

**To connect your app to the Amazon Location Service**

In your React App, open `src/App.js` file, and call the following function to initialize the Amazon Location Service client:

```javascript
import  from '@aws-sdk/client-location';
Amplify.configure(outputs);

const createClient = async () => );
  return client;
};
```

You’ve now successfully connected your app to the Amazon Location Service.

## Using the Amazon Location Service APIs

In order to access Amazon Location Service APIs, ensure you've provisioned resources and configured your app using the instructions in either [Amplify Geo Maps docs](/[platform]/build-a-backend/add-aws-services/geo/set-up-geo/) or the [Amazon Location Service console](https://console.aws.amazon.com/location/home#/create).

You can check out the [Amazon Location API Reference documentation](https://docs.aws.amazon.com/location/index.html) for a complete list of supported features.

### Example: Getting Device Position

This example requires you to have first provisioned a Tracker resource using the [Amazon Location Service console](https://console.aws.amazon.com/location/tracking/home#/create).

The following code details how to use the Amazon Location Service APIs to update a device position and get a device position using the tracker you just created:

```javascript
// UpdateDevicePosition API
const params = 
  ]
};
const command = new BatchUpdateDevicePositionCommand(params);
client.send(command, (err, data) => );

// GetDevicePosition API
const client = await createClient();
const params = ;
const command = new GetDevicePositionCommand(params);
client.send(command, (err, data) => );
```

</InlineFilter>

If you need functionality in the AWS services used by the Amplify Geo category that isn't available, we provide an escape hatch so you can get a reference to that service.

Note: If you provisioned your Geo resources via CDK, then the IAM policy will be specifically scoped to only allow actions required by the library.
Please [adjust your authorization permissions](/[platform]/build-a-backend/add-aws-services/geo/existing-resources/) accordingly for your escape hatch use-cases.

> **Note**: 

Learn more about consuming Kotlin clients from Java using either a blocking interface or an equivalent async interface based on futures [here](https://github.com/awslabs/smithy-kotlin/blob/main/docs/design/kotlin-smithy-sdk.md#java-interop).

```java
import android.util.Log;

import androidx.annotation.NonNull;

import com.amplifyframework.core.Amplify;
import com.amplifyframework.geo.location.AWSLocationGeoPlugin;

import aws.sdk.kotlin.services.location.LocationClient;
import aws.sdk.kotlin.services.location.model.ListMapsRequest;
import aws.sdk.kotlin.services.location.model.ListMapsResponse;
import kotlin.Unit;
import kotlin.coroutines.Continuation;
import kotlin.coroutines.CoroutineContext;
import kotlinx.coroutines.GlobalScope;
```

```java
// Obtain reference to the plugin
AWSLocationGeoPlugin geoPlugin = (AWSLocationGeoPlugin)
        Amplify.Geo.getPlugin("awsLocationGeoPlugin");
LocationClient locationClient = geoPlugin.getEscapeHatch();

// Send a new request to the Location Maps endpoint directly using the client
ListMapsRequest request = ListMapsRequest.Companion.invoke(requestBuilder -> Unit.INSTANCE);
locationClient.listMaps(request, new Continuation() 

    @Override
    public void resumeWith(@NonNull Object resultOrException) 
});
```

</Block>

```kotlin
import android.util.Log
import aws.sdk.kotlin.services.location.LocationClient
import aws.sdk.kotlin.services.location.model.ListMapsRequest
import com.amplifyframework.core.Amplify
```

```kotlin
// Obtain reference to the Amazon Location Service client
val geoPlugin = Amplify.Geo.getPlugin("awsLocationGeoPlugin")
val locationClient = geoPlugin.escapeHatch as LocationClient

// Send a new request to the Location Maps endpoint directly using the client
val request = ListMapsRequest 
val response = locationClient.listMaps(request)
Log.i("MyAmplifyApp", response.entries.toString())
```

</Block>
</BlockSwitcher>

## Documentation Resources

* [How to manage Amazon Location Service resources through console](https://docs.aws.amazon.com/location/latest/developerguide/welcome.html)

**Maps**
* [Using Amazon Location Maps in your application](https://docs.aws.amazon.com/location/latest/developerguide/using-maps.html)
* [Amazon Location Maps API Reference](https://docs.aws.amazon.com/location-maps/latest/APIReference/API_Operations.html)

**Places**
* [Searching place and geolocation data using Amazon Location](https://docs.aws.amazon.com/location/latest/developerguide/searching-for-places.html)
* [Amazon Location Places API Reference](https://docs.aws.amazon.com/location-places/latest/APIReference/API_Operations.html)

**Device Tracking**
* [Managing your tracker resources](https://docs.aws.amazon.com/location/latest/developerguide/managing-trackers.html)
* [Amazon Location Trackers API Reference](https://docs.aws.amazon.com/location-trackers/latest/APIReference/API_Operations.html)

</InlineFilter>

If you need functionality in the AWSLocation framework used by the Amplify Geo category that isn't available, we provide an escape hatch so you can reference it directly.

Note: If you provisioned your Geo resources, then the IAM policy will be specifically scoped to only allow actions required by the library. Please [adjust your authorization permissions](/[platform]/build-a-backend/add-aws-services/geo/existing-resources/) accordingly for your escape hatch use-cases.

```swift
import AWSLocation
```

Then retrieve the escape hatch and call methods on `AWSLocation` directly:

```swift
do 

    // Retrieve reference to AWSLocation
    let awsLocation = locationPlugin.getEscapeHatch()

    // Make Request
    var request = ListMapsInput()
    request.maxResults = 5
    let response = try await awsLocation.listMaps(input: request)
    // handle response ...
} catch 
```

## Documentation Resources

- [How to manage Amazon Location Service resources through console](https://docs.aws.amazon.com/location/latest/developerguide/welcome.html)

**Maps**

- [Using Amazon Location Maps in your application](https://docs.aws.amazon.com/location/latest/developerguide/using-maps.html)
- [Amazon Location Maps API Reference](https://docs.aws.amazon.com/location-maps/latest/APIReference/API_Operations.html)

**Places**

- [Searching place and geolocation data using Amazon Location](https://docs.aws.amazon.com/location/latest/developerguide/searching-for-places.html)
- [Amazon Location Places API Reference](https://docs.aws.amazon.com/location-places/latest/APIReference/API_Operations.html)

**Device Tracking**

- [Managing your tracker resources](https://docs.aws.amazon.com/location/latest/developerguide/managing-trackers.html)
- [Amazon Location Trackers API Reference](https://docs.aws.amazon.com/location-trackers/latest/APIReference/API_Operations.html)

</InlineFilter>
