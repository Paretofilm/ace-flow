---
title: Remember devices
source: pages/build-a-backend/auth/manage-users/manage-devices/index.mdx
---

# Remember devices

Amplify Auth enables you to track devices your users use for auditing, MFA, and more. Before you begin it is important to understand the terminology for device statuses:

- **Tracked:** Every time the user signs in with a new device, the client is given the device key at the end of a successful authentication event. We use this device key to generate a salt and password verifier which is used to call the ConfirmDevice API. At this point, the device is considered to be _tracked_. Once the device is in a tracked state, you can use the Amazon Cognito console to see the time it started to be tracked, last authentication time, and other information about that device.
- **Remembered:** Remembered devices are also tracked. During user authentication, the device key and secret pair assigned to a remembered device is used to authenticate the device to verify that it is the same device that the user previously used to sign in.
- **Not Remembered:** A not-remembered device is a tracked device where Cognito has been configured to require users to "Opt-in" to remember a device, but the user has not opt-ed in to having the device remembered. This use case is used for users signing into their application from a device that they don't own.
- **Forgotten:** a forgotten device is one removed from being remembered

> **Note**: 

**Note:** [device tracking and remembering](https://aws.amazon.com/blogs/mobile/tracking-and-remembering-devices-using-amazon-cognito-your-user-pools/) features are not available when using federating sign-in with external providers as devices are tracked on the upstream identity provider. These features are also not available when using Cognito's Hosted UI.

## Remember devices

You can remember devices using the following:

```ts

await rememberDevice();
```

</InlineFilter>

```dart
Future<void> rememberCurrentDevice() async  on AuthException catch (e) 
}
```

</InlineFilter>

```java
Amplify.Auth.rememberDevice(
    () -> Log.i("AuthQuickStart", "Remember device succeeded"),
    error -> Log.e("AuthQuickStart", "Remember device failed with error " + error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.rememberDevice(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.rememberDevice()
    .subscribe(
      () -> Log.i("AuthQuickStart", "Remember device succeeded"),
      error -> Log.e("AuthQuickStart", "Remember device failed with error " + error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
func rememberDevice() async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func rememberDevice() -> AnyCancellable .sink 
        }
        receiveValue: 
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

## Forget devices

You can also forget devices but note that forgotten devices are neither remembered nor tracked.

```ts

await forgetDevice();
```

</InlineFilter>

```dart
Future<void> forgetCurrentDevice() async  on AuthException catch (e) 
}
```

</Block>

```dart
// A device that was fetched via Amplify.Auth.fetchDevices()
Future<void> forgetSpecificDevice(AuthDevice myDevice) async  on AuthException catch (e) 
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

```java
Amplify.Auth.forgetDevice(
    () -> Log.i("AuthQuickStart", "Forget device succeeded"),
    error -> Log.e("AuthQuickStart", "Forget device failed with error " + error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.forgetDevice(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.forgetDevice()
    .subscribe(
      () -> Log.i("AuthQuickStart", "Forget device succeeded"),
      error -> Log.e("AuthQuickStart", "Forget device failed with error " + error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
func forgetDevice() async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func forgetDevice() -> AnyCancellable .sink 
    }
    receiveValue: 
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

## Fetch devices

You can fetch a list of remembered devices by using the following:

```ts

const output = await fetchDevices();
```

</InlineFilter>

```dart
Future<void> fetchAllDevices() async 
  } on AuthException catch (e) 
}
```

</InlineFilter>

```java
Amplify.Auth.fetchDevices(
    devices -> 
    },
    error -> Log.e("AuthQuickStart", "Fetch devices failed with error: " + error.toString()));
```

</Block>

```kotlin
Amplify.Auth.fetchDevices(
    
    },
    
)
```

</Block>

```kotlin
try 
} catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.fetchDevices()
    .subscribe(
        device -> Log.i("AuthQuickStart", "Device: " + device);
        error -> Log.e("AuthQuickStart", "Fetch devices failed with error: " + error.toString())
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```swift
func fetchDevices() async 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func fetchDevices() -> AnyCancellable .sink 
    }
    receiveValue: 
    }
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

## Fetch the current device

You can fetch the current device by using the following:

```dart
Future<void> fetchCurrentUserDevice() async  on AuthException catch (e) 
}
```

</InlineFilter>

You can now set up devices to be remembered, forgotten, and fetched.
