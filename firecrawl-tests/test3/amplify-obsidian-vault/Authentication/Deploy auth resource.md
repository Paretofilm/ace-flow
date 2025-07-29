---
title: Deploy auth resource
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/set-up-auth/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Deploy auth resource

Amplify Auth is powered by [Amazon Cognito](https://aws.amazon.com/cognito/). Cognito is a robust user directory service that handles user registration, authentication, account recovery, and other operations. [Review the concepts to learn more](/[platform]/build-a-backend/auth/concepts/).

To get started with defining your authentication resource, open or create the auth resource file:

```ts title="amplify/auth/resource.ts"

/**
 * Define and configure your auth resource
 * @see https://docs.amplify.aws/gen2/build-a-backend/auth
 */

By default, your auth resource is scaffolded using `email` as the default login mechanism. You can also configure your auth resource to allow signing in with phone numbers or an external provider such as Google, Facebook, Amazon, or Sign in with Apple.

> **Note**: 

**Note:** At a minimum you will need to pass a `loginWith` value to set up how your users sign in to your app. Signing in with email and password is configured by default if you do not provide any value.

## Deploy auth resource

After you have chosen and defined your authentication resource, run the following command to create your resource in your personal cloud sandbox.

```bash title="Terminal" showLineNumbers=
npx ampx sandbox
```

</InlineFilter>

```bash title="Terminal" showLineNumbers=
npx ampx sandbox --outputs-format dart --outputs-out-dir lib
```

</InlineFilter>

> **Note**: 
Be sure to add a "raw" folder under `app/src/main/res` directory if it does not exist.

```bash title="Terminal" showLineNumbers=
npx ampx sandbox --outputs-out-dir <path_to_app/src/main/res/raw>
```

</InlineFilter>

```bash title="Terminal" showLineNumbers=
npx ampx sandbox
```

</InlineFilter>

After a successful deployment, this command also generates an outputs file (`amplify_outputs.json`) to enable your frontend app to connect to your backend resources. The values you configure in your backend authentication resource are set in the generated outputs file to automatically configure the frontend [`Authenticator connected component`](https://ui.docs.amplify.aws/react/connected-components/authenticator).

## Connect your application code to your auth resource

Creating and correctly implementing the sign-in flow can be challenging and time-consuming. Amplify's Authenticator UI component streamlines this by enabling you to rapidly build the entire authentication flow for your app. The component works seamlessly with configuration in `amplify/auth/resource.ts` to automatically connect with your backend resources.

Amplify has pre-built UI components for React, Vue, Angular, React Native, Swift, Android, and Flutter. In this guide, we are focusing on those for web applications.

First, install the `@aws-amplify/ui-react` library:

```bash title="Terminal" showLineNumbers=
npm add @aws-amplify/ui-react
```

Next, open **pages/\_app.tsx** and add the `Authenticator` component.

```ts title="pages/_app.tsx"
import '@aws-amplify/ui-react/styles.css';

Amplify.configure(outputs);

</InlineFilter>

First, install the `@aws-amplify/ui-vue` library:

```bash title="Terminal" showLineNumbers=
npm add @aws-amplify/ui-vue
```

Next, open **src/App.vue** and add the `Authenticator` component.

**Authenticator**

The `Authenticator` component offers a simple way to add authentication flows into your app. This component encapsulates an authentication workflow in the framework of your choice and is backed by your backend Auth resources. `Authenticator` passes the `user` info and `signOut` function to the inner template.

```html
<script setup>
  import  from "@aws-amplify/ui-vue";
  import "@aws-amplify/ui-vue/styles.css";

  import  from 'aws-amplify';
  import outputs from '../amplify_outputs.json';

  Amplify.configure(outputs);
</script>

<template>
  <authenticator>
    <template v-slot="">
      <h1>Hello }!</h1>
      <button @click="signOut">Sign Out</button>
    </template>
  </authenticator>
</template>
```

</Block>

First, install the `@aws-amplify/ui-components` library:

```bash title="Terminal" showLineNumbers=
npm add @aws-amplify/ui-components
```

Now open **src/main.ts** and add the following below your last import:

```js title="src/main.ts"
import '@aws-amplify/ui-components';
import  from '@aws-amplify/ui-components/loader';

Vue.config.ignoredElements = [/amplify-\w*/];

applyPolyfills().then(() => );
```

Next, open **src/App.ts** and add the `amplify-authenticator` component.

**amplify-authenticator**

The `amplify-authenticator` component offers a simple way to add authentication flows into your app. This component encapsulates an authentication workflow in the framework of your choice and is backed by your backend Auth resources. The optional `amplify-sign-out` component is available if you would like to render a sign-out button.

```html title="src/App.ts"
<template>
  <amplify-authenticator>
    <div>
      My App
      <amplify-sign-out></amplify-sign-out>
    </div>
  </amplify-authenticator>
</template>
```

</Block>
</BlockSwitcher>

</InlineFilter>

First, install the `@aws-amplify/ui-angular` library:

```bash title="Terminal" showLineNumbers=
npm add @aws-amplify/ui-angular
```

Now open **app.module.ts** and add the Amplify imports and configuration:

```js title="app.module.ts"

Amplify.configure(outputs);

@NgModule()

Next, import the default theme inside **styles.css**:

```css title="styles.css"
@import '~@aws-amplify/ui-angular/theme.css';
```

Next, open **app.component.html** and add the `amplify-authenticator` component.

**amplify-authenticator**

The `Authenticator` component offers a simple way to add authentication flows into your app. This component encapsulates an authentication workflow in the framework of your choice and is backed by your backend Auth resources. `Authenticator` passes the `user` info and `signOut` function to the inner template.

The `amplify-authenticator` component offers a simple way to add authentication flows into your app. This component encapsulates an authentication workflow in the framework of your choice and is backed by your backend Auth resources. `amplify-authenticator` passes the `user` info and `signOut` function to the inner template.

```html title="app.component.html"
<amplify-authenticator>
  <ng-template
    amplifySlot="authenticated"
    let-user="user"
    let-signOut="signOut"
  >
    <h1>Welcome }!</h1>
    <button (click)="signOut()">Sign Out</button>
  </ng-template>
