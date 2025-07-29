---
title: Customization
topics: ['File Storage']
primary_topic: File Storage
source: fragments/lib-v1/storage/ios/configureaccess/50_customization.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, file-storage]
---


## 🧭 Navigation
**Topics**: [[File Storage/]]
**Primary**: [[File Storage/]]

---


# Customization

## Customization

### Customize Object Key Path

You can customize your key path by defining a prefix resolver:

```swift
import Amplify
import AmplifyPlugins

// Define your own prefix resolver, that conforms to `AWSS3StoragePluginPrefixResolver`
struct MyDeveloperDefinedPrefixResolver: AWSS3PluginPrefixResolver 

        // Use "myProtectedPrefix/" and "myPrivatePrefix/" respectively
        // `targetIdentityId` is the value passed into the Storage request object,
        if let identityId = targetIdentityId  else if accessLevel == .private 
            return
        }

        // Use "myProtectedPrefix/" and "myPrivatePrefix/" respectively
        // `identityId` is the identity id of the current user
        getIdentityId  else if accessLevel == .private 
            }
        }
    }

    public func getIdentityId(completion: @escaping (Result) -> Void) 
            } catch 
        }
    }
}
```

Then configure the storage plugin with the resolver.

```swift
let storagePlugin = AWSS3StoragePlugin(configuration: .prefixResolver(MyDeveloperDefinedPrefixResolver()))
Amplify.add(storagePlugin)
```

Add the IAM policy that corresponds with the prefixes defined above to enable read, write and delete operation for all the objects under path *myPublicPrefix/*:

```xml
"Statement": [
    
]
```

If you want to have custom *private* path prefix like *myPrivatePrefix/*, you need to add it into your IAM policy:
```xml
"Statement": [
    /*"
        ]
    }
]
```
This ensures only the authenticated users has the access to the objects under the path.

#### Passthrough PrefixResolver

If you would like no prefix resolution logic, such as performing S3 requests at the root of the bucket, create a prefix resolver that returns an empty string:

```swift
public func resolvePrefix(
    for accessLevel: StorageAccessLevel,
    targetIdentityId: String?
) -> Result 
```

#### Client validation

You can also perform validation based on the access controls you have defined. For example, if you have defined Guests with no access then you can fail the request early by checking if the user is not signed in:

> **Note**: 

This will only stop your app from making a call with an unauthenticated user. You must also set up your IAM policies to protect your resources. See [CLI Storage](/gen1/[platform]/build-a-backend/storage/import/) for more details.

```swift
struct MyDeveloperDefinedPrefixResolver: AWSS3PluginPrefixResolver 

        // Continue to resolve the prefix for the request
        // ...
    }
}
```


---

## 📚 Related Topics
- [[File Storage/]]

## 📖 Source
Original: `fragments/lib-v1/storage/ios/configureaccess/50_customization.mdx`