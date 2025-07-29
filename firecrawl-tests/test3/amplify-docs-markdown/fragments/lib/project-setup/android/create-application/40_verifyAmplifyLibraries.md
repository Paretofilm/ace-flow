---
title: Documentation
source: fragments/lib/project-setup/android/create-application/40_verifyAmplifyLibraries.mdx
---

# Documentation

Create a class by extending `Application` and override its `onCreate()` to initialize Amplify in your application.

Right-click on your namespace (e.g. `com.example.MyAmplifyApp`), click **New**, and click **Java Class** or **Kotlin File/Class** depending on which language you choose.

Configure the new class in **New Java Class**:

- Enter *MyAmplifyApp* in the **Name** field
- Press enter
- Extend *MyAmplifyApp* from *android.app.Application* by adding `extends Application` to your class

Initialize Amplify by adding an `onCreate` method with the following code:

```java
  public void onCreate()  catch (AmplifyException error) 
  }
```

</Block>

Configure the new class in **New Kotlin File/Class**:

- Enter *MyAmplifyApp* in the **Name** field
- Press enter
- Extend *MyAmplifyApp* from *android.app.Application* by adding `: Application()` to your class

Initialize Amplify by adding an `onCreate` method with the following code:

```kotlin
override fun onCreate()  catch (error: AmplifyException) 
}
```

</Block>
</BlockSwitcher>

This overrides the `onCreate()` to initialize Amplify when your application is launched.

Next, configure your application to use your new custom `Application` class. Open **manifests** > **AndroidManifest.xml**, and add a `android:name` attribute with the value of your new class name:

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.MyAmplifyApp">

    <!-- Add the android:name attribute to the application node -->
    <application
        android:name=".MyAmplifyApp"
        ...
    </application>
</manifest>
```

Next, build and run the application. In logcat, you'll see a log line indicating success:

```console
com.example.MyAmplifyApp I/MyAmplifyApp: Initialized Amplify
```
