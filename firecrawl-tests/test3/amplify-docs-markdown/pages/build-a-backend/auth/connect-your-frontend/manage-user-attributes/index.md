---
title: Pass user attributes during sign-up
source: pages/build-a-backend/auth/connect-your-frontend/manage-user-attributes/index.mdx
---

# Pass user attributes during sign-up

User attributes such as email address, phone number help you identify individual users. Defining the user attributes you include for your user profiles makes user data easy to manage at scale. This information will help you personalize user journeys, tailor content, provide intuitive account control, and more. You can capture information upfront during sign-up or enable customers to update their profile after sign-up. In this section we take a closer look at working with user attributes, how to set them up and manage them.

## Pass user attributes during sign-up

You can create user attributes during sign-up or when the user is authenticated. To do this as part of sign-up you can pass them in the `userAttributes` object of the `signUp` API:

```ts

await signUp(,
  },
});
```
</InlineFilter>

## Configure custom user attributes during sign-up

Custom attributes can be passed in with the `userAttributes` option of the `signUp` API:

```ts

await signUp(
  }
});
```

</InlineFilter>

```dart
Future<void> _signUp() async  ;
  await Amplify.Auth.signUp(
    username: username,
    password: password,
    options: SignUpOptions(
      userAttributes: userAttributes,
    ),
  );
}
```

</InlineFilter>

```swift
func signUp(username: String, password: String, email: String) async  else 
    } catch let error as AuthError  catch 
}
```

</InlineFilter>
</InlineFilter>

## Retrieve user attributes

You can retrieve user attributes for your users to read in their profile using the `fetchUserAttributes` API. This helps you personalize their frontend experience as well as control what they will see.

```ts

await fetchUserAttributes();
```

</InlineFilter>

```swift
func fetchAttributes() async  catch let error as AuthError catch 
}
```

</Block>

```swift
func fetchAttributes() -> AnyCancellable .sink 
        }
        receiveValue: 
}
```

</Block>
</BlockSwitcher>

</InlineFilter>

```java
Amplify.Auth.fetchUserAttributes(
    attributes -> Log.i("AuthDemo", "User attributes = " + attributes.toString()),
    error -> Log.e("AuthDemo", "Failed to fetch user attributes.", error)
);
```

</Block>

```kotlin
Amplify.Auth.fetchUserAttributes(
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.fetchUserAttributes()
    .doOnSubscribe(() -> Log.i("AuthDemo", "Attributes:"))
    .flatMapObservable(Observable::fromIterable)
    .subscribe(
        eachAttribute -> Log.i("AuthDemo", eachAttribute.toString()),
        error -> Log.e("AuthDemo", "Failed to fetch attributes.", error)
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```dart
Future<void> fetchCurrentUserAttributes() async ; value: $');
    }
  } on AuthException catch (e) ');
  }
}
```

</InlineFilter>

## Update user attribute

You can use the `updateUserAttribute` API to create or update existing user attributes.

```typescript
import  from 'aws-amplify/auth';

async function handleUpdateUserAttribute(attributeKey: string, value: string) 
    });
    handleUpdateUserAttributeNextSteps(output);
  } catch (error) 
}

function handleUpdateUserAttributeNextSteps(output: UpdateUserAttributeOutput)  = output;

  switch (nextStep.updateAttributeStep) .`
      );
      // Collect the confirmation code from the user and pass to confirmUserAttribute.
      break;
    case 'DONE':
      console.log(`attribute was successfully updated.`);
      break;
  }
}
```

</Block>

