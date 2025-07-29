---
title: Documentation
topics: ['File Storage']
primary_topic: File Storage
source: fragments/sdk/storage/ios/graphql-api.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Documentation

**Note:** Please review the documentation for [API](/gen1/[platform]/sdk/api/graphql/) before you proceed with the rest of this section.

You can upload and download Amazon S3 Objects using AWS AppSync, a GraphQL based solution to build data-driven apps with real-time and offline capabilities. Sometimes you might want to create logical objects that have more complex data, such as images or videos, as part of their structure. _For example, you might create a Person type with a profile picture or a Post type that has an associated image_. You can use AWS AppSync to model these as GraphQL types. If any of your mutations have a variable with `bucket`, `key`, `region`, `mimeType`, and `localUri` fields, the SDK uploads the file to S3 for you.

Update file `amplify/backend/api/yourAppName/schema.graphql` using the following schema which has a `S3Object` type:

```graphql
type Picture @model 

type S3Object 

enum Visibility 
```

and run `amplify push` to update the AppSync backend resource, remember to choose `update API.swift` when `Amplify CLI` prompts the choice

The AWS AppSync SDK doesn't take a direct dependency on the AWS SDK for S3, but takes in `AWSS3TransferUtility`. You will also need to take a dependency on the `AWSS3` SDK. You can do that by updating your Podfile:

```ruby
target: 'PostsApp' do
    use_frameworks!
    pod 'AWSAppSync'
    pod 'AWSS3'
end
```

Then run `pod install` to fetch the new dependencies.

Update the `class AppDelegate: UIResponder, UIApplicationDelegate` in `AppDelegate.swift` to configure `AWSAppSyncClient` and `AWSS3TransferUtility` like below:

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  catch 

        return true
    }
}
```

And to automatically upload image when doing the api mutation. You can create the following method to trigger the action:

```swift
func uploadImage() 
        if let resultError = result?.errors 
    }
}
```

Note: Remember to replace the `bucket` and `region` with what you find in `awsconfiguration.json`

The mutation operation doesn't require any specific changes in method signature. It requires only an `S3Object` with `bucket`, `key`, `region`, `localUri`, and `mimeType`. Now when you do a mutation, it automatically uploads the specified file to Amazon S3 using the `AWSS3TransferUtility` client internally.


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/sdk/storage/ios/graphql-api.mdx`