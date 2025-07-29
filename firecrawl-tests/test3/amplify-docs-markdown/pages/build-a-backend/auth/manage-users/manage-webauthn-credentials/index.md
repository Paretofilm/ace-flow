---
title: Associate WebAuthn credentials
source: pages/build-a-backend/auth/manage-users/manage-webauthn-credentials/index.mdx
---

# Associate WebAuthn credentials

> **Note**: 

WebAuthn registration and authentication are not currently supported on React Native, other passwordless features are fully supported.

</InlineFilter>

Amplify Auth uses passkeys as the credential mechanism for WebAuthn. The following APIs allow users to register, keep track of, and delete the passkeys associated with their Cognito account. 

[Learn more about using passkeys with Amplify](/[platform]/build-a-backend/auth/concepts/passwordless/#webauthn-passkey).

## Associate WebAuthn credentials

> **Note**: 
Registering a passkey is supported on Android 9 (API level 28) and above.

</InlineFilter>
  
Note that users must be authenticated to register a passkey. That also means users cannot create a passkey during sign up; consequently, they must have at least one other first factor authentication mechanism associated with their account to use WebAuthn.

You can associate a passkey using the following API:

```ts

await associateWebAuthnCredential();

```

</InlineFilter>

```java
Amplify.Auth.associateWebAuthnCredential(
    activity,
    () -> Log.i("AuthQuickstart", "Associated credential"),
    error -> Log.e("AuthQuickstart", "Failed to associate credential", error)
);
```

</Block>

```kotlin
Amplify.Auth.associateWebAuthnCredential(
    activity,
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.associateWebAuthnCredential(activity)
    .subscribe(
        result -> Log.i("AuthQuickstart", "Associated credential"), 
        error -> Log.e("AuthQuickstart", "Failed to associate credential", error)
    );
```

</Block>
</BlockSwitcher>

You must supply an `Activity` instance so that Amplify can display the PassKey UI in your application's [Task](https://developer.android.com/guide/components/activities/tasks-and-back-stack).

</InlineFilter>

```swift
func associateWebAuthNCredentials() async  catch 
}
```

</Block>

```swift
func associateWebAuthNCredentials() -> AnyCancellable .sink 
    receiveValue: 
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

The user will be prompted to register a passkey using their local authenticator. Amplify will then associate that passkey with Cognito.

## List WebAuthn credentials

You can list registered passkeys using the following API:

```ts

const result = await listWebAuthnCredentials();

for (const credential of result.credentials) `);
	console.log(`Friendly Name: $`);
	console.log(`Relying Party ID: $`);
	console.log(`Created At: $`);
}

```
</InlineFilter>

```swift
func listWebAuthNCredentials() async 
        }
          
        // Fetch the next page
        if let nextToken = result.nextToken 
    } catch 
}
```

</Block>

```swift
func listWebAuthNCredentials() -> AnyCancellable .sink 
    receiveValue: 
        }
          
        if let nextToken = result.nextToken 
    }
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

```java
Amplify.Auth.listWebAuthnCredentials(
    result -> result.getCredentials().forEach(credential -> ),
    error -> Log.e("AuthQuickstart", "Failed to list credentials", error)
);
```

</Block>

```kotlin
Amplify.Auth.listWebAuthnCredentials(
    ")
            Log.i("AuthQuickstart", "Friendly Name: $")
            Log.i("AuthQuickstart", "Relying Party ID: $")
            Log.i("AuthQuickstart", "Created At: $")
        }
    },
    
)
```

</Block>

```kotlin
try ")
        Log.i("AuthQuickstart", "Friendly Name: $")
        Log.i("AuthQuickstart", "Relying Party ID: $")
        Log.i("AuthQuickstart", "Created At: $")
    }
} catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.listWebAuthnCredentials()
    .subscribe(
        result -> result.getCredentials().forEach(credential -> ), 
        error -> Log.e("AuthQuickstart", "Failed to list credentials", error)
    );
```

</Block>
</BlockSwitcher>
</InlineFilter>

## Delete WebAuthn credentials

You can delete a passkey with the following API:

```ts

const id = "credential-id-to-delete";

await deleteWebAuthnCredential();
```
</InlineFilter>

```swift
func deleteWebAuthNCredentials(credentialId: String) async  catch 
}
```

</Block>

```swift
func deleteWebAuthNCredentials(credentialId: String) -> AnyCancellable .sink 
    receiveValue: 
}
```

</Block>
</BlockSwitcher>
</InlineFilter>

```java
Amplify.Auth.deleteWebAuthnCredential(
    credentialId,
    (result) -> Log.i("AuthQuickstart", "Deleted credential"),
    error -> Log.e("AuthQuickstart", "Failed to delete credential", error)
);
```

</Block>

```kotlin
Amplify.Auth.deleteWebAuthnCredential(
    credentialId,
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.deleteWebAuthnCredential(credentialId)
    .subscribe(
        result -> Log.i("AuthQuickstart", "Deleted credential"), 
        error -> Log.e("AuthQuickstart", "Failed to delete credential", error)
    );
```

</Block>
</BlockSwitcher>

The delete passkey API has only the required `credentialId` as input, and it does not return a value.

</InlineFilter>

## Practical example

Here is a code example that uses the list and delete APIs together. In this example, the user has 3 passkeys registered. They want to list all passkeys while using a `pageSize` of 2 as well as delete the first passkey in the list.

```ts
import  from 'aws-amplify/auth';

let passkeys = [];

const result = await listWebAuthnCredentials();

passkeys.push(...result.credentials);

const nextPage = await listWebAuthnCredentials();

passkeys.push(...nextPage.credentials);

const id = passkeys[0].credentialId;

await deleteWebAuthnCredential();
```

</InlineFilter>
