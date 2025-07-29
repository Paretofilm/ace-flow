---
title: Password operations
source: fragments/lib/auth/js/manageusers.mdx
---

# Password operations

This section covers the client-side development experience for password and user management. To learn more about exposing administration actions to your application, click [here](/gen1/[platform]/build-a-backend/graphqlapi/customize-authorization-rules/).

## Password operations

### Change password

```ts

async function changePassword(oldPassword: string, newPassword: string)  catch (err) 
}
```

</Block>

```javascript

async function changePassword(oldPassword, newPassword)  catch (err) 
}
```

</Block>
</BlockSwitcher>

### Forgot password

```ts
// Send confirmation code to user's email
async function forgotPassword(username: string)  catch (err) 
}

// Collect confirmation code and new password
async function forgotPasswordSubmit(
  username: string,
  code: string,
  newPassword: string
)  catch (err) 
}
```

</Block>

```javascript

// Send confirmation code to user's email
async function forgotPassword(username)  catch (err) 
}

// Collect confirmation code and new password
async function forgotPasswordSubmit(username, code, newPassword)  catch (err) 
}
```

</Block>
</BlockSwitcher>

### Complete new password

The user is asked to provide the new password and required attributes during the first sign-in attempt if a valid user directory is created in Amazon Cognito. During this scenario, the following method can be called to process the new password entered by the user.

```ts

async function completeNewPassword(username: string, password: string)  = user.challengeParam; // the array of required attributes, e.g ['email', 'phone_number']
    }
    const newPassword = 'newPassword';
    const loggedInUser = await Auth.completeNewPassword(
      user, // the Cognito User Object
      newPassword, // the new password
      // OPTIONAL, the required attributes
      
    );

    console.log(loggedInUser);
  } catch (err) 
}
```

</Block>

```js

async function completeNewPassword(username, password)  = user.challengeParam; // the array of required attributes, e.g ['email', 'phone_number']
      const loggedInUser = await Auth.completeNewPassword(
        user, // the Cognito User Object
        newPassword, // the new password
        // OPTIONAL, the required attributes
        
      );

      console.log(loggedInUser);
    }
  } catch (err) 
}
```

</Block>
</BlockSwitcher>

## Account recovery verification

Either the phone number or the email address is required for account recovery. You can let the user verify those attributes by:

```ts
// To initiate the process of verifying the attribute like 'phone_number' or 'email'
async function verifyCurrentUserAttribute(attr: string)  catch (err) 
}

// To verify attribute with the code
async function verifyCurrentUserAttributeSubmit(
  attr: string,
  verificationCode: string
)  catch (err) 
}
```

</Block>

```javascript
// To initiate the process of verifying the attribute like 'phone_number' or 'email'
async function verifyCurrentUserAttribute(attr)  catch (err) 
}

// To verify attribute with the code
async function verifyCurrentUserAttributeSubmit(attr, verificationCode)  catch (err) 
}
```

</Block>
</BlockSwitcher>

## Retrieve current authenticated user

You can call `Auth.currentAuthenticatedUser()` to get the current authenticated user object.

```ts

async function currentAuthenticatedUser() );
    console.log(user);
  } catch (err) 
}
```

</Block>

```javascript

async function currentAuthenticatedUser() );
  } catch (err) 
}
```

</Block>
</BlockSwitcher>