```javascript

async function handleUpdateUserAttribute(attributeKey, value) 
    });
    handleUpdateUserAttributeNextSteps(output);
  } catch (error) 
}

function handleUpdateUserAttributeNextSteps(output)  = output;

  switch (nextStep.updateAttributeStep) .`
      );
      // Collect the confirmation code from the user and pass to confirmUserAttribute.
      break;
    case 'DONE':
      console.log(`attribute was successfully updated.`);
      break;
  }
}
```

</Block>
</BlockSwitcher>

> **Note**: 
  Note: If you change an attribute that requires confirmation (i.e. email or phone_number), the user will receive a confirmation code either to their email or cellphone. This code can be used with the confirmUserAttribute API to confirm the change.

</InlineFilter>

```swift
func updateAttribute() async 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func updateAttribute() -> AnyCancellable .sink 
    }
    receiveValue: 
    }
}
```

</Block>

</BlockSwitcher>
</InlineFilter>

```java
AuthUserAttribute userEmail =
    new AuthUserAttribute(AuthUserAttributeKey.email(), "email@email.com");
Amplify.Auth.updateUserAttribute(userEmail,
    result -> Log.i("AuthDemo", "Updated user attribute = " + result.toString()),
    error -> Log.e("AuthDemo", "Failed to update user attribute.", error)
);
```

</Block>

```kotlin
Amplify.Auth.updateUserAttribute(
    AuthUserAttribute(AuthUserAttributeKey.email(), "email@email.com"),
    ,
    
)
```

</Block>

```kotlin
val attribute =
    AuthUserAttribute(AuthUserAttributeKey.email(), "email@email.com")
try  catch (error: AuthException) 
```

</Block>

```java
AuthUserAttribute userEmail =
    new AuthUserAttribute(AuthUserAttributeKey.email(), "email@email.com");
RxAmplify.Auth.updateUserAttribute(userEmail)
    .subscribe(
        result -> Log.i("AuthDemo", "Updated user attribute = " + result.toString()),
        error -> Log.e("AuthDemo", "Failed to update user attribute.", error)
    );
```

</Block>
</BlockSwitcher>

</InlineFilter>

```dart
Future<void> updateUserEmail() async  on AuthException catch (e) ');
  }
}
```

User attribute updates may require additional verification before they're complete. Check the
`UpdateUserAttributeResult` returned from `Amplify.Auth.updateUserAttribute` to see which next
step, if any, is required. When the update is complete, the next step will be `done`.

```dart
void _handleUpdateUserAttributeResult(
  UpdateUserAttributeResult result,
) 
}

void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) . '
    'Please check your $ for the code.',
  );
}
```

To update multiple user attributes at a time, call `updateUserAttributes`:

```dart
Future<void> updateUserAttributes() async 
    });
  } on AuthException catch (e) ');
  }
}
```
</InlineFilter>

## Update user attributes

You can use the `updateUserAttributes` API to create or update multiple existing user attributes.

```typescript