</amplify-authenticator>
```

</InlineFilter>

First, install the `@aws-amplify/ui-react-native` library:

```bash title="Terminal" showLineNumbers=
npm add \
  @aws-amplify/react-native \
  @aws-amplify/ui-react-native \
  aws-amplify \
  @react-native-community/netinfo \
  @react-native-async-storage/async-storage \
  react-native-safe-area-context@^4.2.5 \
  react-native-get-random-values
```

> **Note**: 
If your project will support Federated Sign In using the `React Native Authenticator` the `@aws-amplify/rtn-web-browser` package is also required:

```bash title="Terminal" showLineNumbers=
npm add @aws-amplify/rtn-web-browser
```

Then install the iOS cocoapods by running:

```bash title="Terminal" showLineNumbers=
npx pod-install
```

> **Note**: 
For calling native libraries and platform dependencies from Expo, you need to run the prebuild command for generating the folders for related platforms.

```bash title="Terminal" showLineNumbers=
npx expo prebuild
```

Next, update the `App.tsx` file with the following to set up the authentication flow:

```typescript

Amplify.configure(outputs);

const SignOutButton = () =>  = useAuthenticator();

  return (

    </View>
  );
};

const App = () => ;

const styles = StyleSheet.create(,
});

</InlineFilter>

First, install the `amplify_authenticator` library:

```bash title="Terminal" showLineNumbers=
flutter pub add amplify_flutter
flutter pub add amplify_auth_cognito
flutter pub add amplify_authenticator
```

or you can update your `pubspec.yaml` file with the following

```yaml
dependencies:
  amplify_flutter: ^2.0.0
  amplify_auth_cognito: ^2.0.0
  amplify_authenticator: ^2.0.0
```

and run the following command to download the libraries.

```bash title="Terminal" showLineNumbers=
flutter pub get
```

Next, update your `main.dart` file with the following:

```dart
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'amplify_outputs.dart';

Future<void> main() async  on AmplifyException catch (e) "));
  }
}

// highlight-start
Future<void> _configureAmplify() async  on Exception catch (e) 
}
// highlight-end

class MyApp extends StatelessWidget );
  @override
  Widget build(BuildContext context) 
}
```

</InlineFilter>

> **Note**: 

Be sure to have compileSdk version as 34 or higher.

