---
title: Prerequisites
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/sign-in-with-web-ui/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Prerequisites

## Prerequisites
* An app set up according to the [getting started walkthrough](/[platform]/build-a-backend/auth/set-up-auth/)

> **Note**: 
 When configuring social sign-in, it's important to exercise caution when designating attributes as "required." Different social identity providers have varied scopes in terms of the information they respond back to Cognito with.  User pool attributes that are initially set up as "required" cannot be changed later, and may require you to migrate the users or create a new user pool.  

## Configure Auth Category

> **Note**: 

This library's Cognito plugin currently supports the [Authorization Code Grant](https://docs.aws.amazon.com/cognito/latest/developerguide/authorization-endpoint.html) OAuth Flow.

In your `auth/resource.ts` file, update the 
```ts

## Update AndroidManifest.xml

Add the following activity and queries tag to your app's `AndroidManifest.xml` file, replacing `myapp` with
your redirect URI prefix if necessary:

```xml
<application ...>
  ...
  <activity
      android:name="com.amplifyframework.auth.cognito.activities.HostedUIRedirectActivity"
      android:exported="true">
      <intent-filter>
          <action android:name="android.intent.action.VIEW" />
          <category android:name="android.intent.category.DEFAULT" />
          <category android:name="android.intent.category.BROWSABLE" />
          <data android:scheme="myapp" />
      </intent-filter>
  </activity>
  ...
