---
title: GET requests
source: fragments/lib-v1/restapi/js/fetch.mdx
---

# GET requests

To invoke an endpoint, you need to set `apiName`, `path` and `headers` parameters, and each method returns a Promise. Under the hood the API category utilizes [Axios](https://github.com/axios/axios) to execute the HTTP requests. API status code response > 299 are thrown as an exception. If you need to handle errors managed by your API, work with the `error.response` object.

## GET requests

```javascript
const apiName = 'MyApiName';
const path = '/path';
const myInit = , // OPTIONAL
  response: true, // OPTIONAL (return the entire Axios response object instead of only response.data)
  queryStringParameters: 
};

API.get(apiName, path, myInit)
  .then((response) => )
  .catch((error) => );
```

Example with async/await

```javascript
function getData()  // OPTIONAL
  };

  return API.get(apiName, path, myInit);
}

(async function () )();
```

## GET requests with query parameters

To use query parameters with `get` method, you can pass them in `queryStringParameters` parameter in your method call:

```javascript
const items = await API.get('myCloudApi', '/items', 
});
```

## HEAD

```javascript
const apiName = 'MyApiName'; // replace this with your api name.
const path = '/path'; //replace this with the path you have configured on your API
const myInit =  // OPTIONAL
};

API.head(apiName, path, myInit).then((response) => );
```

Example with async/await:

```javascript
function head()  // OPTIONAL
  };

  return API.head(apiName, path, myInit);
}

(async function () )();
```

## Accessing query parameters & body in Lambda proxy function

> To learn more about Lambda Proxy Integration, please visit [Amazon API Gateway Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-create-api-as-simple-proxy-for-lambda.html).

If you are using a REST API which is generated with Amplify CLI, your backend is created with Lambda Proxy Integration, and you can access your query parameters & body within your Lambda function via the _event_ object:

```javascript
exports.handler = function (event, context, callback) ;
```

Alternatively, you can update your backend file which is located at `amplify/backend/function/[your-lambda-function]/app.js` with the middleware:

```javascript
const awsServerlessExpressMiddleware = require('aws-serverless-express/middleware');
app.use(awsServerlessExpressMiddleware.eventContext());
```

Accessing Query Parameters with Serverless Express

In your request handler use `req.apiGateway.event` or `req.query`:

```javascript
app.get('/items', function (req, res) );
});
```

Then you can use query parameters in your path as follows:

```javascript
API.get('sampleCloudApi', '/items?q=test');
```

## Custom response types

By default, calling an API with AWS Amplify parses a JSON response. If you have a REST API endpoint which returns, for example, a file in Blob format, you can specify a custom response type using the `responseType` parameter in your method call:

```javascript
let file = await API.get('myCloudApi', '/items', );
```

Allowed values for `responseType` are "arraybuffer", "blob", "document", "json" or "text"; and it defaults to "json" if not specified. See the [documentation](https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/responseType) for more information.
