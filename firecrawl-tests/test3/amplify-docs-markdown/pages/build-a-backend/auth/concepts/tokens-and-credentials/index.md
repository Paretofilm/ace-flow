---
title: Understand token management options
source: pages/build-a-backend/auth/concepts/tokens-and-credentials/index.mdx
---

# Understand token management options

Amplify Auth interacts with its underlying [Amazon Cognito user pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html) as an OpenID Connect (OIDC) provider. When users successfully authenticate you receive OIDC-compliant JSON web tokens (JWT). These tokens are used to _identity_ your user, and _access_ resources.

[**Access tokens**](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-the-access-token.html) are used to verify the bearer of the token (i.e. the Cognito user) is authorized to perform an action against a resource. Below is an example payload of an access token vended by Cognito:

```json

```

[**ID tokens**](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-the-id-token.html) are intended to be used within your frontend application only. This token contains personally identifiable information (PII) and should not be used to authorize access against a resource. Below is an example of an ID token with the default Amplify Auth configuration of email and password auth.

```json

```

When additional user attributes are specified for Amplify Auth, their values will be found in the ID token. For example, if a `nickname` attribute is requested it will be available on the ID token with the `nickname` claim:

```diff

```

Conversely, user pool group claims are found in both the access token and ID token on the `cognito:groups` claim:

```json

```

Visit the [AWS documentation for using tokens with Cognito user pools](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-tokens-with-identity-providers.html) to learn more about tokens, how they're used with Cognito, and their intended usage.

## Understand token management options

Token keys are automatically rotated for you for added security but you can update how they are stored, customize the refresh rate and expiration times, and revoke tokens on sign-out.

### Update your token-saving mechanism

You can update the storage mechanism to choose where and how tokens are persisted in your application. The default option is `localStorage`. Additionally, you can import the `sessionStorage`, `sharedInMemoryStorage` or `CookieStorage` options as well.

If you want to customize your own mechanism, you can import the `KeyValueStorageInterface` interface and implement it in your own class.

#### Browser Local Storage

In Amplify the `localStorage` is the default storage mechanism. It saves the tokens in the browser's `localStorage`. This local storage will persist across browser sessions and tabs. You can explicitly set to this storage by calling:

```ts

cognitoUserPoolsTokenProvider.setKeyValueStorage(defaultStorage);
```

#### Cookie Storage

`CookieStorage` saves the tokens in the browser's `Cookies`. The cookies will persist across browser sessions and tabs. You can explicitly set to this storage by calling:

```ts

cognitoUserPoolsTokenProvider.setKeyValueStorage(new CookieStorage());
```

#### Browser Session Storage

`sessionStorage` saves the tokens in the browser's `sessionStorage` and these tokens will clear when a tab is closed. The benefit to this storage mechanism is that the session only lasts as long as the browser is open and you can sign out users when they close the tab. You can update to this storage by calling:

```ts

cognitoUserPoolsTokenProvider.setKeyValueStorage(sessionStorage);
```

#### Custom Storage

You can implement your own custom storage mechanism by creating a class that implements the storage interface. Here is an example that uses memory storage:

```ts

class MyCustomStorage implements KeyValueStorageInterface ;
  async setItem(key: string, value: string): Promise<void> 
  async getItem(key: string): Promise<string | null> 
  async removeItem(key: string): Promise<void> 
  async clear(): Promise<void> ;
  }
}

cognitoUserPoolsTokenProvider.setKeyValueStorage(new MyCustomStorage());
```

When you get the current user session, the tokens will be saved in your custom location.

</InlineFilter>

Amplify Auth persists authentication-related information to make it available to other Amplify categories and to your application.

Amplify Flutter securely manages credentials and user identity information. You do not need to store, refresh, or delete credentials yourself. Amplify Flutter stores auth data on the device using platform capabilities such as [Keychain Services](https://developer.apple.com/documentation/security/keychain_services/) on iOS and macOS and [EncryptedSharedPreferences](https://developer.android.com/reference/androidx/security/crypto/EncryptedSharedPreferences) on Android.

> **Note**: 

Amplify will refresh the [access token](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-the-access-token.html) and [ID token](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-the-id-token.html) as long as the [refresh token](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-the-refresh-token.html) is valid. Once the refresh token expires, the user will need to reauthenticate to obtain a new one.

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
</InlineFilter>

## Token Revocation

Token revocation is enabled automatically in Amplify Auth. To revoke tokens you can set up global sign-out with `signOut()` to globally sign out your user from all of their devices.

</InlineFilter>

Token revocation is enabled automatically in Amplify Auth. To revoke tokens you can invoke `await Amplify.Auth.signOut(options: const signOutOptions(globalSignOut: true))` to globally sign out your user from all of their devices.

</InlineFilter>

Token revocation is enabled automatically in Amplify Auth. To revoke tokens you can invoke `await Amplify.Auth.signOut(options: .init(globalSignOut: true))` to globally sign out your user from all of their devices.

</InlineFilter>

## Next steps

- [Learn how to customize the ID token](/[platform]/build-a-backend/functions/examples/override-token/)
- [Learn how to bring your own tokens from external providers](/[platform]/build-a-backend/auth/advanced-workflows/#custom-token-providers)
- [Learn how to use cookie storage server-side](/[platform]/build-a-backend/server-side-rendering/#configure-amplify-library-for-client-side-usage)

</InlineFilter>

- [Learn how to customize the ID token](/[platform]/build-a-backend/functions/examples/override-token/)
- [Learn how to bring your own tokens from external providers](/[platform]/build-a-backend/auth/advanced-workflows/#custom-token-providers)

</InlineFilter>
