---
title: Retrieve your current authenticated user
source: pages/build-a-backend/auth/connect-your-frontend/manage-user-sessions/index.mdx
---

# Retrieve your current authenticated user

Amplify Auth provides access to current user sessions and tokens to help you retrieve your user's information to determine if they are signed in with a valid session and control their access to your app.

## Retrieve your current authenticated user

You can use the `getCurrentUser` API to get information about the currently authenticated user including the `username`, `userId` and `signInDetails`.

```ts

const  = await getCurrentUser();

console.log("username", username);
console.log("user id", userId);
console.log("sign-in details", signInDetails);
```

This method can be used to check if a user is signed in. It throws an error if the user is not authenticated.

> **Note**: 

The user's `signInDetails` are not supported when using the `Hosted UI` or the `signInWithRedirect` API.

## Retrieve a user session

Your user's session is their signed-in state, which grants them access to your app. When your users sign in, their credentials are exchanged for temporary access tokens. You can get session details to access these tokens and use this information to validate user access or perform actions unique to that user.

If you only need the session details, you can use the `fetchAuthSession` API which returns a `tokens` object containing the JSON Web Tokens (JWT).

```ts

const session = await fetchAuthSession();

console.log("id token", session.tokens.idToken)
console.log("access token", session.tokens.accessToken)
```

### Refreshing sessions

The `fetchAuthSession` API automatically refreshes the user's session when the authentication tokens have expired and a valid `refreshToken` is present. Additionally, you can also refresh the session explicitly by calling the `fetchAuthSession` API with the `forceRefresh` flag enabled. 

```ts

await fetchAuthSession();
```

> **Note**: 

**Warning:** by default, sessions from external identity providers cannot be refreshed.

</InlineFilter>

An intentional decision with Amplify Auth was to avoid any public methods exposing credentials or manipulating them.

With Auth, you simply sign in and it handles everything else needed to keep the credentials up to date and vend them to the other categories.

However, if you need to access them in relation to working with an API outside Amplify or want access to AWS specific identifying information (e.g. IdentityId), you can access these implementation details by calling `fetchAuthSession` on the Cognito Auth Plugin. This will return a `CognitoAuthSession`, which has additional attributes compared to `AuthSession`, which is typically returned by `fetchAuthSession`. See the example below:

```dart
Future<void> fetchAuthSession() async ');
  } on AuthException catch (e) ');
  }
}
```

## Retrieving AWS credentials

Sometimes it can be helpful to retrieve the instance of the underlying plugin which has more specific typing. In case of Cognito, calling `fetchAuthSession` on the Cognito plugin returns AWS-specific values such as the identity ID, AWS credentials, and Cognito User Pool tokens.

```dart
Future<void> fetchCognitoAuthSession() async  on AuthException catch (e) ');
  }
}
```

</InlineFilter>

An intentional decision with Amplify Auth was to avoid any public methods exposing credentials or manipulating them.

With Auth, you simply sign in and it handles everything else needed to keep the credentials up to date and vend them to the other categories.

However, if you need to access them in relation to working with an API outside Amplify or want access to AWS specific identifying information (e.g. IdentityId), you can access these implementation details by casting the result of `fetchAuthSession` as follows:

```java
Amplify.Auth.fetchAuthSession(
    result -> 
        },
        error -> Log.e("AuthQuickStart", error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.fetchAuthSession(
    ")
            AuthSessionResult.Type.FAILURE ->
                Log.w("AuthQuickStart", "IdentityId not found", session.identityIdResult.error)
        }
    },
    
)
```

</Block>

```kotlin
try ")
    } else if (id.type == AuthSessionResult.Type.FAILURE) ")
    }
} catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.fetchAuthSession()
    .subscribe(
        result -> 
        },
        error -> Log.e("AuthQuickStart", error.toString())
    );
```

</Block>
</BlockSwitcher>

## Force refreshing session

Through the plugin, you can force refresh the internal session by setting the `forceRefresh` option when calling the fetchAuthSession API.

```java
AuthFetchSessionOptions options = AuthFetchSessionOptions.builder().forceRefresh(true).build();
```

</Block>

```kotlin
val option = AuthFetchSessionOptions.builder().forceRefresh(true).build()
```

</Block>

```kotlin
val option = AuthFetchSessionOptions.builder().forceRefresh(true).build()
```

</Block>

```java
AuthFetchSessionOptions options = AuthFetchSessionOptions.builder().forceRefresh(true).build();
```

</Block>
</BlockSwitcher>

</InlineFilter>

An intentional decision with Amplify Auth was to avoid any public methods exposing credentials or manipulating them.

With Auth, you simply sign in and it handles everything else needed to keep the credentials up to date and vend them to the other categories.

However, if you need to access them in relation to working with an API outside Amplify or want access to AWS specific identifying information (e.g. IdentityId), you can access these implementation details by casting the result of `fetchAuthSession` as follows:

```swift
import AWSPluginsCore

do 

    // Get AWS credentials
    if let awsCredentialsProvider = session as? AuthAWSCredentialsProvider 

    // Get cognito user pool token
    if let cognitoTokenProvider = session as? AuthCognitoTokensProvider 
} catch let error as AuthError  catch 
```
If you have enabled guest user in Cognito Identity Pool and no user is signed in, you will be able to access only identityId and AWS credentials. All other session details will give you an error.

```swift
import AWSPluginsCore

do 

    // Get AWS credentials
    if let awsCredentialsProvider = session as? AuthAWSCredentialsProvider 
} catch let error as AuthError  catch 
```

## Force refreshing session

Through the plugin, you can force refresh the internal session by passing an api options `forceRefresh` while calling the fetchAuthSession api.

```swift
Amplify.Auth.fetchAuthSession(options: .forceRefresh())

```
</InlineFilter>
