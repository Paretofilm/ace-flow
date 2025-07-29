---
title: GET requests
topics: ['General']
primary_topic: General
source: fragments/lib-v1/restapi/ios/fetch.mdx
type: aws-amplify-docs
platform: next.js
tags: [aws, amplify, general]
---


## 🧭 Navigation
**Topics**: [[General/]]
**Primary**: [[General/]]

---


# GET requests

## GET requests

To make a GET request, first create a RESTRequest object and then use the Amplify.API.get api to issue the request:

```swift
func getTodo() 
    }
}
```

</Block>

```swift
func getTodo() -> AnyCancellable 
        }
        receiveValue: 
    return sink
}
```

</Block>

</BlockSwitcher>

## Handling non-2xx HTTP responses

When your service returns a non-2xx HTTP status code in the response, the API call will result in a failure that you can handle in your app. The response body can be accessed from the `body: Data?` property. For example, when the `APIError` is an `.httpStatusError(StatusCode, HTTPURLResponse)`, then access the response body by type casting the response to an `AWSHTTPURLResponse` and retrieve the `body` field.

```swift
if case let .httpStatusError(statusCode, response) = error,
    let awsResponse = response as? AWSHTTPURLResponse,
    let responseBody = awsResponse.body

```

## Accessing query parameters & body in Lambda proxy function

> To learn more about Lambda Proxy Integration, please visit [Amazon API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-create-api-as-simple-proxy-for-lambda.html).

If you are using a REST API which is generated with Amplify CLI, your backend is created with Lambda Proxy Integration, and you can access your query parameters & body within your Lambda function via the *event* object:

```javascript
exports.handler = function(event, context, callback) 
```

Alternatively, you can update your backend file which is located at `amplify/backend/function/[your-lambda-function]/app.js` with the middleware:

```javascript
const awsServerlessExpressMiddleware = require('aws-serverless-express/middleware');
app.use(awsServerlessExpressMiddleware.eventContext());
```

## Accessing query parameters with Serverless Express

In your request handler use `req.apiGateway.event` or `req.query`:

```javascript
app.get('/todo', function(req, res) );
});
```

Then you can use query parameters in your path as follows:

```swift
func getTodo() 
    }
}
```

</Block>

```swift
func getTodo() -> AnyCancellable 
        }
        receiveValue: 
    return sink
}
```

</Block>

</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib-v1/restapi/ios/fetch.mdx`