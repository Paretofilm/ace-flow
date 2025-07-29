---
title: Documentation
source: fragments/lib-v1/auth/ios/access_credentials/10_fetchAuthSession.mdx
---

# Documentation

```swift
import AWSPluginsCore

Amplify.Auth.fetchAuthSession 

        // Get AWS credentials
        if let awsCredentialsProvider = session as? AuthAWSCredentialsProvider 

        // Get cognito user pool token
        if let cognitoTokenProvider = session as? AuthCognitoTokensProvider 

    } catch 
}
```
If you have enabled guest user in Cognito Identity Pool and no user is signed in, you will be able to access only identityId and AWS credentials. All other session details will give you an error.

```swift
import AWSPluginsCore

Amplify.Auth.fetchAuthSession 

        // Get AWS credentials
        if let awsCredentialsProvider = session as? AuthAWSCredentialsProvider 

    } catch 
}
```
