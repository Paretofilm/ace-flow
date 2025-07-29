---
title: GET requests
topics: ['General']
primary_topic: General
source: fragments/lib/restapi/android/fetch.mdx
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

To make a GET request, first build a RestOptions object and then use the Amplify.API.get api to issue the request:

```java
void getTodo() 
```

</Block>

```kotlin
private fun getTodo() ,
        
    )
}
```

</Block>

```kotlin
private suspend fun getTodo() ")
    } catch (error: ApiException) 
}
```

</Block>

```java
void getTodo() 
```

</Block>
</BlockSwitcher>

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

Accessing Query Parameters with Serverless Express

In your request handler use `req.apiGateway.event` or `req.query`:

```javascript
app.get('/todo', function(req, res) );
});
```

Then you can use query parameters in your path as follows:

```java
RestOptions options = RestOptions.builder()
    .addPath("/todo")
    .addQueryParameters(Collections.singletonMap("q", "test"))
    .build();

Amplify.API.get(options,
    response -> Log.i("MyAmplifyApp", "GET succeeded: " + response),
    error -> Log.e("MyAmplifyApp", "GET failed.", error)
);
```

</Block>

```kotlin
val request = RestOptions.builder()
    .addPath("/todo")
    .addQueryParameters(mapOf("q" to "test"))
    .build()

Amplify.API.get(request,
    ,
    
)
```

</Block>

```kotlin
val request = RestOptions.builder()
    .addPath("/todo")
    .addQueryParameters(mapOf("q" to "test"))
    .build()

try  catch (error: ApiException) 
```

</Block>

```java
RestOptions options = RestOptions.builder()
    .addPath("/todo")
    .addQueryParameters(Collections.singletonMap("q", "test"))
    .build();

RxAmplify.API.get(options)
    .subscribe(
        response -> Log.i("MyAmplifyApp", "GET succeeded: " + response),
        error -> Log.e("MyAmplifyApp", "GET failed.", error)
    );
```

</Block>
</BlockSwitcher>


---

## 📚 Related Topics
- [[General/]]

## 📖 Source
Original: `fragments/lib/restapi/android/fetch.mdx`