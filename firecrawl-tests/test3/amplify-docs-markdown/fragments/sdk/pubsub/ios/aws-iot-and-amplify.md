---
title: Prerequisites
source: fragments/sdk/pubsub/ios/aws-iot-and-amplify.mdx
---

# Prerequisites

The new [**Amplify Library for Swift** ](/gen1/[platform]/tools/libraries/) (also known as **v2**) is implemented using the new AWS SDK for Swift, which does not support **AWS IoT** .

Follow this guide if you are looking to:
  - Use **AWS IoT** for your Swift project using **v2** of the Amplify Library for Swift
  - Migrate to **v2** of the Amplify Library for Swift and you currently have an **AWS IoT** implementation in your project. 

You can achieve it by using CocoaPods to pull the `AWSIoT` pod, and by manually providing the necessary credentials.

## Prerequisites

You will need:
1. [CocoaPods installed](/gen1/[platform]/sdk/configuration/setup-options/#cocoapods-setup) in your computer.
2. An application that is configured with the [Auth category](/gen1/[platform]/build-a-backend/auth/set-up-auth/) of the latest Amplify Library for Swift.

## Installation

In a Terminal window, navigate to your application's root folder and run the following command:

```bash 
pod init
```

Open the resulting `Podfile` file and add the `AWSIoT` pod to your target

```ruby
platform :ios, '13.0'

target :'YOUR-APP-NAME' do
  use_frameworks!

  pod  'AWSIoT'
end
```

Go back to the Terminal and run:

```bash
pod install
```

Now you can use the `.xcworkspace` file to open your application, and you should be able to successfully build and run it.

## Configuration

In order to configure `AWSIoTDataManager`, you need to provide an instance that conforms to `AWSCredentialsProvider`. 

Since your application is using Amplify Auth, you can use it to provide the credentials. Just create a new `CredentialsProxy.swift` file with the following content:

```swift
import Amplify
import AWSCognitoAuthPlugin
import AWSCore
import AWSPluginsCore
import Foundation

/// Convenience implementation of the aws-sdk-ios `AWSCredentialsProvider` protocol backed
/// by Amplify's Cognito-based Auth plugin.
///
/// - Tag: CredentialsProxy
class CredentialsProxy: NSObject 

    private let auth: AuthCategoryBehavior

    /// - Tag: CredentialsProxy.init
    init(auth: AuthCategoryBehavior = Amplify.Auth) 

    private func fetchCredentials() async throws -> AWSCore.AWSCredentials 

        let credentials = try provider.getAWSCredentials().get()
        guard let cognitoCredentials = credentials as? AuthAWSCognitoCredentials else 

        return AWSCredentials(
            accessKey: cognitoCredentials.accessKeyId,
            secretKey: cognitoCredentials.secretAccessKey,
            sessionKey: cognitoCredentials.sessionToken,
            expiration: cognitoCredentials.expiration
        )
    }
}

extension CredentialsProxy: AWSCore.AWSCredentialsProvider  catch 
        }
        return source.task
    }

    func invalidateCachedTemporaryCredentials() 
}
```

Add the corresponding import to the files in which you wish you use AWS IoT:

```swift
import AWSIoT
```

You can then use a new `CredentialsProxy` instance as the credentials provider when creating your configuration with your unique client ID and endpoint:

```swift
let iotEndPoint = AWSEndpoint(
    urlString: "wss://xxxxxxxxxxxxx-ats.iot..amazonaws.com/mqtt"
)

let iotDataConfiguration = AWSServiceConfiguration(
    region: AWSRegionType.,
    endpoint: iotEndPoint,
    credentialsProvider: CredentialsProxy()
)

AWSIoTDataManager.register(with: iotDataConfiguration!, forKey: "MyAWSIoTDataManager")
let iotDataManager = AWSIoTDataManager(forKey: "MyAWSIoTDataManager")
```

> **Note**: 

You can get the endpoint information from the IoT Core -> Settings page on the AWS Console.  

**Create IAM policies for AWS IoT**

To use PubSub with AWS IoT, you will need to create the necessary IAM policies in the AWS IoT Console, and attach them to your Amazon Cognito Identity. 

Go to IoT Core and choose *Secure* from the left navigation pane, and then *Policies* from the dropdown menu. Next, click *Create*. The following `myIOTPolicy` policy will allow full access to all the topics.

![](/images/iot_attach_policy.png)

**Attach your policy to your Amazon Cognito Identity**

To attach the policy to your *Cognito Identity*, begin by retrieving the `Cognito Identity Id` from `Amplify Auth`. 

Add the following import statements: 

```swift
import Amplify
import AWSPluginsCore
```

Then you can retrieve the ID using `Amplify.Auth.fetchAuthSession()`

```swift
let session = try await Amplify.Auth.fetchAuthSession()
if let identityProvider = session as? AuthCognitoIdentityProvider 
```

Finally, you need to attach the `myIOTPolicy` policy to the user's *Cognito Identity Id* with the following [AWS CLI](https://aws.amazon.com/cli/) command:

```bash
aws iot attach-principal-policy --policy-name 'myIOTPolicy' --principal ''
```