await updateUserAttributes(,
});
```
</InlineFilter>

```java
Amplify.Auth.updateUserAttributes(
    attributes, // attributes is a list of AuthUserAttribute
    result -> Log.i("AuthDemo", "Updated user attributes = " + result.toString()),
    error -> Log.e("AuthDemo", "Failed to update user attributes.", error)
);
```

</Block>

```kotlin
Amplify.Auth.updateUserAttributes(
    attributes, // attributes is a list of AuthUserAttribute
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
// attributes is a list of AuthUserAttribute
RxAmplify.Auth.updateUserAttributes(attributes)
    .subscribe(
        result -> Log.i("AuthDemo", "Updated user attributes = " + result.toString()),
        error -> Log.e("AuthDemo", "Failed to update user attributes.", error)
    );
```

</Block>
</BlockSwitcher>
</InlineFilter>
</InlineFilter>

## Verify user attribute

Some attributes require confirmation for the attribute update to complete. If the attribute needs to be confirmed, part of the result of the `updateUserAttribute` or `updateUserAttributes` APIs will be `CONFIRM_ATTRIBUTE_WITH_CODE`. A confirmation code will be sent to the delivery medium mentioned in the delivery details. When the user gets the confirmation code, you can present a UI to the user to enter the code and invoke the `confirmUserAttribute` API with their input:
</InlineFilter>

Some attributes require confirmation for the attribute update to complete. If the attribute needs to be confirmed, part of the result of the `updateUserAttribute` or `updateUserAttributes` APIs will be `confirmAttributeWithCode`. A confirmation code will be sent to the delivery medium mentioned in the delivery details. When the user gets the confirmation code, you can present a UI to the user to enter the code and invoke the `confirmUserAttribute` API with their input:
</InlineFilter>

```typescript
import  from 'aws-amplify/auth';

async function handleConfirmUserAttribute(: ConfirmUserAttributeInput) );
  } catch (error) 
}
```
</InlineFilter>

```swift
func confirmAttribute() async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func confirmAttribute() -> AnyCancellable .sink 
        }
        receiveValue: 
}
```

</Block>

</BlockSwitcher>
</InlineFilter>

```java
Amplify.Auth.confirmUserAttribute(AuthUserAttributeKey.email(), "344299",
    () -> Log.i("AuthDemo", "Confirmed user attribute with correct code."),
    error -> Log.e("AuthDemo", "Failed to confirm user attribute. Bad code?", error)
);
```

</Block>

```kotlin
Amplify.Auth.confirmUserAttribute(AuthUserAttributeKey.email(), "344299",
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.confirmUserAttribute(AuthUserAttributeKey.email(), "344299")
    .subscribe(
        () -> Log.i("AuthDemo", "Confirmed user attribute using correct code."),
        error -> Log.e("AuthDemo", "Failed to confirm user attribute. Bad code?", error)
    );
```

</Block>
</BlockSwitcher>
</InlineFilter>

```dart
Future<void> verifyAttributeUpdate() async  on AuthException catch (e) ');
  }
}
```
</InlineFilter>

## Send user attribute verification code

If an attribute needs to be verified while the user is authenticated, invoke the `sendUserAttributeVerificationCode` API as shown below:

```ts
import  from 'aws-amplify/auth';

async function handleSendUserAttributeVerificationCode(
  key: VerifiableUserAttributeKey
) );
  } catch (error) 
}
```
</InlineFilter>

```swift
func sendVerificationCode() async  catch let error as AuthError  catch 
}
```

</Block>

```swift
func sendVerificationCode() -> AnyCancellable .sink 
        }
        receiveValue: 
}
```

</Block>

</BlockSwitcher>
</InlineFilter>

```java
Amplify.Auth.resendUserAttributeConfirmationCode(AuthUserAttributeKey.email(),
    result -> Log.i("AuthDemo", "Code was sent again: " + result.toString()),
    error -> Log.e("AuthDemo", "Failed to resend code.", error)
);
```

</Block>

```kotlin
Amplify.Auth.resendUserAttributeConfirmationCode(
    AuthUserAttributeKey.email(),
    ,
    
)
```

</Block>

```kotlin
try  catch (error: AuthException) 
```

</Block>

```java
RxAmplify.Auth.resendUserAttributeConfirmationCode(AuthUserAttributeKey.email())
    .subscribe(
        result -> Log.i("AuthDemo", "Code was resent: " + result.toString()),
        error -> Log.e("AuthDemo", "Failed to resend code.", error)
    );
```

</Block>
</BlockSwitcher>
</InlineFilter>

 ```dart
Future<void> resendVerificationCode() async  on AuthException catch (e) ');
  }
}
```
</InlineFilter>

## Delete user attributes

The `deleteUserAttributes` API allows to delete one or more user attributes.

```ts
import  from 'aws-amplify/auth';

async function handleDeleteUserAttributes(
  keys: DeleteUserAttributesInput['userAttributeKeys']
) );
  } catch (error) 
}
```
</InlineFilter>

## Next Steps 

- [Learn how to set up password change and recovery](/[platform]/build-a-backend/auth/manage-users/manage-passwords/)
- [Learn how to set up custom attributes](/[platform]/build-a-backend/auth/concepts/user-attributes#custom-attributes)
