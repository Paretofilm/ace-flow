---
title: Documentation
source: fragments/lib-v1/graphqlapi/ios/advanced-workflows/50_interceptor.mdx
---

# Documentation

To include custom headers in your outgoing requests, add an `URLRequestInterceptor` to the `AWSAPIPlugin`. Also specify the name of one of the APIs configured in your **amplifyconfiguration.json** file.

```swift
struct CustomInterceptor: URLRequestInterceptor 
        mutableRequest.setValue("headerValue", forHTTPHeaderField: "headerKey")
        return mutableRequest as URLRequest
    }
}
let apiPlugin = try AWSAPIPlugin()
try Amplify.addPlugin(apiPlugin)
try Amplify.configure()
try apiPlugin.add(interceptor: CustomInterceptor(), for: "yourApiName")
```
