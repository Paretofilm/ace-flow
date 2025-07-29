---
title: Force refreshing session
topics: ['Authentication']
primary_topic: Authentication
source: fragments/lib/auth/ios/access_credentials/10_fetchAuthSession.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, authentication]
---


## 🧭 Navigation
**Topics**: [[Authentication/]]
**Primary**: [[Authentication/]]

---


# Force refreshing session

However, if you need to access them in relation to working with an API outside Amplify or want access to AWS specific identifying information (e.g. IdentityId), you can access these implementation details by casting the result of fetchAuthSession as follows:

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

You can ask the plugin to force refresh the internal session by passing an api options `forceRefresh` while calling the fetchAuthSession api.

```swift
Amplify.Auth.fetchAuthSession(options: .forceRefresh())

```


---

## 📚 Related Topics
- [[Authentication/]]

## 📖 Source
Original: `fragments/lib/auth/ios/access_credentials/10_fetchAuthSession.mdx`