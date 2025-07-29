---
title: SignUp
source: fragments/sdk/auth/android/working-with-api.mdx
---

# SignUp

## SignUp

Creates a new user in your User Pool:

```java
final String username = getInput(R.id.signUpUsername);
final String password = getInput(R.id.signUpPassword);
final Map attributes = new HashMap<>();
attributes.put("email", "name@email.com");
AWSMobileClient.getInstance().signUp(username, password, attributes, null, new Callback()  else 
            }
        });
    }

    @Override
    public void onError(Exception e) 
});
```

## Confirm SignUp

Confirms a new user after signing up in a User Pool:

```java
final String username = getInput(R.id.confirmSignUpUsername);
final String code = getInput(R.id.confirmSignUpCode);
AWSMobileClient.getInstance().confirmSignUp(username, code, new Callback()  else 
            }
        });
    }

    @Override
    public void onError(Exception e) 
});
```

## Re-send Confirmation Code

```java
AWSMobileClient.getInstance().resendSignUp("your_username", new Callback() 

    @Override
    public void onError(Exception e) 
});
```

## SignIn

Sign in with user credentials:

```java
AWSMobileClient.getInstance().signIn(username, password, null, new Callback() 
            }
        });
    }

    @Override
    public void onError(Exception e) 
});
```

## Confirm SignIn (MFA)

In order to setup multifactor authentication, choose `Manual configuration` while setting up auth in the CLI. When you get to the `Multifactor authentication` step, choose these values:

```console
 Multifactor authentication (MFA) user login options: ON (Required for all logins, can not be enabled later)
For user login, select the MFA types: SMS Text Message
Please specify an SMS authentication message: Your authentication code is 
Email based user registration/forgot password: Enabled (Requires per-user email entry at registration)
Please specify an email verification subject: Your verification code
Please specify an email verification message: Your verification code is 
Do you want to override the default password policy for this User Pool? No
Warning: you will not be able to edit these selections.
What attributes are required for signing up? Email, Phone Number (This attribute is not supported by Facebook, Login With Amazon.)
```

Note in the example above that for the `What attributes are required for signing up?` prompt, you need to use the arrow keys to scroll down in the list and select `Phone Number`. Otherwise you will not be able to add a phone number to the user and thus will not be able to sign in since SMS MFA is required.

When signing up a user, be sure to pass an attributes map including both `email` (in the case above where email is used for password recovery) and `phone_number`.

After you call sign in and get the `SMS_MFA` response back, you can send your user's input of the SMS code they received with the following command:

```java
AWSMobileClient.getInstance().confirmSignIn(signInChallengeResponse, new Callback() 
    }

    @Override
    public void onError(Exception e) 
});
```

## Force Change Password

If a user is required to change their password on first login, there is a `NEW_PASSWORD_REQUIRED` state returned when `signIn` is called. You need to provide a new password given by the user in that case. It can be done using `confirmSignIn` with the new password.

```java
AWSMobileClient.getInstance().signIn("username", "password", null, new Callback() 
            }
        });
    }
     @Override
    public void onError(Exception e) 
});

AWSMobileClient.getInstance().confirmSignIn("NEW_PASSWORD_HERE", new Callback() 
    }
     @Override
    public void onError(Exception e) 
});
```

## Forgot Password

Forgot password is a 2 step process. You need to first call `forgotPassword()` method which would send a confirmation code to user via email or phone number. The details of how the code was sent are included in the response of `forgotPassword()`. Once the code is given by the user, you need to call `confirmForgotPassword()` with the confirmation code to confirm the change of password.

```java
AWSMobileClient.getInstance().forgotPassword("username", new Callback() 
            }
        });
    }

    @Override
    public void onError(Exception e) 
});

AWSMobileClient.getInstance().confirmForgotPassword("username", "NEW_PASSWORD_HERE", "CONFIRMATION_CODE", new Callback() 
            }
        });
    }

    @Override
    public void onError(Exception e) 
});
```

## SignOut

```java
AWSMobileClient.getInstance().signOut(SignOutOptions.builder().invalidateTokens(true).build(), new Callback() 

    @Override
    public void onError(Exception e) 
});
```

If you want to sign out locally by just deleting tokens, you can call `signOut` method:

```java
AWSMobileClient.getInstance().signOut();
```

## Global SignOut

Using global signout, you can signout a user from all active login sessions. By doing this, you are revoking all the OIDC tokens(id token, access token and refresh token) which means the user is signed out from all the devices. However, although the tokens are revoked, the AWS credentials will remain valid until they expire (which by default is 1 hour).

```java
AWSMobileClient.getInstance().signOut(SignOutOptions.builder().signOutGlobally(true).build(), new Callback() 

    @Override
    public void onError(Exception e) 
});
```

## Utility Properties

The `AWSMobileClient` provides several property "helpers" that are automatically cached locally for you to use in your application.

```java
AWSMobileClient.getInstance().getUsername()       //String
AWSMobileClient.getInstance().isSignedIn()        //Boolean
AWSMobileClient.getInstance().getIdentityId()     //String
```

## Managing Security Tokens

**When using Authentication with `AWSMobileClient`, you don’t need to refresh Amazon Cognito tokens manually. The tokens are automatically refreshed by the library when necessary.**

### OIDC Tokens

```java
AWSMobileClient.getInstance().getTokens();
AWSMobileClient.getInstance().getTokens().getIdToken().getTokenString();
```

### AWS Credentials

```java
AWSMobileClient.getInstance().getCredentials();
```
