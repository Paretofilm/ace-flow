---
title: Configure your application
source: pages/build-a-backend/add-aws-services/geo/set-up-geo/index.mdx
---

# Configure your application

Amplify provides APIs and map UI components for maps and location search for your web apps.You can add maps and location search functionality to your app in just a few lines of code. The following is an example utilizing the [AWS Cloud Development Kit (AWS CDK)](https://docs.aws.amazon.com/cdk/latest/guide/home.html) to create a Geo resource powered by [Amazon Location Services](https://aws.amazon.com/location/). But do note there are no official hand-written (L2) constructs for this service yet.

```ts title="amplify/backend.ts"

const backend = defineBackend();

const geoStack = backend.createStack("geo-stack");

// create a location services map
const map = new CfnMap(geoStack, "Map", ,
  pricingPlan: "RequestBasedUsage",
  tags: [
    ,
  ],
});

// create an IAM policy to allow interacting with geo resource
const myGeoPolicy = new Policy(geoStack, "GeoPolicy", ),
  ],
});

// apply the policy to the authenticated and unauthenticated roles
backend.auth.resources.authenticatedUserIamRole.attachInlinePolicy(myGeoPolicy);
backend.auth.resources.unauthenticatedUserIamRole.attachInlinePolicy(myGeoPolicy);

// patch the map resource to the expected output configuration
backend.addOutput(,
      },
      default: map.mapName,
    },
  },
});
```

## Configure your application

To display a map in your application, you can use the [Amplify React MapView component](https://ui.docs.amplify.aws/react/components/geo) or the [MapLibre GL](https://github.com/maplibre/maplibre-gl-js) with `maplibre-gl-js-amplify` libraries are required.

Install the necessary dependencies by running the following command:

```bash title="Terminal" showLineNumbers=
npm add aws-amplify @aws-amplify/geo
```

> **Note:** Make sure that version `6.0.0` or above is installed.

Import and load the configuration file in your app. It's recommended you add the Amplify configuration step to your app's root entry point.

```javascript title="src/index.js"
Amplify.configure(outputs);
```
</InlineFilter>

```javascript title="pages/_app.js"
Amplify.configure(outputs);
```

</InlineFilter>

> **Note**: 

Make sure you call `Amplify.configure` as early as possible in your application’s life-cycle. A missing configuration or `NoCredentials` error is thrown if `Amplify.configure` has not been called before other Amplify JavaScript APIs.

</InlineFilter>

Amplify Geo provides APIs and map UI components for mobile app development such that you can add maps to your app in just a few lines of code. Amplify Geo APIs are powered by [Amazon Location Service](https://aws.amazon.com/location/) and the map UI components from [MapLibre](https://maplibre.org/) are already integrated with the Geo APIs.

## Prerequisites

* An Android application targeting at least Android SDK API level 24 with Amplify libraries integrated
    * For a full example of creating Android project, please follow the [project setup walkthrough](/[platform]/start/quickstart/)
</InlineFilter>

An application with Amplify libraries integrated and a minimum target of any of the following:
- **iOS 13.0**, using **Xcode 14.1** or later.
- **macOS 10.15**, using **Xcode 14.1** or later.
- **tvOS 13.0**, using **Xcode 14.3** or later.
- **watchOS 9.0**, using **Xcode 14.3** or later.
- **visionOS 1.0**, using **Xcode 15 beta 2** or later. (Preview support - see below for more details.)

For a full example, please follow the [project setup walkthrough](/[platform]/start/quickstart/).

> **Note**: 

visionOS support is currently in **preview** and can be used by using the latest [Amplify Release](https://github.com/aws-amplify/amplify-swift/releases). 
As new Xcode and visionOS versions are released, the support will be updated with any necessary fixes on a best effort basis.

</InlineFilter>

## Install Amplify Libraries

Add the following dependencies to your **build.gradle.kts (Module :app)** file and click "Sync Now" when prompted:

```kotlin title="app/build.gradle.kts"
android 
}

dependencies 
```

> **Note**: 

**Note:** The Geo plugin has a dependency on Cognito Auth.

</InlineFilter>

The Geo plugin is dependent on Cognito Auth.

1. To install the Amplify Libraries in your application, open your project in Xcode and select **File > Add Packages...**.

2. Enter the **Amplify Library for Swift** GitHub repo URL (`https://github.com/aws-amplify/amplify-swift`) into the search bar and click **Add Package**.

  > **Note**: 

  **Note:** **Up to Next Major Version** should be selected from the **Dependency Rule** dropdown.

3. Lastly, add **AWSLocationGeoPlugin**, **AWSCognitoAuthPlugin**, and **Amplify** to your target. Then click **Add Package**.

</InlineFilter>

## Initialize Amplify Geo

To initialize Amplify Geo, use the `Amplify.addPlugin()` method to add the AWS Location Geo plugin. Next, finish configuring Amplify by calling `Amplify.configure()`.

Add the following code to your `onCreate()` method in your application class:

> **Note**: 
Before calling the `Amplify.configure` function, make sure to either download the `amplify_outputs.json` file from the console, or generate it with the following command: 

```bash title="Terminal" showLineNumbers=
npx ampx generate outputs --app-id <app-id> --branch main --out-dir app/src/main/res/raw
```

Next, be sure the file you generated or downloaded is in the appropriate resource directory for your application (for example, `app/src/main/res/raw`) in your Android project. Otherwise, you will not be able to compile your application.

```java
Amplify.addPlugin(new AWSCognitoAuthPlugin());
Amplify.addPlugin(new AWSLocationGeoPlugin());
Amplify.configure(AmplifyOutputs.fromResource(R.raw.amplify_outputs), getApplicationContext());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>

```kotlin
Amplify.addPlugin(AWSCognitoAuthPlugin())
Amplify.addPlugin(AWSLocationGeoPlugin())
Amplify.configure(AmplifyOutputs.fromResource(R.raw.amplify_outputs), applicationContext)
```

Your class will look like this:

```kotlin
class MyAmplifyApp : Application()  catch (error: AmplifyException) 
    }
}
```

</Block>

```java
RxAmplify.addPlugin(new AWSCognitoAuthPlugin());
RxAmplify.addPlugin(new AWSLocationGeoPlugin());
RxAmplify.configure(AmplifyOutputs.fromResource(R.raw.amplify_outputs), getApplicationContext());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>
</BlockSwitcher>

Upon building and running this application you should see the following in your console window:

```console
Initialized Amplify
```
</InlineFilter>

> **Note**: 
Make sure to generate the `amplify_outputs.json` file by running the following command: 

```bash title="Terminal" showLineNumbers=
npx ampx sandbox
```

Next, move the file to your project. You can do this by dragging and dropping the file into your Xcode project.

To initialize Amplify Geo, use the `Amplify.add(plugin:)` method to add the AWS Location Geo plugin. Next, finish configuring Amplify by calling `Amplify.configure(with:)`.

Open the main file of the application - `AppDelegate.swift` or `App.swift` depending on the app's life cycle - and **add the following** import statements at the top of the file:

```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSLocationGeoPlugin
```

In the same file, **create a function** to configure Amplify:
```swift
func configureAmplify()  catch 
}
```

Now **call the `configureAmplify()` function** in the starting point of your application.

```swift
@main
struct App: App 
}
```

</Block>

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate 
    // ...
}
```

</Block>
</BlockSwitcher>

Upon building and running this application you should see the following in your console window:

```console
Initialized Amplify
```
</InlineFilter>

</InlineFilter>

**Notes:**
- If you want to use existing Amazon Location Service resources [follow this guide](/[platform]/build-a-backend/add-aws-services/geo/existing-resources/) instead.
- If you want to use Amazon Location Service APIs not directly supported by Geo, use the [escape hatch](/[platform]/build-a-backend/add-aws-services/geo/amazon-location-sdk/) to access the Amazon Location Service SDK.

### References

[Location Construct Library](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_location-readme.html)

## Map Pricing Plan
The pricing plan for the Map example is set to `RequestBasedUsage`.
We advice you to go through the [location service pricing](https://aws.amazon.com/location/pricing/) along with the [location service terms](https://aws.amazon.com/service-terms/) (_82.5 section_) to learn more about the pricing plan.