The Authenticator component is built using [Jetpack Compose](https://developer.android.com/jetpack/compose). Enable Jetpack Compose by adding the following to the android section of your app's `build.gradle` file:

```kotlin title="app/build.gradle.kts" showLineNumbers=
compileOptions 
buildFeatures 
composeOptions 
dependencies 
```

Add the following dependencies to your *app*'s `build.gradle.kts` file and click "Sync Now" when prompted:

```kotlin title="app/build.gradle.kts" 
dependencies 
```

> **Note**: 
Before calling the `Amplify.configure` function, make sure to either download the `amplify_outputs.json` file from the console, or generate it with the following command: 

```bash title="Terminal" showLineNumbers=
npx ampx generate outputs --app-id <app-id> --branch main --out-dir app/src/main/res/raw
```

Next, be sure the file you generated or downloaded is in the appropriate resource directory for your application (for example, `app/src/main/res/raw`) in your Android project. Otherwise, you will not be able to compile your application.

```kotlin title="MyAmplifyApp.kt"
import android.app.Application
import android.util.Log
import com.amplifyframework.AmplifyException
import com.amplifyframework.auth.cognito.AWSCognitoAuthPlugin
import com.amplifyframework.core.Amplify
import com.amplifyframework.core.configuration.AmplifyOutputs

class MyAmplifyApp: Application()  catch (error: AmplifyException) 
    }
}
```

Lastly, update your MainActivity.kt file to use the Amplify UI components:

```kotlin
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.amplifyframework.core.Amplify
import com.amplifyframework.ui.authenticator.ui.Authenticator
// highlight-next-line
import <your-package-name>.ui.theme.MyAmplifyAppTheme

class MainActivity : ComponentActivity() !",
                            )
                            Button(onClick = 
                            }) 
                        }
                    }
                }
            }
        }
    }
}
```

</InlineFilter>

### Prerequisites

An application with Amplify libraries integrated and a minimum target of any of the following:

- **iOS 13.0**, using **Xcode 14.1** or later.
- **macOS 10.15**, using **Xcode 14.1** or later.
- **tvOS 13.0**, using **Xcode 14.3** or later.
- **watchOS 9.0**, using **Xcode 14.3** or later.
- **visionOS 1.0**, using **Xcode 15** or later. (Preview support - see below for more details.)

> **Note**: 

visionOS support is currently in **preview** and can be used by using the latest [Amplify Release](https://github.com/aws-amplify/amplify-swift/releases). 
As new Xcode and visionOS versions are released, the support will be updated with any necessary fixes on a best effort basis.

> **Note**: 

**Note:** To use Amplify Auth in a macOS project, you'll need to enable the Keychain Sharing capability. In Xcode, navigate to **your application target** > **Signing & Capabilities** > **+ Capability**, then select **Keychain Sharing.**

This capability is required because Auth uses the Data Protection Keychain on macOS as a platform best practice. See [TN3137: macOS keychain APIs and implementations](https://developer.apple.com/documentation/technotes/tn3137-on-mac-keychains) for more information on how Keychain works on macOS and the Keychain Sharing entitlement.

For more information on adding capabilities to your application, see [Xcode Capabilities](https://developer.apple.com/documentation/xcode/capabilities).

Move the generated files to your project. You can do this by dragging and dropping the files to your project.

![Dialog appears when users drag and drop the generated files into Xcode. It displays targets, added folders, and destination options. The default settings should be sufficient for drag and drop.](/images/lib/getting-started/ios/set-up-swift-8.png)

Open your project in Xcode and select File > Add Packages... and add the following dependencies:

- Amplify Library for Swift: Enter its GitHub URL (https://github.com/aws-amplify/amplify-swift), *select Up to Next Major Version* and click *Add Package*

  - Select the following libraries:
    - Amplify
    - AWSCognitoAuthPlugin

- Amplify UI Swift - Authenticator: Enter its GitHub URL (https://github.com/aws-amplify/amplify-ui-swift-authenticator), *select Up to Next Major Version* and click *Add Package*

  - Select the following library:
    - Authenticator

Next, update the `init` part of your `MyAmplifyAppApp.swift` file with the following code:

```swift title="MyAmplifyApp.swift"
import Amplify
import Authenticator
import AWSCognitoAuthPlugin
import SwiftUI

@main
struct MyApp: App  catch 
    }

    var body: some Scene 
                    }
                }
            }
        }
    }
}
```

</InlineFilter>

Once you add the Authenticator component to your app, you can test the sign-up, sign-in, and sign-out functionality. You can also [customize the Authenticator connected component](https://ui.docs.amplify.aws/react/connected-components/authenticator/customization) to adjust colors and styling as needed.

## Next steps

Now that you have completed setting up authentication in your Amplify app with email and password, you may also want to add some additional features. We recommend you learn more about:

- [Learn more about authentication concepts](/[platform]/build-a-backend/auth/concepts/)
- [Moving to production](/[platform]/build-a-backend/auth/moving-to-production/)


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/set-up-auth/index.mdx`