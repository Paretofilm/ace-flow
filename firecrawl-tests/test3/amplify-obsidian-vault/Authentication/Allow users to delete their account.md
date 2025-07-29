---
title: Allow users to delete their account
topics: ['Authentication']
primary_topic: Authentication
source: pages/build-a-backend/auth/connect-your-frontend/delete-user-account/index.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Allow users to delete their account

Empowering users to delete their account can improve trust and transparency. You can programmatically enable self-service account deletion with Amplify Auth.

If you have not yet created an Amplify Gen 2 app, visit the [quickstart](/[platform]/start/quickstart).

## Allow users to delete their account

You can quickly set up account deletion for your users with the Amplify Libraries. Invoking the `deleteUser` API to delete a user from the Auth category will also sign out your user.

If your application uses a Cognito User Pool, which is the default configuration, this action will only delete the user from the Cognito User Pool. It will have no effect if you are federating with a Cognito Identity Pool alone.

> **Note**: 

Before invoking the `deleteUser` API, you may need to first delete associated user data that is not stored in Cognito. For example, if you are using Amplify Data to persist user data, you could follow [these instructions](https://gist.github.com/aws-amplify-ops/27954c421bd72930874d48c15c284807) to delete associated user data. This allows you to address any guidelines (such as GDPR) that require your app to delete data associated with a user who deletes their account.

You can enable account deletion using the following method:

```ts

async function handleDeleteUser()  catch (error) 
}
```
</InlineFilter>

```dart
Future<void> deleteUser() async  on AuthException catch (e) 
}
```
</InlineFilter>

```java
Amplify.Auth.deleteUser(
    () -> Log.i("AuthQuickStart", "Delete user succeeded"),
    error -> Log.e("AuthQuickStart", "Delete user failed with error " + error.toString())
);
```

</Block>

```kotlin
Amplify.Auth.deleteUser(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.deleteUser()
    .subscribe(
      () -> Log.i("AuthQuickStart", "Delete user succeeded"),
      error -> Log.e("AuthQuickStart", "Delete user failed with error " + error.toString())
    );
```

</Block>
</BlockSwitcher>
</InlineFilter>

```swift
func deleteUser() async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func deleteUser() -> AnyCancellable .sink 
        }
        receiveValue: 
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

We recommend you update your UI to let your users know that their account is deleted and test the functionality with a test user. Note that your user will be signed out of your application when they delete their account.


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `pages/build-a-backend/auth/connect-your-frontend/delete-user-account/index.mdx`