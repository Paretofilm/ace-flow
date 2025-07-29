---
title: Documentation
source: fragments/lib/restapi/ios/authz/22_none_headers.mdx
---

# Documentation

If you would like to add request headers, you can add it directly to the request
```swift
let headers = ["headerField": "headerValue"]
let request = RESTRequest(headers: headers)
```
