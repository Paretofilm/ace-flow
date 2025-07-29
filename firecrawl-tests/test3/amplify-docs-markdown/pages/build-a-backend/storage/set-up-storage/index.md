---
title: Building your storage backend
source: pages/build-a-backend/storage/set-up-storage/index.mdx
---

# Building your storage backend

In this guide, you will learn how to set up storage in your Amplify app. You will set up your backend resources, and enable listing, uploading, and downloading files.

If you have not yet created an Amplify app, visit the [quickstart guide](/[platform]/start/quickstart/).

Amplify Storage seamlessly integrates file storage and management capabilities into frontend web and mobile apps, built on top of Amazon Simple Storage Service (Amazon S3). It provides intuitive APIs and UI components for core file operations, enabling developers to build scalable and secure file storage solutions without dealing with cloud service complexities.

## Building your storage backend

First, create a file `amplify/storage/resource.ts`. This file will be the location where you configure your storage backend. Instantiate storage using the `defineStorage` function and providing a `name` for your storage bucket. This `name` is a friendly name to identify your bucket in your backend configuration. Amplify will generate a unique identifier for your app using a UUID, the name attribute is just for use in your app.

```ts title="amplify/storage/resource.ts"

Import your storage definition in your `amplify/backend.ts` file that contains your backend definition. Add storage to `defineBackend`.

```ts title="amplify/backend.ts"
// highlight-next-line

defineBackend();
```

Now when you run `npx ampx sandbox` or deploy your app on Amplify, it will configure an Amazon S3 bucket where your files will be stored. Before files can be accessed in your application, you must configure storage access rules.

To deploy these changes, commit them to git and push the changes upstream. Amplify's CI/CD system will automatically pick up the changes and build and deploy the updates.

```bash title="Terminal" showLineNumbers=
git commit -am "add storage backend"
git push
```

### Define File Path Access

By default, no users or other project resources have access to any files in the storage bucket. Access must be explicitly granted within `defineStorage` using the `access` callback.

The access callback returns an object where each key in the object is a file path and each value in the object is an array of access rules that apply to that path.

The following example shows you how you can set up your file storage structure for a generic photo sharing app. Here,

1. Guests have access to see all profile pictures and only the users that uploaded the profile picture can replace or delete them. Users are identified by their Identity Pool ID in this case i.e. identityID.
2. There's also a general pool where all users can submit pictures.

[Learn more about customizing access to file path](/[platform]/build-a-backend/storage/authorization/).

```ts title="amplify/storage/resource.ts"

### Configure additional storage buckets

Amplify Storage gives you the flexibility to configure your backend to automatically provision and manage multiple storage resources. 

You can define additional storage buckets by using the same `defineStorage` function and providing a unique, descriptive `name` to identify the storage bucket. You can pass this `name` to the storage APIs to specify the bucket you want to perform the action to. Ensure that this `name` attribute is unique across the defined storage buckets in order to reliably identify the correct bucket and prevent conflicts.

It's important to note that if additional storage buckets are defined one of them must be marked as default with the `isDefault` flag.

```ts title="amplify/storage/resource.ts"

Add additional storage resources to the backend definition.

```ts title="amplify/backend.ts"

defineBackend();
```

### Storage bucket client usage

Additional storage buckets can be referenced from application code by passing the `bucket` option to Amplify Storage APIs. You can provide a target bucket's name assigned in Amplify Backend.

```ts

try 
  }).result;
} catch (error) `)
}
```
Alternatively, you can also pass in an object by specifying the bucket name and region from the console. See each Amplify Storage API page for additional usage examples.

```ts

try 
      // highlight-end
    }
  }).result;
} catch (error) `);
}

```
</InlineFilter>

### Storage bucket client usage

Additional storage buckets can be referenced from application code by passing the `bucket` option to Amplify Storage APIs. You can provide a target bucket's name assigned in Amplify Backend.

```java
StorageBucket secondBucket = StorageBucket.fromOutputs("secondBucket");
StorageDownloadFileOptions options = StorageDownloadFileOptions.builder().bucket(secondBucket).build();
Amplify.Storage.downloadFile(
        StoragePath.fromString("public/example"),
        new File(getApplicationContext().getFilesDir() + "/download.txt"),
        options,
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
);
```

</Block>

```kotlin
val secondBucket = StorageBucket.fromOutputs("secondBucket")
val options = StorageDownloadFileOptions.builder().bucket(secondBucket).build()
val file = File("$/download.txt")
Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file, option,
    ") },
    
)
```

</Block>

```kotlin
val secondBucket = StorageBucket.fromOutputs("secondBucket")
val options = StorageDownloadFileOptions.builder().bucket(secondBucket).build()
val file = File("$/download.txt")
val download = Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file, options)
try  catch (error: StorageException) 
```

</Block>

```java      
StorageBucket secondBucket = StorageBucket.fromOutputs("secondBucket");
StorageDownloadFileOptions options = StorageDownloadFileOptions.builder().bucket(secondBucket).build();
RxProgressAwareSingleOperation download =
        RxAmplify.Storage.downloadFile(
            StoragePath.fromString("public/example"),
            new File(getApplicationContext().getFilesDir() + "/download.txt"),
            options
        );

