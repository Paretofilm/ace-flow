---
title: Sign Out Result Types
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/ios/signout/15_sign_out_types.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Sign Out Result Types

## Sign Out Result Types

### .complete
Indicates a successful sign out with no errors.

### .partial
Indicates that sign out was completed, but with errors. 
The device credentials have been cleared and the user is locally signed out of the device.
The `.partial` case will return 1 or more errors where sign out actions can be retried manually.
* `.globalSignOutError` - The GlobalSignOut action failed.
    - `error`: Provides a message and recovery suggestion for the failure.
    - `accessToken`: The access token that was unable to be revoked. The Escape Hatch can be used to manually retry the global sign out.
* `.revokeTokenError` - The RevokeToken action failed.
    - `error`:  Provides a message and recovery suggestion for the failure.
    - `refreshToken`: The refresh token that was unable to be revoked. The Escape Hatch can be used to manually retry revoking the token.
* `.hostedUIError` - The HostedUI sign out action failed.
    - `error`: Provides a message and recovery suggestion for the failure.

### .failed
Indicates a failed sign out where user credentials remain on the device. 
See the attached error to determine the cause.


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/ios/signout/15_sign_out_types.mdx`