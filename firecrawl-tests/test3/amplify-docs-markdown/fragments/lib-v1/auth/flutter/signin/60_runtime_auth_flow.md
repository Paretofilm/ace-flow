---
title: Switching authentication flow at runtime
source: fragments/lib-v1/auth/flutter/signin/60_runtime_auth_flow.mdx
---

# Switching authentication flow at runtime

### Switching authentication flow at runtime

By default, the [`authenticationFlowType`](https://docs.aws.amazon.com/cognito/latest/developerguide/amazon-cognito-user-pools-authentication-flow.html) value specified in your `amplifyconfiguration.dart` will be used when authenticating with Cognito. You can change the default behavior at runtime with `CognitoSignInPluginOptions`:

```dart
Future<void> signInCustom(String username, String password) async  on AuthException catch (e) ');
  }
}
```

The two available options are `userSrpAuth` and `customAuth`. You can learn more about the custom auth flow [here](/gen1/[platform]/prev/build-a-backend/auth/sign-in-custom-flow/).