</application>
```

## Launch Web UI Sign In

Sweet! You're now ready to launch sign in with web UI. For now, just add this method to the `onCreate` method of MainActivity:

```java
Amplify.Auth.signInWithWebUI(
    this,
    result -> Log.i("AuthQuickStart", result.toString()),
    error -> Log.e("AuthQuickStart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.signInWithWebUI(
    this,
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.signInWithWebUI(this)
    .subscribe(
        result -> Log.i("AuthQuickStart", result.toString()),
        error -> Log.e("AuthQuickStart", error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

## Prerequisites

> **Note**: 

**Note:** Social sign-in (OAuth) functionality is only available in **iOS**, **macOS** and **visionOS**.

 When configuring social sign-in, it's important to exercise caution when designating attributes as "required." Different social identity providers have varied scopes in terms of the information they respond back to Cognito with.  User pool attributes that are initially set up as "required" cannot be changed later, and may require you to migrate the users or create a new user pool.  

For a full example, please follow the [project setup walkthrough](/[platform]/start/quickstart/).

> **Note**: 

To use Auth in a macOS project, you'll need to enable the Keychain Sharing capability. In Xcode, navigate to **your application target** > **Signing & Capabilities** > **+ Capability**, then select **Keychain Sharing.**

This capability is required because Auth uses the Data Protection Keychain on macOS as a platform best practice.
See [TN3137: macOS keychain APIs and implementations](https://developer.apple.com/documentation/technotes/tn3137-on-mac-keychains) for more information on how Keychain works on macOS and the Keychain Sharing entitlement.

For more information on adding capabilities to your application, see [Xcode Capabilities](https://developer.apple.com/documentation/xcode/capabilities).

## Configure Auth Category

> **Note**: 

This library's Cognito plugin currently supports the [Authorization Code Grant](https://docs.aws.amazon.com/cognito/latest/developerguide/authorization-endpoint.html) OAuth Flow.

Update the `auth/resource.ts` file like the following to enable the sign-in and sign-out capabilities with a web ui.

```ts

## Update Info.plist

Signin with web UI require the Amplify plugin to show up the signin UI inside a webview. After the signin process is complete it will redirect back to your app. 
You have to enable this in your app's `Info.plist`. Right click Info.plist and then choose Open As > Source Code. Add the following entry in the URL scheme:

```xml

 <plist version="1.0">

     <dict>
     <!-- YOUR OTHER PLIST ENTRIES HERE -->

     <!-- ADD AN ENTRY TO CFBundleURLTypes for Cognito Auth -->
     <!-- IF YOU DO NOT HAVE CFBundleURLTypes, YOU CAN COPY THE WHOLE BLOCK BELOW -->
     <key>CFBundleURLTypes</key>
     <array>
         <dict>
             <key>CFBundleURLSchemes</key>
             <array>
                 <string>myapp</string>
             </array>
         </dict>
     </array>

     <!-- ... -->
     </dict>
```

When creating a new SwiftUI app using Xcode 13 no longer require configuration files such as the Info.plist. If you are missing this file, click on the project target, under Info, Url Types, and click '+' to add a new URL Type. Add `myapp` to the URL Schemes. You should see the Info.plist file now with the entry for CFBundleURLSchemes.

## Launch Web UI Sign In

You're now ready to launch sign in with web UI. The `signInWithWebUI` api require a presentationAnchor and for an iOS app it will be the main UIWindow of the app. The example code below assume that you are in a UIViewController where you can fetch the UIWindow instance by `self.view.window`.

```swift
func signInWithWebUI() async 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func signInWithWebUI() -> AnyCancellable .sink 
        }
        receiveValue: 
        }
}
```

</Block>

</BlockSwitcher>

### Prefer private session during signIn

Starting Amplify 1.6.0, `Amplify.Auth.signInWithWebUI` automatically uses [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession) internally for iOS 13.0+. For older iOS versions, it will fall back to [SFAuthenticationSession](https://developer.apple.com/documentation/safariservices/sfauthenticationsession).
This release also introduces a new `preferPrivateSession` flag to `AWSAuthWebUISignInOptions` during the sign in flow. If `preferPrivateSession` is set to `true` during sign in, the user will not see a web view displayed when they sign out. `preferPrivateSession` will set [ASWebAuthenticationSession.prefersEphemeralWebBrowserSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/3237231-prefersephemeralwebbrowsersessio) internally and the authentication session will be private if the user's preferred browser supports it.

```swift
try await Amplify.Auth.signInWithWebUI(
    presentationAnchor: self.view.window!,
    options: .preferPrivateSession()
) 
```

</InlineFilter>

## Prerequisites

* An app set up according to the [getting started walkthrough](/[platform]/build-a-backend/auth/set-up-auth/)

> **Note**: 
 When configuring Social sign-in, it's important to exercise caution when designating attributes as "required." Different social identity providers have varied scopes in terms of the information they respond back to Cognito with.  User pool attributes that are initially set up as "required" cannot be changed later, and may require you to migrate the users or create a new user pool.  

## Configure Auth Category

> **Note**: 

This library's Cognito plugin currently supports the [Authorization Code Grant](https://docs.aws.amazon.com/cognito/latest/developerguide/authorization-endpoint.html) OAuth Flow.

Update the `auth/resource.ts` file like the following to enable the sign-in and sign-out capabilities with a web ui.

```ts

## How It Works

Sign-in with web UI will display the sign-in UI inside a webview. After the sign-in process is complete, the sign-in UI will redirect back to your app.

## Platform Setup

### Web

To use Hosted UI in your Flutter web application locally, you must run the app with the `--web-port=3000` argument (with the value being whichever port you assigned to localhost host when configuring your redirect URIs).

### Android

Add the following `queries` element to the `AndroidManifest.xml` file in your app's `android/app/src/main` directory, as well as the following `intent-filter` to the `MainActivity` in the same file.

Replace `myapp` with your redirect URI scheme as necessary:

```xml
<queries>
    <intent>
        <action android:name=
            "android.support.customtabs.action.CustomTabsService" />
    </intent>
</queries>
<application>
  ...
  <activity
        android:name=".MainActivity" android:exported="true">
        <intent-filter>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
            <data android:scheme="myapp" />
        </intent-filter>
  </activity>
  ...
</application>
```

### macOS

Open XCode and enable the App Sandbox capability and then select "Incoming Connections (Server)" under "Network".

![Incoming Connections setting selected in the App Sandbox section of the runner signing and capabilities tab.](/images/project-setup/flutter/mac/xcode-entitlements.png)

### iOS, Windows and Linux

No specific platform configuration is required.

## Launch Web UI Sign In

You're now ready to launch sign in with web UI.

```dart
Future<void> signInWithWebUI() async  on AuthException catch (e) ');
  }
}
```

You can also specify a provider with the `provider` attribute:

```dart
Future<void> signInWithWebUIProvider() async  on AuthException catch (e) ');
  }
}
```

Amplify Flutter currently supports the following social sign-in providers:
  * Google
  * Facebook
  * Login With Amazon
  * Apple

### Prefer private session during signIn on iOS.

Amplify.Auth.signInWithWebUI uses [ASWebAuthenticationSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession) internally for iOS. ASWebAuthenticationSession has a property, [prefersEphemeralWebBrowserSession](https://developer.apple.com/documentation/authenticationservices/aswebauthenticationsession/3237231-prefersephemeralwebbrowsersessio) which can be used to indicate whether the session should ask the browser for a private authentication session. To set this flag to true, set `preferPrivateSession` to true using `CognitoSignInWithWebUIPluginOptions`.

This will bypass the permissions dialog that is displayed to the end user during sign in and sign out. However, it will also prevent reuse of existing sessions from the user's browser. For example, if the user is logged into Google in their browser and try to sign in using Google in your app, they would now need to re-enter their credentials.

```dart
Future<void> signInWithWebUIAndPrivateSession() async 
```

</InlineFilter>


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/sign-in-with-web-ui/index.mdx`