download
    .observeResult()
    .subscribe(
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
    );
```

</Block>
</BlockSwitcher>

Alternatively, you can also pass in an object by specifying the bucket name and region from the console. See each Amplify Storage API page for additional usage examples.

```java
BucketInfo bucketInfo = new BucketInfo("second-bucket-name-from-console", "us-east-2");
StorageBucket secondBucket = StorageBucket.fromBucketInfo(bucketInfo);
StorageDownloadFileOptions options = StorageDownloadFileOptions.builder().bucket(secondBucket).build();
Amplify.Storage.downloadFile(
        StoragePath.fromString("public/example"),
        new File(getApplicationContext().getFilesDir() + "/download.txt"),
        options,
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
);
```

</Block>

```kotlin
val bucketInfo = BucketInfo("second-bucket-name-from-console", "us-east-2")
val secondBucket = StorageBucket.fromBucketInfo(bucketInfo)
val options = StorageDownloadFileOptions.builder().bucket(secondBucket).build()
val file = File("$/download.txt")
Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file, options,
    ") },
    
)
```

</Block>

```kotlin
val bucketInfo = BucketInfo("second-bucket-name-from-console", "us-east-2")
val secondBucket = StorageBucket.fromBucketInfo(bucketInfo)
val options = StorageDownloadFileOptions.builder().bucket(secondBucket).build()
val file = File("$/download.txt")
val download = Amplify.Storage.downloadFile(StoragePath.fromString("public/example"), file, options)
try  catch (error: StorageException) 
```

</Block>

```java
BucketInfo bucketInfo = new BucketInfo("second-bucket-name-from-console", "us-east-2");
StorageBucket secondBucket = StorageBucket.fromBucketInfo(bucketInfo);
StorageDownloadFileOptions options = StorageDownloadFileOptions.builder().bucket(secondBucket).build();
RxProgressAwareSingleOperation download =
        RxAmplify.Storage.downloadFile(
            StoragePath.fromString("public/example"),
            new File(getApplicationContext().getFilesDir() + "/download.txt"),
            options,
        );

download
    .observeResult()
    .subscribe(
        result -> Log.i("MyAmplifyApp", "Successfully downloaded: " + result.getFile().getName()),
        error -> Log.e("MyAmplifyApp",  "Download Failure", error)
    );
```

</Block>
</BlockSwitcher>
</InlineFilter>

### Storage bucket client usage

Additional storage buckets can be referenced from application code by passing the `bucket` option to Amplify Storage APIs. You can provide a target bucket's name assigned in Amplify Backend.

```swift
let downloadTask = Amplify.Storage.downloadData(
    path: .fromString("public/example/path"),
    options: .init(
        bucket: .fromOutputs(name: "secondBucket")
    )
)
```

Alternatively, you can also directly specify the bucket name and region from the console. See each Amplify Storage API page for additional usage examples.

```swift
let downloadTask = Amplify.Storage.downloadData(
    path: .fromString("public/example/path"),
    options: .init(
        bucket: .fromBucketInfo(.init(
            bucketName: "another-bucket-name",
            region: "another-bucket-region")
        )    
    )
)
```
</InlineFilter>

### Storage bucket client usage

Additional storage buckets can be referenced from application code by passing the `bucket` option to Amplify Storage APIs. You can provide a target bucket's name assigned in Amplify Backend.

```dart
import 'package:amplify_flutter/amplify_flutter.dart';

try  on Exception catch (e) 
```
Alternatively, you can also pass in an object by specifying the bucket name and region from the console. See each Amplify Storage API page for additional usage examples.

```dart
import 'package:amplify_flutter/amplify_flutter.dart';

try  on Exception catch (e) 
```
</InlineFilter>

## Connect your app code to the storage backend

The Amplify Storage library provides client APIs that connect to the backend resources you defined.

### Configure Amplify in project

Import and load the configuration file in your app. It's recommended you add the Amplify configuration step to your app's root entry point. For example `index.js` in React or `main.ts` in Angular.

```javascript

