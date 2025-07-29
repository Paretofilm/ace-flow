---
title: Customization
source: fragments/lib-v1/storage/android/configureaccess/50_customization.mdx
---

# Customization

## Customization

### Customize Object Key Path

You can customize your key path by defining a prefix resolver:

```java
// Define your own prefix resolver, that conforms to `AWSS3StoragePluginPrefixResolver`
public class MyDeveloperPrefixResolver implements AWSS3PluginPrefixResolver 
            case PROTECTED: 
            case PRIVATE: 
        }
    }
}
```

</Block>

```kotlin
// Define your own prefix resolver, that conforms to `AWSS3StoragePluginPrefixResolver`
class MyDeveloperPrefixResolver: AWSS3PluginPrefixResolver 
            StorageAccessLevel.PROTECTED -> 
            StorageAccessLevel.PRIVATE -> 
        }
    }
}
```

</Block>
</BlockSwitcher>

Then configure the storage plugin with the resolver.

```java
AWSS3StoragePluginConfiguration.Builder builder = new AWSS3StoragePluginConfiguration.Builder();
builder.setAwsS3PluginPrefixResolver(new MyDeveloperPrefixResolver());
Amplify.addPlugin(new AWSS3StoragePlugin(builder.build()));
```

</Block>

```kotlin
Amplify.addPlugin>(
    AWSS3StoragePlugin(
        AWSS3StoragePluginConfiguration 
    )
)
```

</Block>
</BlockSwitcher>

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
#### Passthrough PrefixResolver

If you would like no prefix resolution logic, such as performing S3 requests at the root of the bucket, create a prefix resolver that returns an empty string:

```java
public class PassThroughPrefixResolver implements AWSS3PluginPrefixResolver 
}
```

</Block>

```kotlin
class PassThroughPrefixResolver: AWSS3PluginPrefixResolver 
}
```

</Block>
</BlockSwitcher>
