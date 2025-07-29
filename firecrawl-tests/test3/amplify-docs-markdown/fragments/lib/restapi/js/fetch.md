---
title: GET requests
source: fragments/lib/restapi/js/fetch.mdx
---

# GET requests

To invoke an endpoint, you need to set input object with required `apiName` 
option and optional `headers`, `queryParams`, and `body` options. API status
code response > 299 are thrown as an `ApiError` instance. The error instance
provides `name` and `message` properties parsed from the response.

## GET requests

```javascript

async function getTodo() );
    const response = await restOperation.response;
    console.log('GET call succeeded: ', response);
  } catch (e) 
}
```

## Accessing query parameters & body in Lambda proxy function

> To learn more about Lambda Proxy Integration, please visit [Amazon API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-create-api-as-simple-proxy-for-lambda.html).

If you are using a REST API which is generated with Amplify CLI, your backend is created with Lambda Proxy Integration, and you can access your query parameters & body within your Lambda function via the _event_ object:

```javascript
exports.handler = function(event, context, callback) ;
```

Alternatively, you can update your backend file which is located at `amplify/backend/function/[your-lambda-function]/app.js` with the middleware:

```javascript
const awsServerlessExpressMiddleware = require('aws-serverless-express/middleware');
app.use(awsServerlessExpressMiddleware.eventContext());
```

Accessing Query Parameters with Serverless Express

In your request handler use `req.apiGateway.event` or `req.query`:

```javascript
app.get('/items', function(req, res) );
});
```

Then you can use query parameters in your path as follows:

```javascript
async function getTodo() 
      }
    });
    const response = await restOperation.response;
    console.log('GET call succeeded: ', response);
  } catch (e) 
}
```

## Accessing response payload

You can consume the response payload by accessing the `body` property of the response object.
Depending on the use case and the content type of the body, you can consume they payload in string, blob or JSON.

```javascript
// ...
const  = await restOperation.response;
// consume as a string:
const str = await body.text();
// OR consume as a blob:
const blob = await body.blob();
// OR consume as a JSON:
const json = await body.json();
```

> **Note**: 

You can not consume the response payload more than once.

## Access HTTP response from errors

The REST API handler may throw an `ApiError` error instance. If the error is caused by an HTTP response with a
non-2xx status code, the error instance will provide a `response` property. The `response` property contains following
properties:
* `statusCode`: HTTP status code
* `headers`: HTTP response headers
* `body`: HTTP response body as a string

The following example shows how to access the HTTP response from an `ApiError` instance, so that you can handle the 
error response from your REST API endpoint:

```javascript

try );
  await restOperation.response;
} catch (error)  = error.response;
      console.error(`Received $ error response with payload: $`);
    }
    // Handle API errors not caused by HTTP response.
  }
  // Handle other errors.
}
```
