---
title: GET requests
source: fragments/lib/restapi/flutter/fetch.mdx
---

# GET requests

## GET requests

To make a GET request use `Amplify.API.get`:

```dart
Future<void> getTodo() async ');
  } on ApiException catch (e) 
}
```

## Accessing query parameters & body in Lambda proxy function

> To learn more about Lambda Proxy Integration, please visit [Amazon API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-create-api-as-simple-proxy-for-lambda.html).

If you are using a REST API which is generated with Amplify CLI, your backend is created with Lambda Proxy Integration, and you can access your query parameters & body within your Lambda function via the *event* object:

```javascript
exports.handler = function(event, context, callback) 
```

In case you do not have it already, alternatively, you can update your backend file which is located at `amplify/backend/function/[your-lambda-function]/src/app.js` with the middleware:

```javascript
const awsServerlessExpressMiddleware = require('aws-serverless-express/middleware');
app.use(awsServerlessExpressMiddleware.eventContext());
```

Accessing Query Parameters with Serverless Express

In your request handler use `req.apiGateway.event` or `req.query`:

```javascript
app.get('/todo', function(req, res) );
});
```

Then you can use query parameters in your path as follows:

```dart
Future<void> getTodo() async ,
    );
    final response = await restOperation.response;
    print('GET call succeeded: $');
  } on ApiException catch (e) 
}
```
