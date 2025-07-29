---
title: Documentation
source: fragments/lib-v1/storage/ios/escapehatch.mdx
---

# Documentation

For advanced use cases where Amplify does not provide the functionality, you can retrieve the escape hatch to access the [AWSS3](https://aws-amplify.github.io/aws-sdk-ios/docs/reference/AWSS3/Classes/AWSS3.html) instance.

Add the following imports:

```swift
import AWSS3StoragePlugin  // Imports the Amplify plugin interface
import AWSS3               // Imports the AWSS3 client escape hatch
```

</Block>

```swift
import AmplifyPlugins // Imports the Amplify plugin interface
import AWSS3          // Imports the AWSS3 client escape hatch
```

</Block>

</BlockSwitcher>

Then retrieve the escape hatch with this code

```swift
func getEscapeHatch()  catch 
}
```