Amplify.configure(outputs);
```
> **Note**: 

Make sure you call `Amplify.configure` as early as possible in your application’s life-cycle. A missing configuration or `NoCredentials` error is thrown if `Amplify.configure` has not been called before other Amplify JavaScript APIs.

</InlineFilter>

### Prerequisites

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

### Install Amplify library via Swift Package Manager

1. To install Amplify Libraries in your application, open your project in Xcode and select **File > Add Packages...**.

2. Enter the **Amplify Library for Swift** GitHub repo URL (`https://github.com/aws-amplify/amplify-swift`) into the search bar and click **Add Package**.

  > **Note**: 

  **Note:** **Up to Next Major Version** should be selected from the **Dependency Rule** dropdown.

3. Lastly, choose **AWSS3StoragePlugin**, **AWSCognitoAuthPlugin**, and **Amplify**. Then click **Add Package**.

### Configure Amplify in project

Initialize the Amplify Storage category by calling `Amplify.add(plugin:)`. To complete initialization call `Amplify.configure()`.

Add the following imports to the top of your `App` scene and configure Amplify in the `init`:
```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin

@main
struct MyAmplifyApp: App 
    }

    init()  catch 
    }
}
```

</Block>

Add the following imports to the top of your `AppDelegate.swift` file:

```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSS3StoragePlugin
```

Add the following code to the `application:didFinishLaunchingWithOptions` method:

```swift
func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool  catch 

    return true
}
```

</Block>

</BlockSwitcher>

Upon building and running this application you should see the following in your console window:

```console
Amplify configured with Auth and Storage plugins
```

</InlineFilter>

### Prerequisites

* An Android application targeting Android API level 24 (Android 7.0) or above
    * For a full example of creating Android project, please follow the [quickstart guide](/[platform]/start/quickstart/)

### Install the Amplify library

Expand **Gradle Scripts**, open **build.gradle (Module: app)**. You will already have configured Amplify by following the steps in the [quickstart guide](/[platform]/start/quickstart/).

Add these libraries into the `dependencies` block:
```kotlin title="app/build.gradle.kts"
android 
}

dependencies 
```

`aws-auth-cognito` is used to provide authentication for Amazon S3.

Click **Sync Now**.

### Configure Amplify in your project

Initialize Amplify Storage by calling `Amplify.addPlugin()`. To complete initialization, call `Amplify.configure()`.

Add the following code to your `onCreate()` method in your application class:

> **Note**: 
Before calling the `Amplify.configure` function, make sure to either download the `amplify_outputs.json` file from the console, or generate it with the following command: 

```bash title="Terminal" showLineNumbers=
npx ampx generate outputs --app-id <app-id> --branch main --out-dir app/src/main/res/raw
```

Next, be sure the file you generated or downloaded is in the appropriate resource directory for your application (for example, `app/src/main/res/raw`) in your Android project. Otherwise, you will not be able to compile your application.

```java
import android.util.Log;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.Amplify;
import com.amplifyframework.core.configuration.AmplifyOutputs;
import com.amplifyframework.storage.s3.AWSS3StoragePlugin;
```

```java
Amplify.addPlugin(new AWSCognitoAuthPlugin());
Amplify.addPlugin(new AWSS3StoragePlugin());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>

```kotlin
import android.util.Log
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.core.Amplify
import com.amplifyframework.core.configuration.AmplifyOutputs
import com.amplifyframework.storage.s3.AWSS3StoragePlugin
```

```kotlin
Amplify.addPlugin(AWSCognitoAuthPlugin())
Amplify.addPlugin(AWSS3StoragePlugin())
```

Your class will look like this:

```kotlin
class MyAmplifyApp : Application()  catch (error: AmplifyException) 
    }
}
```

</Block>

```java
import android.util.Log;
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin;
import com.amplifyframework.core.configuration.AmplifyOutputs;
import com.amplifyframework.rx.RxAmplify;
import com.amplifyframework.storage.s3.AWSS3StoragePlugin;
```

```java
RxAmplify.addPlugin(new AWSCognitoAuthPlugin());
RxAmplify.addPlugin(new AWSS3StoragePlugin());
```

Your class will look like this:

```java
public class MyAmplifyApp extends Application  catch (AmplifyException error) 
    }
}
```

</Block>
</BlockSwitcher>

Note that because the storage category requires auth, you will need to either configure [guest access](/[platform]/build-a-backend/auth/concepts/guest-access/) or [sign in a user](/[platform]/build-a-backend/auth/connect-your-frontend/sign-in) before using features in the storage category.

</InlineFilter>

### Prerequisites

Amplify Flutter requires a minimum target platform for iOS (13.0), Android (API level 24), and macOS (10.15). Refer to [Flutter's supported deployment platforms](https://docs.flutter.dev/reference/supported-platforms) when targeting Web, Windows, or Linux.

### Install Amplify library

Add the following dependency to your **app**'s `pubspec.yaml` along with others you added above in **Prerequisites**:

```yaml
dependencies:
  flutter:
    sdk: flutter

  amplify_auth_cognito: ^2.0.0
  amplify_flutter: ^2.0.0
  amplify_storage_s3: ^2.0.0