This method can be used to check if a user is logged in when the page is loaded. It will throw an error if there is no user logged in. This method should be called after the Auth module is configured or the user is logged in. To ensure that you can listen on the auth events `configured` or `signIn`. [Learn how to listen on auth events.](/gen1/[platform]/build-a-backend/utilities/hub/#authentication-events)

### Retrieve attributes for current authenticated user

You can also access the user's attributes like their email address, phone number, sub, or any other attributes that are associated with them from the user object returned by `Auth.currentAuthenticatedUser`.

```ts
const  = await Auth.currentAuthenticatedUser();
```

## Retrieve current session

`Auth.currentSession()` returns a `CognitoUserSession` object which contains JWT `accessToken`, `idToken`, and `refreshToken`.

This method will automatically refresh the `accessToken` and `idToken` if tokens are expired and a valid `refreshToken` presented. So you can use this method to refresh the session if needed.

```javascript

async function currentSession()  catch (err) 
}
```

## Managing user attributes

Attributes such as name, email address, phone number help you identify individual users. The Amplify JavaScript library contains a set of APIs that can help you manage attributes in your user pool.

### Pass user attributes during sign up

Amazon Cognito has a set of default standard attributes; you also have the ability to define custom attributes. Up to 50 custom attributes can be added to your user pool. You can find a [list of all the standard attributes here](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html#cognito-user-pools-standard-attributes) and [documentation for custom attributes here](https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-settings-attributes.html#user-pool-settings-custom-attributes). You can pass them in the `attributes` object of `Auth.signUp` function parameters:

```javascript
Auth.signUp(
});
```

### Retrieve user attributes

```ts
const user = await Auth.currentAuthenticatedUser();

const  = user;
```

### Update user attributes

```ts

async function updateUserAttributes() );
    console.log(result); // SUCCESS
  } catch (err) 
}
```

> **Note**: 
  Note: If you change an attribute that requires confirmation (i.e. email or
  phone number), you will receive a confirmation code to that attribute.

`Auth.updateUserAttributes()` function dispatches hub event to help identify attributes that require verification. You can listen to `updateUserAttributes` event on `auth` channel:

```javascript

Hub.listen('auth', () => 
});
```

You can learn more about how to listen to Hub events [here](/gen1/[platform]/build-a-backend/utilities/hub/).

Example of the dispatched `resultObject`:

```javascript

  },
  'family_name': 
}
```

If a user sends several attributes for update and one or more of them is `read_only` or doesn't exist, the Amplify JavaScript library will throw an error and dispatch `updateUserAttributes_failure` Hub event. None of the attributes in the request will be updated.

### Confirm attribute

If you change the email address, you will receive a confirmation code to the new email address. Below is an example of how to confirm the new email address in your app:

```javascript
const result = await Auth.verifyCurrentUserAttributeSubmit(
  'email',
  '<verification_code>'
);
```

### Delete user attributes

If you need to delete one or more user attributes, you can call `Auth.deleteUserAttributes` function from the Amplify JavaScript library:

```ts

async function deleteUserAttributes()  catch (err) 
}
```

## Updating and verifying a Cognito user email address

Updating an email address using `Auth.updateUserAttributes` will require a verification of the new email address. The user will be emailed a verification code to the updated email address and your application will need to receive the verification code and send it to `Auth.verifyCurrentUserAttributeSubmit` before the email address will be updated in Cognito.

The React application below implements this flow of updating the email address for the current user when the "Update Email" button is clicked, then provides a form to capture the verification code sent to the user.

```ts
// App.js
import '@aws-amplify/ui-react/styles.css';

async function updateUserEmail() );

    console.log('a verification code is sent');
  } catch(err) 
}

async function verifyEmailValidationCode(code: string)  catch(err) 
}

function ValidationCodeForm() }
          type="text"
          name="vc"
        />
      </label>
      <button onClick=>
        Send Code
      </button>
    </div>
  );
}

  return (
    
      ) => (
        <div className="App">
          <div>
            <pre></pre>
          </div>
          }
            >
              Update Email
            </button>
          )}
          
          <button onClick=>Sign out</button>
        </div>
      )}
    </Authenticator>
  );
}
```

</Block>

```javascript
// App.js
import '@aws-amplify/ui-react/styles.css';

async function updateUserEmail() );

    console.log('a verification code is sent');
  } catch (err) 
}

async function verifyEmailValidationCode(code)  catch (err) 
}

function ValidationCodeForm() }
          type="text"
          name="vc"
        />
      </label>
      <button onClick=>
        Send Code
      </button>
    </div>
  );
}

  return (
    
      ) => (
        <div className="App">
          <div>
            <pre></pre>
          </div>
          }
            >
              Update Email
            </button>
          )}
          
          <button onClick=>Sign out</button>
        </div>
      )}
    </Authenticator>
  );
}
```

</Block>
</BlockSwitcher>

## Managing security tokens

> When using Authentication with AWS Amplify, you don't need to refresh Amazon Cognito tokens manually. The tokens are automatically refreshed by the library when necessary.

Security Tokens like _IdToken_ or _AccessToken_ are stored in _localStorage_ for the browser and in _AsyncStorage_ for React Native. If you want to store those tokens in a more secure place or you are using Amplify in server side, then you can provide your own `storage` object to store those tokens.

For example:

```ts
class MyStorage );
    }
    return MyStorage.syncPromise;
  }
}

// tell Auth to use your storage object
Auth.configure();
```

Here is the example of how to use AsyncStorage as your storage object which will show you how to sync items from AsyncStorage into Memory:

```javascript

const MYSTORAGE_KEY_PREFIX = '@MyStorage:';
let dataMemory = ;

/** @class */
class MyStorage 

  /**
   * This is used to get a specific key from storage
   */
  static getItem(key) 

  /**
   * This is used to remove an item from storage
   */
  static removeItem(key) 

  /**
   * This is used to clear the storage
   */
  static clear() ;
    return dataMemory;
  }

  /**
   * Will sync the MyStorage data from AsyncStorage to storageWindow MyStorage
   */
  static sync() );
            res();
          });
        });
      });
    }
    return MyStorage.syncPromise;
  }
}

Auth.configure();
```

To learn more about tokens, please visit [Amazon Cognito Developer Documentation](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-using-tokens-with-identity-providers.html).
