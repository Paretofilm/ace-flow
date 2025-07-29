---
title: Get Current User
source: fragments/lib/auth/android/signin_next_steps/80_current_user.mdx
---

# Get Current User

## Get Current User

This call fetches the current logged in user and should be used after a user has been successfully signed in.
If the user is signed in, it will return the current userId and username.
Note: An empty string will be assigned to userId and/or username, if the values are not present in the accessToken.

```java
 try  catch (Exception error) 
```
</Block>

```kotlin
Amplify.Auth.getCurrentUser(,)
```
</Block>

```kotlin
try  catch (error: Exception) 
```
</Block>

```java
  RxAmplify.Auth.getCurrentUser().subscribe(
        result -> Log.i("AuthQuickStart getCurrentUser: " + result.toString()),
        error -> Log.e("AuthQuickStart", error.toString())
 );
```
</Block>

</BlockSwitcher>