```

### Configure Amplify in project

To initialize the Amplify Auth and Storage categories, call `Amplify.addPlugin()` for each plugin or pass all the plugins in `Amplify.addPlugins()`. To complete initialization, call `Amplify.configure()`.

Your code should look like this:

```dart
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';

import 'amplify_outputs.dart';

Future<void> _configureAmplify() async  on Exception catch (e) 
}

Future<void> main() async 

class MyApp extends StatefulWidget ) : super(key: key);

  // ...
}
```

</InlineFilter>

### Upload your first file

Next, let's a photo to the `picture-submissions/` path.

```jsx

function App() ;

  const handleClick = () => 
    uploadData(`,
      data: file,
    });
  };

  return (
    <div>
      <input type="file" onChange= />
      <button onClick=>Upload</button>
    </div>
  );
}
```
</InlineFilter>

```javascript

const file = document.getElementById("file");
const upload = document.getElementById("upload");

upload.addEventListener("click", () => `
      });
    } catch (e) 
  };
});
```
</InlineFilter>

```swift
import Amplify
import SwiftUI
import PhotosUI

struct ContentView: View 
            .padding()
            PhotosPicker(
                selection: $selectedPhoto
            ) 
            .task(id: selectedPhoto) 
                    let uploadTask = Amplify.Storage.uploadData(
                        path: .fromString("picture-submissions/myPhoto.png"),
                        data: imageData
                    )
                }
            }
        }
    }
}
```

</InlineFilter>

```java
private void uploadFile()  catch (Exception exception) 

    Amplify.Storage.uploadFile(
            StoragePath.fromString("picture-submissions/myPhoto.png"),
            exampleFile,
            result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
            storageFailure -> Log.e("MyAmplifyApp", "Upload failed", storageFailure)
    );
}
```

</Block>

```kotlin
private fun uploadFile() ") },
        
    )
}
```

</Block>

```kotlin
private suspend fun uploadFile() ")
    } catch (error: StorageException) 
}
```

</Block>

```java
private void uploadFile()  catch (Exception exception) 

    RxProgressAwareSingleOperation rxUploadOperation =
            RxAmplify.Storage.uploadFile(StoragePath.fromString("picture-submissions/myPhoto.png"), exampleFile);

    rxUploadOperation
            .observeResult()
            .subscribe(
                result -> Log.i("MyAmplifyApp", "Successfully uploaded: " + result.getPath()),
                error -> Log.e("MyAmplifyApp", "Upload failed", error)
            );
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

> **Note**: 

**Note**: To use `AWSFilePlatform`, add [aws_common](https://pub.dev/packages/aws_common) package to your Flutter project
by running: `flutter pub add aws_common`

```dart
import 'package:amplify_flutter/amplify_flutter.dart';

Future<void> uploadFile() async ');
  } on StorageException catch (e) 
}
```

</Block>

```dart
import 'dart:io' show File;

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_common/vm.dart';

Future<void> uploadFile(File file) async ');
  } on StorageException catch (e) 
}
```

</Block>

```dart
import 'dart:html' show File;

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_common/web.dart';

Future<void> uploadFile(File file) async ');
  } on StorageException catch (e) 
}
```

</Block>

</BlockSwitcher>

</InlineFilter>

## Manage files in Amplify console

After successfully publishing your storage backend and connecting your project with client APIs, you can manage files and folders in [the Amplify console](https://console.aws.amazon.com/amplify). You can perform on-demand actions like upload, download, copy, and more under the Storage tab in the console. Refer to [Manage files in Amplify Console](/[platform]/build-a-backend/storage/manage-with-amplify-console/) guide for additional information.

## Conclusion

Congratulations! You finished the Set up Amplify Storage guide. In this guide, you set up and connected to backend resources, customized your file paths and access definitions, and connected your application to the backend to implement features like file uploads and downloads.

### Next steps

Now that you have completed setting up storage in your Amplify app, you can proceed to add file management features to your app. You can use the following guides to implement upload and download functionality, or you can access more capabilities from the side navigation.

- [Upload Files](/[platform]/build-a-backend/storage/upload-files/)
- [Download Files](/[platform]/build-a-backend/storage/download-files/)
