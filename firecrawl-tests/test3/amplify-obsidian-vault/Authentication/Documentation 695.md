---
title: Documentation
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/flutter/managing_credentials/10_managing_credentials.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Documentation

The Amplify Auth category persists authentication-related information to make it available to other Amplify categories and to your application.

Amplify Flutter securely manages credentials and user identity information. You do not need to store, refresh, or delete credentials yourself. Amplify Flutter stores auth data on the device using platform capabilities such as [Keychain Services](https://developer.apple.com/documentation/security/keychain_services/) on iOS and macOS and [EncryptedSharedPreferences](https://developer.android.com/reference/androidx/security/crypto/EncryptedSharedPreferences) on Android.

> **Note**: 

Amplify will refresh the [Access Token](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-the-access-token.html) and [ID Token](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-the-id-token.html) as long as the [Refresh Token](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-the-refresh-token.html) is valid. Once the Refresh token expires, the user will need to reauthenticate to obtain a new one.

Some platform specific option can be customized with the out of the box options. In the example below, credentials will be stored in-memory on Web instead of the default behavior of using browser storage.

```dart
await Amplify.addPlugin(
  AmplifyAuthCognito(
    secureStorageFactory: AmplifySecureStorage.factoryFrom(
      webOptions: WebSecureStorageOptions(
        persistenceOption: WebPersistenceOption.inMemory,
      ),
    ),
  ),
);
```

If you would like further customization, you can provide your own factory for creating `SecureStorageInterface` instances to `AmplifyAuthCognito`. The example below shows the use of a custom implementation that stores data in-memory on all platforms.

```dart
await Amplify.addPlugin(
  AmplifyAuthCognito(secureStorageFactory: InMemoryStorage.new),
);
```

```dart
class InMemoryStorage implements SecureStorageInterface ;

  @override
  void write() .$key'] = value;
  }

  @override
  String? read() .$key'];
  }

  @override
  void delete() .$key');
  }
}
```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/flutter/managing_credentials/10_managing_credentials.mdx`