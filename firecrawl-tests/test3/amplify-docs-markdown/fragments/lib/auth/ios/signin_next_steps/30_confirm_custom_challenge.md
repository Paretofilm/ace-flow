---
title: Documentation
source: fragments/lib/auth/ios/signin_next_steps/30_confirm_custom_challenge.mdx
---

# Documentation

If the next step is `confirmSignInWithCustomChallenge`, Amplify Auth is awaiting completion of a custom authentication challenge. The challenge is based on the Lambda trigger you setup when you configured a [custom sign in flow](/gen1/[platform]/build-a-backend/auth/sign-in-custom-flow/). To complete this step, you should prompt the user for the custom challenge answer, and pass the answer to the `confirmSignIn` API.

```swift
func confirmSignIn(challengeAnswerFromUser: String) async  else 
    } catch let error as AuthError  catch 
}
```

</Block>

```swift
func confirmSignIn(challengeAnswerFromUser: String) -> AnyCancellable .sink 
        }
        receiveValue:  else 
        }
}
```

</Block>
</BlockSwitcher>

> **Note**: 

<b>Special Handling on ConfirmSignIn</b>

During a confirmSignIn call if `failAuthentication=true` is returned by the lambda the session of the request gets invalidated by cognito, a NotAuthorizedException is returned and a new signIn call is expected via Amplify.Auth.signIn

```swift
Exception:  notAuthorized
```
